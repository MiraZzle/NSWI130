# **Quality Scenarios**

# Design-Time attributes

    >= n/2 [modifiability, testability, interoperability]

## **Modifiability**

#### Martin Znamenáček

1. **Scenario: Updating Enrollment Validation Rules** - **PASSED**

    - **Context:** A new academic policy requires changing the criteria for course prerequisites.
    - **Stimulus:** A developer modifies the enrollment validation logic in the "Course Enrollment Provider [Container], Enrollment Validator [Component]" without affecting other components.
    - **Response:** Due to modular architecture and well-defined APIs, the change is isolated to the validator logic. Automated tests confirm the new rule and no other areas are impacted.
    - **Response Measure:** The code change and tests are completed within **2 working days** with no regressions detected in adjacent functionalities.
    - **Current architecture status:** The application architecure is prepared for this by having the Enrollment Validator isolated.

#### Ladislav Nagy

2. **Scenario: A new API request type needs to be added** - **FAILED**
    - **Context:** A new requirment or change in requirments require a new API call to be added.
    - **Stimulus:** A developer is adding a new API call to the backend.
    - **Response:** Because application has one entry point where new API call can be easilly registered the developer can easily program the call logic separately and only register the call in one place.
    - **Response Measure:** The registration of the new call should be done under **1 hour**, this does not include the programing time of the logic of the call which can vary depending on the requirement and is not relevant here.
    - **Current architecture status:** The current application architecture doesn't have a single point of communication, which makes this impossible and makes adding API requests a much harder and time demanding task. (We are assuming the SIS component includes the frontend which makes the calls)
    - **New architecture to solve the problem** - The Enrollment Controler and Communication provider should be one container which should solely take care of the outside communication, the Course Enrollment Provider should also only communicate with the Enrollment Provider and not with the frontend directly.
  
#### Dominik Mészáros

3. ### Course Enrollment Provider external system API
    #### Artifact
    - **Course Enrollment Provider**
    #### What is the source of modifiability and why?
    - Integration with an external learning management system (LMS) (Elements of AI...) or APIs that provide course updates dynamically. As institutions adopt third-party tools for managing course details, this integration might become essential so people can simply enroll through
    external courses and get ECTS credits.
    #### This component will need to be modified because
    - It will require API adapters to fetch and validate course details from external sources rather than relying on internal storage.
    #### Outcome of this modifiability and time estimated
    - Add a service interface for external integrations, supporting extensibility for new LMS.
    #### Estimate:
    - **4–6 man-weeks**
        - including collaboration with LMS providers and rigorous testing

---

## **Testability**

#### Ladislav Nagy

1. **Scenario: Testing application perfomance under heavy load** - **PASSED**
    - **Context:** How application behaves under heavy load, expected when enrollment is opened, needs to be tested in advance as it is the most possible point of failure or poor user experience for our application.
    - **Stimulus:** A system tester wants to test the application under heavy load that is anticipated during opening of enrollment.
    - **Response:** A testing database image is prepared with prepared courses for enrollment and student accounts. The request and their sending is also prepared so the tester only setups the right app configuration and can launch the tests with one button click. He can also see the analytics and logs of what was happening in the system.
    - **Response Measure:** The testing shouldn't take the tester longer than **8 hours** including the data analysis and performance test itself should take less than **40 minutes** because it might require a sheduled maintenance service unavailability to prevent poor user experience during the test.
    - **Current architecture status:** The application architecure is prepared for this kind of testing because only the databases need to be swapped and the performance can be tested.

#### Dominik Mészáros

2. ### Course Enrollment Provider’s high-load handling.
    - Real-Time Conflict Resolution
    #### Artifact
    - **Course Enrollment Provider**
    #### Stimulus
    - Concurrent enrollment requests are processed under high load conditions.
    #### Source of Stimulus
    - Tester simulates multiple students attempting concurrent enrollment in courses with limited seats.
    #### Environment
    - Simulated high-traffic test environment with many enrollment requests.
    #### Response:
    - Conflicts (e.g., exceeding capacity) are identified correctly, quickly, and enrollments are queued or rejected. Performance metrics (e.g., response time) are logged.
    #### Measurement:
    - **Effort**: Automated performance and concurrency testing tools integrated.
    - **Coverage**: All edge cases of many requests (e.g., many people try to enroll to one course which will be soon full).
    - **Observability**: Metrics and logs highlight issues like race conditions or bottlenecks.
    #### Estimate:
    - **4 man-weeks**
        - of rigorous testing

3. ### Role-Specific Workflow Handling
    #### Artifact
    - **Course Enrollment Provider**
    #### Stimulus:
    - Test enrollment tasks requiring advisor approval or admin overrides.
    #### Source of Stimulus:
    - Tester configures roles such as student, advisor, or admin, and tests their respective workflows.
    #### Artifact:
    - **Course Enrollment Provider**
        - Workflow logic and role authorization mechanisms in the CEP.
    #### Environment:
    - Role-based test accounts in a controlled test environment.
    #### Response:
    - The system validates role permissions and produces consistent outcomes for each role.
    #### Measurement:
    - **Effort**: Simple test case creation for role-based scenarios.
    - **Coverage**: Validation of all role workflows.
    - **Observability**: Role-specific logs and workflow traces facilitate debugging.
    #### Estimate:
    - **5 man-weeks**
        - of rigorous testing of edge-cases

---

## **Interoperability**

#### Ladislav Nagy

1. **Scenario: Another university system wants to get access to the enrollment statistics data** - **FAILED**
    - **Context:** The enrollment statistics need to be available for another university system.
    - **Stimulus:** A developer wants to make the enrollment statistics data available for another sytem.
    - **Response:** Because viewing and computation from the statistics is isolated from the logic that saves them this only requires changes in the statistics output part of the application, where this new system can be easily authenticated to get the data.
    - **Response Measure:** The adding and testing of this feature should take the developer less than **10 hours**
    - **Current architecture status:** The application architecure does not have the viewing of statistics split from their saving and the Enrollment logic which makes adding such a requirment much harder. Also how this should even be done is unclear from the architecture should we call the Enrollment Controller or some SIS API as shown in the statistics L3 diagram.
    - **New architecture should solve the problem** - The logic of viewing and computing statistics and even the resources used for it should be in a separate container from the Enrollment logic and saving of the statistics data. So a Statistics Output Controller should be in the Statistics Provider container with Analytical Computing component to get the computed statistics and will take care of statistics output requests. The enrollment itself or the Logger provider can take care of saving the statistics into the statistics database.

---

# Run-Time attributes

    <= 3* (n/2) [performance, availability, scalability, security]

## **Performance**

#### Matěj Foukal

1. **Enrollment Controller Performance - SIS User → Enrollment Controller → Providers**

    - Enrollment requests should be processed within **100ms to 500ms** under normal load.

#### Jirka Zelenka

2. **Scenario: High-Frequency Batch Enrollment** - **PASSED**
    - **Context:** During late registration, large batches of enrollment requests are submitted simultaneously.
    - **Stimulus:** A surge of requests hits the "Enrollment Controller" over a short period (e.g., 1,000 requests in 1 minute).
    - **Response:** The system scales horizontally, leveraging load balancing and microservice replicas to handle the burst. Caching and asynchronous processing ensure throughput.
    - **Response Measure:** The system maintains an average response time ≤ **700ms** under peak load, with no request timeouts.
        - The system uses kubernetes (in their documentation) so scaling should be taken care of

---

## **Availability**

#### Matěj Foukal

1. **Database High Availability**

    - Both the **Enrollment Database** and **Log Database** must support replication and failover mechanisms.

#### Ladislav Nagy

2. **Viewing of statistics not denied by Enrollment part failure** - **FAILED**
    - **Context:** During the high intensity enrollment the demand is higher than expected and some part of the Enrollment system fails or is very slow to respond, when this happends the enrollment statistics are usefull to have more data to immediatelly adress the issue, this data can be needed by computer (for automatic scalling) or human.
    - **Stimulus:** A system operator or the system itself wants to get the .
    - **Response:** Because viewing and computation from the statistics is isolated from the logic that saves them the ability to get these statistics is not hindered by the slowness or failure of the Enrollment application part.
    - **Response Measure:** There should be **0s** or no downtime to get the statistics when the Enrollment is overrequested.
    - **Current architecture status:** The application architecure does not have the viewing of statistics split from their saving and the Enrollment logic which makes ugetting the needed data hard when the enrollment part is under problems.
    - **New architecture should solve the problem** - The logic of viewing and computing statistics and even the resources used for it should be in a separate container from the Enrollment logic and saving of the statistics data. So a Statistics Output Controller should be in the Statistics Provider container with Analytical Computing component to get the computed statistics and will take care of statistics output requests. The enrollment itself or the Logger provider can take care of saving the statistics into the statistics database.

---

## **Scalability**

#### Jirka Zelenka

1. **Scenario: Peak Enrollment Period** - **PASSED**
    - **Context:** At the start of a new semester, enrollment requests triple due to incoming students.
    - **Stimulus:** Traffic surges significantly over a short period.
    - **Response:** The system automatically scales additional Enrollment Controller and Provider instances. Horizontal scaling and load balancing maintain performance.
    - **Response Measure:** Under triple normal load, the system sustains response times ≤ **700ms**, with no downtime.
        - The system uses kubernetes (in their documentation) so scaling should be taken care of
---

## **Security**

#### Matěj Foukal

1. **SIS User → Enrollment Controller → Providers**

    - The Enrollment Controller must validate users to ensure they can only access their **permitted functionalities**, based on their roles and permissions.

#### Martin Znamenáček

2. **Scenario: Malicious Attack Attempt** - **FAILED**
    - **Context:** A malicious user attempts SQL injection or tries to exploit an API endpoint.
    - **Stimulus:** Suspicious requests hit the Enrollment Controller, attempting to bypass input validation.
    - **Response:** The system includes a **Web Application Firewall (WAF)** at the entry point of the system, specifically in front of the API Gateway (SIS App API), to filter and block malicious requests before they reach the Enrollment Controller or other services.  
    - **Response Measure:** 100% of known attack patterns are blocked, with alerts raised to the security team in real-time, and no data is compromised.
---

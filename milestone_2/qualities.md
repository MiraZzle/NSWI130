# **Quality Scenarios**
## **Improved C4 models can be found in the presentation**

# Design-Time attributes

    >= n/2 (at least 3) [modifiability, testability, interoperability]

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
    - **New architecture to solve the problem** - The Enrollment Controler should solely take care of the outside communication, the Course Enrollment Provider should also only communicate with the Enrollment Provider and not with the frontend directly. **The new C4 diagram** can be found in the presentation

## **Modifiability**

#### Pavel Kubát

1. **Scenario: Adding a New Messaging Protocol (e.g., SMS or Push Notifications) - **PASSED**
    - **Context:** A new requirement necessitates support for sending messages through SMS or push notifications in addition to emails.
    - **Stimulus:** A developer adds an adapter to the Message Creator and Message Scheduler for the new protocol.
    - **Response:** Due to the modular design of the Communication Provider, new protocols are added as separate modules with minimal changes to the existing components.
    - **Response Measure:** Integration and testing of the new protocol are completed within **5 working days** without impacting existing functionality.
    - **Current architecture status:** The modular structure allows seamless extension by plugging in new message protocols.

#### Dominik Mészáros

2. ### Course Enrollment Provider external system API
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

#### Pavel Kubát

2. **Scenario: Validating Complex Enrollment Conditions** - **PASSED**
    - **Context:** New prerequisites require extensive testing to ensure correct validation under all edge cases.
    - **Stimulus:** Testers write automated tests for the Enrollment Validator to simulate diverse enrollment scenarios.
    - **Response:** The modular design of the Enrollment Validator allows isolated testing, with logs providing detailed insights into validation logic.
    - **Response Measure:** Automated tests cover **95%** of scenarios, and manual edge-case validation is completed within **2 days**.
    - **Current architecture status:** The separation of validation logic ensures focused testing and detailed observability.

#### Dominik Mészáros

3. **Scenario: Course Enrollment Provider’s High-Load Handling** - **PASSED**

    - **Context:** Concurrent enrollment requests are processed under high load conditions.
    - **Stimulus:** Tester simulates multiple students attempting concurrent enrollment in courses with limited seats.
    - **Response:** Conflicts (e.g., exceeding capacity) are identified correctly, quickly, and enrollments are queued or rejected. Performance metrics (e.g., response time) are logged.
    - **Response Measure:** Automated performance and concurrency testing tools integrated. All edge cases of many requests (e.g., many people try to enroll in one course which will be soon full) are covered. Metrics and logs highlight issues like race conditions or bottlenecks.
    - **Current architecture status:** The application architecture supports high-load handling with proper conflict resolution mechanisms.
    - **Estimate:** **4 man-weeks** of rigorous testing.

#### Dominik Mészáros

4. ### Role-Specific Workflow Handling
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

    <= 3*(n/2) (at most 9) [performance, availability, scalability, security]

## **Performance**

#### Matěj Foukal

1. **Scenario: Enrollment Controller Performance** - **PASSED**
    - **Context:** Enrollment requests are made by users during the registration period.
    - **Stimulus:** A user submits an enrollment request via SIS.
    - **Response:** The Enrollment Controller routes the request to the appropriate provider and returns the processed response.
    - **Response Measure:** Enrollment requests should be processed within **100ms to 500ms** under **NORMAL** load conditions.

#### Jirka Zelenka

2. **Scenario: High-Frequency Batch Enrollment** - **PASSED**
    - **Context:** During late registration, large batches of enrollment requests are submitted simultaneously.
    - **Stimulus:** A surge of requests hits the "Enrollment Controller" over a short period (e.g., 1,000 requests in 1 minute).
    - **Response:** The system scales horizontally, leveraging load balancing and microservice replicas to handle the burst. Caching and asynchronous processing ensure throughput.
    - **Response Measure:** The system maintains an average response time ≤ **700ms** under peak load, with no request timeouts. The system uses kubernetes (in their documentation) so load balancing should be taken care of.

---

## **Availability**

#### Matěj Foukal

1. **Scenario: Database High Availability** - **FAILED**
    - **Context:** Critical databases like the Enrollment Database and Log Database need to be highly available to avoid system downtime during peak usage.
    - **Stimulus:** A database server failure occurs during peak enrollment periods.
    - **Response:** The system automatically fails over to a replica database, ensuring uninterrupted service.
    - **Response Measure:** Failover occurs within a few **seconds**, with no noticeable impact on UX.

#### Jirka Zelenka

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
    - **Response Measure:** Under triple normal load, the system sustains response times ≤ **700ms**, with no downtime. The system uses kubernetes (in their documentation) so scaling should be taken care of.

---

## **Security**

#### Matěj Foukal - **PASSED**

1. **Scenario: Role-Based Access Validation**
    - **Context:** Users can interact with the Enrollment Controller based only on their specific roles and permission.
    - **Stimulus:** A user attempts to perform an action outside their permission scope.
    - **Response:** The system validates the user's roles and denies unauthorized access while logging the attempt for audit purposes.
    - **Response Measure:** Access validation is completed within **50ms**, and unauthorized actions are logged without system disruption.

#### Martin Znamenáček

2. **Scenario: Malicious Attack Attempt** - **FAILED**
    - **Context:** A malicious user attempts SQL injection or tries to exploit an API endpoint.
    - **Stimulus:** Suspicious requests hit the Enrollment Controller, attempting to bypass input validation.
    - **Response:** The system includes a **Web Application Firewall (WAF)** at the entry point of the system, specifically in front of the API Gateway (SIS App API), to filter and block malicious requests before they reach the Enrollment Controller or other services.
    - **Response Measure:** 100% of known attack patterns are blocked, with alerts raised to the security team in real-time, and no data is compromised.

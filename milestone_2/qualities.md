# **Quality Scenarios**

# Design-Time attributes

    >= n/2 [modifiability, testability, interoperability]

## **Modifiability**

1. **Scenario: Updating Enrollment Validation Rules** - **PASSED**
    - **Context:** A new academic policy requires changing the criteria for course prerequisites.
    - **Stimulus:** A developer modifies the enrollment validation logic in the "Enrollment Provider" without affecting other components.
    - **Response:** Due to modular architecture and well-defined APIs, the change is isolated to the validator logic. Automated tests confirm the new rule and no other areas are impacted.
    - **Response Measure:** The code change and tests are completed within **2 working days** with no regressions detected in adjacent functionalities.
    - **Current architecture status:** The application architecure is prepared for this by having the Enrollment Validator isolated.
  
2. **Scenario: A new API request type needs to be added** - **FAILED**
    - **Context:** A new requirment or change in requirments require a new API call to be added.
    - **Stimulus:** A developer is adding a new API call to the backend.
    - **Response:** Because application has one entry point where new API call can be easilly registered the developer can easily program the call logic separately and only register the call in one place.
    - **Response Measure:** The registration of the new call should be done under **1 hour**, this does not include the programing time of the logic of the call which can vary depending on the requirement and is not relevant here.
    - **Current architecture status:** The current application architecture doesn't have a single point of communication, which makes this impossible and makes adding API requests a much harder and time demanding task. (We are assuming the SIS component includes the frontend which makes the calls)
    - **New architecture to solve the problem** - The Enrollment Controler and Communication provider should be one container which should solely take care of the outside communication, the Course Enrollment Provider should also only communicate with the Enrollment Provider and not with the frontend directly.
---

## **Testability**

1. **Scenario: Testing application perfomance under heavy load** - **PASSED**
   - **Context:** How application behaves under heavy load, expected when enrollment is opened, needs to be tested in advance as it is the most possible point of failure or poor user experience for our application.
    - **Stimulus:** A system tester wants to test the application under heavy load that is anticipated during opening of enrollment.
    - **Response:** A testing database image is prepared with prepared courses for enrollment and student accounts. The request and their sending is also prepared so the tester only setups the right app configuration and can launch the tests with one button click. He can also see the analytics and logs of what was happening in the system.
    - **Response Measure:** The testing shouldn't take the tester longer than **8 hours** including the data analysis and performance test itself should take less than **40 minutes** because it might require a sheduled maintenance service unavailability to prevent poor user experience during the test.
    - **Current architecture status:** The application architecure is prepared for this kind of testing because only the databases need to be swapped and the performance can be tested.

---

## **Interoperability**

1. **Scenario: Another university system wants to get access to the enrollment statistics data** - **FAILED**
   - **Context:** The enrollment statistics need to be available for another university system.
    - **Stimulus:** A developer wants to make the enrollment statistics data available for another sytem.
    - **Response:** Because viewing and computation from the statistics is isolated from the logic that saves them this only requires changes in the statistics output part of the application, where this new system can be easily authenticated to get the data.8
    - **Response Measure:** The adding and testing of this feature should take the developer less than **10 hours**
    - **Current architecture status:** The application architecure does not have the viewing of statistics split from their saving and the Enrollment logic which makes adding such a requirment much harder. Also how this should even be done is unclear from the architecture.
    - **New architecture should solve the problem** - The logic of viewing and computing statistics and even the resources used for it should be in a separate container from the Enrollment logic and saving of the statistics data. So a simple Statistics Output Controller should be added together which will run in a different container and will take care of statistics output requests.
---

# Run-Time attributes

    <= 3* (n/2) [performance, availability, scalability, security]

## **Performance**

### **Enrollment Controller Performance**

1. **SIS User → Enrollment Controller → Providers**

    - Enrollment requests should be processed within **100ms to 500ms** under normal load.

2. **Scenario: High-Frequency Batch Enrollment**
    - **Context:** During late registration, large batches of enrollment requests are submitted simultaneously.
    - **Stimulus:** A surge of requests hits the "Enrollment Controller" over a short period (e.g., 1,000 requests in 1 minute).
    - **Response:** The system scales horizontally, leveraging load balancing and microservice replicas to handle the burst. Caching and asynchronous processing ensure throughput.
    - **Response Measure:** The system maintains an average response time ≤ **700ms** under peak load, with no request timeouts.

---

## **Availability**

1. **Database High Availability**
    - Both the **Enrollment Database** and **Log Database** must support replication and failover mechanisms.

---

## **Scalability**

1. **Scenario: Peak Enrollment Period**
    - **Context:** At the start of a new semester, enrollment requests triple due to incoming students.
    - **Stimulus:** Traffic surges significantly over a short period.
    - **Response:** The system automatically scales additional Enrollment Controller and Provider instances. Horizontal scaling and load balancing maintain performance.
    - **Response Measure:** Under triple normal load, the system sustains response times ≤ **700ms**, with no downtime.

---

## **Security**

1. **SIS User → Enrollment Controller → Providers**

    - The Enrollment Controller must validate users to ensure they can only access their **permitted functionalities**, based on their roles and permissions.

2. **Scenario: Malicious Attack Attempt**
    - **Context:** A malicious user attempts SQL injection or tries to exploit an API endpoint.
    - **Stimulus:** Suspicious requests hit the Enrollment Controller, attempting to bypass input validation.
    - **Response:** The system employs input validation, parameterized queries, and a Web Application Firewall (WAF). Attempts are blocked before reaching internal services.
    - **Response Measure:** 100% of known attack patterns are blocked, with alerts raised to the security team in real-time, and no data is compromised.

---

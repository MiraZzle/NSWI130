# **Quality Scenarios**

# Design-Time attributes

    >= n/2 [modifiability, testability, interoperability]

## **Modifiability**

1. **Scenario: Updating Enrollment Validation Rules**
    - **Context:** A new academic policy requires changing the criteria for course prerequisites.
    - **Stimulus:** A developer modifies the enrollment validation logic in the "Enrollment Provider" without affecting other components.
    - **Response:** Due to modular architecture and well-defined APIs, the change is isolated to the validator logic. Automated tests confirm the new rule and no other areas are impacted.
    - **Response Measure:** The code change and tests are completed within **2 working days** with no regressions detected in adjacent functionalities.

---

## **Testability**

1. **Placeholder:**

---

## **Interoperability**

1. **Placeholder:**

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

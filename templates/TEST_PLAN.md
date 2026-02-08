# Test Plan

> **Project:** [Project Name]
> **Version:** 0.1
> **Last Updated:** YYYY-MM-DD
> **Status:** Draft | Active | Complete

---

## 1. Test Strategy

### Scope
What is being tested and what is not.

### Approach
- **Unit Tests** — individual functions and modules
- **Integration Tests** — component interactions, API endpoints, database operations
- **End-to-End Tests** — full user workflows from start to finish
- **Manual Verification** — UX flows, visual checks, edge cases requiring human judgment

### Environments

| Environment | Purpose | Database | External Services |
|-------------|---------|----------|-------------------|
| Local Dev | Developer testing | Local / Docker | Mocked or sandbox |
| CI | Automated test suite | Test DB | Sandbox |
| Staging | Pre-production verification | Staging DB | Real (sandbox keys) |
| Production | Smoke tests post-deploy | Production DB | Real |

---

## 2. Requirement Verification Matrix

Maps every PRD requirement to specific test cases. A requirement is **not verified** until all its test cases pass.

### Functional Requirements

| Req ID | Requirement | Test Cases | Status | Evidence |
|--------|-------------|------------|--------|----------|
| FR-001 | [from PRD] | TC-001, TC-002 | Not Tested / Pass / Fail | [link to test file or manual result] |
| FR-002 | | | | |

### Non-Functional Requirements

| Req ID | Requirement | Test Method | Target | Actual | Status |
|--------|-------------|-------------|--------|--------|--------|
| NFR-001 | Response time < 200ms | Load test | 200ms | — | Not Tested |
| NFR-002 | | | | | |

---

## 3. Test Cases

### TC-001: [Test Case Name]

- **Requirement:** FR-001
- **Type:** Unit / Integration / E2E / Manual
- **Preconditions:** [Setup required before test]
- **Steps:**
  1. [Action]
  2. [Action]
  3. [Action]
- **Expected Result:** [What should happen]
- **Actual Result:** [Fill in during execution]
- **Status:** Not Run / Pass / Fail
- **Automated:** Yes (file: `tests/path/to/test.ts`) / No (manual)

---

### TC-002: [Test Case Name]

- **Requirement:** FR-001
- **Type:**
- **Preconditions:**
- **Steps:**
  1.
- **Expected Result:**
- **Actual Result:**
- **Status:** Not Run
- **Automated:** Yes / No

---

## 4. Acceptance Criteria Checklist

Pulled directly from PRD user stories. Every criterion must pass before a feature is considered verified.

### [User Story / Feature 1]

- [ ] **AC-001** — [Acceptance criterion from PRD]
  - Test: TC-001
  - Evidence:
  - Verified by:
  - Date:

- [ ] **AC-002** — [Acceptance criterion]
  - Test:
  - Evidence:
  - Verified by:
  - Date:

### [User Story / Feature 2]

- [ ] **AC-003** — [Acceptance criterion]
  - Test:
  - Evidence:
  - Verified by:
  - Date:

---

## 5. Phase Exit Verification

Pulled from IMPLEMENTATION_PLAN.md. Each phase's exit criteria must be verified here before the phase is considered complete.

### Phase 1: [Name]

| Exit Criterion | Test/Method | Status | Evidence |
|----------------|-------------|--------|----------|
| [from impl plan] | | Not Verified / Verified | |

### Phase 2: [Name]

| Exit Criterion | Test/Method | Status | Evidence |
|----------------|-------------|--------|----------|
| | | | |

---

## 6. Defects Found

| ID | Description | Severity | Found In | Test Case | Status | Fix Task |
|----|-------------|----------|----------|-----------|--------|----------|
| DEF-001 | | Critical/High/Med/Low | TC-XXX | | Open/Fixed/Won't Fix | T-XXX |

---

## 7. Test Run Log

| Date | Phase/Scope | Tests Run | Passed | Failed | Blocked | Notes |
|------|-------------|-----------|--------|--------|---------|-------|
| YYYY-MM-DD | | | | | | |

---

## 8. Sign-Off

| Phase | Verified By | Date | Notes |
|-------|-------------|------|-------|
| Phase 1 | | | |
| Phase 2 | | | |
| Final | | | |

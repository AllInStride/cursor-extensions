# Implementation Plan

> **Project:** [Project Name]
> **Version:** 0.1
> **Last Updated:** YYYY-MM-DD
> **Status:** Draft | In Review | Approved

---

## 1. Overview

Brief summary of what's being implemented and the overall approach.

## 2. Phases

### Phase 1: [Foundation / Setup]

**Goal:** What this phase achieves
**Duration:** [estimate]
**Prerequisites:** None

| Step | Description | Output / Deliverable | Definition of Done |
|------|-------------|----------------------|--------------------|
| 1.1 | | | |
| 1.2 | | | |
| 1.3 | | | |

**Phase Exit Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

---

### Phase 2: [Core Features]

**Goal:**
**Duration:**
**Prerequisites:** Phase 1 complete

| Step | Description | Output / Deliverable | Definition of Done |
|------|-------------|----------------------|--------------------|
| 2.1 | | | |
| 2.2 | | | |

**Phase Exit Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

---

### Phase 3: [Integration / Polish]

**Goal:**
**Duration:**
**Prerequisites:** Phase 2 complete

| Step | Description | Output / Deliverable | Definition of Done |
|------|-------------|----------------------|--------------------|
| 3.1 | | | |
| 3.2 | | | |

**Phase Exit Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

---

## 3. Dependencies

```
Phase 1 ──► Phase 2 ──► Phase 3
                ▲
                │
           [External Dep]
```

| Dependency | Owner | Status | Blocks |
|------------|-------|--------|--------|
| | | Pending/Ready | Phase X |

## 4. Implementation Rules

> These rules prevent stub/mock drift and ensure real implementation quality.

1. **No stub implementations** — Every function must have real logic or be explicitly marked as `// NOT_IMPLEMENTED: [reason]` with a linked task
2. **No fake databases** — Use real database connections (local dev DB minimum), never in-memory mocks for features
3. **No placeholder data** — Seed scripts with realistic data, not `"test123"` or `"foo bar"`
4. **Definition of Done applies** — A task is not complete until its DoD criteria from the table above are met
5. **One phase at a time** — Do not start Phase N+1 until Phase N exit criteria are all checked

## 5. Risk Mitigation

| Risk | Impact | Mitigation Strategy |
|------|--------|---------------------|
| | | |

## 6. Review Checkpoints

| Checkpoint | When | What's Reviewed |
|------------|------|-----------------|
| Phase 1 Review | After Phase 1 | Foundation integrity, no stubs |
| Phase 2 Review | After Phase 2 | Feature completeness, real data |
| Final Review | After Phase 3 | Full system, all criteria met |

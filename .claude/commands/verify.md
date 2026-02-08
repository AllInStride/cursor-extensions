You are performing a systematic verification of the project. Your job is to walk through every acceptance criterion in the PRD, every definition of done in the Task Tracker, every phase exit criterion in the Implementation Plan, and every test case in the Test Plan — then check each one against the actual codebase to confirm the implementation is real, complete, and working.

This is NOT a code review. This is a requirements verification audit.

## Step 1: Load Verification Sources

Read these documents at the project root:
- **PRD.md** — acceptance criteria per user story
- **IMPLEMENTATION_PLAN.md** — phase exit criteria and definitions of done
- **TASK_TRACKER.md** — task-level definitions of done
- **TEST_PLAN.md** — test cases, requirement verification matrix, acceptance criteria checklist

If any are missing, report which ones and what can't be verified without them.

## Step 2: Build the Verification Checklist

Extract every verifiable claim from the documents:

1. **From PRD:** Every acceptance criterion under every user story
2. **From Implementation Plan:** Every phase exit criterion
3. **From Task Tracker:** Every task marked `[x]` (done) — pull its definition of done
4. **From Test Plan:** Every test case and its expected result

Compile these into a single ordered checklist.

## Step 3: Verify Each Item Against the Codebase

For each item in the checklist:

### Check 1: Does the code exist?
- Find the files/functions that should implement this feature
- If no code exists: **FAIL — not implemented**

### Check 2: Is it a real implementation?
- Read the actual code, not just file names
- Check for stubs: `throw new Error("not implemented")`, empty bodies, `// TODO`
- Check for fake data: hardcoded returns, in-memory stores pretending to be databases, mock services in production code
- Check for placeholders: `"test123"`, `"foo"`, `console.log` instead of real error handling
- If stubs/fakes found: **FAIL — stub implementation, not real**

### Check 3: Does it meet the criterion?
- Does the code actually do what the acceptance criterion says?
- Does it handle the edge cases implied by the criterion?
- Does it connect to real infrastructure (real DB, real API, real auth)?
- If the behavior doesn't match the criterion: **FAIL — implementation doesn't match requirement**

### Check 4: Is it tested?
- Find corresponding test files
- Check if tests assert the actual acceptance criterion (not just "renders without crashing")
- Check if tests use real-ish data, not trivial mocks
- If no meaningful tests: **WARN — not tested**

## Step 4: Verify Phase Exit Criteria

For each phase marked as complete in the Implementation Plan:
- Check every exit criterion against codebase reality
- A phase is NOT complete if any exit criterion fails verification
- Flag phases claiming completion that aren't actually done

## Step 5: Check Test Plan Status

If TEST_PLAN.md exists:
- Cross-reference automated test files against test case definitions
- Run test suite if possible (`npm test`, `pytest`, `cargo test`, etc.) and report results
- Flag test cases marked "Pass" that have no corresponding automated test
- Flag gaps: requirements with no test cases at all

## Step 6: Generate Verification Report

Create `reports/VERIFICATION_REPORT_<YYYY-MM-DD>.md`:

```markdown
# Verification Report — [Project Name]
> Generated: YYYY-MM-DD
> Scope: [Full / Phase X / Specific features]

## Verification Summary

| Category | Total | Verified | Failed | Warned | Not Testable |
|----------|-------|----------|--------|--------|--------------|
| Acceptance Criteria | | | | | |
| Task DoDs | | | | | |
| Phase Exit Criteria | | | | | |
| Test Cases | | | | | |
| **Total** | | | | | |

**Overall Verdict:** PASS / PARTIAL / FAIL

## Detailed Results

### Acceptance Criteria (from PRD)

| AC ID | Criterion | Status | Evidence | Notes |
|-------|-----------|--------|----------|-------|
| AC-001 | [text] | PASS/FAIL/WARN | [file:line] | |

### Task Verification (completed tasks)

| Task ID | DoD | Status | Evidence | Notes |
|---------|-----|--------|----------|-------|
| T-001 | [text] | PASS/FAIL | [file:line] | |

### Phase Exit Criteria

| Phase | Criterion | Status | Evidence |
|-------|-----------|--------|----------|
| 1 | [text] | PASS/FAIL | |

### Test Results

| TC ID | Name | Expected | Actual | Status |
|-------|------|----------|--------|--------|
| TC-001 | | | | PASS/FAIL/NOT RUN |

## Failures & Issues

### Critical (claimed done, but not implemented or stubbed)
| Item | Claim | Reality | Action Needed |
|------|-------|---------|---------------|
| | | | |

### Warnings (implemented but not tested, or partially done)
| Item | Issue | Action Needed |
|------|-------|---------------|
| | | |

## Stub & Fake Inventory

| File | Line | Type | Description |
|------|------|------|-------------|
| | | stub/mock/fake-data/placeholder | |

## Recommendations

[Prioritized list of what must be fixed before this can be considered verified]

## What Must Be True Before Ship

[Non-negotiable items that must all pass for release]
```

Also update TEST_PLAN.md:
- Update test case statuses based on findings
- Update the Acceptance Criteria Checklist
- Update the Requirement Verification Matrix
- Log the test run in the Test Run Log

## Rules

- VERIFY means checking the CODEBASE, not trusting the documents
- A checked checkbox with no real code behind it is a FAIL
- "It compiles" is not verification. "It does what the criterion says" is verification
- Always reference exact file paths and line numbers
- Run automated tests if possible — don't just read test files
- Update TEST_PLAN.md with findings (don't leave it stale)
- Be blunt: if the project claims Phase 2 is done but half the acceptance criteria fail, say so

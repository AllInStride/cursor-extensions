You are conducting a comprehensive project review. Your job is to audit the current state of the project by cross-referencing documentation against the actual codebase, then generate a detailed progress report.

## Step 1: Locate and Read Project Documents

Find and read these documents (check `docs/` and project root):
- **PRD** (PRD.md or similar) — requirements and acceptance criteria
- **Architecture Doc** (ARCHITECTURE.md) — system design and tech stack
- **Implementation Plan** (IMPLEMENTATION_PLAN.md) — phases, steps, and definitions of done
- **Task Tracker** (TASK_TRACKER.md) — checkable task list with progress
- **Decision Log** (DECISION_LOG.md) — decisions made and open questions

If any document is missing, note it as a gap in the report.

## Step 2: Scan Codebase for Quality Issues

Search the entire codebase for:

### Stub / Incomplete Implementation Markers
- `TODO`, `FIXME`, `HACK`, `XXX`, `STUB`, `NOT_IMPLEMENTED` comments
- Empty function bodies or functions that only `throw new Error("not implemented")`
- Functions returning hardcoded/placeholder values

### Fake Data & Mock Drift
- In-memory databases used as production substitutes (not test fixtures)
- Hardcoded test data outside of test files (`"test123"`, `"foo"`, `"bar"`, `"lorem ipsum"`, `"example"`)
- Mock services that should be real integrations
- Seed files with obviously placeholder data

### Placeholder Patterns
- `console.log` used as error handling
- Empty catch blocks
- Commented-out code blocks longer than 5 lines
- Files with only boilerplate and no real logic

## Step 3: Cross-Reference Task Tracker Against Reality

For each task in TASK_TRACKER.md:
- If marked `[x]` (done): verify the referenced files exist AND contain real implementations
- If marked `[ ]` (not done): check if implementation actually exists (tracker might be out of date)
- Flag any mismatches between tracker status and codebase reality

For each phase in IMPLEMENTATION_PLAN.md:
- Check if exit criteria are actually met
- Flag phases marked complete that still have open items

## Step 4: Compile Open Questions and Decisions Needed

From DECISION_LOG.md:
- List all items with status "Proposed" or open questions
- Flag any decisions that are blocking tasks

From the codebase:
- Identify areas where the code suggests a decision hasn't been made (multiple approaches attempted, feature flags, A/B patterns without clear winner)

## Step 5: Generate Progress Report

Create a report at `reports/PROGRESS_REPORT_<YYYY-MM-DD>.md` with this structure:

```markdown
# Project Review — [Project Name]
> Generated: YYYY-MM-DD

## Executive Summary
[2-3 sentence overview of project health]

## Document Status
| Document | Found | Last Updated | Health |
|----------|-------|-------------|--------|
| PRD | Yes/No | date | Good/Stale/Missing |
| Architecture | | | |
| Implementation Plan | | | |
| Task Tracker | | | |
| Decision Log | | | |

## Progress by Phase
[For each phase: what's done, what's in progress, what's not started]

### Phase N: [Name]
- **Status:** Not Started / In Progress / Complete
- **Tasks:** X/Y complete
- **Exit Criteria:** X/Y met
- **Issues Found:**

## Outstanding Items
### Tasks Remaining
[List of unchecked tasks from tracker]

### Stubs & Incomplete Implementations
[List of stubs, TODOs, fake data found in codebase]

### Tracker Mismatches
[Where tracker says done but code says otherwise, or vice versa]

## Decisions Needed
[Open questions and proposed decisions awaiting resolution]

## Recommendations
[Prioritized list of what to do next]

## What's Next
[Concrete next steps in priority order]

## What's Left
[Remaining work estimated by phase]
```

## Important Rules

- Be specific: reference exact file paths and line numbers
- Be honest: if the project is behind, say so clearly
- Distinguish between "done" and "done correctly" — a checked box with a stub implementation is NOT done
- The report should be actionable — every finding should have a clear next step

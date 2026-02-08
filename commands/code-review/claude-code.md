You are performing a thorough code review. Review the changes in the current branch (or the files/diff provided via $ARGUMENTS) against project standards, then produce a structured review with actionable findings.

## Step 1: Identify What to Review

Determine the review scope:
- If `$ARGUMENTS` contains a file path or glob: review those specific files
- If `$ARGUMENTS` contains a PR number: fetch and review that PR's diff
- If `$ARGUMENTS` is empty: review all uncommitted changes (`git diff` + `git diff --staged`) and any commits on the current branch not yet on main/master

Run `git log --oneline main..HEAD` (or `master..HEAD`) to understand the full scope of branch changes.

## Step 2: Read Project Context

Before reviewing code, read these documents if they exist:
- **PRD** — to verify the change aligns with requirements
- **Architecture Doc** — to verify the change follows established patterns
- **Implementation Plan** — to check if this work corresponds to a planned task
- **Task Tracker** — to identify which task(s) this change addresses

This context prevents reviewing in a vacuum.

## Step 3: Review for Correctness

For each changed file, check:

### Logic & Behavior
- Does the code do what it claims to do?
- Are there off-by-one errors, race conditions, or edge cases?
- Are error paths handled (not just the happy path)?
- Are return values and types correct?
- Does it handle null/undefined/empty inputs?

### Completeness
- Is the implementation complete or are there stubs/TODOs?
- Are all branches of conditionals handled?
- Are all cases in switch statements covered?
- If a new feature: does it cover all acceptance criteria from the PRD?

### Integration
- Does this change break anything it touches?
- Are imports/exports correct?
- Are API contracts maintained (no breaking changes without versioning)?
- Do database migrations match model changes?

## Step 4: Review for Quality

### Security (OWASP-aware)
- SQL injection: parameterized queries used?
- XSS: user input sanitized before rendering?
- Auth: are endpoints/routes properly protected?
- Secrets: no hardcoded API keys, passwords, tokens?
- CSRF: state-changing operations protected?
- Input validation: at system boundaries?

### Performance
- N+1 query patterns?
- Unbounded loops or recursion?
- Missing pagination on list endpoints?
- Unnecessary re-renders (frontend)?
- Large payloads without compression/streaming?

### Maintainability
- Is the code readable without comments explaining every line?
- Are names descriptive (variables, functions, files)?
- Is there unnecessary complexity or premature abstraction?
- Is there duplicated code that should be extracted?
- Are there magic numbers/strings that should be constants?

### Testing
- Are there tests for the changed code?
- Do tests cover edge cases, not just happy path?
- Are tests actually testing behavior (not just mocking everything)?
- If no tests: flag it and suggest what should be tested

## Step 5: Check for Anti-Patterns

Flag these specifically:
- **Stub drift**: Functions with `// TODO` or `throw new Error("not implemented")` being committed
- **Fake data**: Hardcoded test values in production code
- **Console.log debugging**: `console.log` left in production code
- **Empty catch blocks**: Swallowed errors with no handling
- **Commented-out code**: Dead code committed instead of deleted
- **God functions**: Functions doing too many things (>50 lines is a smell)
- **Deep nesting**: More than 3 levels of indentation (extract early returns or helper functions)

## Step 6: Generate Review Output

Output the review in this format:

```markdown
# Code Review

**Scope:** [what was reviewed — files, PR, branch]
**Branch:** [branch name]
**Reviewer:** Claude
**Date:** YYYY-MM-DD

## Summary
[1-2 sentence overall assessment: ship it / needs changes / needs major rework]

## Findings

### Critical (must fix before merge)
| # | File | Line | Issue | Suggestion |
|---|------|------|-------|------------|
| 1 | | | | |

### Important (should fix)
| # | File | Line | Issue | Suggestion |
|---|------|------|-------|------------|
| 1 | | | | |

### Minor (nice to have)
| # | File | Line | Issue | Suggestion |
|---|------|------|-------|------------|
| 1 | | | | |

### Positive (things done well)
- [Call out good patterns, clean implementations, thoughtful design]

## Security Checklist
- [ ] No hardcoded secrets
- [ ] Input validation at boundaries
- [ ] Auth/authz enforced
- [ ] No SQL/XSS injection vectors
- [ ] Sensitive data not logged

## Test Coverage
- [ ] New code has tests
- [ ] Edge cases covered
- [ ] Tests are meaningful (not just mocking everything)

## Verdict
**[APPROVE / REQUEST_CHANGES / COMMENT]**

[Final notes and recommended next steps]
```

## Rules

- Be specific: always include file path and line number
- Be constructive: every criticism must include a concrete suggestion
- Be proportional: don't nitpick formatting when there are logic bugs
- Prioritize: Critical > Important > Minor
- Acknowledge good work: always include positive findings
- No false positives: only flag issues you're confident about

You are generating an end-of-session summary. This runs before the user closes their session to capture context, decisions, learnings, and continuity information. The goal is threefold: (1) enable the next session to pick up seamlessly, (2) build a persistent memory that makes future sessions smarter, and (3) keep project documents in sync with what actually happened.

## Step 1: Analyze the Session

Review the full conversation history from this session. Extract:

### What Happened
- **Session goal:** What was the user trying to accomplish?
- **Project:** Which project was this session working on? (directory path)
- **Accomplished:** What was completed? (be specific — files created, features built, bugs fixed)
- **In progress:** What was started but not finished?
- **Left off at:** Exact state — what file, what function, what was the last thing being worked on?

### Decisions Made
- What choices were made and why?
- What alternatives were considered and rejected?
- What trade-offs were accepted?

### Problems & Solutions
- What errors or blockers were encountered?
- How were they resolved?
- What was tried that DIDN'T work? (critical for avoiding repeated failures)
- What's still blocked and why?

### Learnings
- What project-specific knowledge was gained? (architecture patterns, gotchas, conventions)
- What user preferences were revealed? (communication style, code style, workflow preferences, autonomy level)
- What technical insights emerged? (library quirks, performance findings, integration details)

## Step 2: Update Project Documents

If the session worked on a project that has these documents, update them:

### Task Tracker (TASK_TRACKER.md)
- Check off tasks that were completed this session
- Update status of in-progress tasks
- Add new tasks discovered during the session
- Update the Progress Summary table counts

### Decision Log (DECISION_LOG.md)
- Add any decisions made this session as new entries (DEC-XXX)
- Move any resolved questions from Open Questions to Decisions
- Add new open questions that emerged

### Backlog (BACKLOG.md)
- Add any ideas, tech debt, or future work identified during the session
- Update priorities if the session revealed new information

### Test Plan (TEST_PLAN.md)
- Update test case statuses if tests were written or run
- Add new test cases for features built this session
- Log test runs in the Test Run Log

If a document doesn't exist or the project doesn't use this system, skip those updates.

## Step 3: Write Session Summary

Create the summary file at: `~/.claude/sessions/<project-name>_<YYYY-MM-DD>_<HH-MM>.md`

If `~/.claude/sessions/` doesn't exist, create it.

Use this structure:

```markdown
# Session Summary
> **Date:** YYYY-MM-DD HH:MM
> **Project:** [name] ([path])
> **Duration context:** [brief/moderate/deep session]

## Goal
[What the user was trying to accomplish]

## Accomplished
- [Specific deliverable 1]
- [Specific deliverable 2]

## In Progress
- [Unfinished item — current state and what's left]

## Pick Up Here
[Exact context for the next session: what file, what function, what state, what to do next]

## Decisions Made
| Decision | Choice | Rationale | Alternatives Rejected |
|----------|--------|-----------|----------------------|
| | | | |

## What Didn't Work
- [Failed approach and why it failed — prevents repeating]

## Blockers & Open Questions
- [Blocker/question — what's needed to resolve it]

## Learnings
### Project Knowledge
- [Architecture/codebase insight gained]

### User Preferences
- [Communication or workflow preference observed]

### Technical Insights
- [Library, tool, or technique insight]

## Documents Updated
- [ ] Task Tracker — [what changed]
- [ ] Decision Log — [what changed]
- [ ] Backlog — [what changed]
- [ ] Test Plan — [what changed]

## Next Session Should
1. [First thing to do]
2. [Second thing to do]
3. [Context needed before starting]
```

## Step 4: Update Persistent Memory

Read `~/.claude/memory/MEMORY.md` (or the project-level auto memory at `~/.claude/projects/*/memory/MEMORY.md`).

### Promote durable learnings
Add to MEMORY.md only insights that will be useful across multiple sessions:
- User preferences that are consistent (not one-off)
- Project architecture patterns that won't change frequently
- Tool/library gotchas that apply broadly
- Workflow patterns that worked well

### Don't pollute memory with
- Session-specific details (that's what the session summary is for)
- Temporary blockers already resolved
- One-time decisions that won't recur

### Update format
When adding to MEMORY.md, use concise entries:
```
## [Category]
- [Insight] — learned [date]
```

Remove or update entries that this session proved wrong or outdated.

## Step 5: Recursive Learning — Meta-Reflection

At the end of the summary, add a brief meta section:

```markdown
## Meta: Session Effectiveness
- **What worked well:** [approach, communication pattern, tool usage]
- **What could improve:** [where we lost time, miscommunication, wrong assumptions]
- **Memory usefulness:** [which MEMORY.md entries helped? which were noise?]
```

This section feeds back into improving the summary process itself. If multiple sessions flag the same "could improve" pattern, promote it to MEMORY.md as a workflow adjustment.

## Step 6: Show Summary to User

After writing the file, show the user a compact version:

```
Session summary saved: ~/.claude/sessions/<filename>.md

Accomplished: [1-2 line summary]
Pick up next: [1 line — where to start]
Docs updated: [list which project docs were changed]
Memory updated: [what was added to MEMORY.md, if anything]
```

## Rules

- ALWAYS write the session file — even for short sessions, context matters
- Be specific about "where we left off" — file paths, function names, exact state
- "What didn't work" is as valuable as "what did work" — capture both
- Don't pad the summary — if it was a 5-minute session, a 5-line summary is fine
- User preferences should be observed, not assumed — only record what was demonstrated
- MEMORY.md should stay under 200 lines — be selective about what gets promoted
- Session summaries are append-only — never edit or delete previous session files
- If this is the first session for a project, note that in the summary

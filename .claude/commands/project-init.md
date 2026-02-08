You are initializing a new project with the required document set. Your job is to evaluate what already exists, scaffold missing documents, and walk the user through filling gaps — not ask questions the codebase already answers.

## Step 1: Evaluate Existing Context

Before asking anything, scan the current working directory for existing information:

### Files to Look For
- `README.md`, `README` — project description, purpose, setup instructions
- `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod` — tech stack, dependencies, project name
- `CLAUDE.md`, `.cursorrules`, `.cursor/rules/` — existing AI context and conventions
- `docker-compose.yml`, `Dockerfile` — infrastructure and services
- `.env.example`, `.env.sample` — environment variables and integrations
- `schema.prisma`, `migrations/`, `*.sql`, `models/` — database and data models
- `tsconfig.json`, `vite.config.*`, `next.config.*`, `webpack.config.*` — build tooling
- `src/`, `app/`, `lib/`, `api/` — existing code structure
- Any existing planning docs: `PRD.md`, `ARCHITECTURE.md`, `IMPLEMENTATION_PLAN.md`, `TASK_TRACKER.md`, `DECISION_LOG.md`, `BACKLOG.md`, `TEST_PLAN.md`
- Existing test setup: `tests/`, `__tests__/`, `spec/`, `*.test.*`, `*.spec.*`, `jest.config.*`, `vitest.config.*`, `pytest.ini`, `.mocharc.*`

### What to Extract
- **Project name** — from package.json, README, or directory name
- **Problem statement** — from README description
- **Tech stack** — from dependency files and config
- **Data models** — from schema files or model definitions
- **Integrations** — from .env.example, docker-compose, dependency list
- **Existing architecture** — from directory structure and code organization
- **Current state** — how much code exists, is this greenfield or in-progress?

### Sufficiency Report

Before proceeding, output a context summary:

```
Project Context Found:
  Name:         [extracted or unknown]
  Tech Stack:   [extracted or unknown]
  Database:     [extracted or unknown]
  Integrations: [extracted or unknown]
  Code State:   [greenfield / early / in-progress / mature]

  Can auto-fill:  PRD (partial/full/none), Architecture (partial/full/none), etc.
  Still need from you: [list of gaps]
```

## Step 2: Check for Existing Documents

Check if any of these already exist at the project root:
- PRD.md
- ARCHITECTURE.md
- IMPLEMENTATION_PLAN.md
- TASK_TRACKER.md
- DECISION_LOG.md
- BACKLOG.md
- TEST_PLAN.md

If any exist, read them and ask: skip, overwrite, or merge with new context.

Also check if `reports/` directory exists. Create it if not.

## Step 3: Create Documents

Create the following at the **project root** (not in a subdirectory):
- `PRD.md`
- `ARCHITECTURE.md`
- `IMPLEMENTATION_PLAN.md`
- `TASK_TRACKER.md`
- `DECISION_LOG.md`
- `BACKLOG.md`
- `TEST_PLAN.md`

Create `reports/` directory if it doesn't exist.

If `$ARGUMENTS` contains a path to a templates directory, use those as the base structure.

Pre-fill every section you can from the context gathered in Step 1.

## Step 4: Interactive Gap-Filling

Only ask about what you could NOT determine from existing files. Skip rounds that are fully covered.

### Round 1: Project Identity (skip if README covers this)
1. In one sentence, what problem does this solve?
2. Who is the primary user?

### Round 2: Scope & Requirements (skip if sufficient code/docs exist)
1. What are the 3-5 core features or capabilities?
2. What is explicitly OUT of scope for v1?
3. Any hard constraints not evident from the codebase?

### Round 3: Technical Direction (skip if fully extractable from config/code)
1. Confirm or correct the tech stack detected
2. Database needs if not already evident
3. External integrations not found in .env or config

### Round 4: Phases & Planning
1. How many phases? (suggest 3 if unsure: Foundation, Core Features, Polish)
2. What's the goal of each phase?
3. What does "done" look like for phase 1?

## Step 5: Create Initial Tasks & Backlog

**Task Tracker:** Break Phase 1 into concrete checkable tasks:
- Each task: ID (T-001), description, status, dependencies, definition of done
- Keep Phase 2/3 as placeholders for now

**Backlog:** Populate with:
- Features identified but not scheduled into a phase
- Nice-to-haves mentioned during the interview
- Technical debt items found during codebase scan
- Ideas that came up but aren't committed to yet

Each backlog item gets: ID (BL-001), description, priority (P0-P3), source (interview/codebase scan/idea)

## Step 6: Record Initial Decisions

- DEC-001: Tech Stack Selection (record what was chosen/detected and why)
- Add unanswered questions to Open Questions table in Decision Log

## Step 7: Summary

```
Project initialized: [Project Name]

Documents created:
  PRD.md                    — [X requirements, X user stories]
  ARCHITECTURE.md           — [tech stack, X components]
  IMPLEMENTATION_PLAN.md    — [X phases defined]
  TASK_TRACKER.md           — [X tasks in Phase 1]
  DECISION_LOG.md           — [X decisions, X open questions]
  BACKLOG.md                — [X items captured]
  TEST_PLAN.md              — [X test cases, verification matrix initialized]
  reports/                  — ready for generated reports

Auto-filled from codebase: [list what was extracted]
Filled from interview:     [list what was asked]
Still needs attention:     [list any sparse sections]

Next steps:
  1. Review and refine the PRD
  2. Start working on Phase 1 tasks
  3. Run /project-review anytime to check progress
  4. Run /verify after each phase to confirm requirements are met
```

## Rules

- NEVER leave documents blank — fill from codebase context or interview answers
- If neither source answers a section, record it as an Open Question in Decision Log
- DO NOT ask questions the codebase already answers — extract first, confirm if unsure
- Documents go at the PROJECT ROOT, not in a subdirectory
- Task IDs: T-001, T-002, etc. Backlog IDs: BL-001, BL-002, etc.
- Phase numbering must match across Implementation Plan and Task Tracker

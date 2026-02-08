# cursor-extensions

Cross-tool AI commands for Claude Code, Cursor, and Claude Cowork. Project management commands that enforce document-driven development — from init through verification.

## What This Is

A set of slash commands and document templates that work across three AI coding tools:

- **Claude Code** — `.claude/commands/*.md`
- **Cursor** — `.cursor/rules/*.mdc`
- **Claude Cowork** — Portable system prompts for Claude.ai Projects or any LLM

Each command exists in all three formats. The core logic is the same; the wrapper adapts to each tool's conventions.

## Commands

| Command | When to Use | What It Does |
|---------|-------------|-------------|
| `/project-init` | Start of project | Evaluates existing codebase, scaffolds 7 required docs, interviews for gaps |
| `/project-review` | During development | Audits doc health vs codebase, flags stubs/mocks, generates progress report |
| `/code-review` | Per code change | Reviews for correctness, security (OWASP), performance, testing |
| `/verify` | End of phase | Checks every acceptance criterion against actual codebase |
| `/session-summary` | End of session | Captures context, updates docs, builds persistent memory |
| `/generate-command` | Anytime | Creates a new command for all 3 tools from a single description |

## Document Templates

Every project initialized with `/project-init` gets these 7 documents at the project root:

| Template | Purpose |
|----------|---------|
| `PRD.md` | Requirements, user stories, acceptance criteria |
| `ARCHITECTURE.md` | Tech stack, components, data models, integrations |
| `IMPLEMENTATION_PLAN.md` | Phased execution with steps, dependencies, exit criteria |
| `TASK_TRACKER.md` | Checkable task list with IDs, status, definitions of done |
| `BACKLOG.md` | Unscheduled features, tech debt, ideas (P0-P3 priority) |
| `DECISION_LOG.md` | Decisions made, alternatives considered, open questions |
| `TEST_PLAN.md` | Test cases mapped to requirements, verification matrix |

## Installation

### Quick — All commands into a project

```bash
git clone https://github.com/AllInStride/cursor-extensions.git
cd cursor-extensions
./install.sh ~/projects/your-project
```

### With document templates

```bash
./install.sh ~/projects/your-project --with-templates
```

### Specific commands only

```bash
./install.sh ~/projects/your-project --commands project-init,verify,session-summary
```

### Cowork plugin only

```bash
./install.sh ~/projects/your-project --plugin-only
# Then: claude --plugin-dir ~/projects/your-project/cursor-extensions-plugin
```

### Manual

Copy what you need:

```bash
# Claude Code
cp commands/<command>/claude-code.md ~/projects/your-project/.claude/commands/<command>.md

# Cursor
cp commands/<command>/cursor.mdc ~/projects/your-project/.cursor/rules/<command>.mdc

# Cowork — copy the plugin directory
cp -r plugin ~/projects/your-project/cursor-extensions-plugin
# Then: claude --plugin-dir ~/projects/your-project/cursor-extensions-plugin
```

## Project Structure

```
cursor-extensions/
├── commands/                      # Source of truth — organized by command
│   ├── project-init/
│   │   ├── claude-code.md         # Claude Code version
│   │   ├── cursor.mdc             # Cursor version
│   │   └── cowork.md              # Cowork / system prompt version
│   ├── project-review/
│   ├── code-review/
│   ├── verify/
│   ├── session-summary/
│   └── generate-command/
├── templates/                     # Document templates
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   ├── IMPLEMENTATION_PLAN.md
│   ├── TASK_TRACKER.md
│   ├── BACKLOG.md
│   ├── DECISION_LOG.md
│   └── TEST_PLAN.md
├── plugin/                        # Cowork plugin (ready to load)
│   ├── .claude-plugin/
│   │   └── plugin.json           # Plugin manifest
│   └── commands/                  # Same commands, plugin-packaged
├── .claude/commands/              # Active Claude Code installs
├── .cursor/rules/                 # Active Cursor installs
├── install.sh                     # Installer script
└── README.md
```

## Workflow

```
/project-init          Create docs, evaluate context, interview for gaps
      │
      ▼
   Build code          Track progress in TASK_TRACKER.md
      │
      ▼
/project-review        Check doc health, flag stubs and drift
      │
      ▼
/code-review           Review changes for quality, security, testing
      │
      ▼
/verify                Prove acceptance criteria are met — the "prove it" step
      │
      ▼
/session-summary       Capture context, update docs, build memory
```

## How Cowork Works

Claude Cowork uses the same command format as Claude Code — markdown files with `$ARGUMENTS`. The difference is packaging: Cowork loads commands as a **plugin**.

### Using with Cowork

```bash
# Option 1: Load plugin directly from this repo
claude --plugin-dir ./plugin

# Option 2: After installing to a project
claude --plugin-dir ~/projects/my-app/cursor-extensions-plugin
```

Commands are namespaced in Cowork: `/cursor-extensions:project-init`, `/cursor-extensions:verify`, etc.

### Portable Versions

Each command also has a `portable.md` — a system-prompt version for use with:

- **Claude.ai Projects** — Paste into Project Instructions
- **Claude API** — Use as system prompt
- **Any LLM** — Model-agnostic workflow instructions

## Creating New Commands

Use `/generate-command` to describe what you want, and it produces all three tool versions automatically.

```
/generate-command

> "Create a command that audits npm dependencies for security vulnerabilities,
>  checks for outdated packages, and generates a dependency health report"
```

This generates `security-audit` for Claude Code, Cursor, and Cowork in one step.

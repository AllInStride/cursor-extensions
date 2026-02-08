#!/usr/bin/env bash
set -euo pipefail

# cursor-extensions installer
# Copies commands and optionally templates into a target project

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
    echo "Usage: ./install.sh <target-project-path> [options]"
    echo ""
    echo "Options:"
    echo "  --with-templates    Also copy document templates to target project root"
    echo "  --commands          Comma-separated list of commands to install (default: all)"
    echo "                      Available: project-init,project-review,code-review,verify,session-summary,generate-command"
    echo "  --plugin-only       Only install the Cowork plugin (skip Claude Code + Cursor)"
    echo ""
    echo "Examples:"
    echo "  ./install.sh ~/projects/my-app                          # Install all (Claude Code + Cursor + Cowork plugin)"
    echo "  ./install.sh ~/projects/my-app --with-templates         # Commands + templates"
    echo "  ./install.sh ~/projects/my-app --commands project-init,verify  # Specific commands only"
    echo "  ./install.sh ~/projects/my-app --plugin-only            # Only install Cowork plugin"
    echo ""
    echo "Cowork plugin:"
    echo "  After installing, load the plugin in Claude Cowork with:"
    echo "    claude --plugin-dir <target>/cursor-extensions-plugin"
    exit 1
}

if [ -z "$TARGET" ]; then
    usage
fi

if [ ! -d "$TARGET" ]; then
    echo -e "${RED}Error: Target directory does not exist: $TARGET${NC}"
    exit 1
fi

# Parse flags
WITH_TEMPLATES=false
SELECTED_COMMANDS=""
PLUGIN_ONLY=false

shift
while [[ $# -gt 0 ]]; do
    case $1 in
        --with-templates)
            WITH_TEMPLATES=true
            shift
            ;;
        --commands)
            SELECTED_COMMANDS="$2"
            shift 2
            ;;
        --plugin-only)
            PLUGIN_ONLY=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

ALL_COMMANDS="project-init project-review code-review verify session-summary generate-command"

if [ -n "$SELECTED_COMMANDS" ]; then
    COMMANDS=$(echo "$SELECTED_COMMANDS" | tr ',' ' ')
else
    COMMANDS="$ALL_COMMANDS"
fi

echo -e "${GREEN}Installing cursor-extensions to: $TARGET${NC}"
echo ""

# ── Claude Code + Cursor ──────────────────────────────────────────────
INSTALLED=0
if [ "$PLUGIN_ONLY" = false ]; then
    mkdir -p "$TARGET/.claude/commands"
    mkdir -p "$TARGET/.cursor/rules"
    mkdir -p "$TARGET/reports"

    for cmd in $COMMANDS; do
        CMD_DIR="$SCRIPT_DIR/commands/$cmd"
        if [ ! -d "$CMD_DIR" ]; then
            echo -e "${YELLOW}  Skip: $cmd (not found in source)${NC}"
            continue
        fi

        # Claude Code
        if [ -f "$CMD_DIR/claude-code.md" ]; then
            cp "$CMD_DIR/claude-code.md" "$TARGET/.claude/commands/$cmd.md"
        fi

        # Cursor
        if [ -f "$CMD_DIR/cursor.mdc" ]; then
            cp "$CMD_DIR/cursor.mdc" "$TARGET/.cursor/rules/$cmd.mdc"
        fi

        echo -e "  ${GREEN}Installed:${NC} /$cmd (Claude Code + Cursor)"
        INSTALLED=$((INSTALLED + 1))
    done
fi

# ── Cowork Plugin ─────────────────────────────────────────────────────
PLUGIN_DIR="$TARGET/cursor-extensions-plugin"
if [ -d "$SCRIPT_DIR/plugin" ]; then
    # Copy full plugin directory
    rm -rf "$PLUGIN_DIR"
    cp -r "$SCRIPT_DIR/plugin" "$PLUGIN_DIR"

    # If specific commands selected, remove unwanted ones from plugin
    if [ -n "$SELECTED_COMMANDS" ]; then
        for cmd_file in "$PLUGIN_DIR/commands/"*.md; do
            cmd_name=$(basename "$cmd_file" .md)
            if ! echo "$COMMANDS" | grep -qw "$cmd_name"; then
                rm "$cmd_file"
            fi
        done
    fi

    echo ""
    echo -e "  ${CYAN}Plugin:${NC} cursor-extensions-plugin/ (Cowork)"
    echo -e "         Load with: claude --plugin-dir $PLUGIN_DIR"
fi

# ── Templates ─────────────────────────────────────────────────────────
TEMPLATE_COUNT=0
if [ "$WITH_TEMPLATES" = true ]; then
    echo ""
    for template in "$SCRIPT_DIR/templates/"*.md; do
        if [ -f "$template" ]; then
            filename=$(basename "$template")
            if [ -f "$TARGET/$filename" ]; then
                echo -e "  ${YELLOW}Exists:${NC} $filename (skipped — already in project)"
            else
                cp "$template" "$TARGET/$filename"
                echo -e "  ${GREEN}Copied:${NC} $filename"
                TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
            fi
        fi
    done
fi

# ── Summary ───────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Done.${NC}"
[ "$PLUGIN_ONLY" = false ] && echo "  Commands installed: $INSTALLED (Claude Code + Cursor)"
echo "  Cowork plugin: $PLUGIN_DIR"
[ "$WITH_TEMPLATES" = true ] && echo "  Templates copied: $TEMPLATE_COUNT"
[ "$PLUGIN_ONLY" = false ] && echo "  Reports directory: $TARGET/reports/"
echo ""
echo "Available commands:"
for cmd in $COMMANDS; do
    CMD_DIR="$SCRIPT_DIR/commands/$cmd"
    if [ -d "$CMD_DIR" ]; then
        echo "  /$cmd"
    fi
done
echo ""
echo "To use with Cowork:"
echo "  claude --plugin-dir $PLUGIN_DIR"

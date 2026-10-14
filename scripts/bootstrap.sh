#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo "      SDD Framework Bootstrap"
echo "======================================"
echo

ROOT="$(pwd)"

# ------------------------------------------------------------
# 1. Ensure we are in repo root
# ------------------------------------------------------------
if [[ ! -d ".claude" ]]; then
  echo "❌ ERROR: .claude/ directory not found."
  echo "You must run this script from the repository root."
  exit 1
fi

if [[ ! -d ".claude/commands" ]]; then
  echo "❌ ERROR: .claude/commands directory not found."
  echo "This repo may be incomplete."
  exit 1
fi

echo "✅ Repository root detected."
echo

# ------------------------------------------------------------
# 2. Verify custom command folders
# ------------------------------------------------------------
OPSX_DIR=".claude/commands/opsx"
AISPECS_DIR=".claude/commands/ai-specs"

if [[ ! -d "$OPSX_DIR" ]]; then
  echo "❌ ERROR: Missing $OPSX_DIR"
  exit 1
fi

if [[ ! -d "$AISPECS_DIR" ]]; then
  echo "❌ ERROR: Missing $AISPECS_DIR"
  exit 1
fi

OPSX_COUNT=$(find "$OPSX_DIR" -type f -name "*.md" | wc -l | tr -d ' ')
AISPECS_COUNT=$(find "$AISPECS_DIR" -type f -name "*.md" | wc -l | tr -d ' ')

if [[ "$OPSX_COUNT" -eq 0 ]]; then
  echo "❌ ERROR: No opsx command files found."
  exit 1
fi

if [[ "$AISPECS_COUNT" -eq 0 ]]; then
  echo "❌ ERROR: No ai-specs command files found."
  exit 1
fi

echo "✅ opsx commands detected: $OPSX_COUNT"
echo "✅ ai-specs commands detected: $AISPECS_COUNT"
echo

# ------------------------------------------------------------
# 3. Check OpenSpec CLI installation
# ------------------------------------------------------------
echo "Checking OpenSpec CLI..."

MIN_OPENSPEC_VERSION="1.14.1"

if command -v openspec >/dev/null 2>&1; then
  INSTALLED_OPENSPEC_VERSION="$(openspec --version 2>/dev/null || echo 'unknown')"
  echo "✅ OpenSpec CLI detected: $INSTALLED_OPENSPEC_VERSION"

  LOWEST_VERSION="$(printf '%s\n%s\n' "$MIN_OPENSPEC_VERSION" "$INSTALLED_OPENSPEC_VERSION" | sort -V | head -1)"
  if [[ "$INSTALLED_OPENSPEC_VERSION" == "unknown" || "$LOWEST_VERSION" != "$MIN_OPENSPEC_VERSION" ]]; then
    echo "⚠️  OpenSpec CLI $MIN_OPENSPEC_VERSION or later is required by the commands in .claude/."
    echo "Upgrade the CLI only (this does not touch the repository files):"
    echo "  npm install -g @fission-ai/openspec@latest"
  fi
else
  echo "⚠️  OpenSpec CLI is NOT installed."
  echo
  echo "Install it using your preferred method:"
  echo "  npm install -g @fission-ai/openspec@latest"
  echo "  or"
  echo "  pnpm add -g @fission-ai/openspec@latest"
  echo
fi

echo

# ------------------------------------------------------------
# 4. Detect potential misuse of 'openspec init' / 'openspec update'
# ------------------------------------------------------------
echo "Verifying repository integrity..."

if [[ ! -d "openspec" ]]; then
  echo "⚠️ WARNING: openspec/ directory not found."
  echo "This template should include it."
fi

# Optional heuristic check:
DEFAULT_MARKER=".claude/commands/default"

if [[ -d "$DEFAULT_MARKER" ]]; then
  echo
  echo "⚠️ It looks like default OpenSpec commands may have been generated."
  echo "If someone ran 'openspec init', custom commands might be overwritten."
  echo
  echo "DO NOT run 'openspec init' in this repository."
fi

# Each customized command must still contain a marker of its customization.
# 'openspec init' and 'openspec update' regenerate these files and drop the markers.
CUSTOMIZATION_MARKERS=(
  "$OPSX_DIR/apply.md|Live Design Mode"
  "$OPSX_DIR/continue.md|[BE]"
  "$OPSX_DIR/ff.md|/opsx:continue"
  "$OPSX_DIR/propose.md|/opsx:ff"
  "$OPSX_DIR/archive.md|/ai-specs:update-docs"
  "$OPSX_DIR/bulk-archive.md|Update Notion Status"
  ".claude/skills/openspec-apply-change/SKILL.md|.claude/commands/opsx/apply.md"
  ".claude/skills/openspec-continue-change/SKILL.md|.claude/commands/opsx/continue.md"
  ".claude/skills/openspec-ff-change/SKILL.md|.claude/commands/opsx/ff.md"
  ".claude/skills/openspec-propose/SKILL.md|.claude/commands/opsx/propose.md"
  ".claude/skills/openspec-archive-change/SKILL.md|.claude/commands/opsx/archive.md"
  ".claude/skills/openspec-bulk-archive-change/SKILL.md|.claude/commands/opsx/bulk-archive.md"
)

OVERWRITTEN_COUNT=0
for ENTRY in "${CUSTOMIZATION_MARKERS[@]}"; do
  MARKER_FILE="${ENTRY%%|*}"
  MARKER_TEXT="${ENTRY#*|}"
  if [[ ! -f "$MARKER_FILE" ]] || ! grep -qF -- "$MARKER_TEXT" "$MARKER_FILE"; then
    echo "⚠️  Customization missing in $MARKER_FILE (expected: '$MARKER_TEXT')"
    OVERWRITTEN_COUNT=$((OVERWRITTEN_COUNT + 1))
  fi
done

if [[ "$OVERWRITTEN_COUNT" -gt 0 ]]; then
  echo
  echo "❌ ERROR: $OVERWRITTEN_COUNT customized OpenSpec file(s) appear to be overwritten."
  echo "This usually means 'openspec init' or 'openspec update' was run in this repository."
  echo "Restore them from git, e.g.: git checkout -- .claude/"
  exit 1
fi

echo "✅ Repository structure looks correct."
echo

# ------------------------------------------------------------
# 5. Claude Code reminder
# ------------------------------------------------------------
echo "Next Steps:"
echo
echo "1) Open this folder in VS Code."
echo "2) Ensure Workspace Trust is enabled."
echo "3) Open Claude Code (NOT Copilot Chat)."
echo "4) Type '/' in Claude Code to verify commands are detected."
echo
echo "IMPORTANT:"
echo "This repository is already initialized."
echo "DO NOT run: openspec init / openspec update"
echo
echo "Bootstrap completed successfully."
echo "======================================"
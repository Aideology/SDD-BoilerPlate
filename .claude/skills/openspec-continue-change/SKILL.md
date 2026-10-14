---
name: openspec-continue-change
description: Continue working on an OpenSpec change by creating the next artifact. Use when the user wants to progress their change, create the next artifact, or continue their workflow. Also use when the user says "openspec continue" or "opsx continue".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:continue` workflow.

**Before doing anything else**, read `.claude/commands/opsx/continue.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:continue`. Treat the user's request (for example, a change name) as the command argument.

That command file is the single source of truth for this workflow. On top of the standard OpenSpec continue workflow, it adds the project rules for enriched-section extraction, scope/design metadata (backend/frontend/design-linked), Figma design references, and `[BE]`/`[FE]`/`[TEST]`/`[E2E]` task tagging.

**Guardrails**
- Do NOT fall back to a generic OpenSpec continue workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

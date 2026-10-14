---
name: openspec-archive-change
description: Archive a completed OpenSpec change in the experimental workflow. Use when the user wants to finalize and archive a change after implementation is complete. Also use when the user says "openspec archive" or "opsx archive".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:archive` workflow.

**Before doing anything else**, read `.claude/commands/opsx/archive.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:archive`. Treat the user's request (for example, a change name) as the command argument.

That command file is the single source of truth for this workflow. On top of the standard OpenSpec archive workflow, it adds the project rules for the mandatory documentation update (`/ai-specs:update-docs`, with the blocking rule for `ai-specs/specs/api-spec.yml`) and the Notion Status update to `Done` after a successful archive.

**Guardrails**
- Do NOT fall back to a generic OpenSpec archive workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

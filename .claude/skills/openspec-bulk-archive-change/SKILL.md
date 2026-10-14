---
name: openspec-bulk-archive-change
description: Archive multiple completed OpenSpec changes at once. Use when archiving several parallel changes. Also use for a plural archive request - "openspec bulk-archive", "opsx bulk-archive", "openspec archive all", or "openspec archive these changes".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:bulk-archive` workflow.

**Before doing anything else**, read `.claude/commands/opsx/bulk-archive.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:bulk-archive`.

That command file is the single source of truth for this workflow. On top of the standard OpenSpec bulk-archive workflow, it adds the project rule for the Notion Status update to `Done` for each successfully archived change.

**Guardrails**
- Do NOT fall back to a generic OpenSpec bulk-archive workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

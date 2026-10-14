---
name: openspec-ff-change
description: Fast-forward through OpenSpec artifact creation. Use when the user wants to quickly create all artifacts needed for implementation without stepping through each one individually. Also use when the user says "openspec ff" or "opsx ff".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:ff` workflow.

**Before doing anything else**, read `.claude/commands/opsx/ff.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:ff`. Treat the user's request (a change name or a description of what to build) as the command argument.

That command file is the single source of truth for this workflow. It orchestrates the `/opsx:continue` logic in a loop until every artifact in the transitive required set is complete, so every artifact carries the project rules for scope/design metadata, Figma design references, and FE/BE task tagging.

**Guardrails**
- Do NOT fall back to a generic OpenSpec fast-forward workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

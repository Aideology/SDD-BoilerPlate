---
name: openspec-apply-change
description: Implement tasks from an OpenSpec change. Use when the user wants to start implementing, continue implementation, or work through tasks. Also use when the user says "openspec apply", "opsx apply", or "openspec implement".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:apply` workflow.

**Before doing anything else**, read `.claude/commands/opsx/apply.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:apply`. Treat the user's request (for example, a change name) as the command argument.

That command file is the single source of truth for this workflow. On top of the standard OpenSpec apply workflow, it adds the project rules for scope metadata (backend/frontend), Figma Live Design Mode with mandatory design tokens, the UI framework compatibility gate, and the post-apply smoke test.

**Guardrails**
- Do NOT fall back to a generic OpenSpec apply workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

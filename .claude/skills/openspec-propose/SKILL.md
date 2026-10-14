---
name: openspec-propose
description: Propose a new OpenSpec change with all artifacts generated in one step. Use when the user wants to quickly describe what they want to build and get a complete proposal with design, specs, and tasks ready for implementation. Also use when the user says "openspec propose" or "opsx propose".
allowed-tools: Bash(openspec:*)
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.14.1"
---

This skill is the natural-language entry point for this repository's customized `/opsx:propose` workflow.

**Before doing anything else**, read `.claude/commands/opsx/propose.md` (relative to the repository root) and follow it exactly, as if the user had run `/opsx:propose`. Treat the user's request (a change name or a description of what to build) as the command argument.

That command file is the single source of truth for this workflow. It is planning only, and it generates every artifact through the `/opsx:ff` logic (which delegates to `/opsx:continue`), so every artifact carries the project rules for scope/design metadata, Figma design references, and FE/BE task tagging.

**Guardrails**
- Do NOT fall back to a generic OpenSpec propose workflow, and do not reconstruct the steps from memory.
- When the command refers to another slash command (`/opsx:*` or `/ai-specs:*`), read its file under `.claude/commands/<namespace>/<name>.md` and follow it the same way.
- If the command file cannot be read, stop and tell the user that the repository's OpenSpec commands are missing or damaged, and suggest running `bash scripts/bootstrap.sh`.

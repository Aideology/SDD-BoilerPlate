# 🚀 BOOTSTRAP GUIDE

## Using This Repository

This repository is designed to be reused as a **governed development
starter kit** — for both **new (greenfield)** and **existing (brownfield)** projects.

It provides:

-   OpenSpecs workflow (`/opsx:*`)
-   AI governance layer (`/ai-specs:*`)
-   Deterministic standards system
-   Documentation enforcement
-   Spec-Driven Development (SDD)

This guide explains how to bootstrap a new project using this template.

------------------------------------------------------------------------

# 1. Create a New Project from This Template

Option A (Recommended): - Mark this repository as a GitHub Template. -
Click **"Use this template"** to create a new repo.

Option B: - Clone this repository. - Remove its `.git` folder. -
Initialize a new Git repository.

------------------------------------------------------------------------

# 2. Clean Project-Specific Content

Keep:

-   `.claude/`
-   `ai-specs/`
-   `openspec/`
-   `CLAUDE.md`
-   `.gitignore`
-   `README.md`
-   `BOOTSTRAP.md`

Remove (if present):

-   Old project source code
-   Previous domain-specific models
-   Old CI config (if not reusable)
-   Example APIs or dummy data

The governance and workflow system must remain intact.

# ⚠️ IMPORTANT — DO NOT RUN `openspec init` OR `openspec update`

This repository is **already initialized**.

Running either of:

```bash
openspec init
openspec update
```

inside this project regenerates the OpenSpec instruction files and **overwrites**:

-   Custom `/opsx:*` commands (`apply`, `continue`, `ff`, `propose`, `archive`, `bulk-archive`)
-   The `openspec-*` skills that delegate to those custom commands
-   The curated OpenSpec structure

If you do this, the custom workflow (scope/design metadata, Figma Live Design Mode,
FE/BE task tagging, documentation and Notion steps on archive) is silently lost.

In this repository, NEVER run `openspec init` or `openspec update`.
To upgrade OpenSpec, follow [Upgrading OpenSpec](#15-upgrading-openspec).

------------------------------------------------------------------------

# 3. Minimum Requirements (New Machine)

Install the following:

Git

Node.js (if OpenSpec is installed via npm/pnpm)

OpenSpec CLI **1.14.1 or later** (`npm install -g @fission-ai/openspec@latest`).
The commands in `.claude/` are generated from OpenSpec 1.14.1 and rely on its
status/instructions JSON fields.

(Optional) Python, if required by your backend stack

VS Code

The Claude Code VS Code extension (Anthropic)

# 4. Setup Steps

Clone the repository:

git clone <YOUR_REPO>
cd <YOUR_REPO>

Run the bootstrap script:

bash scripts/bootstrap.sh

The script will:

Verify you are in the correct project root

Verify custom Claude commands exist

Check if OpenSpec CLI is installed

Warn if openspec init was executed accidentally

Provide corrective guidance if something is missing

# 5. First-Time Project Usage

This is the actual minimal workflow.

Some commands exist but are not required in every scenario.

# 6. Initialize Standards (MANDATORY)

If these files do not exist:

-   `ai-specs/specs/backend-standards.mdc`
-   `ai-specs/specs/frontend-standards.mdc`

Choose the appropriate initialization command:

## 6a. Greenfield (new project, no existing code)

```bash
/ai-specs:init-greenfield
```

You will be prompted for:

-   Backend language & framework
-   Architecture pattern
-   Database & ORM
-   API style (REST / GraphQL)
-   Testing stack
-   Frontend framework
-   Tooling & CI strategy

This generates deterministic, stack-specific standards.

## 6b. Brownfield (existing codebase)

```bash
/ai-specs:init-brownfield
```

This command will:

1. **Discover** — Auto-detect stack, architecture, and modules from existing code
2. **Normalize** — Generate technical standards that reflect reality (`ai-specs/specs/*`)
3. **Baseline** — Capture existing capabilities as functional specs (`openspec/specs/*`)
4. **Prepare** — Leave the project ready for incremental SDD changes

No source code is modified. Only documentation and spec files are generated.

---

Without this step, development is blocked by design.

------------------------------------------------------------------------


# 7. Create User Stories (If using Notion MCP)

```bash
/ai-specs:new-us
```

This command internally calls:

/ai-specs:enrich-us

to ensure the story follows SDD structure.

Then the system ask you for POMode or Dev:

# 8.1 Product Owner Mode (PO Mode)

If working in refinement mode:

Iterate on the draft

When ready for implementation:

```bash
/ai-specs:handoff-us
```

This validates and upgrades the story to implementation-ready 
status.

# OR

# 8.2 Development Mode (Dev Mode)

Once the User Story is implementation-ready:

```bash
/opsx:new
```

Then continue working on the change:

```bash
/opsx:continue
```

# 9. Apply (When the 4 Artifacts Are Ready)

When all required artifacts are completed:

```bash
/opsx:apply
```

This step includes:

- Implementation
- Validation
- Verify execution (quality gate)

# 10. Archive

When everything passes validation:

```bash
/opsx:archive
```

# 11. Diagram

![SDD Workflow](/docs/workflow-diagram.png)

Versión mermaid
```mermaid
flowchart TD
  A[Init Standards<br/>/ai-specs:init-greenfield] --> B{Using Notion MCP?}
  B -- Yes --> C[/ai-specs:new-us<br/>(calls enrich-us)/]
  B -- No --> D[Create US manually<br/>using .md in Draft folder]

  C --> E{PO Mode or Dev Mode?}
  D --> E

  E -- PO Mode --> F[Refine draft]
  F --> G[/ai-specs:handoff-us<br/>(implementation-ready)/]
  G --> H[/opsx:new/]

  E -- Dev Mode --> H[/opsx:new/]
  H --> I[/opsx:continue/]

  I --> J{Are 4 artifacts complete?}
  J -- No --> I
  J -- Yes --> K[/opsx:apply<br/>(includes verify)/]
  K --> L{Verify OK?}
  L -- No --> I
  L -- Yes --> M[/opsx:archive/]

```

# 12 Troubleshooting
Claude commands not visible

If /opsx:* or /ai-specs:* commands are not detected:

Make sure VS Code opened the project root (where .claude/ exists)

Ensure Workspace Trust is enabled

Restart VS Code

Confirm you are using Claude Code, not Copilot Chat

Someone ran openspec init or openspec update

If commands stopped working after running openspec init or openspec update:

Run:

bash scripts/bootstrap.sh

Follow the repair instructions provided by the script.

------------------------------------------------------------------------

# 13. Documentation Rules

All documentation lives under:

ai-specs/specs/

Templates live under:

ai-specs/specs/templates/

Templates define structure only. Never copy template example content
verbatim.

Documentation is enforced automatically during:

/opsx:archive

------------------------------------------------------------------------

# 14. Optional Hardening

For stricter governance, consider:

-   Enforcing non-empty standards validation
-   Adding CI validation for api-spec.yml changes
-   Requiring archive before merge
-   Disallowing direct commits to main

------------------------------------------------------------------------

# 15. Upgrading OpenSpec

The files under `.claude/commands/opsx/` and `.claude/skills/openspec-*/` were
generated by OpenSpec and then customized. Never regenerate them in place.
Upgrade them with a three-way merge instead:

1.  **Back up**: tag the current state (e.g. `git tag backup/pre-openspec-<new-version>`)
    and work on a branch.
2.  **Generate a pristine base** with the version that produced the current files
    (see `generatedBy` in any `.claude/skills/openspec-*/SKILL.md`), in an empty
    temporary directory:
    `npx @fission-ai/openspec@<old-version> init --tools claude .`
3.  **Generate the new version** in another empty temporary directory, using an
    isolated config with the `custom` profile and all workflows enabled
    (`XDG_CONFIG_HOME=<tmp>` with `profile: custom` and the full `workflows` list),
    so your global OpenSpec config is not modified:
    `npx @fission-ai/openspec@<new-version> init --tools claude .`
4.  **Merge**: files without local customizations take the new version as-is.
    Customized files are merged with `git merge-file <ours> <base> <theirs>`;
    heavily restructured files (`apply`, `continue`, `ff`) are merged by hand,
    porting each upstream change into our structure.
    Delegating skills keep their body; only refresh their frontmatter
    (for example the `description`) from the new version.
5.  **Verify** that every line added upstream and every local customization
    is present in the merged result, run `bash scripts/bootstrap.sh`, then
    install the new CLI globally.

Commands with local customizations: `apply`, `continue`, `ff`, `propose`
(delegates to `ff`), `archive`, and `bulk-archive`.

Skills that delegate to those commands (their body only says "read
`.claude/commands/opsx/<name>.md` and follow it"): `openspec-apply-change`,
`openspec-continue-change`, `openspec-ff-change`, `openspec-propose`,
`openspec-archive-change`, and `openspec-bulk-archive-change`. This keeps a single
source of truth, so natural-language invocations follow the same custom rules
as the slash commands.

------------------------------------------------------------------------

# Final Principle

This repository is not a code scaffold.

It is a governed development system.

Standards first. Specs first. Code second.

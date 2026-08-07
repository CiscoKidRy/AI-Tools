# AGENTS.md — AI-Tools

## What this repo is
Canonical **AI-tool-agnostic** vault of agent rules, skills, workflows, prompts, and an **Obsidian second brain**. Not an application product.

## Commands
- No build step for markdown-first content.
- Sync rules to Grok: `./scripts/sync-rules-to-local.sh`
- Promote local Grok rules into vault: `./scripts/sync-from-local-rules.sh`
- Second-brain multi-machine sync: `./scripts/sync-second-brain.sh sync` (auto via launchd + agent rule `40-second-brain-auto-sync`)
- Install second-brain timer: `./scripts/install-second-brain-autosync.sh install`
- End-of-session learning capture: skill **`Retrospective`** (`skills/Retrospective/`) — AI-tool-agnostic; propose skills/rules then write only after approval
- Requirements discovery: skill **`plan-interview`** (`skills/plan-interview/`) — quality gates to 95%+; loads **`grounding-discipline`** at start and emits a Grounding Report at end
- Claim hygiene: skill **`grounding-discipline`** (`skills/grounding-discipline/`) — no silent assumptions/hallucinations; FACT/ASSUMPTION/INFERENCE/UNKNOWN + end report
- Preview structure: `find . -type f -not -path './.git/*' | sort`

## Architecture invariants
- `rules/` = always-on, short, durable, **tool-agnostic** constraints; **source of truth** for the constitution.
- `skills/` = procedures (versioned, disposable).
- `workflows/` = multi-agent orchestration.
- `templates/` = copy-into-project starters.
- `second-brain/` = Obsidian vault root; open this path in Obsidian (not necessarily the monorepo root).
- Do not store secrets, tokens, or personal customer data.
- Local product configs (e.g. `~/.grok/rules/`) are **mirrors**; keep them synced with `rules/`.

## Conventions
- Prefer Markdown and portable names (`AGENTS.md`, `rules/`, `skills/`) over single-vendor lock-in.
- Default branch: `main`.
- Small reviewable commits; group related tool + second-brain updates when they share intent.
- After improving constitution, skills, or second-brain notes: update this repo, sync locals, commit, and push.

## Never in this repo
- Hardcoded API keys, PATs, or `.env` files with real values.
- Force-push `main` without explicit human confirmation.
- Letting one AI product’s private folder be the only copy of the constitution or second brain.

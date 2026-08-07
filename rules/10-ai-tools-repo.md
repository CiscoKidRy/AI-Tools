# AI-Tools repository (canonical toolkit + second brain)

## Location
- **GitHub:** https://github.com/CiscoKidRy/AI-Tools
- **Local clone (preferred):** `~/dev/AI-Tools`
- **Owner account:** https://github.com/CiscoKidRy

## Purpose
This repository is the user’s **canonical, AI-tool-agnostic vault**:
- Constitution and global rules (`rules/`)
- Skills, workflows, prompts, templates
- **Obsidian second brain** (`second-brain/`)

Prefer reading from and contributing back to this repo over inventing one-off copies inside a single product (Grok-only, Claude-only, etc.).

## When working on AI tooling or knowledge
1. Prefer AI-Tools as source of truth for reusable agent rules, skills, workflows, and second-brain notes.
2. Before creating a new skill/rule/workflow/note elsewhere, check AI-Tools for an existing one to extend.
3. Keep secrets out of this repo (use `.env.example` only; never commit tokens).
4. After meaningful improvements, **update the vault, commit, and push** so GitHub, local clone, tool configs, and Obsidian stay aligned (never force-push `main` without explicit confirmation).
5. Open **`second-brain/`** as the Obsidian vault root (not the whole monorepo unless the user prefers that).

## Sync map
| Change type | Update in AI-Tools | Also update |
|-------------|-------------------|-------------|
| Constitution / global rules | `rules/*.md` | `~/.grok/rules/` (and any other agent rule dirs in use) |
| Skills / workflows / prompts | matching folders | tool skill dirs if actively used |
| Second-brain notes | `second-brain/**` | (edit in place; Obsidian uses this folder) |
| Project starters | `templates/` | copy into new projects on demand |

Helper: `scripts/sync-rules-to-local.sh` copies `rules/` → `~/.grok/rules/`.

## Git defaults for this vault
- Default branch: `main`
- Prefer small, reviewable commits with clear messages
- Use `gh` for PRs, issues, and repo ops when available
- Group related tool + second-brain updates in the same commit when they share one intent

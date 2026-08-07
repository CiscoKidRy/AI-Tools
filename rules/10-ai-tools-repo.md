# AI-Tools repository (canonical toolkit)

## Location
- **GitHub:** https://github.com/CiscoKidRy/AI-Tools
- **Local clone (preferred):** `~/dev/AI-Tools`
- **Owner account:** https://github.com/CiscoKidRy

## Purpose
This repository is the user’s **canonical AI tooling vault**: agent rules templates, skills, workflows, prompts, and related utilities. Prefer reading from and contributing back to this repo over inventing one-off copies.

## When working on AI tooling
1. Prefer the AI-Tools repo as the source of truth for reusable agent rules, skills, and workflows.
2. Before creating a new skill/rule/workflow elsewhere, check AI-Tools for an existing one to extend.
3. Keep secrets out of this repo (use `.env.example` only; never commit tokens).
4. After meaningful improvements to global rules/skills that belong in the vault, offer to commit and push to AI-Tools (never force-push `main` without explicit confirmation).

## Git defaults for this vault
- Default branch: `main`
- Prefer small, reviewable commits with clear messages
- Use `gh` for PRs, issues, and repo ops when available

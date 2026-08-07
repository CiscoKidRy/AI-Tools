# AGENTS.md — AI-Tools

## What this repo is
Canonical vault of agent rules, skills, workflows, and prompts for CLI AI tools. Not an application product.

## Commands
- No build step for markdown-first content.
- Preview structure: `find . -type f -not -path './.git/*' | sort`
- Validate markdown links optionally with any link checker the agent has installed.

## Architecture invariants
- `rules/` = always-on, short, durable constraints only.
- `skills/` = procedures (versioned, disposable).
- `workflows/` = multi-agent orchestration.
- `templates/` = copy-into-project starters (do not special-case one app here).
- Do not store secrets, tokens, or personal customer data.

## Conventions
- Prefer Markdown.
- Default branch: `main`.
- Small reviewable commits.
- When promoting a local `~/.grok/rules` improvement, update the matching file here so the vault stays canonical.

## Never in this repo
- Hardcoded API keys, PATs, or `.env` files with real values.
- Force-push `main` without explicit human confirmation.

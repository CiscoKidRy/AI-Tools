# Git tooling for this machine

## Required
- `git` — version control (Apple Git or newer)
- `gh` — GitHub CLI for auth, repos, PRs, issues

## Recommended free extras
- `git-lfs` — large file storage when needed
- `jq` — JSON in shell scripts
- macOS Keychain credential helper for HTTPS

## Auth
```bash
gh auth login --hostname github.com --git-protocol https --web
gh auth status
gh auth setup-git   # use gh as git credential helper
```

## Clone AI-Tools
```bash
gh repo clone CiscoKidRy/AI-Tools ~/dev/AI-Tools
```

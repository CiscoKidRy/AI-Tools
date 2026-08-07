# Keeping AI-Tools in sync

## Goal
One GitHub repo holds the **tool-agnostic constitution**, the rest of the agent toolkit, and the **Obsidian second brain**. Local AI products are mirrors, not sole owners.

## Layout
```
~/dev/AI-Tools/                 # git clone of CiscoKidRy/AI-Tools
  rules/                        # constitution + global policies
  skills/ workflows/ prompts/
  templates/
  second-brain/                 # Obsidian vault root
  scripts/sync-*.sh
```

## Common flows

### After editing the vault (preferred)
```bash
cd ~/dev/AI-Tools
# edit rules/, second-brain/, skills/, …
./scripts/sync-rules-to-local.sh   # push constitution into ~/.grok/rules
git add -A
git commit -m "Describe the change"
git push
```

### After editing only ~/.grok/rules
```bash
cd ~/dev/AI-Tools
./scripts/sync-from-local-rules.sh
git add rules && git commit -m "Promote local rules to vault" && git push
```

### Obsidian
Open folder `~/dev/AI-Tools/second-brain` as the vault. Notes commit with the rest of the repo.

## Conflict rule
If local agent config and AI-Tools diverge: **prefer AI-Tools** unless the user explicitly chose local-first for that change.

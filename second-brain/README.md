# Second brain (Obsidian vault)

This folder is a full **Obsidian** vault. It lives inside **AI-Tools** so personal knowledge, agent constitution context, and tooling docs version and sync together on GitHub.

## Open in Obsidian

1. Install [Obsidian](https://obsidian.md) if needed.
2. **Open folder as vault** → choose:

   ```
   ~/dev/AI-Tools/second-brain
   ```

3. Do **not** point Obsidian at `~/dev/AI-Tools` root unless you intentionally want rules/skills mixed into the graph.

## Layout

| Path | Purpose |
|------|---------|
| `00-Inbox/` | Quick capture; process later |
| `01-Projects/` | Active efforts with an end state |
| `02-Areas/` | Ongoing responsibilities (career, health, AI tooling, etc.) |
| `03-Resources/` | Reference notes, how-tos, evergreen knowledge |
| `04-Archive/` | Inactive but kept |
| `05-Daily/` | Daily notes |
| `06-AI-Tools/` | Notes about this vault’s tools, agents, decisions |
| `Templates/` | Note templates |
| `Attachments/` | Images and binary embeds |

## Sync

- Vault path is git-tracked as part of **CiscoKidRy/AI-Tools**.
- After meaningful note or tooling changes: commit and push from `~/dev/AI-Tools`.
- Agents should keep constitution (`../rules/`) and second-brain updates **synced together** when they share the same work.

## Privacy

- Do not put secrets, passwords, or live API keys in notes.
- Prefer links and redaction over pasting credentials.

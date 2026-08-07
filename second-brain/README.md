# Second brain (Obsidian vault)

Git-backed **Obsidian** vault for CiscoKidRy. Lives inside [AI-Tools](https://github.com/CiscoKidRy/AI-Tools) so knowledge and agent tooling version together.

## Open in Obsidian

1. Install [Obsidian](https://obsidian.md) (already on this Mac if setup completed).  
2. **Open folder as vault** → exactly:

   ```text
   ~/dev/AI-Tools/second-brain
   ```

3. Do **not** open `~/dev/AI-Tools` as the vault root unless you want rules/skills in the graph.

## Method (configured)

- **CODE** — Capture → Organize → Distill → Express (Forte)  
- **PARA** — Projects / Areas / Resources / Archive by actionability  
- **Atomic notes** — one idea, your words, `[[links]]`  
- **Minimal plugins** — core first; optional community list in-vault  

Read: `06-AI-Tools/How this second brain works.md` after open.

## Layout

| Path | Purpose |
|------|---------|
| `00-Inbox/` | Capture |
| `01-Projects/` | Finish-line work |
| `02-Areas/` | Ongoing responsibilities |
| `03-Resources/` | Evergreen + atomic ideas |
| `04-Archive/` | Inactive |
| `05-Daily/` | Daily notes |
| `06-AI-Tools/` | Meta + AI tooling |
| `Templates/` | Note skeletons |
| `Attachments/` | Media |
| `.obsidian/` | App config (synced) |

## Hotkeys

- `⌘⇧D` daily note · `⌘⇧T` template · `⌘O` switcher · graph via `⌘G` then `G`

## Sync to GitHub

```bash
cd ~/dev/AI-Tools
git add second-brain
git commit -m "second-brain: …"
git push
```

# How this second brain works

This vault implements a **practical hybrid** of current best practice:

1. **Building a Second Brain (Tiago Forte)** — CODE workflow + PARA folders for *actionability*  
2. **Zettelkasten / atomic notes** — one idea per note, heavy linking for *compounding knowledge*  
3. **Git-backed vault** — lives inside [AI-Tools](https://github.com/CiscoKidRy/AI-Tools) so tools + knowledge version together  

Sources distilled into this setup: Forte’s PARA/CODE, Obsidian community practice (Inbox → process, daily notes, minimal plugins), and AI-agent friendly markdown structure (local files agents can read).

---

## CODE — how knowledge moves

| Stage | What you do | Where it lives here |
|-------|-------------|---------------------|
| **C — Capture** | Dump fast; zero organization tax | `00-Inbox/`, daily note, or Quick capture |
| **O — Organize** | File by **actionability**, not topic | PARA: Projects / Areas / Resources / Archive |
| **D — Distill** | Progressive summary; bold → highlight → executive summary | Inside the note (layers over time) |
| **E — Express** | Use notes to ship work, decisions, writing | Projects, commits, PRs, blog drafts |

**Rule:** Capture is cheap. Organize only when you touch a note again or when the Inbox gets noisy.

---

## PARA — where notes go

Ask *one* question: **How actionable is this right now?**

| Bucket | Meaning | Folder |
|--------|---------|--------|
| **Projects** | Short-term effort with a finish line | `01-Projects/` |
| **Areas** | Ongoing standard of care (no end date) | `02-Areas/` |
| **Resources** | Topics of interest / evergreen reference | `03-Resources/` |
| **Archives** | Inactive; keep for search | `04-Archive/` |

Plus operational folders:

| Folder | Role |
|--------|------|
| `00-Inbox/` | Capture landing zone |
| `05-Daily/` | Journal + daily priorities (CODE capture surface) |
| `06-AI-Tools/` | Meta: this vault, constitution, AI tooling |
| `Templates/` | Note skeletons |
| `Attachments/` | Images / binary embeds |

Notes **move** as life changes (project → archive is normal). Links keep surviving the move if you use `[[wikilinks]]` (this vault has “Always update links” on).

---

## Atomic notes (Zettelkasten flavor)

For ideas that should compound:

1. **One note ≈ one idea** (not one book dump).  
2. Write in **your own words**.  
3. Add **at least one** `[[link]]` to related notes.  
4. Prefer **links over deep folder trees**. Folders are buckets; the graph is the brain.  
5. Use YAML properties (`type`, `status`, `tags`) sparingly—for filters, not decoration.

Template: [[Templates/Atomic idea]]

---

## Daily operating loop (recommended)

### Morning (5 min)
1. Open **Daily note** (`⌘⇧D`)  
2. Set **3 priorities**  
3. Glance [[Home]] and active projects  

### During the day
- Capture to **Inbox** or daily note—don’t file mid-flow  
- Link while thinking (`[[`) when a connection is obvious  

### Evening or weekly process (10–20 min)
1. Empty **Inbox** → Project / Area / Resource / Archive / delete  
2. Distill any long captures (highlight what you’d want in 6 months)  
3. Update project status  
4. **Git commit + push** from `~/dev/AI-Tools` when notes or tools changed  

```bash
cd ~/dev/AI-Tools
git add second-brain
git status
git commit -m "second-brain: process inbox / daily notes"
git push
```

---

## Progressive summarization (Distill)

When revisiting a note:

1. **Bold** the sentences that matter  
2. **Highlight** the bold that still matters on a later pass  
3. Optional: write a **3-line executive summary** at the top  

Don’t over-distill on first capture—that kills capture speed.

---

## Plugins philosophy (2026 consensus)

**Start minimal.** Core plugins only until friction appears.

**Enabled core (this vault):** Daily Notes, Templates, Backlinks, Outgoing links, Graph, Canvas, Properties, Bookmarks, Note composer, Workspaces, Random note, Slash commands, Bases (if available).

**Optional community later (max 3–5):**  
Templater · Calendar · Dataview · QuickAdd · Periodic Notes · Obsidian Git  

Do **not** install 30 plugins on day one.

---

## Hotkeys configured here

| Shortcut | Action |
|----------|--------|
| `⌘⇧D` | Open daily note |
| `⌘⇧T` | Insert template |
| `⌘G G` | Open graph |
| `⌘O` | Quick switcher |
| `⌘⇧P` | Command palette |

---

## Link to the rest of AI-Tools

- Constitution (tool-agnostic): `../rules/00-constitution.md` in the monorepo  
- Map: [[AI-Tools map]]  
- Sync duties: [[Constitution and sync]]  

Agents and humans: treat this vault + `rules/` as one system. After vault-worthy changes, **commit and push** the whole AI-Tools repo.

---
name: Retrospective
description: >
  End-of-session retrospective that extracts learnings and proposes AI-tool-agnostic
  skills, rules, workflows, agents, and memory updates for the AI-Tools vault.
  Use when the user says retrospective, retro, session retro, what should we skill-ify,
  capture learnings, or /Retrospective.
---

# Retrospective

**AI-tool-agnostic.** This skill must work the same whether the host is Grok, Claude Code, Codex, Cursor, Gemini CLI, or another agent. Prefer portable artifacts and never lock procedures to one product’s private paths.

**Canonical vault:** `~/dev/AI-Tools` (GitHub: `CiscoKidRy/AI-Tools`).

---

## Goals

1. Summarize what this session achieved and where it hurt.  
2. Propose durable improvements: **skills · rules · workflows · agents · memory · AGENTS.md**.  
3. Write only after **human approval**, into **AI-Tools** (tool-agnostic), then optional local mirrors.  
4. Never promote secrets (tokens, keys, passwords, Dropbox secrets vault contents).

---

## Principles (non-negotiable)

| Principle | Meaning |
|-----------|---------|
| **Portable first** | Artifacts use `AGENTS.md`, `rules/`, `skills/`, `workflows/`, `prompts/` — not `~/.claude/`-only or Grok-only as the sole home |
| **Vendor shims last** | Thin pointers (`CLAUDE.md` → `@AGENTS.md`) are fine; substance lives in AI-Tools |
| **Two-stage capture** | Propose → user approve/edit/skip → then write |
| **Recurrence over one-offs** | Prefer skills/rules for patterns that will repeat; one-offs go to staging retro notes |
| **Progressive disclosure** | Skills = procedures; rules = short always-on; don’t bloat constitution |
| **Redact** | No secrets in retros, skills, rules, or commits |

---

## When invoked

### 1. Gather context (host-agnostic)

Use **whatever is available**, in this order:

1. **Live conversation** — primary source (always available).  
2. **User-stated goals** and corrections (“no, do X instead”).  
3. **Optional host transcript** — if the runtime exposes session logs, use them as *supplement* only:  
   - Grok: `~/.grok/sessions/<encoded-cwd>/<session-id>/` (`updates.jsonl`, `chat_history.jsonl`)  
   - Claude Code: `~/.claude/projects/.../*.jsonl`  
   - Codex / Cursor: only if the user points at a log path  
4. **Existing vault** — scan `~/dev/AI-Tools/skills/`, `rules/`, `workflows/` so proposals **dedupe** and extend rather than duplicate.

Do **not** fail if a vendor transcript path is missing. The live session is enough.

### 2. Analyze

Extract:

- **Intent** — what the user set out to do  
- **Outcomes** — what shipped or decided  
- **Friction** — failed approaches, timeouts, wrong tools, rework  
- **Corrections** — explicit user redirects (highest signal)  
- **Techniques** — non-obvious procedures worth repeating  
- **Open loops** — unfinished work  

### 3. Classify candidates

For each durable insight, assign **one** primary artifact type:

| Type | When | Target path (AI-Tools) |
|------|------|-------------------------|
| `skill` | Multi-step procedure, on-demand | `skills/<Name>/SKILL.md` |
| `rule` | Always-on short constraint / preference | `rules/<nn>-<slug>.md` |
| `workflow` | Multi-agent orchestration | `workflows/<name>.rhai` (or portable script notes in `workflows/README`) |
| `agent` | Reusable persona / subagent brief | `prompts/agents/<name>.md` or skill that defines the agent |
| `memory` | Fact/preference for global memory | Propose text for `MEMORY.md` / second-brain — user confirms |
| `agents_md` | Project/repo how-to or invariant | `AGENTS.md` or `templates/AGENTS.md` |
| `staging` | Useful but one-off or immature | `docs/retros/YYYY-MM-DD-<slug>.md` |

**Score** each candidate 1–5 on: recurrence, cost of rediscovery, portability, risk (secrets/scope). Prefer promoting score ≥ 3.

### 4. Present the retrospective

Output markdown matching `references/output-template.md`:

1. TL;DR  
2. Intent & outcomes  
3. Friction & lessons  
4. **Proposals table** (type · title · why · score · action)  
5. Drafts (collapsed or abbreviated SKILL/rule text)  
6. Explicit: “Approve which numbers? (all / 1,3 / none)”

### 5. Write only what was approved

For each approved item:

1. Create/update files **under `~/dev/AI-Tools`**.  
2. Skills: YAML frontmatter `name` + `description` (when to trigger); body = steps, checks, never-dos.  
3. Rules: short, durable, no product lock-in.  
4. Staging retro file always optional even if nothing promoted.  
5. Offer: `git add` / commit / push to `CiscoKidRy/AI-Tools`.  
6. Offer local mirrors only as **copies** (e.g. `scripts/sync-rules-to-local.sh` for rules → `~/.grok/rules/`). Never make a single vendor directory the source of truth.

### 6. Close the loop

Tell the user:

- What was written (paths)  
- What was staged only  
- What was skipped  
- How to invoke new skills next session (tool-agnostic: “load skill X from AI-Tools” / natural language description)

---

## Skill authoring standards (when scaffolding)

Follow portable Agent Skills shape:

```markdown
---
name: example-name
description: What it does and when to use it (trigger phrases).
---

# Title
## Prerequisites
## Steps
## Verification
## Never
```

- Prefer **name** without vendor prefixes (`session-retro` not `claude-only-retro`).  
- Description must state **when to trigger**.  
- Steps should name tools generically (“run tests”, “use git”, “use rclone”) not “only in Cursor Composer”.  
- Point to AI-Tools docs for long runbooks.

---

## Security

- Redact tokens, private keys, `.pem` contents, Passwords-app secrets, Dropbox secrets vault file bodies.  
- Secrets vault path may be referenced in **private** memory/rules only; do not expand inventories into public skills.  
- Never commit `rclone.conf` or raw credentials.

---

## Anti-patterns

- Auto-writing always-on rules without approval  
- Narrative-only retro with zero proposals  
- Duplicating an existing skill under a new name  
- Vendor-only paths as the only install location  
- Promoting a one-line fix that will never recur  
- Bloated constitution dumps  

---

## Related vault paths

| Path | Role |
|------|------|
| `skills/Retrospective/` | This skill |
| `docs/retrospective.md` | Human-oriented design notes |
| `docs/retros/` | Staging retrospective write-ups |
| `rules/` | Approved always-on policy |
| `skills/` | Approved procedures |
| `second-brain/` | Optional personal notes (not secret dumps) |

## Triggers (examples)

- “Run Retrospective”  
- “session retro”  
- “what skills should we create from this session?”  
- “capture learnings before we stop”

---
name: plan-interview
description: >
  Structured requirements discovery interview with quality gates until 95%+
  aggregate confidence. Loads grounding-discipline at the start of planning
  (no silent assumptions, no hallucinations, calibrated claims) and emits a
  Grounding Report when the plan/discovery is presented. Use when the user
  wants a plan interview, requirements discovery, quality-gated planning,
  pre-implementation interview, or runs /plan-interview.
---

# Plan Interview

**AI-tool-agnostic.** Works with Grok, Claude Code, Codex, Cursor, Gemini CLI, and any agent host. Prefer portable tools (`git`, tracker CLIs, read/search) over product-only APIs when both exist.

Conduct a structured requirements discovery interview with **quality gates**. Continue until aggregate gate confidence reaches **95%+** or the user ends the session (`done` / `proceed` / `good enough`).

**Mandatory companion:** load and obey **`grounding-discipline`** for the entire session (entry charter, claim labels, abstention, end report).

---

## When to use

- Before implementing complex features  
- When requirements are ambiguous or evolving  
- Multi-stakeholder or high-rework-cost work  
- Planning against an existing ticket/issue/PR/work item  
- User runs `/plan-interview` or asks for a structured planning interview  

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `topic` | Yes | What we’re planning — free text, and/or a work-item reference in whatever tracker this project uses |

## Usage

```
/plan-interview Build a user analytics dashboard
/plan-interview Migrate auth system to OAuth2
/plan-interview Redesign the notification pipeline
/plan-interview PROJ-123 improve onboarding funnel
```

Optional prompt generator (host-agnostic):

```bash
python skills/plan-interview/template.py "Build a user analytics dashboard"
```

---

## Workflow

### 0. Load grounding-discipline (FIRST — non-optional)

1. Read and apply `skills/grounding-discipline/SKILL.md` (AI-Tools vault or local skill mirror).  
2. **Activate Phase A** of grounding-discipline:
   - Restate goal + success sketch  
   - Open empty **Source Inventory** + **Claim Ledger**  
   - State the brief charter to the user (abstain OK; claims labeled; Grounding Report at end)  
3. Do **not** invent requirements, APIs, file paths, SLAs, or “existing” modules.  

### 1. Enter planning mode (host-native)

If the current host provides a plan/read-only mode, **use it** before deep Q&A or design prose:

| Host examples | Action |
|---------------|--------|
| Grok Build | `enter_plan_mode` (or equivalent plan mode) |
| Claude Code / Cursor | Plan mode / read-only planning if available |
| Other agents | Stay read-only: no implementation edits until discovery completes and user accepts |

If no plan mode exists, **simulate** it: research and interview only; no production edits until the user accepts the discovery outcome.

### 2. Work-item / tracker context (toolset-agnostic)

If `topic` or the user mentions a work item, issue, ticket, PR, epic, or story:

1. **Detect** which tracker(s) this environment actually uses—do not assume GitHub. Prefer, in order of availability:
   - Project docs / `AGENTS.md` / README that name the tracker  
   - Installed CLIs or MCP tools already connected (e.g. `gh`, Linear, Jira, Azure Boards, Asana, Shortcut, YouTrack)  
   - URLs the user pasted (host decides the API)  
2. **Fetch** the item with the matching tool; record as Source `S#` (type: tracker).  
3. Seed the claim ledger with **user-stated / tracker-stated** FACTS only; mark gaps as UNKNOWN.  
4. If no tracker is available: say so once, continue from conversation + repo evidence.

Never invent ticket fields, acceptance criteria, or assignee intent.

### 3. Structured interview (protocol below)

Run quality gates G1–G7 (+ dynamic gates). Apply grounding labels to every material answer.

### 4. Present plan / discovery (END — non-optional)

When ending (95%+ gates **or** user override):

1. **Discovery Complete** summary (gate table)  
2. **Grounding Report** from `grounding-discipline` (Pass | Warn | Fail)  
3. Only then offer next steps (e.g. write implementation plan, design doc, or implement)—do not start implementation unless the user asks and gate status is Pass or accepted Warn  

---

## Protocol

### Quality gates (add more as topics emerge)

| ID | Gate | Description |
|----|------|-------------|
| G1 | SCOPE | What is included / excluded |
| G2 | USERS | Who uses this, what roles |
| G3 | INPUTS | Data sources, formats, triggers |
| G4 | OUTPUTS | Deliverables, formats, destinations |
| G5 | CONSTRAINTS | Tech limits, timelines, dependencies |
| G6 | EDGE CASES | Error handling, boundaries, exceptions |
| G7 | SUCCESS | How we know it works |

A gate **PASS**es when confidence for that domain is **≥ 95%** (confidence here means *discovery completeness with the user*, still backed by grounding labels—not a license to invent).  
**Aggregate** = average of active (non-skipped) gate confidences. Target **≥ 95%**.

### Gate status output (after each round)

```
-------- GATE STATUS --------
Gate         | Status | Conf | Notes
-------------|--------|------|------
G1 SCOPE     | OPEN   | 60%  | Need to clarify X
G2 USERS     | PASS   | 95%  | Admin + end users confirmed
G3 INPUTS    | OPEN   | 40%  | Unknown: data format
-----------------------------
AGGREGATE: 67% (Target: 95%)
BLOCKING QUESTIONS: 3
GROUNDING: open UNKNOWN central claims: N | open assumptions: M
-----------------------------
```

### Question prioritization

1. **BLOCKERS** — unlock other gates  
2. **AMBIGUITY** — multiple interpretations that change design/API/data  
3. **GAPS** — missing information in open gates  
4. **VALIDATION** — confirm before marking PASS  

Prefer **one focused question** (or a tight set) at a time. Prefer options + recommended default when useful. Exhaust a line of inquiry before jumping topics.

### When new topics emerge

1. Create gate G8, G9, … with clear scope  
2. Initial confidence 0%  
3. Add blocking questions  
4. Recalculate aggregate  

### Session controls

User may say at any time:

| Command | Effect |
|---------|--------|
| `status` | Gate table + short grounding snapshot |
| `focus on [gate]` | Prioritize that gate |
| `skip [gate]` | Mark N/A after confirmation |
| `done` / `proceed` / `good enough` | End interview; full summaries + Grounding Report |
| `add gate: [name]` | Add custom quality gate |

### Completion summary (always pair with Grounding Report)

```
============ DISCOVERY COMPLETE ============
Total Gates: X
Passed: Y (95%+)
Open: Z (list with confidence)
Aggregate Confidence: XX%

KNOWN GAPS (if any):
- [Gap 1]: [Impact assessment]

ASSUMPTIONS MADE (must match Grounding Report):
- [Assumption 1]

READY TO PROCEED: [YES/NO — requires 95%+ OR user override]
============================================
```

Immediately after, emit the full **Grounding Report** from `grounding-discipline` (source inventory, claim ledger, assumptions, refusals/retractions, over/understatement checks, why handled this way, Pass|Warn|Fail).

---

## Rules

1. **Grounding-discipline is always on** for this skill—no silent assumptions, no hallucinations, no over/understatement.  
2. Ask focused questions until aggregate ≥ 95% **or** user ends.  
3. Never invent requirements; label ASSUMPTION only under grounding rules.  
4. One topic depth at a time.  
5. New requirements → new gates.  
6. Tracker lookups use **whatever tools the current host/project already has**—never hard-code a single vendor.  
7. Do not implement production changes during the interview unless the user explicitly pivots out of discovery.  

---

## Composition with other skills

```
plan-interview
  ├── [start] grounding-discipline (activate + inventory)
  ├── [loop]  interview + evidence reads + gate table
  └── [end]   Discovery Complete + Grounding Report
        └── then (if user asks): design / writing-plans / implement …
```

---

## Never

- Claude-only or Grok-only steps as the only path (hosts differ; stay portable)  
- Assuming GitHub when the project uses another tracker  
- Marking gates PASS based on model confidence without user confirmation or repo evidence  
- Presenting a “plan” without a Grounding Report  
- Claiming tests/CI passed during planning without running them  

## Related

- `grounding-discipline` — required mixin  
- AI-Tools vault: `~/dev/AI-Tools/skills/`  

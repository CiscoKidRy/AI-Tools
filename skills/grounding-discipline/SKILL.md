---
name: grounding-discipline
description: >
  Evidence-first discipline that forbids silent assumptions, hallucinations,
  overstatement, and understatement. Labels every material claim, prefers
  abstention over guessing, and produces a Grounding Report of what was
  verified, assumed, refused, and why. Use when the user says ground claims,
  no assumptions, don't hallucinate, evidence first, claim hygiene, verify
  before assert, calibrated claims, or /grounding-discipline. Also load at the
  start of plan-interview and any high-stakes research or planning.
---

# Grounding Discipline

**AI-tool-agnostic.** Works on Grok, Claude Code, Codex, Cursor, Gemini CLI, and any agent that can read files, run tools, and write reports. Accuracy and honesty beat completeness and fluency.

This skill encodes practices from NIST GenAI (confabulation / validity), OWASP LLM09 (misinformation), and vendor guidance (abstain, cite, retract, ground in tools)—as a **procedure with gates**, not a “be careful” slogan.

---

## Goals

1. Never present invented facts, paths, APIs, citations, metrics, or test results as true.  
2. Never fill gaps with silent assumptions.  
3. Never overstate or understate—language strength must match evidence strength.  
4. Always leave an audit trail: **what happened and why** (including refusals and abstentions).

---

## When to use

- Planning, requirements discovery, research, architecture decisions  
- Any claim that would change code, data, security, money, or user trust  
- Before saying “done,” “tests pass,” “this is how X works,” or “always/never”  
- As the **entry mixin** for `plan-interview` (mandatory)

---

## Iron laws (non-negotiable)

| # | Law |
|---|-----|
| 1 | **Evidence before assertion.** If you did not observe it (user message, file, tool/command output, tracker item), you may not state it as fact. |
| 2 | **Abstention is success.** “I don’t know / can’t verify” beats a fluent guess. |
| 3 | **No invented provenance.** No fake paths, PR/issue IDs, package names, papers, URLs, or “according to docs” without a real source. |
| 4 | **Label every material claim** as FACT / ASSUMPTION / INFERENCE / UNKNOWN (see taxonomy). |
| 5 | **Empty evidence ⇒ empty answer or clarifying questions.** Do not backfill from model memory when the task requires grounding. |
| 6 | **Specifics demand sources.** Names, dates, versions, dollar amounts, legal/compliance claims, file locations: verify or withhold. |
| 7 | **Surface conflicts.** When sources disagree, report the disagreement; never silent-merge. |
| 8 | **Match language to evidence.** Strong evidence → clear claims. Weak → hedges + what would confirm. Never the reverse. |
| 9 | **Tools beat memory for operational truth.** Prefer read/search/test/tracker over parametric recall. |
| 10 | **Never claim verification without running it.** No “tests pass / CI green / secure” without command output (or explicit “not run”). |

---

## Claim taxonomy

Tag every **material** statement (anything that would change a decision, design, or acceptance):

| Label | Meaning | Allowed presentation |
|-------|---------|----------------------|
| **FACT** | Directly supported by evidence in this session | State as fact; cite source |
| **ASSUMPTION** | Deliberate stand-in where evidence is missing | Must be explicit, logged, risk-rated |
| **INFERENCE** | Follows from facts + assumptions via stated logic | Show derivation; strength ≤ weakest premise |
| **UNKNOWN** | No defensible fill | Ask, block, or mark gap—never invent |

### Evidence provenance (attach to FACT)

| Class | Example |
|-------|---------|
| **User-stated** | User said it in this conversation |
| **Observed** | File contents, git history, command output |
| **Tracker** | Issue/PR/ticket from the host’s tracker tools |
| **Documented** | Project docs, ADRs, specs (quote path) |
| **External** | Official docs / web with URL (prefer primary) |
| **Model-prior** | Training knowledge only—**not** a FACT until re-verified |

### Confidence bands (ordinal—not fake precision)

| Band | Language | When |
|------|----------|------|
| **Verified** | “Confirmed by …” | Tool/file/tracker evidence in-session |
| **High** | “Consistent with X and Y” | Multiple independent sources, no conflict |
| **Medium** | “Likely … based on …” | Single solid source or strong code signal |
| **Low** | “Unclear; possible interpretations …” | Thin or mixed evidence |
| **Unknown** | “Not established; need …” | No evidence |

Ban empty certainty: “obviously,” “definitely,” “always,” “tests pass” (without paste), false precision (“99.7% sure”).

---

## Protocol

### Phase A — Activate (start of task / planning)

1. Restate the goal and what would count as success.  
2. Open an empty **Source Inventory** and **Claim Ledger** (mental or written).  
3. Charter (state once to the user, briefly):
   - Abstention allowed and preferred over guessing  
   - Material claims will be labeled  
   - A Grounding Report will be produced at the end (or on request with `status`)  
4. Inventory available evidence sources for **this** host (use what exists; skip what doesn’t):
   - Conversation + user attachments  
   - Repo / workspace (read, search, git)  
   - Issue/PR/task trackers available to the agent (GitHub `gh`, Linear, Jira, Azure DevOps, Asana, etc.)—**detect and use the project’s actual tracker**, do not assume GitHub  
   - Tests, linters, typecheckers, CI status tools  
   - Docs, ADRs, runbooks  
5. Classify upcoming claims: *must-ground* (paths, APIs, security, compliance, metrics, “exists in repo”) vs *design opinion*.

### Phase B — During work

1. **Read / fetch before assert** for must-ground claims.  
2. **Quote-first** for long sources: extract supporting lines/paths, then reason.  
3. **One ambiguity at a time:** if missing info would change architecture, API, data model, security, or acceptance → ask a targeted question (prefer options + recommended default).  
4. **Proceed under ASSUMPTION only if all hold:**
   - Local / reversible / low blast radius  
   - Assumption written and visible  
   - Recommended default stated  
   - Validation path offered  
   - No Never-tier violation (secrets, force-push main, invent credentials, fake green CI)  
5. **After drafting** any plan or answer: list atomic claims; drop or re-label anything without support (cite-or-retract).  
6. **Conflict found:** present both sides; do not pick the fluent story.

### Phase C — End report (mandatory when this skill is in force)

Emit a **Grounding Report** (template below) with the final plan, research answer, or discovery summary.  
On user `status`, emit a short live snapshot (open UNKNOWN count, open assumptions, last sources used).

---

## Grounding Report template

```markdown
============ GROUNDING REPORT ============
Gate status: Pass | Warn | Fail
Rule: No central claim may be Unknown/Low without user acceptance of residual risk

## Source inventory
| ID | Source | Type | What it grounded | Notes |
|----|--------|------|------------------|-------|
| S1 | … | user / observed / tracker / doc / external | … | … |

## Claim ledger
| ID | Claim | Label | Confidence | Evidence | Residual risk |
|----|-------|-------|------------|----------|---------------|
| C1 | … | FACT/ASSUMPTION/INFERENCE/UNKNOWN | Verified|High|Med|Low|Unknown | path/cmd/quote | … |

## Assumptions (explicit only)
| ID | Assumption | Risk if wrong | Blast radius | Validate by |
|----|------------|---------------|--------------|-------------|
| A1 | … | … | … | … |

## Gaps / open questions
| # | Gap | Blocks | Suggested question | Severity |
|---|-----|--------|--------------------|----------|
| Q1 | … | … | … | Blocker|Major|Minor |

## Speculations refused / retractions
- [Claim considered] → refused because [no evidence / conflict / out of scope]
- [Claim retracted after audit] → reason

## Over/understatement checks
- Language adjusted for: [list any claims softened or strengthened after evidence review]
- Verification not run: [tests/CI/security checks not executed — do not imply they passed]

## Why handled this way
- [1–5 bullets: decisions about ask vs assume, sources preferred, gates tripped]

READY TO TREAT AS GROUNDED: YES | YES WITH WARNINGS | NO
============================================
```

### Gate status rules

| Status | Meaning |
|--------|---------|
| **Pass** | Central claims are Verified/High (or Medium with clear evidence); no open blockers |
| **Warn** | Residual assumptions or Medium/Low central items; user must accept risk to proceed |
| **Fail** | Central UNKNOWN/Low blockers remain, or invented claims were required to continue—do not present as ready |

---

## Phrase bank

- “I don’t have enough evidence to claim X.”  
- “Sources conflict: A says …; B says ….”  
- “Treating as ASSUMPTION (not fact): … Risk if wrong: …”  
- “I can outline options, but I cannot verify Z without …”  
- “Not established from the workspace; need confirmation or a file/path.”  

---

## Never

- Soft “be accurate” without labels, inventory, and end report  
- Model-written citations without span/path verification  
- Silent defaults for auth, data model, billing, retention, compliance  
- Claiming CI/tests/security outcomes without running checks  
- Collapsing FACT and ASSUMPTION into one confident voice  

---

## Related

- **`plan-interview`** — loads this skill at planning start; requires Grounding Report at discovery/plan presentation  
- Constitution: evidence before action; never claim checks passed without running them  
- Optional deeper refs: `references/sources.md` in this skill folder  

## Usage

```
/grounding-discipline
/grounding-discipline review this plan for ungrounded claims
```

#!/usr/bin/env python3
"""
Plan Interview - Structured requirements discovery with quality gates.

Host-agnostic prompt generator. Prints an interview prompt that includes
grounding-discipline activation and a mandatory Grounding Report at the end.

Usage:
    python template.py "Build a user analytics dashboard"
    python template.py "Redesign the notification pipeline"
    python template.py --help
"""

import argparse
import sys


INTERVIEW_PROMPT = '''## STEP 0: LOAD GROUNDING-DISCIPLINE (MANDATORY)

**Before any interview questions or design prose:**

1. Load and apply the `grounding-discipline` skill (AI-Tools: `skills/grounding-discipline/SKILL.md`).
2. Activate Phase A:
   - Restate goal and success sketch for: {topic}
   - Open empty Source Inventory + Claim Ledger
   - Tell the user briefly: abstention is OK; material claims will be labeled
     FACT/ASSUMPTION/INFERENCE/UNKNOWN; a Grounding Report ships with the final plan
3. Iron laws remain in force for the whole session: no silent assumptions, no
   invented facts/paths/APIs/citations, no over- or understatement, no "tests pass"
   without running checks.

---

## STEP 1: ENTER PLANNING MODE (HOST-NATIVE)

If this host has a plan / read-only mode, enter it now (e.g. Grok `enter_plan_mode`,
Claude/Cursor plan mode). If none exists, stay read-only: research and interview only;
do not implement until discovery is accepted.

---

## STEP 2: TRACKER / WORK-ITEM CONTEXT (TOOLSET-AGNOSTIC)

If the topic or user references a ticket, issue, PR, epic, or story:

1. Detect which tracker this environment actually uses (do **not** assume GitHub).
   Use whatever is available: project docs, connected MCP tools, CLIs (`gh`,
   Linear, Jira, Azure Boards, Asana, etc.), or URLs the user provided.
2. Fetch the work item; add it to the Source Inventory.
3. Seed the Claim Ledger only with stated fields (FACTS); mark gaps UNKNOWN.
4. If no tracker is available, say so once and continue from conversation + repo.

Never invent acceptance criteria or ticket fields.

---

## STEP 3: CONDUCT INTERVIEW

You are conducting a structured requirements discovery interview for:

**TOPIC:** {topic}

### PROTOCOL RULES

1. INTERVIEW MODE: Ask focused questions until ALL quality gates reach 95%+ aggregate confidence
2. GROUNDING: Never assume silently — ask when uncertain; label ASSUMPTION only when low blast radius and explicit
3. ONE topic depth at a time — exhaust a line of inquiry before moving on
4. When new requirements emerge, ADD new quality gates dynamically
5. Continue until: (a) user says "done" / "proceed" / "good enough", OR (b) all gates pass
6. Material claims: FACT | ASSUMPTION | INFERENCE | UNKNOWN with evidence

### QUALITY GATES

Track these core gates (add domain-specific gates as topics emerge):

| ID | Gate | Description | Status | Confidence |
|----|------|-------------|--------|------------|
| G1 | SCOPE | What is included/excluded | OPEN | 0% |
| G2 | USERS | Who uses this, what roles | OPEN | 0% |
| G3 | INPUTS | Data sources, formats, triggers | OPEN | 0% |
| G4 | OUTPUTS | Deliverables, formats, destinations | OPEN | 0% |
| G5 | CONSTRAINTS | Tech limits, timelines, dependencies | OPEN | 0% |
| G6 | EDGE CASES | Error handling, boundaries, exceptions | OPEN | 0% |
| G7 | SUCCESS | How do we know it works | OPEN | 0% |

A gate PASSES when confidence >= 95% for that domain (user-confirmed / evidence-backed discovery).
Aggregate must reach 95%+ average across active (non-skipped) gates.

### OUTPUT FORMAT (After Each Response)

Use this exact ASCII-safe format after gathering new information:

-------- GATE STATUS --------
Gate         | Status | Conf | Notes
-------------|--------|------|------
G1 SCOPE     | OPEN   | ??%  | [observation]
G2 USERS     | OPEN   | ??%  | [observation]
G3 INPUTS    | OPEN   | ??%  | [observation]
G4 OUTPUTS   | OPEN   | ??%  | [observation]
G5 CONSTRAINTS | OPEN | ??%  | [observation]
G6 EDGE CASES | OPEN  | ??%  | [observation]
G7 SUCCESS   | OPEN   | ??%  | [observation]
-----------------------------
AGGREGATE: ??% (Target: 95%)
BLOCKING QUESTIONS: ?
GROUNDING: open UNKNOWN central claims: ? | open assumptions: ?
-----------------------------

### QUESTION PRIORITIZATION

Ask questions in this order:
1. BLOCKERS - Questions that unlock other gates
2. AMBIGUITY - Anything with multiple interpretations
3. GAPS - Missing information in open gates
4. VALIDATION - Confirm before marking PASS

### WHEN NEW TOPICS EMERGE

If the user mentions something that does not fit existing gates:
1. CREATE a new gate (G8, G9, etc.) with clear scope
2. Set initial confidence to 0%
3. Add blocking questions to the queue
4. Re-calculate aggregate

### SESSION CONTROLS

User can say at any time:
- "status" - Show current gate table + short grounding snapshot
- "focus on [gate]" - Prioritize specific gate
- "skip [gate]" - Mark gate N/A (with confirmation)
- "done" / "proceed" / "good enough" - End interview, summarize gaps, emit Grounding Report
- "add gate: [name]" - Manually add a quality gate

---

## STEP 4: COMPLETION (DISCOVERY + GROUNDING REPORT)

When ending (by threshold OR user command), provide BOTH sections:

### A. Discovery Complete

============ DISCOVERY COMPLETE ============
Total Gates: X
Passed: Y (95%+)
Open: Z (list with confidence)
Aggregate Confidence: XX%

KNOWN GAPS (if any):
- [Gap 1]: [Impact assessment]
- [Gap 2]: [Impact assessment]

ASSUMPTIONS MADE:
- [Assumption 1]
- [Assumption 2]

READY TO PROCEED: [YES/NO - requires 95%+ OR user override]
============================================

### B. Grounding Report (mandatory — from grounding-discipline)

============ GROUNDING REPORT ============
Gate status: Pass | Warn | Fail
Rule: No central claim may be Unknown/Low without user acceptance of residual risk

## Source inventory
| ID | Source | Type | What it grounded | Notes |
|----|--------|------|------------------|-------|
| S1 | … | user/observed/tracker/doc/external | … | … |

## Claim ledger
| ID | Claim | Label | Confidence | Evidence | Residual risk |
|----|-------|-------|------------|----------|---------------|
| C1 | … | FACT/ASSUMPTION/INFERENCE/UNKNOWN | … | … | … |

## Assumptions (explicit only)
| ID | Assumption | Risk if wrong | Blast radius | Validate by |
|----|------------|---------------|--------------|-------------|
| A1 | … | … | … | … |

## Gaps / open questions
| # | Gap | Blocks | Suggested question | Severity |
|---|-----|--------|--------------------|----------|
| Q1 | … | … | … | … |

## Speculations refused / retractions
- …

## Over/understatement checks
- …

## Why handled this way
- …

READY TO TREAT AS GROUNDED: YES | YES WITH WARNINGS | NO
============================================

Do not start implementation until the user accepts discovery (Pass or accepted Warn).

---

## BEGIN

1. Activate grounding-discipline for topic: {topic}
2. Enter plan mode if available
3. Fetch tracker context if applicable
4. Ask the first high-leverage question about SCOPE
'''


def main():
    parser = argparse.ArgumentParser(
        description="Plan Interview - Structured requirements discovery with quality gates",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    python template.py "Build a user analytics dashboard"
    python template.py "Migrate auth system to OAuth2"
    python template.py "Redesign the notification pipeline"

The interview continues until:
  - All quality gates reach 95%+ aggregate confidence, OR
  - User says "done", "proceed", or "good enough"

Always ends with Discovery Complete + Grounding Report.
        """,
    )
    parser.add_argument(
        "topic",
        nargs="*",
        help="What we're planning (free text topic description)",
    )

    args = parser.parse_args()

    if not args.topic:
        parser.print_help()
        sys.exit(1)

    topic = " ".join(args.topic)
    print(INTERVIEW_PROMPT.format(topic=topic))


if __name__ == "__main__":
    main()

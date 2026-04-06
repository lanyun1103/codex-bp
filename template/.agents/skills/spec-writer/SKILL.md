---
name: spec-writer
description: Turn a vague coding request into an execution-ready spec with goals, non-goals, likely file boundaries, concrete deliverables, acceptance criteria, open questions, and a recommended next step before implementation begins.
---

# Spec Writer

Use this skill when the task is still vague and Codex should not start coding yet.

## Workflow

1. Read `AGENTS.md`.
2. Read `docs/codex/project-map.md` if it exists.
3. Convert the request into a short execution-ready spec.
4. Separate goals from non-goals.
5. Name the likely file or directory boundaries.
6. Define the expected deliverables for the next phase.
7. State acceptance criteria and key risks.
8. List open questions that block implementation or routing.
9. Recommend the next step, not full execution.

## Guardrails

- Do not start coding.
- Do not stop at strategy-only language.
- For large or cross-system work, force the output to name a `P0 slice`.
- Prefer one concrete next phase over a broad multi-quarter roadmap.
- If the task is still too wide, say what must be clarified before routing or implementation.

## Output Format

```text
Problem:
Goal:
Non-goals:
Affected areas:
Deliverables:
Acceptance criteria:
Risks:
Open questions:
Recommended route: S | M | L | Unknown
Suggested next step:
```

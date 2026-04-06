---
name: review-loop
description: Run an independent review loop on a proposed change. Use when a builder has finished work and Codex should verify correctness, regressions, edge cases, and missing tests before merge.
---

# Review Loop

Use this skill after implementation work.

## Workflow

1. Read the spec or plan first.
2. Review the diff against the acceptance criteria.
3. Focus on bugs, regressions, edge cases, and missing validation.
4. Prefer an independent `reviewer` subagent for the main pass.
5. If confidence is still low, add `tester` for explicit verification.
6. End with pass / no-pass and the highest-priority fixes.

## Required Checks

- Correctness against the intended behavior
- Regression risk
- Missing tests or validation
- Contract mismatches
- Documentation or runbook impact

## Output Format

```text
Findings:
Severity:
Missing validation:
Decision: pass | no-pass
```


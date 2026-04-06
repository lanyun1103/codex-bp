---
name: memory-sync
description: Update durable repository memory after meaningful work lands. Use when Codex should reflect stable knowledge into AGENTS.md, project maps, runbooks, templates, or long-lived docs.
---

# Memory Sync

Use this skill after a completed task when new durable project knowledge should be saved.

## Workflow

1. Capture only facts that will matter again.
2. Keep `AGENTS.md` short and navigable.
3. Put deep details into docs and runbooks.
4. Update templates only if the pattern is reusable.
5. Do not document transient debugging noise.

## Preferred Targets

- `AGENTS.md`
- `docs/codex/project-map.md`
- `docs/runbooks/`
- `docs/codex/templates/`
- `specs/`

## Output Format

```text
Durable facts:
Files updated:
Reason:
Open documentation gaps:
```


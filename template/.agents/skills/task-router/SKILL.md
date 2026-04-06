---
name: task-router
description: Route a coding task into the repository's small, medium, or large workflow. Use when work should be turned into a spec, scoped into file boundaries, and optionally executed with multiple Codex subagents.
---

# Task Router

Use this skill when the user gives a real coding task and the workflow should choose between:

- `S` small
- `M` medium
- `L` large

Read [references/routing-rules.md](references/routing-rules.md) before deciding.

## Workflow

1. Read `AGENTS.md` and `docs/codex/project-map.md` if they exist.
2. Convert the request into a short spec.
3. Classify the task as `S`, `M`, or `L`.
4. Assign explicit file boundaries and acceptance criteria.
5. If the user only asked for planning, stop after the route plan.
6. If the user asked to execute, spawn the required subagents.
7. Keep one independent reviewer outside the builder path.
8. End by stating the selected route and next action.

## Route Policy

### S Route

Use:

- `lead`
- `builder`
- `reviewer`

Only use this when blast radius is small and file ownership is obvious.

### M Route

Use:

- `lead`
- `explorer`
- `builder`
- `reviewer`

Use this when one repo is involved but multiple modules or interfaces are touched.

### L Route

Use:

- `lead`
- one or more `explorer`
- one or more `builder`
- `tester`
- `reviewer`
- optionally `docs-writer`

Use this when the task crosses modules, repos, deployments, migrations, or long-running validation.

## Guardrails

- Do not spawn builders before file boundaries are clear.
- Do not allow overlapping builders on the same files.
- Keep subagent depth at 1.
- Prefer read-only explorers and reviewers.
- If the task is still vague, call `spec-writer` first or perform only the spec phase here.

## Output Format

```text
Route: S | M | L
Reason:
Spec:
File boundaries:
Assigned roles:
Acceptance criteria:
Next action:
```


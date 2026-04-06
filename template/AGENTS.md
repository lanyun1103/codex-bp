# AGENTS.md

## Project Identity

- Project name: `{{PROJECT_NAME}}`
- Installed from `codex-bp`
- Install date: `{{INSTALL_DATE}}`

Fill this file with the minimum persistent context Codex needs for this repository.

## Default Workflow

- For non-trivial work, start with `$task-router`.
- Keep specs in `plans/` or `specs/`.
- Keep one independent reviewer for any meaningful code change.
- Do not run multiple builders on the same file set.

## Task Sizing

- `S`: single module, limited blast radius, no major schema or API change
- `M`: one repo, multiple modules, some interface or test changes
- `L`: cross-repo, migration, deployment, data repair, or multi-stage rollout

## Repo Rules

- Add project-specific constraints here.
- Add build, test, and run commands here.
- Add deployment, rollback, and incident notes here.
- Keep this file short; move deep details into `docs/`.

## Codex Blueprint Map

- Custom subagents: `.codex/agents/`
- Repo-scoped skills: `.agents/skills/`
- Project map: `docs/codex/project-map.md`
- Workflow notes: `docs/codex/methodology.md`
- Runbooks: `docs/runbooks/`
- Plan template: `docs/codex/templates/plan-template.md`
- Spec template: `docs/codex/templates/spec-template.md`
- Review template: `docs/codex/templates/review-template.md`


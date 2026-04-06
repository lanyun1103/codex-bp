# codex-bp

Reusable Codex blueprint for multi-agent coding workflows.

This repository gives any project a working baseline for:

- repo-scoped custom subagents
- repo-scoped skills
- task routing for small / medium / large work
- spec, review, and memory update loops
- project docs and templates
- one-command installation into an existing repo

## Install into the current project

Public repo:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lanyun1103/codex-bp/main/install.sh)
```

Private repo with `gh` auth:

```bash
gh api repos/lanyun1103/codex-bp/contents/install.sh?ref=main --jq .content | base64 -d | bash
```

Install into another directory:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lanyun1103/codex-bp/main/install.sh) -- --target /path/to/repo
```

Overwrite existing blueprint-managed files:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lanyun1103/codex-bp/main/install.sh) -- --force
```

## What gets installed

```text
AGENTS.md
.codex/
  config.toml
  agents/
.agents/
  skills/
docs/
  codex/
  runbooks/
plans/
specs/
.codex-bp/
  manifest.json
```

## Default workflow after install

1. Use `$task-router` for any task that is not trivial.
2. Let it classify the task as `S`, `M`, or `L`.
3. Let the lead produce a spec and task split.
4. Spawn builders only after file boundaries are clear.
5. Keep one independent reviewer.
6. Run `$memory-sync` after meaningful work lands.

## Included custom agents

- `lead`
- `explorer`
- `builder`
- `reviewer`
- `tester`
- `docs-writer`

## Included repo-scoped skills

- `task-router`
- `spec-writer`
- `review-loop`
- `memory-sync`

## Notes

- The installer is idempotent for unchanged files.
- Existing files are skipped by default and overwritten only with `--force`.
- When `--force` is used, replaced files are backed up under `.codex-bp/backups/`.
- The installer supports public GitHub tarballs, `GITHUB_TOKEN` / `GH_TOKEN`, and `gh` CLI fallback.


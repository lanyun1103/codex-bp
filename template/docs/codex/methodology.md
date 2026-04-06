# Multi-Agent Workflow

This repository uses the `codex-bp` baseline.

## Working Model

- One lead defines the spec and task boundaries.
- Explorers map the codebase before risky implementation.
- Builders implement only bounded slices.
- One reviewer stays independent.
- Memory is written back into repo docs.

## Route Selection

- `S`: lead + builder + reviewer
- `M`: lead + explorer + builder + reviewer
- `L`: lead + explorers + builders + tester + reviewer + docs-writer

## Operating Rules

- No overlapping builders on the same file set.
- No broad implementation before the spec is clear.
- Reviewer is not the main implementer.
- Project memory belongs in the repo, not only in chat history.


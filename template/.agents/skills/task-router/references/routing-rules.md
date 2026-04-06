# Routing Rules

## S: Small

Use `S` when all of these are roughly true:

- one clear module or directory
- expected work under roughly 45 minutes
- no schema migration
- no production rollout complexity
- no multi-team or multi-repo coordination

Typical examples:

- single bug fix
- local refactor inside one package
- one endpoint tweak with straightforward tests

## M: Medium

Use `M` when any of these are true:

- one repo but multiple modules
- interface or contract changes
- test updates across layers
- moderate regression risk
- exploration is needed before implementation

Typical examples:

- backend API plus frontend consumer update
- feature flag rollout inside one product
- service refactor with moderate test work

## L: Large

Use `L` when any of these are true:

- cross-repo coordination
- migrations or data repair
- deployment or operational changes
- staged rollout or long-running verification
- more than one builder is justified

Typical examples:

- backend + frontend + infra + docs
- event pipeline redesign
- production data cleanup with code updates

## Promotion Rules

Move the task to the next size if:

- file ownership is unclear
- acceptance criteria are missing
- interfaces are not yet agreed
- the user asks for rollout or incident-safe handling


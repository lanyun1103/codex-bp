#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
TARGET_DIR="${TMP_DIR}/demo-project"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$TARGET_DIR"
"${REPO_ROOT}/install.sh" --target "$TARGET_DIR" --force

test -f "${TARGET_DIR}/AGENTS.md"
test -f "${TARGET_DIR}/.codex/config.toml"
test -f "${TARGET_DIR}/.codex/agents/lead.toml"
test -f "${TARGET_DIR}/.agents/skills/task-router/SKILL.md"
test -f "${TARGET_DIR}/docs/codex/project-map.md"
test -f "${TARGET_DIR}/.codex-bp/manifest.json"

echo "codex-bp install validation passed"


#!/usr/bin/env bash
set -euo pipefail

REPO="${CODEX_BP_REPO:-lanyun1103/codex-bp}"
REF="${CODEX_BP_REF:-main}"
TARGET="."
FORCE=0

usage() {
  cat <<'EOF'
Usage: install.sh [--target <path>] [--repo <owner/name>] [--ref <git-ref>] [--force]

Installs the codex-bp blueprint into an existing project.

Examples:
  install.sh
  install.sh --target /path/to/repo
  install.sh --repo lanyun1103/codex-bp --ref main
  install.sh --force
EOF
}

log() {
  printf '%s\n' "$*"
}

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "missing required command: $1"
}

escape_sed() {
  printf '%s' "$1" | sed 's/[\/&]/\\&/g'
}

download_archive() {
  local archive="$1"
  if [ -n "${GITHUB_TOKEN:-}" ] || [ -n "${GH_TOKEN:-}" ]; then
    local token="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
    curl -fsSL \
      -H "Authorization: token ${token}" \
      -H "Accept: application/vnd.github+json" \
      "https://api.github.com/repos/${REPO}/tarball/${REF}" \
      -o "$archive"
    return 0
  fi

  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    gh api "repos/${REPO}/tarball/${REF}" >"$archive"
    return 0
  fi

  curl -fsSL "https://codeload.github.com/${REPO}/tar.gz/${REF}" -o "$archive"
}

copy_template() {
  local src_root="$1"
  local dest_root="$2"
  local timestamp="$3"
  local project_name="$4"
  local copied=0
  local skipped=0
  local backed_up=0
  local rel=""
  local src=""
  local dest=""
  local backup_root="${dest_root}/.codex-bp/backups/${timestamp}"

  while IFS= read -r -d '' src; do
    rel="${src#${src_root}/}"
    dest="${dest_root}/${rel}"
    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ] && cmp -s "$src" "$dest"; then
      skipped=$((skipped + 1))
      continue
    fi

    if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
      log "skip existing: ${rel}"
      skipped=$((skipped + 1))
      continue
    fi

    if [ -e "$dest" ] && [ "$FORCE" -eq 1 ]; then
      mkdir -p "$(dirname "${backup_root}/${rel}")"
      cp "$dest" "${backup_root}/${rel}"
      backed_up=$((backed_up + 1))
    fi

    sed \
      -e "s/{{PROJECT_NAME}}/$(escape_sed "$project_name")/g" \
      -e "s/{{INSTALL_DATE}}/$(escape_sed "$(date -u +%Y-%m-%d)")/g" \
      "$src" >"$dest"
    copied=$((copied + 1))
  done < <(find "$src_root" -type f -print0 | sort -z)

  log "installed files: ${copied}"
  log "skipped files: ${skipped}"
  log "backed up files: ${backed_up}"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      shift 2
      ;;
    --repo)
      REPO="${2:-}"
      shift 2
      ;;
    --ref)
      REF="${2:-}"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "unknown argument: $1"
      ;;
  esac
done

require_cmd curl
require_cmd tar
require_cmd find
require_cmd sed

TARGET="$(cd "$TARGET" && pwd)"
PROJECT_NAME="$(basename "$TARGET")"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "${SCRIPT_DIR}/template" ]; then
  TEMPLATE_DIR="${SCRIPT_DIR}/template"
else
  ARCHIVE_PATH="${TMP_DIR}/codex-bp.tar.gz"
  download_archive "$ARCHIVE_PATH"
  tar -xzf "$ARCHIVE_PATH" -C "$TMP_DIR"
  EXTRACTED_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name 'codex-bp-*' | head -n 1)"
  [ -n "$EXTRACTED_DIR" ] || fail "unable to locate extracted archive contents"
  TEMPLATE_DIR="${EXTRACTED_DIR}/template"
fi

[ -d "$TEMPLATE_DIR" ] || fail "template directory not found"
mkdir -p "${TARGET}/.codex-bp"
copy_template "$TEMPLATE_DIR" "$TARGET" "$TIMESTAMP" "$PROJECT_NAME"

cat >"${TARGET}/.codex-bp/manifest.json" <<EOF
{
  "name": "codex-bp",
  "repo": "${REPO}",
  "ref": "${REF}",
  "installed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_name": "${PROJECT_NAME}"
}
EOF

log "manifest written: .codex-bp/manifest.json"
log "next step: restart Codex in ${TARGET} so repo-scoped skills and agents are reloaded"


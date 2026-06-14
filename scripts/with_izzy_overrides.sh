#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OVERRIDES_FILE="$ROOT_DIR/pubspec_overrides.yaml"
IZZY_OVERRIDES_TEMPLATE="$ROOT_DIR/tooling/pubspec_overrides.izzy.yaml"

if [[ $# -eq 0 ]]; then
  echo "Usage: scripts/with_izzy_overrides.sh <command...>"
  exit 1
fi

if [[ ! -f "$IZZY_OVERRIDES_TEMPLATE" ]]; then
  echo "Missing overrides template: $IZZY_OVERRIDES_TEMPLATE"
  exit 1
fi

backup_file=""
if [[ -f "$OVERRIDES_FILE" ]]; then
  backup_file="$(mktemp)"
  cp "$OVERRIDES_FILE" "$backup_file"
fi

cleanup() {
  if [[ -n "$backup_file" ]]; then
    cp "$backup_file" "$OVERRIDES_FILE"
    rm -f "$backup_file"
  else
    rm -f "$OVERRIDES_FILE"
  fi
}
trap cleanup EXIT

cp "$IZZY_OVERRIDES_TEMPLATE" "$OVERRIDES_FILE"

(
  cd "$ROOT_DIR"
  "$@"
)

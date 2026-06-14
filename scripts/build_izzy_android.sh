#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/with_izzy_overrides.sh" flutter pub get
"$ROOT_DIR/scripts/with_izzy_overrides.sh" flutter build apk \
  --release \
  --flavor izzy \
  --dart-define=ENABLE_REVENUECAT=false \
  --split-per-abi \
  --no-tree-shake-icons \
  "$@"

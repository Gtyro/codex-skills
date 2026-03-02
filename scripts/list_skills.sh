#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

find "$ROOT_DIR" -mindepth 1 -maxdepth 1 -type d \
  ! -name scripts \
  ! -name .git \
  ! -name .github \
  -print0 \
  | xargs -0 -I{} bash -c 'if [[ -f "{}/SKILL.md" ]]; then basename "{}"; fi' \
  | sort

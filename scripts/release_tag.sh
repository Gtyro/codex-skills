#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ $# -ne 1 ]]; then
  echo "Usage: release_tag.sh <tag>"
  echo "Example: release_tag.sh v0.1.0"
  exit 1
fi

TAG="$1"

if ! [[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Tag must match semantic version format: vMAJOR.MINOR.PATCH"
  exit 1
fi

if ! git -C "$ROOT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Current directory is not a git repository: $ROOT_DIR"
  exit 1
fi

"$ROOT_DIR/scripts/validate_skills.sh"

if [[ -n "$(git -C "$ROOT_DIR" status --porcelain)" ]]; then
  echo "Working tree is dirty. Commit or stash changes before tagging."
  exit 1
fi

git -C "$ROOT_DIR" tag -a "$TAG" -m "skills release ${TAG}"
echo "Created tag: ${TAG}"
echo "Push with: git -C \"$ROOT_DIR\" push origin \"$TAG\""

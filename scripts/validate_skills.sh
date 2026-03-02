#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYSTEM_VALIDATOR="${HOME}/.codex/skills/.system/skill-creator/scripts/quick_validate.py"

fallback_validate() {
  local skill_dir="$1"
  local skill_md="${skill_dir}/SKILL.md"

  if [[ ! -f "$skill_md" ]]; then
    echo "[FAIL] $(basename "$skill_dir"): missing SKILL.md"
    return 1
  fi

  if ! head -n 1 "$skill_md" | grep -q '^---$'; then
    echo "[FAIL] $(basename "$skill_dir"): missing YAML frontmatter"
    return 1
  fi

  if ! grep -Eq '^name:[[:space:]]+[a-z0-9-]+[[:space:]]*$' "$skill_md"; then
    echo "[FAIL] $(basename "$skill_dir"): missing or invalid name in frontmatter"
    return 1
  fi

  if ! grep -Eq '^description:[[:space:]]+.+$' "$skill_md"; then
    echo "[FAIL] $(basename "$skill_dir"): missing description in frontmatter"
    return 1
  fi

  echo "[OK] $(basename "$skill_dir"): fallback validation passed"
}

status=0
while IFS= read -r skill_name; do
  skill_dir="${ROOT_DIR}/${skill_name}"
  if [[ -f "$SYSTEM_VALIDATOR" ]]; then
    if python3 "$SYSTEM_VALIDATOR" "$skill_dir" >/tmp/skill_validate.out 2>/tmp/skill_validate.err; then
      echo "[OK] ${skill_name}: system validation passed"
    else
      echo "[FAIL] ${skill_name}: system validation failed"
      cat /tmp/skill_validate.out /tmp/skill_validate.err
      status=1
    fi
  else
    if ! fallback_validate "$skill_dir"; then
      status=1
    fi
  fi
done < <("$ROOT_DIR/scripts/list_skills.sh")

if [[ $status -ne 0 ]]; then
  exit $status
fi

echo "All skills validated."

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST_DIR="${CODEX_HOME:-$HOME/.codex}/skills"

force=0
install_all=0
skills=()

usage() {
  cat <<'EOF'
Usage:
  install_to_codex_home.sh --all [--force]
  install_to_codex_home.sh <skill-name> [<skill-name> ...] [--force]

Options:
  --all      Install all skills from this repository.
  --force    Overwrite existing installed skill directories.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      install_all=1
      shift
      ;;
    --force)
      force=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      skills+=("$1")
      shift
      ;;
  esac
done

if [[ $install_all -eq 1 ]]; then
  mapfile -t skills < <("$ROOT_DIR/scripts/list_skills.sh")
fi

if [[ ${#skills[@]} -eq 0 ]]; then
  usage
  exit 1
fi

mkdir -p "$DEST_DIR"

for skill_name in "${skills[@]}"; do
  src_dir="${ROOT_DIR}/${skill_name}"
  dst_dir="${DEST_DIR}/${skill_name}"

  if [[ ! -f "${src_dir}/SKILL.md" ]]; then
    echo "Skip ${skill_name}: not a valid skill directory at ${src_dir}"
    continue
  fi

  if [[ -d "$dst_dir" && $force -ne 1 ]]; then
    echo "Skip ${skill_name}: already exists at ${dst_dir} (use --force to overwrite)"
    continue
  fi

  if [[ -d "$dst_dir" && $force -eq 1 ]]; then
    rm -rf "$dst_dir"
  fi

  rsync -a "$src_dir/" "$dst_dir/"
  echo "Installed ${skill_name} -> ${dst_dir}"
done

echo "Done. Restart Codex to pick up new skills."

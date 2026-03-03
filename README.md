# codex-skills

Reusable Codex skills managed as a standalone Git repository.

## Repository Layout

```
codex-skills/
├── commit-workflow/
│   ├── SKILL.md
│   ├── agents/openai.yaml
│   └── references/
└── scripts/
    ├── list_skills.sh
    ├── validate_skills.sh
    ├── install_to_codex_home.sh
    └── release_tag.sh
```

Rules:

1. Put each skill in `<skill-name>/`.
2. Keep required file `<skill-name>/SKILL.md`.
3. Use hyphen-case for skill directory names.
4. Keep skill-facing docs inside the skill folder (`references/`, `scripts/`, `assets/`).

## Day-to-Day Workflow

1. Add or modify skills.
2. Validate all skills:
   - `./scripts/validate_skills.sh`
3. Commit and push changes.
4. Create a release tag:
   - `./scripts/release_tag.sh v0.1.0`

## Install Skills Locally

Install all skills to `${CODEX_HOME:-~/.codex}/skills`:

```bash
./scripts/install_to_codex_home.sh --all
```

Install specific skills:

```bash
./scripts/install_to_codex_home.sh commit-workflow
```

Overwrite existing installed skills:

```bash
./scripts/install_to_codex_home.sh --all --force
```

After installation, restart Codex to pick up new skills.

## Use From Any Project

Clone this repository once, then install skills globally:

```bash
git clone <your-org>/<your-skills-repo>.git ~/.local/share/codex-skills
~/.local/share/codex-skills/scripts/install_to_codex_home.sh --all --force
```

This keeps skills decoupled from application repositories and reusable across projects.

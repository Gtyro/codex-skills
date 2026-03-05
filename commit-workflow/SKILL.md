---
name: commit-workflow
description: Stage git changes with git add and create, validate, or rewrite commit messages that follow Conventional Commits plus project-specific commit policy. Use when a user asks to auto-stage changes, asks for commit subjects/bodies, asks whether a message is compliant, requests a commit command, or needs message alternatives after code changes.
---

# Commit Workflow

Stage changes safely, then generate commit messages that are machine-checkable and team-compliant.

## Workflow

1. Read project policy sources before writing any message.
2. Prefer local policy precedence:
   - `.github/` rules, `CONTRIBUTING.md`, `docs/engineering/*`
   - `AGENTS.md` or repo-specific operational instructions
   - Team default policy when repo policy is missing
3. Inspect workspace state with `git status --short`.
4. Stage task-scoped changes unless the user explicitly asked for review-only mode.
5. Extract technical intent from staged changes.
6. Choose the Conventional Commit `type` and `scope`.
7. Draft subject and optional body.
8. Validate subject format and policy constraints.
9. Return staged summary plus commit text, and include a commit command only when requested.

## Staging Rules

Apply these rules when staging:

1. Build candidate paths from files changed in the current task/session.
2. Classify each candidate file as task-pure or mixed.
3. If a file is task-pure (all changes belong to the current task and no overlap risk), stage it directly with `git add <path>`.
4. Use interactive patch staging `git add -p <path>` for mixed files, uncertain ownership, or shared files.
5. If the user gives an explicit file/path scope, constrain staging commands to that scope.
6. Use `git add -A` only when the user explicitly asks to stage all changes.
7. If `git status --short` shows conflict markers (`UU`, `AA`, `DD`), stop and report conflicts.
8. In multi-agent overlap cases on the same file, keep using patch mode and avoid staging mixed unrelated hunks.
9. If a mixed hunk cannot be cleanly separated in patch mode, leave it unstaged and report it.
10. After staging, show a concise staged summary with `git diff --staged --name-status`.
11. Do not run `git commit` unless the user explicitly asks.

## Subject Rules

Apply all rules:

1. Use Conventional format: `<type>(<scope>): <subject>` or `<type>: <subject>`.
2. Pick `type` and `scope` using the reference heuristics in [references/commit_message_policy.md](references/commit_message_policy.md).
3. Keep subject technical and intent-oriented.
4. Use imperative style in the subject clause.
5. Avoid transient planning labels in subject (for example: `W2`, `M1`, `phase-x`, `milestone-y`).
6. Avoid trailing period.

## Output Contract

When asked for commit text, return:

1. One recommended commit message.
2. Up to two alternatives only when tradeoffs are meaningful.
3. A short staged-file summary when staging was performed.
4. A `git commit -m "..."` command only if the user asks for a command.

Use [references/commit_message_policy.md](references/commit_message_policy.md) for allowed types, scope guidance, staging examples, edge cases, and review checklist.

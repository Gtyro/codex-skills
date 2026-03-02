---
name: commit-policy
description: Create, validate, and rewrite git commit messages that must follow Conventional Commits plus project-specific commit message policy. Use when a user asks for commit subjects/bodies, asks whether a message is compliant, requests a commit command, or needs message alternatives after code changes.
---

# Commit Policy

Generate commit messages that are machine-checkable and team-compliant.

## Workflow

1. Read project policy sources before writing any message.
2. Prefer local policy precedence:
   - `.github/` rules, `CONTRIBUTING.md`, `docs/engineering/*`
   - `AGENTS.md` or repo-specific operational instructions
   - Team default policy when repo policy is missing
3. Extract technical intent from staged/changed files.
4. Choose the Conventional Commit `type` and `scope`.
5. Draft subject and optional body.
6. Validate subject format and policy constraints.
7. Return final message plus ready-to-run `git commit` command when requested.

## Subject Rules

Apply all rules:

1. Use Conventional format: `<type>(<scope>): <subject>` or `<type>: <subject>`.
2. Use a recognized `type`:
   - `fix` for bug fixes and behavior corrections.
   - `feat` for user-visible capabilities.
   - `refactor` for internal design changes without behavior change.
   - `perf` for performance improvements.
   - `test` for tests only.
   - `docs` for documentation only.
   - `build` for tooling/dependencies/build config.
   - `ci` for CI pipeline changes.
   - `chore` for low-impact maintenance.
3. Keep subject technical and intent-oriented.
4. Use imperative style in the subject clause.
5. Avoid transient planning labels in subject (for example: `W2`, `M1`, `phase-x`, `milestone-y`).
6. Avoid trailing period.

## Body Rules

Add a body only when needed for context.

1. Use short bullet lines for rationale or impact.
2. Place plan traceability links in body, never in subject.
3. Use `Refs: <path-or-ticket>` when tracing to plans/tasks.
4. Keep body factual and implementation-focused.

## Output Contract

When asked for commit text, return:

1. One recommended commit message.
2. Up to two alternatives only when tradeoffs are meaningful.
3. A `git commit -m "..."` command if the user asks for a command.

Use [references/commit_message_policy.md](references/commit_message_policy.md) for templates, edge cases, and review checklist.

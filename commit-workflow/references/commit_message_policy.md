# Commit Message Policy Reference

This file extends [../SKILL.md](../SKILL.md) with staging guidance, decision heuristics, and examples.
Keep normative guardrails in `SKILL.md`; keep this file focused on applied guidance.

## Staging Patterns

1. Default task-scoped flow:
   - `git status --short`
   - Stage task-pure files directly: `git add <task-pure-path1> <task-pure-path2> ...`
   - Use patch mode for mixed/uncertain files: `git add -p <mixed-path1> <mixed-path2> ...`
   - `git diff --cached --name-status`
2. Explicit user-scoped flow:
   - For fully task-pure scoped files: `git add <path1> <path2> ...`
   - Otherwise: `git add -p <path1> <path2> ...`
   - `git diff --cached --name-status`
3. Conflict handling:
   - If status includes `UU`, `AA`, or `DD`, stop and ask user to resolve conflicts before staging.
4. Multi-agent overlap handling:
   - Prefer patch staging to isolate current-task hunks in shared files.
   - Do not ask for path scope by default; derive paths from current task changes.
   - If a hunk is mixed and cannot be split safely, leave it unstaged and report it.
   - Let the user control final commit boundaries when a file mixes changes from multiple agents.

## Subject Template

Use one of:

1. `<type>(<scope>): <subject>`
2. `<type>: <subject>`

Examples:

1. `fix(frontend): persist tab session state for chat and forms`
2. `feat(api): add optimize job resume endpoint`
3. `docs: clarify deployment rollback procedure`

## Scope Selection

Pick the most specific stable scope from changed paths:

1. `frontend`, `backend`, `worker`, `infra`, `docs`, `tests`
2. Omit scope when changes are wide or no single scope dominates.

## Type Selection Heuristic

1. Behavior bug fix -> `fix`
2. New capability -> `feat`
3. Structural cleanup without behavior change -> `refactor`
4. Faster execution or lower resource usage -> `perf`
5. Test files/assertions only -> `test`
6. Documentation only -> `docs`
7. Build/dependency/toolchain -> `build`
8. CI workflow/pipeline only -> `ci`
9. Small maintenance and no user impact -> `chore`

## Edge Cases

1. Mixed intent changes:
   - Choose the dominant user impact for `type`, or split into multiple commits.
2. Refactor plus bug fix in one commit:
   - Use `fix` if behavior correction is real and user-impacting.
3. Scope ambiguity:
   - Omit scope rather than guessing a broad or unstable scope name.
4. Traceability when required by team policy:
   - Put `Refs: <path-or-ticket>` in the body, never in subject.

## Quick Review Checklist

1. Intended files are staged and visible in `git diff --cached --name-status`.
2. Subject follows one of the two allowed templates.
3. `type` reflects the dominant technical intent.
4. `scope` is specific and stable, or intentionally omitted.
5. Subject is concise, imperative, and implementation-focused.
6. Body is present only for rationale/impact/traceability.

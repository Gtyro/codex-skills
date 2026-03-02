# Commit Message Policy Reference

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

## Policy Add-ons

1. Keep subject technical and explicit about intent.
2. Keep planning tokens out of subject:
   - Forbidden examples: `W2`, `M1`, `phase-x`, `milestone-y`
3. Put plan traceability in body:
   - `Refs: OptiDoc/PLAN_FOCUS_MODE_V1.md#W2`

## Quick Review Checklist

1. Subject matches Conventional format.
2. Type matches actual change intent.
3. Scope is accurate or intentionally omitted.
4. Subject excludes transient plan labels.
5. Body contains traceability only when needed.

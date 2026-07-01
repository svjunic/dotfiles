# Review Protocol

Use this protocol to keep reviews strict, actionable, and grounded in evidence.

## Findings Standard

A finding must include:

- Severity: `Critical`, `High`, `Medium`, or `Low`.
- Location: file and line when available.
- Trigger: the concrete input, runtime path, environment, or sequence that exposes the issue.
- Impact: what breaks, leaks, corrupts, regresses, or becomes unsafe.
- Evidence: code path, type/API contract, test behavior, command output, or documented invariant.
- Fix direction: enough detail for an implementer to act without guessing.
- Test gap: what test is missing or insufficient.

Do not report:

- Pure style preferences.
- Hypothetical issues with no plausible runtime path.
- Broad architecture opinions unless they create a concrete failure mode.
- Duplicate symptoms when one root finding covers them.

## Severity Guide

- `Critical`: data loss, security bypass, irreversible destructive action, production outage, or a change that cannot be safely executed.
- `High`: common runtime path fails, migration/deploy can break live systems, serious regression, race, leak, or wrong external side effect.
- `Medium`: edge path fails, degraded reliability, incorrect error handling, missing cleanup, weak validation, or meaningful test blind spot.
- `Low`: narrow correctness issue, confusing behavior, maintainability risk with a concrete future breakage path.

## Finding Categories

Use these labels mentally while reviewing; include them in the title when they clarify the issue:

- `Expectation mismatch`: implementation behavior does not satisfy the request, acceptance criteria, issue, spec, or documented behavior.
- `Partial implementation`: only some required cases, states, or call paths are implemented.
- `Contract drift`: public API, CLI, schema, event, error, return value, or compatibility behavior changes unintentionally.
- `Regression risk`: existing behavior likely changes without a stated migration path or test coverage.
- `Runtime safety`: realistic execution can fail, corrupt state, duplicate side effects, or behave differently by environment.
- `Security`: authorization, validation, injection, secret handling, dependency, or exposure risk.
- `Test gap`: tests do not verify the behavior or failure mode that matters.

## Review Order

1. Reconstruct expected behavior from the request, issue/PR text, specs, docs, tests, schemas, and prior behavior.
2. Map expectations to implementation paths and identify missing, partial, or over-broad behavior.
3. Start from entrypoints and invocation modes.
4. Trace changed data through validation, transformation, side effects, and error handling.
5. Check assumptions about environment, configuration, filesystem, network, clocks, locale, permissions, and dependency versions.
6. Compare implementation behavior to tests and documented contracts.
7. Look for unsafe operations, especially deletes, overwrites, migrations, shell commands, external writes, and irreversible state changes.
8. Only after correctness and safety, consider maintainability findings with concrete consequences.

## Final Review Shape

Lead with findings. Keep summaries short and secondary.

Use this format:

```markdown
Findings
- [High] src/job.ts:42 - Retry loop can duplicate writes
  The retry wraps the external write but not the idempotency key creation, so a timeout after the write can enqueue the same side effect again. This affects the normal worker path because `processJob` retries all thrown errors. Move idempotency creation before the write or make the external call idempotent.
  Test gap: add a timeout-after-write test that verifies a retry does not create a second external write.

Open Questions / Assumptions
- I assumed the queue retries thrown errors because `worker.ts` configures `attempts: 3`.

Notes
- Ran `npm test -- job`; did not run full integration tests.
```

If no findings exist:

```markdown
Findings
- No actionable findings found.

Notes
- Residual risk: ...
- Checks run: ...
```

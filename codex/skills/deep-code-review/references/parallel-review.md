# Parallel Review

Use parallel review for large, risky, or ambiguous changes. For small diffs, run the same lenses sequentially in one pass.

## When To Split

Split the review when:

- The diff spans multiple subsystems or runtime entrypoints.
- The expected behavior is non-trivial or spread across issue text, docs, tests, and schemas.
- The change includes IO, persistence, security, migrations, or public contracts.
- A single reviewer is likely to over-focus on one class of risk.

Do not split when the overhead would exceed the review value.

## Recommended Reviewer Roles

Use these roles for subagents when the environment and user permissions allow it. Otherwise, perform the same passes sequentially.

- `Expectation/Contract reviewer`: reconstruct expected behavior; check specs, docs, tests, public API, CLI, schema, and compatibility.
- `Runtime/Data reviewer`: check entrypoints, IO, state mutation, migrations, retries, idempotency, concurrency, and partial failure.
- `Security/Operations reviewer`: check auth, validation, secret handling, deployment, rollback, logging, metrics, and production safety.
- `Test reviewer`: check whether tests prove the requirements, failure modes, regressions, and runtime entrypoints.
- `Design/Maintainability reviewer`: check boundaries, coupling, type contracts, duplication, testability, and concrete future bug risk.

## Subagent Prompt Pattern

Use prompts shaped like this, passing the skill path and raw review target:

```text
Use $deep-code-review at /path/to/skills/deep-code-review to review this change as the Expectation/Contract reviewer. Focus only on expected behavior, public contracts, compatibility, and requirement coverage. Return actionable findings with file/line evidence, assumptions, and test gaps.
```

Keep subagent tasks independent. Do not pass expected findings or conclusions. Merge overlapping findings by root cause before the final response.

## Sequential Fallback

When subagents are unavailable, run these passes in order:

1. Expectation/contract pass.
2. Runtime/data pass.
3. Security/operations pass.
4. Test pass.
5. Design/maintainability pass.

The final review should still be findings-first and severity-ordered, not grouped by pass.

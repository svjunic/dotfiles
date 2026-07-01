# Expectation Fit

Use this reference to check whether the implementation satisfies what was actually expected. Treat this as the first review pass: correct-looking code is still wrong if it solves the wrong problem.

## Reconstruct Expected Behavior

Build an expectation set from available sources:

- User request, issue, PR description, acceptance criteria, product spec, design doc, or ticket comments.
- README, docs, CLI help, API schema, OpenAPI/GraphQL/protobuf definitions, type declarations, config docs, and migration notes.
- Existing tests, fixtures, snapshots, and examples.
- Existing behavior in adjacent code, previous commits, compatibility layers, and public contracts.
- Error messages, exit codes, logs, events, metrics, and documented operational behavior.

Separate:

- Explicit requirements: stated directly by the source.
- Implied requirements: necessary for compatibility, safety, or existing behavior.
- Assumptions: plausible but not proven; report these under assumptions when they affect a finding.

## Map Expectations To Implementation

For each expectation, identify:

- The runtime entrypoint that should satisfy it.
- The code path that implements it.
- The validation, transformation, side effect, and response/error behavior involved.
- The test that proves it.

Look for:

- Missing implementation for a stated requirement.
- Partial implementation that covers only one caller, input shape, environment, or state.
- Over-broad implementation that changes behavior outside the requested scope.
- Behavior that satisfies tests but not the documented or user-visible contract.
- New behavior without migration notes, compatibility handling, or release risk called out.

## Common Expectation Mismatches

- The implementation handles the happy path but not the acceptance criterion's edge case.
- The API shape changes while tests only exercise internal functions.
- A CLI flag is added but not wired through package scripts, help text, exit codes, or docs.
- A config option is read in one runtime path but ignored in worker, test, or production entrypoints.
- A migration handles empty databases but not existing production data.
- A fallback silently changes semantics instead of preserving existing behavior.
- A fix is scoped to one UI/API surface while the same domain behavior exists elsewhere.

## Finding Language

Use direct titles when expectation fit fails:

- `Expectation mismatch: documented dry-run still writes files`
- `Partial implementation: worker path ignores the new config`
- `Contract drift: API now returns null where callers expect []`
- `Regression risk: existing CLI exit code changes without coverage`

In the finding body, state the expected behavior first, then the observed implementation behavior.

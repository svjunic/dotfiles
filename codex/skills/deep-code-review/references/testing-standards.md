# Testing Standards

Use this guide to evaluate whether tests actually protect the changed behavior.

## Required Test Evidence

For each meaningful behavior change, look for tests that cover:

- The expected behavior from the issue, PR, spec, docs, API contract, or user request.
- The normal success path through the real entrypoint.
- At least one failure path through the real entrypoint.
- Boundary values and malformed inputs.
- Existing data/state, empty data/state, and partially completed prior runs when relevant.
- Repeated execution and concurrent execution when the code can run that way.
- Platform or environment differences when the implementation depends on paths, shells, env vars, network, time, or permissions.

Prefer tests that exercise public behavior over tests that only assert implementation details.

## Expectation-Fit Tests

Check whether tests express the requirement rather than simply confirming the current implementation.

Flag test coverage as insufficient when:

- The test name or assertions do not tie back to the requested behavior.
- The test would still pass if an acceptance criterion were omitted.
- The test only verifies mocks, internal calls, or snapshots instead of user-visible behavior.
- The changed implementation defines the expected output without an independent oracle.
- Existing tests cover a narrower case than the request or public contract requires.

## Runtime Safety Tests

For unsafe operations, expect tests or equivalent verification for:

- Dry-run or preview behavior.
- Path scoping and refusal to operate outside the intended root.
- Idempotency when run twice.
- Partial failure recovery or clear failure without corrupting state.
- Non-zero exit status or visible error on failure.
- No external side effect when validation fails.

## Test Smell Checklist

Flag tests as insufficient when they:

- Only check that a function was called, not the effect or result.
- Mock away the risk being reviewed.
- Assert snapshots without validating critical behavior.
- Cover only happy paths for code that performs IO or mutation.
- Mirror the implementation so closely that the test cannot catch a wrong interpretation of the requirement.
- Depend on execution order or shared global state.
- Pass without exercising the changed runtime entrypoint.

## Suggested Test Language

In findings, name the missing test concretely:

- "Add a CLI test that runs the command from a different current working directory and asserts it refuses to delete outside the workspace."
- "Add an integration test where the external write succeeds but the response times out, then verify retry does not duplicate the write."
- "Add a migration test with pre-existing rows and a rollback/partial-failure scenario."
- "Add an acceptance test for the documented behavior in the issue, including the case the current implementation omits."

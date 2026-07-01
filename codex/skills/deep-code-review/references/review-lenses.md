# Review Lenses

Use these lenses to keep reviews comprehensive. Do not output a checklist; use the lenses to discover actionable findings.

## Expectation And Correctness

- Does the implementation satisfy the request, spec, issue, API contract, and existing behavior?
- Are all required states, inputs, users, environments, and invocation paths covered?
- Does the change introduce behavior outside the requested scope?
- Are error states, boundary values, empty states, and malformed inputs handled correctly?

## Contract And Compatibility

- Public APIs, CLI flags, config keys, schemas, events, return values, status codes, and error types.
- Backward compatibility for callers, stored data, clients, scripts, docs, and generated files.
- Versioning, migration path, deprecation behavior, and feature flag behavior.

## Runtime Safety

- Entrypoints, environment assumptions, current working directory, shells, permissions, platforms, and dependency versions.
- IO, subprocesses, network calls, retries, timeouts, cancellation, cleanup, and exit codes.
- Repeated execution, partial failure, interrupted execution, and resumed execution.

## Data Integrity

- Migrations, existing data, transactions, uniqueness, idempotency, ordering, deduplication, and rollback.
- Concurrent reads/writes, race windows, stale caches, and cross-tenant or cross-namespace isolation.
- Serialization, parsing, timezone, locale, precision, and schema evolution.

## Security And Privacy

- Authentication, authorization, tenant boundaries, privilege escalation, and insecure defaults.
- Input validation, injection, path traversal, SSRF, unsafe deserialization, and command construction.
- Secrets in logs/errors/tests, dependency risk, supply-chain changes, and accidental public exposure.

## Performance And Scale

- N+1 calls, unbounded loops, synchronous IO on hot paths, large input behavior, memory growth, and expensive serialization.
- Cache invalidation, batching, pagination, streaming, backpressure, and timeout behavior.
- Production data sizes versus test fixtures.

## Operations And Observability

- Deploy/migration ordering, rollback behavior, feature flags, config rollout, and mixed-version compatibility.
- Logs, metrics, traces, alerts, and failure diagnostics.
- Success/failure signaling for automation, CI, workers, and operators.

## Maintainability And Design

- Responsibility boundaries, duplication, abstraction fit, type contracts, invariants, and testability.
- Hidden coupling, global mutable state, temporal coupling, and future-change hazards.
- Report maintainability only when it creates a concrete bug risk, testing blind spot, or operational cost.

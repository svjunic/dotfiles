# Runtime Safety Checklist

Use this checklist when a change could behave differently depending on execution path, timing, environment, IO, or operational state.

## Invocation And Environment

Check whether the change is safe under each realistic invocation:

- Direct CLI, package script, test runner, daemon, web request, worker, cron, migration, container entrypoint, or library import.
- Fresh install, dirty working tree, missing optional dependency, different shell, different current working directory, CI, container, macOS/Linux, and restricted permissions.
- Missing, malformed, or conflicting environment variables and config files.
- Repeated execution, partial previous execution, interrupted execution, and resumed execution.

Red flags:

- Relative paths resolved from an assumed current directory.
- Shell-dependent behavior without explicit shell constraints.
- Cleanup that deletes broad paths or follows user-controlled paths.
- Code that works only when run in one specific command order.

## State, IO, And Destructive Operations

Inspect every operation that writes, deletes, moves, migrates, uploads, posts, publishes, or mutates external state.

Ask:

- Is the operation scoped to the intended directory, tenant, branch, environment, account, or namespace?
- Is it idempotent when run twice?
- What happens after partial failure between steps?
- Is there a dry-run, confirmation, backup, transaction, rollback, or compensating action when needed?
- Can concurrent runs interleave and corrupt state?
- Are temporary files unique, cleaned up, and safe from symlink/path traversal issues?

Red flags:

- `rm -rf`, recursive deletes, broad globs, path joins with user input, and overwrites without existence checks.
- Migrations that assume empty data or a single application version.
- External side effects inside retry loops without idempotency keys.
- Writes before validation is complete.

## Time, Concurrency, And Retries

Check:

- Race conditions between read/check/write steps.
- Locks, transactions, atomic renames, compare-and-swap, or uniqueness constraints where needed.
- Timeout behavior for network, subprocess, database, and filesystem operations.
- Retry policy: bounded, classified by error type, backoff, idempotent, and observable.
- Cancellation and signal handling for long-running commands or workers.

Red flags:

- Infinite or unbounded loops.
- Retrying non-idempotent side effects.
- Fire-and-forget async work whose failure is ignored.
- Shared mutable process state in request handlers or parallel tests.

## Failure Visibility

Check:

- Errors include enough context to debug without leaking secrets.
- Failures return non-zero exit codes where callers depend on them.
- Logs/metrics distinguish expected skip, retryable failure, permanent failure, and success.
- Cleanup failure does not hide the original failure unless intentionally prioritized.

Red flags:

- Catch blocks that swallow errors.
- Fallbacks that silently use production defaults.
- Success messages emitted before all side effects are complete.

## Dependency And Version Risk

Check:

- New dependency APIs are used according to their version in the lockfile.
- Optional peer dependencies and platform-specific binaries are handled.
- Generated files or lockfiles match source changes.
- Feature detection is used when runtime capabilities differ across versions.

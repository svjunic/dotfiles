---
name: deep-code-review
description: Comprehensive, rigorous code review for local changes, diffs, pull requests, and repositories. Use when Codex is asked to review code, audit a change, verify implementation against expected behavior, find regressions, assess runtime safety, evaluate operational/security/data/API/test risk, or identify missing tests across any programming language or stack.
---

# Deep Code Review

Use this skill to perform strict, evidence-based code reviews. Start by reconstructing expected behavior, then check whether the implementation satisfies it across correctness, runtime safety, contracts, data, security, operations, performance, maintainability, and tests. Do not spend findings on style unless style hides a real maintenance or correctness risk.

## Review Workflow

1. Establish the review surface and expected behavior:
   - Identify the diff, files, PR, branch, or command output under review.
   - Reconstruct the expected behavior from user request, issue/PR text, specs, docs, tests, schemas, public contracts, and prior behavior.
   - Separate explicit requirements from inferred expectations and assumptions.
   - Inspect surrounding code before judging a changed line.
   - Determine how the changed code is invoked at runtime: CLI, server request, background job, migration, build step, test harness, scheduled task, or library API.

2. Load references as needed:
   - Read `references/review-protocol.md` before producing the final review.
   - Read `references/expectation-fit.md` when the review depends on whether implementation satisfies a request, issue, spec, acceptance criteria, API contract, or existing behavior.
   - Read `references/review-lenses.md` to cover the full set of review perspectives and avoid over-focusing on one class of risk.
   - Read `references/runtime-safety.md` when the change touches execution flow, IO, persistence, networking, concurrency, subprocesses, configuration, deployment, migrations, retries, cleanup, or destructive operations.
   - Read `references/testing-standards.md` when evaluating existing tests or proposing missing coverage.
   - Read `references/parallel-review.md` when the review is large enough to benefit from separate passes or subagents.

3. Verify claims:
   - Prefer concrete evidence from code, tests, schemas, docs, commands, logs, or type contracts.
   - Run non-destructive tests or static checks when they are available and proportionate.
   - If a finding depends on an assumption, state the assumption and why it is plausible.

4. Review through each lens:
   - Check expectation fit before implementation quality: working code that solves the wrong problem is a finding.
   - Check contracts, runtime safety, data integrity, security, performance, operations, maintainability, and test adequacy.
   - Keep only actionable findings with plausible failure paths or meaningful requirement gaps.

5. Report findings first:
   - Order by severity and practical impact.
   - Include file and line references whenever available.
   - Explain the failure scenario, not just the suspicious code shape.
   - Include a fix direction and the test that should catch the issue.

## Output Requirements

Use this structure for the final response:

```markdown
Findings
- [Severity] path:line - Title
  Evidence and failure scenario. Explain why this can happen in real execution, what breaks, and what fix direction is appropriate.
  Test gap: Name the missing or insufficient test.

Open Questions / Assumptions
- ...

Notes
- Mention checks run, checks not run, and residual risk.
```

If there are no actionable findings, say so directly, then list residual test gaps or uncertainty. Do not pad the review with generic checklist items.

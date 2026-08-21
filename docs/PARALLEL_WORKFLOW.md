# Parallel verification workflow

> **Scope:** This document defines how DAAD Harvester runs independent deterministic verification gates concurrently without weakening evidence boundaries or hiding failures.

The repository provides `scripts/run_parallel_workflow.py` as the standard parallel scheduler for read-only verification. It uses an explicit allowlist of gates, isolated subprocesses, bounded worker concurrency, captured output, deterministic result ordering, and an aggregate non-zero exit status when any gate fails. It does not replace the ordered primary workflow for commands that regenerate shared files or require sequencing.

## Gate groups

| Group | Purpose | Examples | Shared-write policy |
| --- | --- | --- | --- |
| `evidence` | Validate retained corpus, resources, checksums, reverse-engineering records, and native generators. | Corpus integrity, runtime resources, artifact checksums, reverse corpus, native generators. | Read-only verification only. |
| `publication` | Validate generated public outputs, manifests, documentation, language policy, and lint. | Backlog index, regeneration manifest, public artifact manifest, static report, documentation, pyflakes. | Each command runs in an isolated CI checkout; local commands are check-only. |
| `analysis` | Validate DDB round trips and bounded negative evidence. | Native round trips and token-boundary blocker. | Read-only verification only. |

The complete parallel invocation is:

```bash
python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4
```

The scheduler defaults to a host-bounded worker count capped at eight. A caller may lower or raise the limit explicitly, but never below one. The effective count is clamped to the number of selected gates so idle workers are not created.

## Safety rules

Parallelism is permitted only for commands that have an explicit entry in the scheduler allowlist and whose verification contract is safe to run concurrently. A task that writes a shared report, changes the corpus database, regenerates a manifest, or depends on a previous command remains in the ordered `scripts/run_primary_workflow.py` path until it has an isolated workspace or an explicit dependency edge. A green child gate never promotes a broad TODO requirement by itself.

Each subprocess runs from the repository root with captured standard output and standard error. Results are sorted by gate name before presentation, so completion order cannot change the diagnostic transcript. All failures are reported together after every selected gate finishes, which maximizes useful feedback while retaining a failing process exit status for CI.

## Local and CI parity

GitHub Actions invokes the same scheduler and gate groups as a clean local clone. The test suite and CLI smoke checks remain separate because they have different lifecycle and resource characteristics. The ordered primary workflow remains available for release debugging, exact gate sequencing, or environments where concurrent execution is not desired.

```bash
# Fast independent verification
python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4

# Ordered release gate
python scripts/run_primary_workflow.py
```

A scheduler change requires focused tests in `tests/test_run_parallel_workflow.py`, a full regression run, and an atomic commit containing the scheduler, tests, CI wiring, and this documentation. The active TODO and evidence index must describe any new boundary or failed gate rather than silently dropping it.

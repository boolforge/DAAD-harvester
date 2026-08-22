---
name: daad-harvester-parallel-gates
description: Safe parallel verification for DAAD Harvester. Use whenever an agent validates code, evidence, reports, manifests, documentation, or tests; always invoke the repository-owned scheduler with bounded workers and timeouts.
---

# Parallel gates

Use `python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4 --timeout 300` for independent read-only verification. Do not create a private scheduler or run non-allowlisted commands concurrently. Keep shared-file regeneration, database mutation, and dependent operations ordered or isolated. Inspect all aggregate failures, fix the same bounded concern, and rerun the scheduler before delivery. Use `python scripts/run_primary_workflow.py` for the full gate; use `--ordered` only for strict recovery diagnostics. Preserve `TODO.md`, manifests, and unresolved evidence boundaries.

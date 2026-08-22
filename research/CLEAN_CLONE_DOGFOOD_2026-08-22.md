# Clean-Clone Dogfooding Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Can a separate clean clone exercise the synchronized repository’s documented workflow and deterministic verification paths without relying on the active checkout, an unrecorded prompt, or hidden project state? |
| **Evidence scope** | One fresh Git clone of `boolforge/DAAD-harvester` at commit `e5849aabc361539cf175a14f576d73b4be12c60e`, created in a separate empty directory and exercised through versioned repository entry points. |
| **Status** | clean-clone validation passed |
| **Implementation links** | [`../AGENT_WORKFLOW.md`](../AGENT_WORKFLOW.md), [`../agent_workflow.json`](../agent_workflow.json), [`../scripts/run_parallel_workflow.py`](../scripts/run_parallel_workflow.py), [`../scripts/run_primary_workflow.py`](../scripts/run_primary_workflow.py), [`../scripts/run_reverse_analysis.py`](../scripts/run_reverse_analysis.py) |
| **Non-claims** | This record validates one clean clone in the recorded environment. It does not prove operation on every operating system, network, package mirror, hardware architecture, external analyzer, or future repository revision. |

## Procedure and outcome

The validation used `gh repo clone boolforge/DAAD-harvester <empty-directory>`
and did not copy state, caches, generated outputs, untracked files, or local
configuration from the active checkout. The clone reported a clean
`main...origin/main` state at the recorded commit before and after every check.

| Documented entry point | Outcome |
| --- | --- |
| `python3 scripts/verify_environment.py` | Passed: Python, Git, SQLite, and an archive extractor met the portable preflight. |
| `python3 scripts/build_active_backlog_index.py --check` | Passed with 162 unchecked preserved work items. |
| `python3 scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4 --timeout 300` | Passed all 21 allowlisted read-only gates. |
| `python3 scripts/run_primary_workflow.py --ordered` | Passed the strict ordered workflow with 442 tests. |
| `python3 scripts/run_reverse_analysis.py --check` | Verified 42 retained analysis records without launching analyzers or writing outputs. |
| Regeneration, report, public-manifest, resource-review, inventory, and acquisition-queue `--check` entry points | Passed: 19 regeneration entries, 42 inputs, 28 outputs, 1,015 retained artifacts, and a zero-queued/79-deferred source-specific authorization queue. |

No clean-clone portability or contract defect was reproduced. The validation
therefore required no code repair. The final active development checkout remains
the only location for subsequent changes; the temporary dogfooding checkout is
not evidence or project state.

## Boundary

The successful check demonstrates that the documented repository paths can be
followed from this clone. It does not authorize new acquisition, promote a
format or interpreter claim, establish emulator equivalence, or replace the
separate native evidence requirements for every preservation feature.

## References

1. [Agent workflow contract](../AGENT_WORKFLOW.md)
2. [Parallel verification workflow](../docs/PARALLEL_WORKFLOW.md)
3. [Transition reconciliation audit](../docs/reverse_engineering/TOOLCHAIN_TRANSITION.md)

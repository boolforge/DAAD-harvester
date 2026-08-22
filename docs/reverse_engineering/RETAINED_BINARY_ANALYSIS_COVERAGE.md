# Retained Binary Static-Analysis Coverage Ledger

| Header field | Value |
| --- | --- |
| **Question** | Which retained DAAD-related binary profiles have hash-recorded static-analysis outputs, and which admission boundaries remain unresolved? |
| **Evidence scope** | Existing `analysis-run.json` records and their immutable input/output hash declarations. |
| **Status** | 42 retained profiles are inventoried across five architecture families. |
| **Non-claims** | The ledger does not establish correct disassembly, a runtime load model, recovered source, or behavior; it does not admit another retained-byte invocation. |

## Deterministic inspection

```bash
python3 scripts/inspect_retained_binary_analysis_coverage.py
```

The command reads existing records without launching an analyzer or writing
derived output. It fails when an analysis record has no explicit architecture or
load model, relabels a legacy raw-base-zero record as another load model, has no
named analyzer lane or output hash, or duplicates another artifact identity.

## Current inventory boundary

The coverage ledger reports 42 records: 22 i8086, 8 Motorola 68000, 2 MOS 6502,
2 MOS 8501, and 8 Z80 profiles. Each currently records three configured static
analysis lanes. All retain `raw_binary_base_0_unverified` as provenance of the
existing analyzer output and therefore have
`retained_execution_state: refused_pending_full_load_model` plus
`cross_tool_disagreement_state: not_recorded`. Separately, every profile now
reports a contract-backed `container_evidence_progress` state and reference;
this records exactly which verified wrapper, header, segment, relocation, or
image fact exists without promoting the raw output.

The ledger intentionally accepts no alternative load-model label for these
legacy records. A future qualified run must use a separately bounded output
directory and admission contract that records its platform-specific load and
entry model, deterministic command and output hashes, and cross-tool
disagreement state.

This provides a deterministic inventory of prior work, not a declaration that
the binary families are understood. An architecture profile can leave the refusal
state only through its independent platform/load/entry contract and a preserved
cross-tool disagreement record.

## References

1. [Architecture-specific analysis workflows](ARCHITECTURE_WORKFLOWS.md)
2. [ScummVM DAAD engine readiness gate](../requirements/SCUMMVM_DAAD_ENGINE_READINESS.md)
3. [Reverse-analysis read-only verifier](../../scripts/run_reverse_analysis.py)

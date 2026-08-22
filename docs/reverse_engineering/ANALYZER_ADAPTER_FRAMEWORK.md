# Analyzer Adapter Framework

| Header field | Value |
| --- | --- |
| **Question** | How does the repository add redundant static-analysis tools without making a tool output, guessed origin, or installed executable into a source or behavior claim? |
| **Evidence scope** | The native adapter catalog, toolchain matrix, reverse-analysis runner, focused adapter regressions, and candidate scouting record. |
| **Status** | configured core with unconfigured architecture-scoped candidates |
| **Implementation links** | [`../../daad_harvester/analyzer_adapters.py`](../../daad_harvester/analyzer_adapters.py), [`../../reverse_engineering/workflows/analyzer_adapters.json`](../../reverse_engineering/workflows/analyzer_adapters.json), [`../../scripts/run_reverse_analysis.py`](../../scripts/run_reverse_analysis.py), [`../../tests/test_analyzer_adapters.py`](../../tests/test_analyzer_adapters.py) |
| **Non-claims** | An adapter catalog, a successful command, matching listings, or detailed comments do not validate a load model, prove a function boundary, recover source code, establish behavior, or replace native parsing and runtime evidence. |

## Model

The catalog separates **configured adapters** from **candidates**. Configured
adapters must name a pinned tool, CPU architectures, role, raw-load-model
compatibility, executable runner, captured output filename, and commentary
boundary. The validator rejects a configured adapter that lacks one of the
three redundant roles for a current toolchain architecture, names an unknown
toolchain entry, or claims compatibility with a different load model.

Candidates remain data only. They cannot be selected by the runner because they
use the `external_candidate` runner. Promotion requires a pinned installation,
health command, documented invocation, explicit input origin/load model,
retained raw/error output, hashes, comparison record, negative test, and an
atomic review. No candidate is run against a retained DAAD byte merely because
its README advertises a relevant CPU.

| Role | Present configured adapter | Purpose | Boundary |
| --- | --- | --- | --- |
| `control_flow_analysis` | radare2 | Independent control-flow and instruction listing. | Control-flow output is a tool hypothesis at the recorded base. |
| `static_disassembly` | Architecture-specific disassembler | Independent byte-to-instruction decoding. | It does not establish data/code classification or runtime behavior. |
| `structured_analysis` | Ghidra headless binary analysis | Structured listings and decompiler-derived output. | Pseudocode and inferred functions are not recovered source. |

## Commentary protocol

Every detailed adapter-derived note must contain the following ordered layers.

1. **Bytes** state immutable input identity, hash, offset range, and retained
   storage path.
2. **Decoded instructions** state adapter, CPU, endian assumptions, origin, and
   undecoded or disputed bytes.
3. **Tool hypotheses** state inferred functions, control flow, symbols, or
   pseudocode together with the generating adapter and configuration.
4. **Evidenced behavior** cites separate native parser, justified load-model,
   trace, emulator observation, or other reproducible evidence. It must not be
   inferred solely from the previous layers.

The runner records `adapter_id` for newly generated outputs while retaining
compatibility with pre-framework analysis records. Its `--check` mode remains
read-only: it validates retained records and output hashes but does not launch
an analyzer or delete/rewrite derived output.

## Candidate intake

The first cataloged candidates are py8dis for MOS 6502 research, z80dismblr and
SkoolKit for Z80 research, and REDasm for i8086 research. py8dis revision
`2a6046356e20e93c4a2d484bc04bd5d74d66254e` passed only its own isolated,
known-good 6502 demonstration fixture; the [health record](../../research/sources/py8dis_installation_2026-08-22.json)
preserves the command and output hash. It remains unconfigured for retained
DAAD bytes because their MOS 6502 load origin is not yet independently
validated. z80dismblr revision
`2ff52822f0d706f9f39762e079f300f45cfd451d` passed only its upstream source
suite under a documented TypeScript library workaround; its [health record](../../research/sources/z80dismblr_installation_2026-08-22.json)
records the standard build incompatibility and its unconfigured Z80 boundary.
REDasm revision `113245ef02090602978e461fcb7031b75da448d6` remains i8086-only
candidate evidence: its GUI repository and multi-repository workspace do not
provide a stable batch invocation, as recorded in its separate [workspace/core boundary](../../research/sources/redasm_workspace_headless_boundary_2026-08-22.json).
The [candidate scout](../../research/sources/analyzer_candidate_scout_2026-08-22.md)
records the remaining candidates, architecture boundaries, and non-promotion
reasons. None is an enabled workflow dependency.

## References

1. [Cross-tool verification protocol](CROSS_TOOL_VERIFICATION.md)
2. [Architecture-specific workflow](ARCHITECTURE_WORKFLOWS.md)
3. [Candidate scouting record](../../research/sources/analyzer_candidate_scout_2026-08-22.md)

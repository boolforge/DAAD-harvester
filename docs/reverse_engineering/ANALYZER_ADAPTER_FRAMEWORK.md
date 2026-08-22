# Analyzer Adapter Framework

| Header field | Value |
| --- | --- |
| **Question** | How does the repository add redundant static-analysis tools without making a tool output, guessed origin, or installed executable into a source or behavior claim? |
| **Evidence scope** | The native adapter catalog, toolchain matrix, reverse-analysis runner, focused adapter regressions, controlled Ghidra health record, and candidate scouting record. |
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

## Ghidra host-health boundary

The configured Ghidra adapter has a separate, validated
[controlled-fixture health record](../../reverse_engineering/workflows/ghidra_headless_health.json)
and a readable [health dossier](../../research/sources/ghidra_headless_health_2026-08-22.md).
The record binds Ghidra 12.1.3, the repository export-script hash, every current
toolchain processor language, controlled fixture bytes, and four deterministic
exports. It is not a retained-artifact test. Linux x86_64 is
`health_checked`; Windows x86_64 and ARM64 remain `documented_unchecked`, even
though the official distribution documents the Windows batch launcher. The
validator rejects processor-language drift, fixture-hash drift, incomplete
export inventory, and incomplete CPU coverage.

An empty function table or decompilation body for a raw controlled fixture is
retained as a result, not converted into a guessed entry point. Ghidra listing,
function, and decompiler output continue to be tool hypotheses until independent
input origin, base, entry/trace, and behavioral evidence exist.

## Commentary review scaffold

[`generate_analysis_commentary_scaffold.py`](../../scripts/generate_analysis_commentary_scaffold.py)
creates one deterministic review index from every retained `analysis-run.json`
record. The generated [commentary scaffold](../../reverse_engineering/derived/COMMENTARY_REVIEW_SCAFFOLD.md)
copies only immutable input identity, tool records, output hashes, and the
recorded load-model non-claim. It creates empty, explicitly bounded review
places for decoded instructions, tool hypotheses, and independently evidenced
behavior; it never interprets analyzer listings or produces semantic comments.

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

## Multi-architecture admission matrix

The repository-owned [candidate matrix](../../reverse_engineering/workflows/analyzer_candidate_matrix.json)
tracks candidates across Z80, MOS 6502, 68000, and i8086. Its validator rejects
an unconfigured candidate marked execution eligible and requires an exact source
revision, architecture scope, comparison role, blockers, and non-claim. The
[matrix scout](../../research/sources/analyzer_candidate_matrix_scout_2026-08-22.md)
preserves the metadata and README-derived observations behind those records.
Candidate admission remains per tool, per CPU variant, per binary load model,
and per retained input; a candidate cannot become a universal backend.

## References

1. [Cross-tool verification protocol](CROSS_TOOL_VERIFICATION.md)
2. [Architecture-specific workflow](ARCHITECTURE_WORKFLOWS.md)
3. [Candidate scouting record](../../research/sources/analyzer_candidate_scout_2026-08-22.md)
4. [Ghidra headless health dossier](../../research/sources/ghidra_headless_health_2026-08-22.md)

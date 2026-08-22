# Reversible Multi-Tool Analysis Transition

| Header field | Value |
| --- | --- |
| **Question** | How can the repository adopt and extend the synchronized reverse-engineering workflow without losing evidence boundaries, active work, or reproducibility? |
| **Evidence scope** | Remote revision audit, committed workflow/toolchain contracts, local command availability/version capture, and retained capability-boundary records. |
| **Snapshot** | 2026-08-22, synchronized `origin/main` revision `fa06f4d85d3df2f7f49008283e20897dfdbfa876`. |
| **Measured expansion** | 1,339 changed files since pre-transition revision `d7c8d2`; 89,216 insertions and 9,027 deletions. The largest area is retained corpus/provenance evidence, followed by tests, scripts, research, core modules, documentation, skills, interface, and reverse-engineering records. |
| **Baseline verification** | The repository-owned environment preflight and all 21 allowlisted evidence, publication, and analysis gates passed after synchronization; every later correction is rechecked by the complete primary workflow. |
| **Non-claims** | Synchronization, a passing static gate, or a new analyzer binary does not validate an interpreter load model, decompilation, runtime behavior, or format grammar. |

## Transition principles

The remote expansion brings significant reusable infrastructure: a versioned
agent workflow, deterministic backlog/resource inventories, controlled
acquisition and catalog-discovery records, CHR atlas support, bundle evidence,
and a three-tool static-analysis runner across five architecture families. The
adoption rule is therefore **reuse verified mechanisms, but re-evaluate every
claim boundary before depending on it**.[1] [2]

> Every tool-derived output remains a derived hypothesis tied to original-byte
> identity, architecture, load model, command/configuration, and output hash.
> A correct static-analysis invocation is not a substitute for native evidence
> or executable behavior.

| Stage | Atomic concern | Required proof before advancing | Preservation boundary |
| --- | --- | --- | --- |
| 0. Synchronize | Fast-forward only after preserving local work and fetching `origin/main`. | Clean branch, recorded revisions, repository preflight, and allowlisted gates pass. | Do not overwrite, discard, or reclassify an active local experiment. |
| 1. Review | Map remote code, generated evidence, workflow, and documentation changes to their tests and non-claims. | Each adopted subsystem has an input/command/output/negative-boundary record. | A merged commit is not exempt from evidence review. |
| 2. Freeze matrix | Publish the tool, architecture, command, and expected-failure matrix. | Version or revision, provenance, compatibility, load-model state, and output location are explicit. | Unsupported tool/CPU pairs stay rejected rather than silently omitted. |
| 3. Validate baseline | Verify commands already listed in `toolchain.json` on immutable inputs without replacing retained outputs. | Version capture and one isolated command-level health check per tool family. | Do not regenerate or delete analysis directories merely to test availability. |
| 4. Add one family | Introduce exactly one new compatible analyzer or configuration. | Pinned acquisition, test input, raw output, error output, hashes, and disagreement ledger. | No tool replaces an existing comparator or becomes a mandatory primary dependency. |
| 5. Promote workflow | Wire a passing family into the versioned runner only after comparison evidence exists. | Focused tests, scheduler, full suite, manifest/report updates if required, and atomic push. | External output remains corroborative until a committed native verifier reproduces the promoted claim. |

## Baseline tool matrix

The synchronized runner already provides the minimum three-way static
comparison for each supported architecture: Ghidra for structured listing and
tool-derived pseudocode, radare2 for separate control-flow analysis, and a
family-specific static disassembler.[1] The local command audit confirmed the
configured command paths are present. The `da65` binary identifies itself as
V2.18 while the installed `cc65` package is `2.19-1`; future manifest edits
must record both the executable-reported and package versions rather than
collapsing them into one ambiguous value.

| Architecture | Structured analyzer | Control-flow analyzer | Independent disassembler | Current evidence state |
| --- | --- | --- | --- | --- |
| Z80 | Ghidra `z80:LE:16:default` | radare2 5.5.0, Z80/8-bit | z80dasm 1.1.6 | 8 official exact-profile outputs; raw base zero remains unverified. |
| MOS 6502/8501 | Ghidra `6502:LE:16:default` | radare2 5.5.0, 6502/8-bit | da65 V2.18, package `cc65` 2.19-1 | 4 official exact-profile outputs; machine/banking model remains unverified. |
| Motorola 68000 | Ghidra `68000:BE:32:default` | radare2 5.5.0, m68k/32-bit | GNU m68k objdump 2.42 | 8 official exact-profile outputs; segment/relocation model remains unverified. |
| 8086 | Ghidra real-mode x86 | radare2 5.5.0, x86/16-bit | NDISASM 2.16.01 | 22 official exact-profile outputs; COM/MZ and segment model remain unverified. |

The existing analysis record for the official MSX English interpreter is the
reference shape for all additions: it retains the original SHA-256, the raw
load-model non-claim, exact commands, individual tool return codes, output
paths, and output hashes.[3] New tools must extend that record rather than
creating untracked local notes.

## Candidate-tool acceptance boundaries

| Candidate | Potential role | Current acceptance boundary | Transition decision |
| --- | --- | --- | --- |
| SkoolKit | Spectrum/Z80-oriented companion analysis, especially snapshots and execution-map-assisted classification. | Pinned source revision `760eeaa…98eb0` was installed locally as SkoolKit 10.2b1; `sna2skool.py --version` and `--help` pass. Its raw-binary default origin is derived from file length, not the retained DAAD raw-base-zero model, and static classification remains an attempt without an execution map. | Installed health-checked candidate only. Configure it against a retained Spectrum input only after a justified memory/load model; never substitute it for the raw-Z80 comparator.[4] |
| py8dis | 6502, 65C02, and 8080 comparison candidate. | The retained capability record does not list Z80 support. | Never configure as a Z80 comparator; evaluate separately for a justified 6502 or 8080 profile.[5] |
| Redasm | Potential supplementary x86 analysis candidate. | The retained processor table lists x86/x86_64 but not Z80. | Evaluate only as an additional 8086-family comparator after a pinned installation and command-level test; not a universal analyzer.[6] |
| Alternative Z80 disassemblers | Independent byte-to-instruction comparison. | They require explicit revision, invocation semantics, origin, and control/data assumptions. | Add one at a time after a raw-output comparison against z80dasm, radare2, and Ghidra. |

## Initial remote capability audit

The first capability audit ran the focused acquisition, authorization-queue,
bundle-relationship, artifact-path, hash, resource-inventory, and
resource-review regressions. All 24 selected tests passed. The result is a
transition classification, not a blanket approval of every future use.

| Capability | Current classification | Verified boundary | Transition action |
| --- | --- | --- | --- |
| Versioned scheduler and primary workflow | **Adopted with correction** | The scheduler is the allowlisted authority for concurrent read-only checks; ordered workflows own shared regeneration. The shared-root wording drift was corrected and classified. | Use the scheduler for eligible verification only. |
| Artifact paths, hashes, resource inventory, and review manifest | **Adopted** | Focused tests establish deterministic path/identity and inventory behavior for retained state. | Use as provenance inputs; do not infer format semantics from inventory fields. |
| PCW same-disk bundle relationship model | **Adopted, profile-scoped** | Exact member hashes and native DSK extraction support co-residency only; non-claims reject runtime or cross-platform inference. | Reuse its evidence shape for new profiles only after profile-specific tests. |
| Acquisition and authorization queue | **Deferred for direct downloading** | The code and queue tests execute, but a repository-stated institutional directive is not independent source-specific authorization. | Retain discovery metadata; do not invoke a new direct-download adapter until independently verifiable authorization or a public-license basis is present. |
| New analysis tool additions | **Pending** | Existing Ghidra, radare2, and architecture-specific disassemblers are already configured and documented. | Add only one compatible candidate after pinning, isolated command testing, and a disagreement record. |

This classification preserves the useful new code while declining to convert a
passing implementation test into a broader legal, runtime, or semantic claim.

## Transition reconciliation audit

The finite remote-expansion audit is complete when each synchronized capability
has a documented adoption state, a focused verification path, and an explicit
residual boundary. It does not turn the broader preservation roadmap into a
completed claim. The audit produced the following corrections after the initial
fast-forward and capability classification.

| Reviewed boundary | Final transition classification | Corrected or verified condition | Residual boundary |
| --- | --- | --- | --- |
| Static report export | **Adopted with corrections** | Mutable log tails are excluded deterministically, and library-manifest operational `source_path` values are removed before publishing `report_data.json`. Focused export tests and the committed fixed-timestamp report verify both boundaries. | The report remains a read-only evidence summary, not a live database or local filesystem browser. |
| Terminal evidence dashboard | **Adopted with contract reconciliation** | The UI contract now reflects the implemented game/port matrix and detection-handoff panels, with real Rich-rendering coverage. | Reversible game/port drill-down and complete per-artifact digest access remain explicit interface backlog, not implied parity. |
| Scheduler and primary workflow | **Adopted with correction** | Publication gates run as check-only subprocesses from the shared repository root; the documentation no longer claims isolated checkouts. Allowlisted concurrent verification remains separate from ordered shared regeneration. | A green scheduler gate does not promote format, runtime, or source claims. |
| Corpus, manifests, resources, and bundles | **Adopted** | Focused artifact-path, checksum, inventory/review, public-manifest, regeneration-manifest, and profile-scoped bundle tests passed during final audit. | Inventory and co-residency fields remain provenance evidence, not generic format or runtime semantics. |
| Acquisition and authorization queue | **Adopted as fail-closed discovery support** | Institutional handling context no longer authorizes a direct binary transfer. Queue selection and downstream transfer planning require independently recorded source-specific authorization; the current 79 catalog candidates are deferred rather than queued. | No new direct download occurs until the exact source/release has a recorded public-license, official-free-download, or permission basis. |

The corresponding atomic deliveries are `3705169` (bounded Spectrum SDG
validation), `610847e` and `f1dff9f` (static-report contract and path privacy),
`f6a6972` (terminal contract reconciliation), `768ae1b` (scheduler contract),
and `2303191` (source-specific acquisition authorization). Each is a small
correction to the synchronized baseline rather than a replacement of the
remote expansion.

The final transition closure gate ran `python3 scripts/run_primary_workflow.py`
with 442 passing tests and `python3 scripts/run_reverse_analysis.py --check`,
which verified all 42 retained analysis records without writing outputs. This
closes the finite synchronization and capability-audit transition only. The
documented format, resource, acquisition, interpreter, decompilation,
emulation, and interface support loops remain active until their own bounded
evidence criteria are met.

## Detailed analysis-writing requirements

Every detailed note about an interpreter must separate four layers. **Bytes**
state the artifact hash and exact offset range. **Disassembly** states the tool,
processor, base address, and undecoded or disputed instructions.
**Tool-derived pseudocode** states its function-range and inference boundary.
**Behavioral hypotheses** require separately evidenced memory/load context,
runtime observation, or native parser evidence. This prevents a richly
commented listing from becoming a fabricated recovered source narrative.[2]

The required comparison record must include agreements, disagreements,
tool-specific rejections, and unknown regions. A majority vote is prohibited:
three tools can repeat the same wrong decision when they share an invalid raw
base or control/data assumption.[2]

## References

[1]: [Architecture-specific analysis workflows](ARCHITECTURE_WORKFLOWS.md)
[2]: [Cross-tool verification protocol](CROSS_TOOL_VERIFICATION.md)
[3]: [Official MSX English interpreter analysis record](../../reverse_engineering/derived/z80/daad-msx-msxedi-official/analysis-run.json)
[4]: [SkoolKit capability boundary](../../research/sources/skoolkit_analysis_boundary_2026-08-22.json)
[5]: [py8dis capability boundary](../../research/sources/py8dis_capability_boundary_2026-08-22.json)
[6]: [Redasm capability boundary](../../research/sources/redasm_capability_boundary_2026-08-22.json)

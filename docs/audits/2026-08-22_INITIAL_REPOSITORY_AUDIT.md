# Initial repository audit

> **Scope boundary:** This is a deterministic static audit of versioned repository inputs. It identifies implementation and evidence work; it does not promote unsupported format, release, runtime, or compatibility claims.

## Executive summary

The repository contains **53 production Python files**, **81 Python automation scripts**, and **100 Python test files**. The active work register contains **198 unchecked items** across **12 sections**. The authorized acquisition queue records **0 queue-ready releases**, **79 candidates requiring a direct source**, and **0 blocked candidates**.

The implementation has a strong deterministic foundation: a repository-owned verification scheduler, an append-only corpus policy, checksum verification, native format validators, and a generated report/TUI/web pipeline. The dominant risk is not a detected single-code defect; it is the remaining breadth of evidence closure. The work register explicitly requires profile-scoped parser, bundle, corpus, regeneration, and interface evidence before broad claims can be completed.

## Measured inventory

| Area | Measured value | Audit interpretation |
| --- | ---: | --- |
| Production Python modules | 53 | Native preservation implementation surface. |
| Python automation scripts | 81 | Reproducible project commands; review command-execution references below. |
| Python test modules | 100 | Unit and regression test surface; filename matching is not coverage measurement. |
| Static web source files | 3 | React + TypeScript + Vite evidence viewer implementation. |
| Static web test files | 1 | Browser/build checks remain separate from source-file count. |
| Retained artifacts | 1015 | Manifested original and derived evidence inventory. |
| Registered sources | 265 | Provenance inventory, not a completeness claim. |
| Native regeneration entries | 20 | Hash-pinned primary regeneration records. |

## Backlog risk map

| Active section | Unchecked items | Primary risk |
| --- | ---: | --- |
| 1. Complete format and archive coverage | 6 | Requires bounded, separately evidenced child deliveries. |
| 10. Universal decompile–recompile round-trip verification | 6 | Requires bounded, separately evidenced child deliveries. |
| 11. Future ScummVM DAAD engine | 4 | Requires bounded, separately evidenced child deliveries. |
| 12. Final emulator-equivalence and ScummVM integration gate | 8 | Requires bounded, separately evidenced child deliveries. |
| 2. Versions, interpreters, and derivatives | 1 | Requires bounded, separately evidenced child deliveries. |
| 3. Sources and metadata | 2 | Requires bounded, separately evidenced child deliveries. |
| 7. Authorization-gated reverse-engineering corpus | 10 | Requires bounded, separately evidenced child deliveries. |
| 8. All-platform retained game corpus and regression suite | 37 | Requires bounded, separately evidenced child deliveries. |
| 9. DAAD game decompiler research and differential implementation | 8 | Requires bounded, separately evidenced child deliveries. |
| Active evidence-interface correction | 81 | Requires bounded, separately evidenced child deliveries. |
| Deferred external-source queue (not part of the active task plan) | 13 | Requires bounded, separately evidenced child deliveries. |
| Self-contained regeneration requirement | 22 | Requires bounded, separately evidenced child deliveries. |

The heaviest active areas are the evidence-interface correction, all-platform retained-corpus closure, and self-contained regeneration. These are broad gates; a single platform or artifact result must remain a child delivery rather than a completion claim.

## Findings and corrective priorities

| Priority | Finding | Evidence | Required next action |
| --- | --- | --- | --- |
| P0 | Backlog closure remains the principal delivery risk. | The active index contains 198 unchecked items, including 81 evidence-interface and 37 all-platform corpus tasks. | Continue with profile-scoped child deliveries, preserving unresolved boundaries. |
| P0 | Cross-file resource relationships lack a reusable first-class evidence model. | `TODO.md` tasks 38–39 require platform-bundle and DDB companion-reference evidence; a static source search found no existing `bundle_relationship` model. | Implement a bounded PCW co-residency relationship model with positive, negative, and real-artifact regressions; do not claim semantic linkage. |
| P1 | The root roadmap labels a historical test-count baseline as latest. | The first TODO status baseline declares 532 passing tests. | Refresh it only with a verified current primary-gate output, retaining it as an auditable baseline rather than a mutable assertion. |
| P1 | Some project areas are outside a filename-matched test proxy. | 10 production modules lack a same-stem `tests/test_<module>.py` file; this is a review prompt, not proof of missing coverage. | Add targeted regression tests where a concrete behavior lacks direct evidence; do not use name matching as coverage proof. |
| P1 | Existing command-execution call sites need a declared primary/optional classification. | 16 AST-detected `subprocess`/`os` call sites exist in Python automation. | Classify each during the self-contained regeneration audit; preserve native paths and make optional validators explicitly unavailable rather than implicit prerequisites. |
| P2 | Possible duplicate function bodies require human semantic review before consolidation. | 11 normalized AST body groups were found. Equal bodies can be deliberate adapters or fixtures. | Review only cross-module production groups; deduplicate through tested shared helpers where behavior and evidence contracts truly match. |
| P2 | Acquisition discovery remains incomplete by design. | The queue has candidates with authorization but no exact public binary URL or release-boundary match. | Retain source-discovery records and add only independently corroborated, checksum-pinned releases. |

## Automation and technology assessment

The project already uses a suitable core technology split: Python provides deterministic parsing, acquisition orchestration, corpus verification, report export, and Rich TUI behavior; React/TypeScript/Vite provides a static, browser-accessible evidence reader. Replacing either surface is not justified by this audit. The immediate engineering priority is to strengthen the typed report schema and deterministic publication gates so each native evidence increment reaches both interfaces without drift.

Python reuse should remain internal-first: `media_inspection`, `daad_parser`, `ddb_ir`, acquisition policy, manifest verification, and report export should be extended through narrow shared contracts rather than one-off scripts. External libraries or independently maintained projects may be added only after their revision, license/provenance, assumptions, reproducibility boundary, and native comparison role are recorded. No external analyzer output should become a primary claim by itself.

## Duplicate-review candidates

| Normalized body digest | Functions |
| --- | --- |
| `0c3fce4eaa845c14` | `scripts/audit_repository_state.py:_read_json`<br>`scripts/record_acquisition_checksums.py:load_json`<br>`scripts/register_discovered_candidate_sources.py:load_json` |
| `10fe3d24891b67d8` | `scripts/inspect_adf_structure.py:main`<br>`scripts/inspect_cpc_dsk.py:main` |
| `124d48f30ad18678` | `daad_harvester/catalog.py:EvidenceCatalogExporter.__init__`<br>`daad_harvester/report.py:ReportGenerator.__init__` |
| `3c2433ea896aa422` | `scripts/build_public_artifact_manifest.py:repository_path`<br>`scripts/verify_artifact_checksums.py:repository_path` |
| `4dba14d2e8246186` | `scripts/discover_authorized_candidate_sources.py:normalize`<br>`scripts/discover_spectrum_computing_sources.py:normalize`<br>`scripts/register_discovered_candidate_sources.py:normalize` |
| `4f414d57b22140ba` | `scripts/discover_spectrum_computing_sources.py:normalized_publisher`<br>`scripts/register_discovered_candidate_sources.py:normalized_publisher` |
| `5a7d44ed68cc5573` | `daad_harvester/amiga_hunk_load_model.py:_sha256`<br>`daad_harvester/atari_st_prg_load_model.py:_sha256`<br>`daad_harvester/behavioral_evidence.py:_sha256`<br>`daad_harvester/c64_prg_load_model.py:_sha256`<br>`daad_harvester/cpc_amsdos_load_model.py:_sha256`<br>`daad_harvester/dos_mz_load_model.py:_sha256`<br>`daad_harvester/msx_z80_image_observation.py:_sha256`<br>`daad_harvester/pcw_z80_image_observation.py:_sha256`<br>`daad_harvester/plus4_prg_load_model.py:_sha256`<br>`daad_harvester/zx_plus3dos_load_model.py:_sha256`<br>`scripts/build_reverse_inventory.py:sha256`<br>`scripts/record_adp_verification.py:sha256`<br>`scripts/record_cpc_fnt_loader_literals.py:digest`<br>`scripts/run_ghidra_headless_fixture_health.py:sha256_file`<br>`scripts/run_lybrown_dis_fixture_health.py:sha256_file`<br>`scripts/run_reverse_analysis.py:sha256`<br>`scripts/vendor_adp_implementation.py:digest`<br>`scripts/vendor_public_reverse_sources.py:sha256`<br>`scripts/verify_reverse_corpus.py:sha256` |
| `6c921af48a5f1062` | `scripts/verify_game_corpus.py:sha256`<br>`scripts/verify_runtime_resources.py:sha256` |
| `72861efaaa72ba18` | `daad_harvester/dms.py:_DeepDecoder.__init__`<br>`daad_harvester/dms.py:_HeavyDecoder.__init__`<br>`daad_harvester/dms.py:_MediumDecoder.__init__`<br>`daad_harvester/dms.py:_QuickDecoder.__init__` |
| `cd3f369356b5145a` | `scripts/capture_py8dis_capability_boundary.py:_fetch`<br>`scripts/capture_redasm_capability_boundary.py:_fetch`<br>`scripts/capture_skoolkit_analysis_boundary.py:_fetch`<br>`scripts/capture_zxdaad128_load_boundary.py:_fetch` |
| `fb814a23745e3ef5` | `scripts/render_chr_atlas.py:sha256`<br>`scripts/verify_jabato_c64_ass_scene_variant.py:_sha256`<br>`scripts/verify_jabato_c64_runtime_recovery.py:_sha256` |

## Required implementation sequence

Recent bounded deliveries established PCW same-disk companion co-residency and the exact R4 all-`E5` FNT byte profile. Neither closes the broader platform-bundle or FNT-grammar requirements. Select the next atomic delivery from the active index as one profile-scoped child: either obtain independent loader/writer evidence before extending FNT semantics, or add a separately evidenced resource-relationship model for one other retained platform. Do not promote a generic FNT/SINTAC decoder, runtime behavior, or cross-platform bundle equivalence from either completed child.

Every change must run the repository-owned parallel scheduler, focused tests, the full test suite, documentation and language gates where applicable, and the atomic commit wrapper. Acquisition discovery can run independently only through the versioned Python adapters and must retain unsuccessful exact-match results as boundaries rather than guessed registrations.

## Limitations and non-claims

This audit does not establish universal catalog completeness, download authorization outside registered policy, binary semantic equivalence, format grammar coverage, code execution safety, runtime equivalence, browser accessibility conformance, or test coverage percentage. Those claims require the profile-specific evidence, fixtures, validators, generated output hashes, and interfaces enumerated in the active work register.

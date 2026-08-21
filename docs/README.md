# DAAD Harvester Preservation Documentation

This documentation corpus describes **what DAAD Harvester can measure**, the evidence needed for each claim, and the boundaries it deliberately preserves instead of guessing. It is organized as small, focused modules for future preservation, archaeology, and interpreter work, including a potential ScummVM-oriented implementation.

| Module | Scope |
| --- | --- |
| [Clone-to-contribution continuation guide](CONTRIBUTOR_CONTINUATION.md) | Prompt-free bootstrap, offline verification, evidence vocabulary, profile-change protocol, optional-tool boundary, and review/recovery workflow for humans and agents. |
| [Atomic remote delivery policy](ATOMIC_REMOTE_DELIVERY.md) | Mandatory small-commit, immediate-push, staging-hygiene, CI-observation, and recovery discipline for every validated change. |
| [Parallel verification workflow](PARALLEL_WORKFLOW.md) | Safe concurrent execution of independent read-only verification gates in local runs and CI. |
| [Self-contained regeneration standard](SELF_CONTAINED_REGENERATION.md) | Mandatory global policy, manifest contract, CI gate, and external-validator boundary for every promoted result. |
| [Research methodology](RESEARCH_METHODOLOGY.md) | Evidence ladder, lawful reverse-engineering boundary, documentation anatomy, and reproducibility packet. |
| [Documentation map](DOCUMENTATION_MAP.md) | Directory ownership, modular migration ledger, required module header, and cross-reference rules. |
| [Requirements and continuation contract](requirements/TRACEABILITY_AND_CONTINUITY.md) | Repository-wide requirements-to-evidence traceability, clean-clone human/agent continuation, CI parity, and public-report/TUI evidence rules. |
| [Format capability matrix](formats/FORMAT_CAPABILITY_MATRIX.md) | Input families, parser contracts, extraction boundaries, and test expectations. |
| [Version chronology](versions/DAAD_CHRONOLOGY.md) | DAAD R2–R5, historical V1/V2 layouts, and DRC V2/V3 evidence. |
| [Platform runtime and media guide](platforms/PLATFORM_RUNTIME_MEDIA.md) | The nine canonical targets, runtime evidence, and native media handling. |
| [Derivative taxonomy](derivatives/COMPATIBILITY_TAXONOMY.md) | Original DAAD, DRC, Maluva, MSX2DAAD, PCDAAD, UnDAAD, and related tools. |
| [Reverse-engineering corpus](reverse_engineering/README.md) | Authorization-gated originals, public source, disassembly, decompilation, and verification methodology. |
| [Source register](sources/SOURCE_REGISTER.md) | Provenance, access boundaries, coverage, and use of every primary source. |
| [TUI demonstration capture](tui/DEMONSTRATION_CAPTURE.md) | Reproducible authentic terminal recording, interaction sequence, and aspect-ratio rationale. |
| [Final bounded live audit](audits/2026-08-19_FINAL_LIVE_AUDIT.md) | Fresh source discovery, bounded acquisition, native extraction, and negative verification result. |
| [Self-contained regeneration baseline audit](audits/2026-08-20_SELF_CONTAINED_REGENERATION_BASELINE.md) | Domain-by-domain status, conversion backlog, and external-tool disposition under the mandatory global policy. |

> **Preservation rule.** A filename, extension, or archive title is useful discovery context, but it is not binary identity. Harvester records a version, platform, or runtime as verified only when its measured structure or hash supports that exact statement.

> **SELF-CONTAINED REGENERATION: REQUIRED.** Every promoted result must link to the [global regeneration standard](SELF_CONTAINED_REGENERATION.md). External tools can corroborate or acquire evidence, but a repository-native, hash-verified, network-free command is the sole primary regeneration path.

The implementation source of truth remains the test suite and the typed evidence persisted in SQLite. Documentation explains intent and provenance; it does not replace structural validation. New detailed modules follow the [research methodology](RESEARCH_METHODOLOGY.md): official original interpreter source is not assumed available merely because public DAAD distribution material exists.

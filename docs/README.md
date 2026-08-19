# DAAD Harvester Preservation Documentation

This documentation corpus describes **what DAAD Harvester can measure**, the evidence needed for each claim, and the boundaries it deliberately preserves instead of guessing. It is organized as small, focused modules for future preservation, archaeology, and interpreter work, including a potential ScummVM-oriented implementation.

| Module | Scope |
| --- | --- |
| [Research methodology](RESEARCH_METHODOLOGY.md) | Evidence ladder, lawful reverse-engineering boundary, documentation anatomy, and reproducibility packet. |
| [Documentation map](DOCUMENTATION_MAP.md) | Directory ownership, modular migration ledger, required module header, and cross-reference rules. |
| [Format capability matrix](formats/FORMAT_CAPABILITY_MATRIX.md) | Input families, parser contracts, extraction boundaries, and test expectations. |
| [Version chronology](versions/DAAD_CHRONOLOGY.md) | DAAD R2–R5, historical V1/V2 layouts, and DRC V2/V3 evidence. |
| [Platform runtime and media guide](platforms/PLATFORM_RUNTIME_MEDIA.md) | The nine canonical targets, runtime evidence, and native media handling. |
| [Derivative taxonomy](derivatives/COMPATIBILITY_TAXONOMY.md) | Original DAAD, DRC, Maluva, MSX2DAAD, PCDAAD, UnDAAD, and related tools. |
| [Source register](sources/SOURCE_REGISTER.md) | Provenance, access boundaries, coverage, and use of every primary source. |
| [TUI demonstration capture](tui/DEMONSTRATION_CAPTURE.md) | Reproducible authentic terminal recording, interaction sequence, and aspect-ratio rationale. |
| [Final bounded live audit](audits/2026-08-19_FINAL_LIVE_AUDIT.md) | Fresh source discovery, bounded acquisition, native extraction, and negative verification result. |

> **Preservation rule.** A filename, extension, or archive title is useful discovery context, but it is not binary identity. Harvester records a version, platform, or runtime as verified only when its measured structure or hash supports that exact statement.

The implementation source of truth remains the test suite and the typed evidence persisted in SQLite. Documentation explains intent and provenance; it does not replace structural validation. New detailed modules follow the [research methodology](RESEARCH_METHODOLOGY.md): official original interpreter source is not assumed available merely because public DAAD distribution material exists.

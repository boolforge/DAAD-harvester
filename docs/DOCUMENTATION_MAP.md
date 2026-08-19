# Documentation Map and Modular Migration Plan

## Navigation contract

This document defines the documentation tree. It is a **map**, not a technical monograph. Every content file has one primary question, one evidence scope, and one owning directory. Directory `README.md` files are navigational indexes only; they do not duplicate the detailed modules below them.

```text
docs/
├── README.md                         # corpus entry point
├── RESEARCH_METHODOLOGY.md           # evidence and lawful-analysis rules
├── DOCUMENTATION_MAP.md              # this map and migration ledger
├── versions/                         # release and DDB-generation facts
├── interpreters/                     # runtime identity and implementation boundaries
├── derivatives/                      # one derivative/project per document
├── platforms/                        # one canonical DAAD target per dossier
├── formats/                          # one media or container family per document
├── schemas/                          # persisted evidence and byte-layout schemas
├── diagrams/                         # standalone Mermaid sources and rendered assets
├── sources/                          # one primary source ledger entry per source family
├── audits/                           # immutable dated reproducibility records
└── tui/                              # operational interface and recording method
```

## Module ownership rules

| Directory | A module answers | A module must not contain |
| --- | --- | --- |
| `versions/` | Which release/generation is evidenced and what DDB compatibility boundary follows? | Full disk, tape, or filesystem format descriptions. |
| `interpreters/` | How is a runtime identified, loaded, or scoped to an implementation? | A claim that a runtime hash proves an adjacent DDB. |
| `derivatives/` | What does one named project state it implements, and how does that differ from original DAAD? | Generalized claims about all DAAD historical releases. |
| `platforms/` | What does one machine target require for runtime/media provenance? | Full repeated binary layout definitions held in `formats/` or `schemas/`. |
| `formats/` | How is one container/media family recognized, validated, and preserved? | Platform history unrelated to that media family. |
| `schemas/` | What fields or bytes have defined semantics? | Narrative release history. |
| `diagrams/` | What visual model supports one named module? | Uncited prose explanations. |
| `sources/` | What exact source supports what claim, with access and legal boundary? | Unattributed interpretation. |
| `audits/` | What exact command and dated result was observed? | Timeless format specification. |

## Current-file migration ledger

| Existing document | Retained role | Focused destination modules | Migration status |
| --- | --- | --- | --- |
| `versions/DAAD_CHRONOLOGY.md` | Chronology index | `versions/RELEASE_LINEAGE.md`, `versions/DDB_GENERATIONS.md`, `versions/COMPATIBILITY_BOUNDARIES.md` | Focused modules available; legacy retained as migration source |
| `interpreter_profiles.py` and runtime-identification tests | Runtime identity implementation source | `interpreters/IDENTITY_PROTOCOL.md`, `interpreters/OFFICIAL_PROFILE_LEDGER.md`, `interpreters/PUBLIC_IMPLEMENTATIONS.md` | Focused modules available |
| `platforms/PLATFORM_RUNTIME_MEDIA.md` | Nine-target platform index | `platforms/ZX_SPECTRUM.md` through `platforms/IBM_PC_DOS.md` | Focused modules available; legacy retained as migration source |
| `derivatives/COMPATIBILITY_TAXONOMY.md` | Derivative index and comparison table | `derivatives/DRC.md`, `derivatives/MSX2DAAD.md`, `derivatives/MALUVA.md`, `derivatives/PCDAAD.md`, `derivatives/UNDAAD.md` | Planned |
| `formats/FORMAT_CAPABILITY_MATRIX.md` | Release-gate matrix | `formats/TAPE_STREAMS.md`, `formats/CBM_DISK_AND_PROGRAM.md`, `formats/CPM_DSK.md`, `formats/FAT_MEDIA.md`, `formats/AMIGA_MEDIA.md`, `formats/ATARI_PROTECTED_MEDIA.md`, `formats/ARCHIVE_WRAPPERS.md`, `formats/EXECUTABLE_AND_SNAPSHOT_EVIDENCE.md` | Planned |
| `sources/SOURCE_REGISTER.md` | Source-family index | `sources/PRIMARY_DAAD.md`, `sources/PUBLIC_IMPLEMENTATIONS.md`, `sources/MEDIA_SPECS.md`, `sources/DISCOVERY_ADAPTERS.md` | Planned |
| `RESEARCH_METHODOLOGY.md` | Corpus method | `schemas/EVIDENCE_MODEL.md`, `diagrams/RESEARCH_EVIDENCE_FLOW.md` | Planned extraction of supporting material |

## Required module header

Every detailed module begins with a compact header.

| Header field | Meaning |
| --- | --- |
| **Question** | The single question the module answers. |
| **Evidence scope** | Applicable P0–P4 grades under `RESEARCH_METHODOLOGY.md`. |
| **Status** | `measured`, `source-backed`, `hypothesis`, `index`, or `implementation contract`. |
| **Implementation links** | Harvester modules and tests relevant to the document. |
| **Non-claims** | What readers must not infer from the material. |

## Cross-reference discipline

Links point **outward** instead of copying text. A platform dossier links to a media-family module for byte details; that module links back only where platform behavior differs. Diagrams are stored separately and embedded by link. A source URL is defined once in the relevant source-ledger file and cited from technical modules through an explicit reference label.

This arrangement keeps a future ScummVM implementer from having to infer whether a paragraph is normative format detail, local Harvester behavior, historical evidence, or a dated audit observation.

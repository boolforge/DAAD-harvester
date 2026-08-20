# Public Report and TUI Evidence Contract

| Header field | Value |
| --- | --- |
| **Question** | What can the GitHub Pages report and terminal UI show, search, group, copy, link, download, or leave unknown without exceeding measured DAAD preservation evidence? |
| **Evidence scope** | P1 implementation contract for `report_data.json`, generated `detection_tables.h`, library manifest, current SQLite-backed TUI state, and their read-only consumers. |
| **Status** | implementation contract and improvement backlog |
| **Implementation links** | [`../../daad_harvester/catalog.py`](../../daad_harvester/catalog.py), [`../../daad_harvester/report_export.py`](../../daad_harvester/report_export.py), [`../../daad_harvester/synthesize.py`](../../daad_harvester/synthesize.py), [`../../daad_harvester/tui.py`](../../daad_harvester/tui.py), [`../../web/report-viewer/src/Home.tsx`](../../web/report-viewer/src/Home.tsx), [`../../tests/test_report_export.py`](../../tests/test_report_export.py), [`../../tests/test_tui.py`](../../tests/test_tui.py), [`../../tests/test_tui_rendering.py`](../../tests/test_tui_rendering.py) |
| **Non-claims** | A catalog title is not a measured release; a listed platform is not necessarily a retained binary port; a checksum identifies the exported artifact, not an unmeasured interpreter/version; a generated detection header is not proof that a universal ScummVM engine exists or runs the title. |

> **Evidence-first interface rule.** The report and TUI are read-only evidence instruments. They may improve discoverability and copyability, but they must never convert a catalog association into a binary claim, a filename into an identity, an absent byte into a download, or an optional validator result into the primary preservation path.

## 1. Current deterministic data flow

```mermaid
flowchart LR
  DB[(state.db)] --> CAT[EvidenceCatalogExporter]
  DB --> SYN[Synthesizer]
  SYN --> H[detection_tables.h]
  SYN --> G[daad_catalog.json]
  CAT --> REP[StaticReportExporter]
  H --> REP
  G --> REP
  LIB[library/manifest.json] --> REP
  REP --> JSON[report_data.json]
  JSON --> WEB[GitHub Pages report]
  DB --> TUI[Rich TUI]
```

`Synthesizer` writes the C++ detection header and catalog from deterministic database state. `StaticReportExporter` reads those committed outputs, strips local extraction paths, and writes browser-safe `report_data.json`. The TUI reads the typed database directly. The Pages workflow verifies the committed primary gate, stages the committed report/detection/library outputs, builds the viewer, and checks the deployed report JSON by SHA-256.[1]

## 2. Evidence vocabulary visible in interfaces

| User-facing term | Required data origin | Meaning | Forbidden inference |
| --- | --- | --- | --- |
| **Known title** | `catalog.games` / known-game catalog. | Catalog-backed title record with stated platform evidence and source URLs. | That a specific retained artifact exists on every listed platform. |
| **Port/platform evidence** | `game.platform_evidence`, source platform, artifact measured/legacy platform fields. | Explicitly labelled catalog or measured association. | That catalog platform evidence is measured binary identity. |
| **Retained artifact** | Artifact record and SHA-256. | A persisted original/container/member/derived evidence object. | That it is necessarily a game DDB or runnable release. |
| **Verified DDB** | Structural parser result (`is_daad_payload`). | Artifact whose DDB structure passed the documented validator. | That its interpreter identity or playable semantics are proved without independent evidence. |
| **Interpreter identity** | Artifact-own-byte profile/hash evidence. | Exact or documented identity claim scoped by platform. | Identity inherited from another platform sibling or filename alone. |
| **Checksum** | Artifact `sha256`, optional SHA-1/MD5/CRC-32. | Copyable integrity identifier for that artifact byte sequence. | A game family, platform port, or runtime version claim beyond its record. |
| **ScummVM detection entry** | Deterministic `detection_tables.h` / `daad_catalog.json`. | Generated metadata handoff from verified/current catalog state. | A complete engine implementation or emulator-equivalence proof. |
| **Download** | Relative public path explicitly present in deployment. | Downloadable public generated metadata or intentionally published artifact. | A local extraction path or an unavailable corpus byte. |
| **Unknown** | Explicit null/absence/sentinel. | Evidence not present in current output. | A value inferred by UI formatting or friendly naming. |

## 3. Required web-report behavior

The public report must serve three audiences simultaneously: a newcomer needing a concise project explanation, a preservation researcher checking provenance and hashes, and a future implementer locating deterministic handoff data. It must retain the current evidence boundary while adding the following measured interactions.

| Surface | Required behavior | Evidence guardrail | Test expectation |
| --- | --- | --- | --- |
| Front page | Explain preservation purpose, canonical nine target platforms, evidence ladder, self-contained rule, and current measured/corpus boundary before dashboard metrics. | Copy comes from versioned project/documentation contract; no unsupported completion claim. | Presence of project/boundary text in built viewer. |
| Game explorer | Group catalog titles, show platform evidence by title, and distinguish catalog platform from retained measured artifacts. | Use labelled source of each association. | A real `report_data.json` fixture demonstrates a catalog-only title and a measured artifact separately. |
| Port matrix | Present each title’s catalog platform set and measured-artifact platform set in separate visual rows. | No merged “available on” claim. | Empty/mixed sets remain visibly distinct. |
| Artifact detail | Show original filename, parent source, DDB/interpreter evidence, size, and complete SHA-256 with one-click copy. | Preserve unknown/not-correlated state. | Copy action and long hash display use real artifact fields. |
| Search/filter | Search title, filename, hash, platform, interpreter, DDB format, and evidence class. | Filtering must not mutate or synthesize records. | Query results are deterministic for a real fixture. |
| Detection handoff | Show count, bounded header preview, deterministic provenance, and a download only when `detections.available` and `download_path` are present. | “Generated header” never becomes “engine works.” | Absent header has no active download; present header is downloadable. |
| Library/source navigation | Link to published metadata or recorded source URL only where included in the export/deployment. | No local path, unauthorized byte, or fabricated link. | Missing/withheld item is explicit. |
| Documentation | Link to CI-rendered documentation and traceability contract from the report. | Documentation is a reader, not an evidence generator. | Build includes documentation index and valid links. |

## 4. Required TUI behavior

The TUI is an operational instrument, not a decorative live dashboard. It must be usable in terminal widths that preserve evidence readability and must expose the same claim boundaries as the report while retaining local pipeline operations.

| TUI area | Required behavior | Current baseline | Required improvement |
| --- | --- | --- | --- |
| Orientation | State purpose, selected corpus/database, phase, evidence policy, and key task shortcuts. | Header shows version, phase, theme, and filter. | Add a concise preservation/boundary line and task-oriented help panel. |
| Artifact ledger | Navigate retained artifacts with platform, evidence status, size, and checksum visibility. | Ledger offers selection, search, inspector, partial MD5. | Add SHA-256-first view/copy/export, evidence-kind filter, and source/DDB/interpreter status columns. |
| Artifact inspector | Show all recorded hash/evidence fields safely. | Inspector already includes SHA-256, SHA-1, MD5, CRC-32, and bounded evidence JSON. | Add source provenance/member lineage and explicit measured-versus-catalog labelling. |
| Game/port explorer | Navigate title → catalog ports → measured artifacts without conflation. | No dedicated game/port tab. | Add a game-focused tab with separate catalog and measured rows and an explicit empty state. |
| Detection handoff | Expose generated header availability/count/path/provenance. | Metrics names catalog entries but lacks header detail. | Add detection tab/panel with count, preview location, generation command, and unavailable state. |
| Acquisition queue | Show source priority and status. | Existing priority tab. | Add reason/evidence-source display and source URL copy/open command where terminal-safe. |
| Accessibility/resilience | Keyboard-first navigation, no Rich markup injection, safe non-TTY behavior, platform themes without semantic changes. | Existing tests cover escaped markup, empty rendering, key navigation, and themes. | Retain these regressions while adding new evidence-navigation tests. |

## 5. ScummVM detection-file contract

The generated `preservation_corpus/detection_tables.h` is a **deterministic metadata output**. It is generated by `daad_harvester/synthesize.py` together with `daad_catalog.json`, included in `report_data.json` by `report_export.py`, verified by the primary gate, and published by Pages only as a generated header when present.[1]

| Requirement | Contract |
| --- | --- |
| Generation | Use repository-native `Synthesizer` over retained database/catalog state; no manual header editing. |
| Escaping | C++ output must use the synthesizer’s explicit escaping rules; test title/filename strings containing quotes or backslashes. |
| Provenance | Report exposes availability, entry count, bounded preview, and relative download path; documentation links to generator, input boundary, and non-claim. |
| Integrity | A corpus/report mutation refreshes the header and report in the same evidence gate when affected. |
| UI | Web/TUI state whether the file is available and how many entries exist; download is active only when exported. |
| Boundary | Detection metadata is not a universal engine, a decompiler/recompiler result, playable-game certification, or emulator-equivalence evidence. |

## 6. Interface test matrix

| Requirement class | Required regression style |
| --- | --- |
| Contract export | Real database fixture → static export; assert fields, local-path removal, detection availability, unknown behavior. |
| Web consumer | Build/type-check plus component/browser test against a committed/realistic `report_data.json`; assert project explanation, title/port separation, hash interaction, detection/download boundary, and documentation navigation. |
| TUI rendering | Rich-rendering regression for empty state, real artifact/game/port/detection state, narrow terminal handling, keyboard navigation, safe text/markup, and bounded inspector fields. |
| Public delivery | CI validates report JSON exact SHA-256 and documentation index after Pages deployment. |
| Corpus coupling | Primary workflow verifies manifests/report/corpus before UI build; output mismatch is a release failure. |

## 7. Implementation sequence and non-terminal gaps

The current report and TUI provide evidence-led foundations, but the requirements in §§3–6 are intentionally stronger than the current presentation. The work is tracked in [`TODO.md`](../../TODO.md) and must proceed through the bounded-change protocol in [the traceability contract](TRACEABILITY_AND_CONTINUITY.md). No missing explorer, hash action, port distinction, introductory surface, TUI panel, or test is treated as an accepted permanent limitation.

## References

[1]: [`synthesize.py`](../../daad_harvester/synthesize.py), [`report_export.py`](../../daad_harvester/report_export.py), [static report contract](../schemas/STATIC_REPORT_CONTRACT.md), [Pages report contract](../PAGES_REPORT.md), and [Pages workflow](../../.github/workflows/pages.yml).

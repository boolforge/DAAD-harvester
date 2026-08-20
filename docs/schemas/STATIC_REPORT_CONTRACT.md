# Static Report Contract

| Header field | Value |
| --- | --- |
| **Question** | What browser-safe evidence fields does `report_data.json` publish, and what safety/meaning rules govern them? |
| **Evidence scope** | P1 static exporter and report-viewer source, subject to the global [`../SELF_CONTAINED_REGENERATION.md`](../SELF_CONTAINED_REGENERATION.md) primary-path requirement. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/report_export.py`](../../daad_harvester/report_export.py), [`../../daad_harvester/catalog.py`](../../daad_harvester/catalog.py), [`../../web/report-viewer/src/Home.tsx`](../../web/report-viewer/src/Home.tsx) |
| **Non-claims** | A static report is a read-only summary; it is not a SQLite dump, live scanner, downloadable local filesystem, or source of unmeasured version claims. |

## Top-level object

| Key | Type | Meaning |
| --- | --- | --- |
| `schema_version` | integer | Contract version; current exporter emits `1`. |
| `generated_at` | ISO-8601 timestamp | UTC generation time of this report object. |
| `purpose` | string | Human-readable preservation-report purpose. |
| `policy` | object | Published no-promotion/path/verified semantics. |
| `summary` | object | Catalog totals plus detection/library summary. |
| `catalog` | object | Browser-safe evidence catalog from the pipeline. |
| `game_port_matrix` | array | Per-known-title matrix that keeps catalog, source, and retained measured-artifact platform layers distinct and lists source-associated retained artifacts with checksums. |
| `detections` | object | Detection-table availability, relative download path, count, and bounded preview. |
| `library` | object | Manifest-derived classified-library summary and relative links. |
| `logs` | object | Bounded tails of general/game logs. |

## Privacy and semantic policy

Before export, every catalog artifact has `extracted_path` removed. Library links are relative retained-artifact paths; the report must never publish a sandbox/workstation filesystem path. The published policy explicitly says unknown values remain unknown and that a verified DDB structural result has independent interpreter identity evidence.[1]

> **SELF-CONTAINED REGENERATION: REQUIRED.** A published report may summarize a promoted result only when its source evidence resolves to a hash-pinned, repository-native regeneration entry. Report export itself must run from committed/persisted inputs and declared dependencies, without a browser, network endpoint, local GUI program, or hidden workstation path. External report viewers and acquisition tools are optional consumers or validators, not part of the report’s primary evidence computation.

| Subobject | Browser-safe contract | Viewer behavior |
| --- | --- | --- |
| `game_port_matrix` | `game_id`, `title`, `catalog_platforms`, `source_platforms`, `measured_artifact_platforms`, `source_count`, and source-associated artifact records. | Lets a consumer browse each layer separately; it never calls a listed platform a runnable port. |
| `game_port_matrix[].artifacts[]` | Artifact/source IDs, filename, size, `source_platform`, artifact-specific `platform_hint`, separately measured DDB platform, lineage role, archive depth, technical medium/container and member fields, parser/status/validation fields, DDB/interpreter fields, evidence state, and a labelled complete checksum map. | The consumer labels each provenance layer separately. The map contains every digest persisted by the native checksum suite: MD5 full/head/tail, SHA-1/224/256/384/512, SHA3-256/512, BLAKE2b/s, CRC-32, Adler-32, and XXH32/64/128. An absent required digest is an integrity failure for retained bytes, not an inferred unknown. |
| `detections` | `available`, `download_path`, `entry_count`, `preview` (maximum 12,000 text characters), SHA-256, generator, input-catalog name, and explicit boundary. | Exposes a download link only when an export exists and labels the header as generated detection metadata rather than engine proof. |
| `library` | Manifest or unavailable sentinel with summary/artifacts. | Links only to relative deployment assets. |
| `logs` | Last 120 lines per named log candidate. | Displays retained lines; never invents events. |
| `catalog` | Evidence catalog with local paths removed. | Supplies artifacts/detections with their recorded confidence/status. |

## Consumer rules

The viewer may format, filter, search, group, copy a recorded checksum, or link fields. The normal game route must render its complete associated artifact lineage in deterministic order; a compact rendering may be an explicit user choice but not the default. It must show an accessible legend for container, extracted member, derived recovery, DDB, interpreter, media support asset, and image/resource payload where those roles occur. It must not calculate an identity confidence from a filename, infer a version from a blank field, merge catalog/source/measured platform layers into a port claim, show hidden local paths, or turn an unavailable download into an active link. A contract-breaking object should be shown as unavailable/unknown **with its recorded reason and available parent/source context**, rather than normalized silently.[1] [2]

The detailed public-report and TUI interaction boundary—including title/port separation, checksum display, ScummVM detection-header semantics, and required regression matrix—is maintained in the [UI evidence contract](../requirements/UI_EVIDENCE_CONTRACT.md).

## References

[1]: [`report_export.py`](../../daad_harvester/report_export.py) static exporter contract
[2]: [`web/report-viewer/src/Home.tsx`](../../web/report-viewer/src/Home.tsx) consumer behavior

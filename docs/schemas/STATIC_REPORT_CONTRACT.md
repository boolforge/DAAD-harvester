# Static Report Contract

| Header field | Value |
| --- | --- |
| **Question** | What browser-safe evidence fields does `report_data.json` publish, and what safety/meaning rules govern them? |
| **Evidence scope** | P1 static exporter and report-viewer source. |
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
| `detections` | object | Detection-table availability, relative download path, count, and bounded preview. |
| `library` | object | Manifest-derived classified-library summary and relative links. |
| `logs` | object | Bounded tails of general/game logs. |

## Privacy and semantic policy

Before export, every catalog artifact has `extracted_path` removed. Library links are relative retained-artifact paths; the report must never publish a sandbox/workstation filesystem path. The published policy explicitly says unknown values remain unknown and that a verified DDB structural result has independent interpreter identity evidence.[1]

| Subobject | Browser-safe contract | Viewer behavior |
| --- | --- | --- |
| `detections` | `available`, `download_path`, `entry_count`, `preview` (maximum 12,000 text characters). | Exposes a download link only when an export exists. |
| `library` | Manifest or unavailable sentinel with summary/artifacts. | Links only to relative deployment assets. |
| `logs` | Last 120 lines per named log candidate. | Displays retained lines; never invents events. |
| `catalog` | Evidence catalog with local paths removed. | Supplies artifacts/detections with their recorded confidence/status. |

## Consumer rules

The viewer may format, filter, search, or link fields. It must not calculate an identity confidence from a filename, infer a version from a blank field, show hidden local paths, or turn an unavailable download into an active link. A contract-breaking object should be shown as unavailable/unknown rather than normalized silently.[1] [2]

## References

[1]: [`report_export.py`](../../daad_harvester/report_export.py) static exporter contract
[2]: [`web/report-viewer/src/Home.tsx`](../../web/report-viewer/src/Home.tsx) consumer behavior

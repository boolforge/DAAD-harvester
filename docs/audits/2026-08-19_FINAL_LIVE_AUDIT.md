# Final Bounded Live Audit — 2026-08-19

## Scope

This audit ran a fresh public-source discovery to an isolated output directory, then executed a bounded six-source acquisition, native-media unpack, structural fingerprint, library organization, and static-report export. It used the ordinary CLI path and did not bypass authentication, access controls, purchase flows, or source rate limits.

```bash
daad-harvester --phase discover --output-dir .audit/final-live-discovery
daad-harvester --phase catalog --resume --output-dir .audit/final-live-discovery
daad-harvester --phase fetch --resume --parallel 2 --max-sources 6 --output-dir .audit/final-live-discovery
daad-harvester --phase unpack --resume --parallel 2 --output-dir .audit/final-live-discovery
daad-harvester --phase fingerprint --resume --output-dir .audit/final-live-discovery
daad-harvester --phase organize --resume --output-dir .audit/final-live-discovery
daad-harvester --phase report --resume --output-dir .audit/final-live-discovery
```

## Result

| Measurement | Result | Interpretation |
| --- | ---: | --- |
| Known catalog titles | 30 | The canonical evidence catalog remained available for all official targets. |
| Fresh source records | 174 | Live adapters contributed public direct-media candidates and catalog evidence under their source contracts. |
| Fetch attempts | 6 | The bounded batch deliberately did not attempt the complete pending queue. |
| Accepted downloads | 5 | Five public artifact responses passed fetch validation. |
| Measured artifacts | 37 | Native-container and recursive extraction produced retained artifact evidence. |
| Structurally verified DDBs | 0 | No downloaded member passed the full DDB contract; no DAAD database version was claimed. |

The accepted sample included Spectrum TAP/TZX material and Commodore/Plus/4 disk/archive material. One public Plus/4 mirror disconnected; the fetcher recorded the failure and its permitted archival fallback attempt instead of substituting an unverified file. The source outcome is retained in the isolated run logs.

## Interpretation boundary

This is a **bounded preservation audit**, not a census of all listed releases. A source row can carry multiple platform-release evidence values when one public page describes a multi-platform release; therefore, a count grouped by the single `source.platform` field is not a coverage census. The project catalog continues to retain PCW and DOS platform evidence separately from source-row uniqueness.

> A zero-verified-DDB result is valid forensic output. The pipeline distinguishes catalog evidence, retained media, interpreter identity, and structurally verified game databases rather than promoting a filename, archive entry, or release claim into a measured DDB.


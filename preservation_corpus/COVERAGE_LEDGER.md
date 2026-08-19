# All-Platform Game Corpus Coverage Ledger

| Header field | Value |
| --- | --- |
| **Question** | Which reachable game artifacts have been discovered, acquired, retained, extracted, structurally inspected, and fingerprinted? |
| **Evidence scope** | Exact source URLs, original SHA-256 values, the resumable state database, native-media evidence, and retained command outputs. |
| **Status** | Active iterative acquisition and support ledger. |
| **Implementation links** | [`../daad_harvester/discover.py`](../daad_harvester/discover.py), [`../daad_harvester/unpack.py`](../daad_harvester/unpack.py), [`../daad_harvester/fingerprint.py`](../daad_harvester/fingerprint.py), [`../scripts/inspect_ddb_candidates.py`](../scripts/inspect_ddb_candidates.py) |
| **Non-claims** | A zero-DDB result in this ledger is not a non-DAAD conclusion. It is a required research/implementation trigger under the global completion rule. |

## Discovery baseline

The first discovery pass retained 247 source records: 131 pending acquisition and 116 cataloged records. It covered every canonical target with reachable source records—Amiga, Atari ST, C64, CPC, DOS, MSX, PCW, Plus/4, and ZX—plus a separately retained unclassified set. The resumable source and artifact state is preserved in [`state.db`](state.db).

## Acquisition batch 001 — one pending artifact per available canonical target

| Source ID | Platform | Title | Original filename | SHA-256 | Media outcome | Extracted members | Verified DDBs |
| ---: | --- | --- | --- | --- | --- | ---: | ---: |
| 106 | Plus/4 | Eight Feet Under — A Hibernated 1 Addon | `106_eight_feet_under.zip` | `1902ce87eccf50110d74c82798e5590221563c44dc2852c07606a968c3ac6560` | ZIP and D64 extracted | 9 | 0 |
| 110 | CPC | La Aventura Original | `110_Aventura_Original_La_1989_Aventuras_AD_es_cpm_version.dsk` | `2d992299625a7f0a401f8b311cbf7337aeb71c6dbc4a34c9cd3c9fd5ee752937` | Valid DSK; nonstandard mixed geometry | 0 | 0 |
| 112 | ZX | Chichén Itzá | `112_ChichenItza.tap.zip` | `cef2fd44c944afa5d27b484a23955872c03615928882711a0ae5a5f058215976` | ZIP and two TAP parts extracted | 7 | 0 |
| 121 | C64 | Jabato | `121_Jabato_1989_Aventuras_AD_es_cr_ASS.d64` | `4f2c17a2324f539dbf0c121b88fb1101602ffed0473481be61800571424c157f` | D64 extracted | 3 | 0 |
| 245 | Amiga | Chichén Itzá | `245_Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf` | `75fbdcf572de907da8b7f5eb25129d1ffefe81601ba0b2263b2d9590688f3092` | OFS ADF fully traversed | 19 | 2 |

The retained source URLs are canonicalized in the `sources` table. Original bytes reside in [`downloads/`](downloads/), all materialized children in [`extracted/`](extracted/), and the raw structural-candidate report for the C64/Plus/4 members in [`evidence_first_slice_ddb_candidates.json`](evidence_first_slice_ddb_candidates.json). The bounded ADF directory/data-chain measurement is retained in [`evidence_amiga_chichen_itza_adf.json`](evidence_amiga_chichen_itza_adf.json); the CPC DSK geometry and directory-window evidence is retained in [`evidence_cpc_la_aventura_original_dsk.json`](evidence_cpc_la_aventura_original_dsk.json).

## Resolved loop — Amiga Chichén Itzá ADF

The original `DOS\0` OFS image declares root block 880. Its complete bounded directory walk reaches 19 files. The production extractor now materializes all 19 paths from retained bytes, preserving distinct filenames even when their payload bytes are equal. In particular, `PART1.DDB` (42,804 bytes) and `PART2.DDB` (43,990 bytes) pass the target-aware recognizer as **Amiga DAAD legacy V2** structures.

The correction was made against the retained image and a real-artifact regression. The implementation reads `FileHeaderBlock::ByteSize` at word 81, follows OFS data blocks through their verified next pointers, and limits file-extension header traversal to FFS. A controlled `--reunpack-source 245` refresh removed earlier partial derived rows, regenerated the 19 children, re-fingerprinted both DDBs, and rebuilt the classified library. This is a parser-resolution result, not a claim that unrelated Amiga loader variants are already complete.

## Required research and implementation loops

| Observation | Reproducible evidence | Required support iteration |
| --- | --- | --- |
| C64 and Plus/4 game members use load-addressed PRG-like members and loader/runtime packaging rather than a directly validated DDB header. | Retained `EDI64`, `EDIPLUS4`, `JABATO P.1`, and `JABATO P.2` members; candidate report records no validated structural header. | Implement loader-aware memory-map reconstruction and DDB-range discovery; validate against interpreter behavior and emitted runtime bytes. |
| ZX game parts materialize 40 KiB `CODE.bin` blocks with executable Z80 entry vectors, but no standalone verified DDB block. | Retained TAP parts, `CODE.bin`, BASIC loaders, and byte-level inspection. | Implement TAP-loader execution/load-map reconstruction and bounded embedded-DDB range discovery. |
| CPC DSK is structurally valid but its 40 track records use three observed layouts: one `41h`–`49h`/9×512 boot-like track, 25 tracks of five 1024-byte sectors numbered 1–5, and 14 zero-sector records. It has no eligible standard CPC System/Data CP/M profile and no credible CP/M directory window. | Retained original; [`evidence_cpc_la_aventura_original_dsk.json`](evidence_cpc_la_aventura_original_dsk.json); real-artifact media-inspection regression; independent standard `cpcsys`/`cpcdata` reader attempts; CPC System/Data reference. [6] | Reconstruct the title-specific loader, physical-sector ordering, and any embedded data model. Keep the full image as validated native evidence; do not synthesize CP/M members from false-positive directory bytes. |
| Amiga ADF extraction was initially partial and contained no verified DDB. | Retained ADF, forensic filesystem report, real-artifact regression, refreshed SQLite records, and two target-aware DDB detections. | **Resolved for this OFS layout.** Future ADF/OFS/FFS observations continue through the same retained-sample regression loop. |

Every row above remains active until the required support iteration produces verified extraction/decompilation evidence and a real-artifact regression. No row may be silently reclassified as unsupported.

## References

[1]: https://plus4world.powweb.com/dl/games/e/eight_feet_under.zip "Plus/4 World — Eight Feet Under source artifact"
[2]: https://archive.org/download/Aventura_Original_La_1989_Aventuras_AD_es_cpm_version/Aventura_Original_La_1989_Aventuras_AD_es_cpm_version.dsk "Internet Archive — CPC source artifact"
[3]: https://www.worldofspectrum.org/pub/sinclair/games/c/ChichenItza.tap.zip "World of Spectrum — ZX source artifact"
[4]: https://archive.org/download/Jabato_1989_Aventuras_AD_es_cr_ASS/Jabato_1989_Aventuras_AD_es_cr_ASS.d64 "Internet Archive — C64 source artifact"
[5]: https://archive.org/download/Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX/Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf "Internet Archive — Amiga source artifact"
[6]: https://www.seasip.info/Cpm/amsform.html "Amstrad CP/M disc formats — system/data profile and XDPB reference"

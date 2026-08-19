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
| 110 | CPC | La Aventura Original | `110_Aventura_Original_La_1989_Aventuras_AD_es_cpm_version.dsk` | `2d992299625a7f0a401f8b311cbf7337aeb71c6dbc4a34c9cd3c9fd5ee752937` | CPC DSK recognized as evidence | 0 | 0 |
| 112 | ZX | Chichén Itzá | `112_ChichenItza.tap.zip` | `cef2fd44c944afa5d27b484a23955872c03615928882711a0ae5a5f058215976` | ZIP and two TAP parts extracted | 7 | 0 |
| 121 | C64 | Jabato | `121_Jabato_1989_Aventuras_AD_es_cr_ASS.d64` | `4f2c17a2324f539dbf0c121b88fb1101602ffed0473481be61800571424c157f` | D64 extracted | 3 | 0 |
| 245 | Amiga | Chichén Itzá | `245_Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf` | `75fbdcf572de907da8b7f5eb25129d1ffefe81601ba0b2263b2d9590688f3092` | ADF extracted | 3 | 0 |

The retained source URLs are canonicalized in the `sources` table. Original bytes reside in [`downloads/`](downloads/), all materialized children in [`extracted/`](extracted/), and the raw structural-candidate report for the C64/Plus/4 members in [`evidence_first_slice_ddb_candidates.json`](evidence_first_slice_ddb_candidates.json).

## Required research and implementation loops

| Observation | Reproducible evidence | Required support iteration |
| --- | --- | --- |
| C64 and Plus/4 game members use load-addressed PRG-like members and loader/runtime packaging rather than a directly validated DDB header. | Retained `EDI64`, `EDIPLUS4`, `JABATO P.1`, and `JABATO P.2` members; candidate report records no validated structural header. | Implement loader-aware memory-map reconstruction and DDB-range discovery; validate against interpreter behavior and emitted runtime bytes. |
| ZX game parts materialize 40 KiB `CODE.bin` blocks with executable Z80 entry vectors, but no standalone verified DDB block. | Retained TAP parts, `CODE.bin`, BASIC loaders, and byte-level inspection. | Implement TAP-loader execution/load-map reconstruction and bounded embedded-DDB range discovery. |
| CPC CP/M DSK was recognized structurally but did not materialize files. | `media_parser=cpc-dsk`, `media_status=recognized_evidence`, zero extracted members. | Complete the CP/M DSK filesystem extraction path for this observed geometry; retain fixture and regression test. |
| Amiga ADF materialized a limited file set without a verified DDB. | Retained ADF and extracted directory/file entries. | Complete filesystem/loader-chain reconstruction, including executable dependency and data-file range analysis. |

Every row above remains active until the required support iteration produces verified extraction/decompilation evidence and a real-artifact regression. No row may be silently reclassified as unsupported.

## References

[1]: https://plus4world.powweb.com/dl/games/e/eight_feet_under.zip "Plus/4 World — Eight Feet Under source artifact"
[2]: https://archive.org/download/Aventura_Original_La_1989_Aventuras_AD_es_cpm_version/Aventura_Original_La_1989_Aventuras_AD_es_cpm_version.dsk "Internet Archive — CPC source artifact"
[3]: https://www.worldofspectrum.org/pub/sinclair/games/c/ChichenItza.tap.zip "World of Spectrum — ZX source artifact"
[4]: https://archive.org/download/Jabato_1989_Aventuras_AD_es_cr_ASS/Jabato_1989_Aventuras_AD_es_cr_ASS.d64 "Internet Archive — C64 source artifact"
[5]: https://archive.org/download/Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX/Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf "Internet Archive — Amiga source artifact"

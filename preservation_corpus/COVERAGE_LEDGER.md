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
| 112 | ZX | Chichén Itzá | `112_ChichenItza.tap.zip` | `cef2fd44c944afa5d27b484a23955872c03615928882711a0ae5a5f058215976` | ZIP/TAP extracted; target-absolute DDB ranges materialized | 9 | 2 |
| 121 | C64 | Jabato | `121_Jabato_1989_Aventuras_AD_es_cr_ASS.d64` | `4f2c17a2324f539dbf0c121b88fb1101602ffed0473481be61800571424c157f` | D64 extracted | 3 | 0 |
| 245 | Amiga | Chichén Itzá | `245_Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf` | `75fbdcf572de907da8b7f5eb25129d1ffefe81601ba0b2263b2d9590688f3092` | OFS ADF fully traversed | 19 | 2 |

The retained source URLs are canonicalized in the `sources` table. Original bytes reside in [`downloads/`](downloads/), all materialized children in [`extracted/`](extracted/), and the raw structural-candidate report for the C64/Plus/4 members in [`evidence_first_slice_ddb_candidates.json`](evidence_first_slice_ddb_candidates.json). The bounded ADF directory/data-chain measurement is retained in [`evidence_amiga_chichen_itza_adf.json`](evidence_amiga_chichen_itza_adf.json); the CPC DSK geometry and directory-window evidence is retained in [`evidence_cpc_la_aventura_original_dsk.json`](evidence_cpc_la_aventura_original_dsk.json); the ZX header candidates, decoded target-absolute fields, and validated embedded ranges are retained in [`evidence_zx_chichen_itza_ddb_candidates.json`](evidence_zx_chichen_itza_ddb_candidates.json).

## Resolved loop — Amiga Chichén Itzá ADF

The original `DOS\0` OFS image declares root block 880. Its complete bounded directory walk reaches 19 files. The production extractor now materializes all 19 paths from retained bytes, preserving distinct filenames even when their payload bytes are equal. In particular, `PART1.DDB` (42,804 bytes) and `PART2.DDB` (43,990 bytes) pass the target-aware recognizer as **Amiga DAAD legacy V2** structures.

The correction was made against the retained image and a real-artifact regression. The implementation reads `FileHeaderBlock::ByteSize` at word 81, follows OFS data blocks through their verified next pointers, and limits file-extension header traversal to FFS. A controlled `--reunpack-source 245` refresh removed earlier partial derived rows, regenerated the 19 children, re-fingerprinted both DDBs, and rebuilt the classified library. This is a parser-resolution result, not a claim that unrelated Amiga loader variants are already complete.

## Resolved loop — ZX Chichén Itzá TAP loader

Each part’s BASIC loader loads its `CODE.bin` image at `24576` (`0x6000`). Both 40 KiB images jump at entry to `0x7F1C`; the game DDB begins at file offset `0x2400`, corresponding to target address `0x8400`. The compact header’s section pointers and final length are native ZX memory addresses, not file-relative offsets. The parser therefore validates the bounded range after subtracting the documented target base: Part 1 is 26,489 bytes (`8002699b5958444129348bed0258833467e41cd7651ee10e61733300113ae474`) and Part 2 is 22,194 bytes (`7d7b26973b9c36a6dca4e804e2c4dbfccda663985f6052080ac85151bb1386ab`).

Both ranges are retained as depth-3 `CODE__embedded_002400.ddb` children and independently fingerprinted as verified Spanish ZX DAAD legacy V2 DDBs. Their source member names are intentionally identical, so the classified library preserves the first literal name and adds the stable `__artifact_91` suffix to the second collision path. The parent code images remain retained as loader/runtime evidence.

## Required research and implementation loops

| Observation | Reproducible evidence | Required support iteration |
| --- | --- | --- |
| C64 and Plus/4 game members use load-addressed PRG-like members and loader/runtime packaging rather than a directly validated DDB header. A complete retained-member scan found no valid embedded DDB in `EDI64`, `EDIPLUS4`, `JABATO P.1`, `JABATO P.2`, or their companion data members; the apparent legacy markers in `EDI64`/`EDIPLUS4` fail bounded length/pointer validation and are code coincidences. | [`evidence_commodore_loader_ddb_candidates.json`](evidence_commodore_loader_ddb_candidates.json); 6502 disassemblies under [`derived/commodore_loader/`](derived/commodore_loader/); a bounded VICE 3.7.1 C64 autostart attempt. The emulator workflow is currently blocked by the Ubuntu package’s absent C64 KERNAL ROM (`kernal-901227-03.bin`), recorded in the retained smoke log; no external ROM was substituted. VICE documents monitor command files, machine snapshots, and memory-range capture for a future reproducible run. [7] | Reconstruct the loader-specific memory maps using static 6502 evidence; supply an authorized ROM set through controlled project provenance before using VICE monitor snapshots; then compare loaded RAM ranges, interpreter execution behavior, and emitted DDB candidates. Keep each absent-ROM or loader semantic as a named, reproducible blocker until resolved. |
| ZX game parts initially materialized 40 KiB `CODE.bin` blocks with executable Z80 entry vectors but no standalone DDB member. | Retained TAP parts, BASIC loaders, target-addressed candidate report, two exact DDB children, parser regression, and library collision regression. | **Resolved for this target-absolute legacy DDB layout.** Future ZX loader variants must retain their load map and either pass the same bounded model or enter a new variant-specific loop. |
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
[7]: https://vice-emu.sourceforge.io/vice_12.html "VICE monitor manual — scripted command files, snapshots, and memory save commands"

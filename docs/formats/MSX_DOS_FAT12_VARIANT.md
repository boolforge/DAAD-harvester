# MSX-DOS FAT12 Variant — Official DAAD R4 `MSX.DSK`

| Audit field | Value |
| --- | --- |
| **Question** | Under what evidence-backed conditions may the native parser recognize an MSX-DOS FAT12 volume that omits the IBM-PC `55 AA` boot-code trailer? |
| **Evidence scope** | The retained official DAAD R4 `MSX.DSK`, its measured BPB and extracted directory, the MSX technical handbook, and the bounded native parser/regression contract. |
| **Non-claims** | This dossier does not claim that four profiles exhaust historical MSX media, that every zero-trailer disk is FAT12, or that extracted package members have completed emulator-equivalence or complete internal-format analysis. |

> **Status:** Native FAT12 extraction, retained-sample regression, and source-250 corpus materialization are complete. Package-member structural roles are recorded below; byte-level interpreter identity and complete companion-resource grammars remain separate evidence loops.

## Retained sample

The official DAAD R4 release bundle contains `DAAD/LIB/MSX/MSX.DSK`, a 737,280-byte raw disk image. Its sector-zero BIOS Parameter Block declares 512-byte sectors, two sectors per cluster, one reserved sector, two FATs, 112 root entries, 1,440 total sectors, media identifier `F9`, and three sectors per FAT. These values match the MSX-DOS two-sided, 9-sector (`2DD, 9`) media profile: 80 tracks per side, two sides, nine 512-byte sectors per track, two-sector clusters, two FATs, three FAT sectors, and 112 directory entries.[1]

| Field | Retained R4 value | MSX-DOS `2DD, 9` profile |
| --- | ---: | ---: |
| Image length | 737,280 bytes | 80 × 2 × 9 × 512 bytes |
| Bytes per sector | 512 | 512 |
| Sectors per cluster | 2 | 2 |
| FAT copies | 2 | 2 |
| Root entries | 112 | 112 |
| Total sectors | 1,440 | 1,440 |
| Media descriptor | `F9` | `F9` |
| FAT sectors | 3 | 3 |

## Signature boundary

The retained image starts with `EB FE 90` and has zero bytes at offsets `0x1FE–0x1FF`, rather than the IBM-PC `55 AA` boot-code marker. The MSX technical handbook describes MSX startup as loading logical sector zero and accepting a boot sector beginning with `EB` or `E9`; it then invokes the MSX boot routine at `C01E`.[1] The FAT-format reference separately explains that `55 AA` identifies IBM-PC-compatible boot code, is not present on all FAT volumes, and explicitly names `EB FE 90` as a common MSX-DOS 2 floppy prefix.[2]

Therefore, the native FAT12 parser must not treat `55 AA` as a universal filesystem requirement. It retains the stricter IBM-PC path while adding a **currently verified MSX FAT12 acceptance path** that requires all of the following: a recognized MSX boot prefix (`EB FE 90` or documented equivalent), a coherent BPB matching a documented profile, a valid FAT12 cluster count and allocation bounds, and successful bounded directory/member traversal. A zero trailer alone is never sufficient.

The four profiles in the handbook table are the **current evidence-backed exception set**, not a final MSX geometry whitelist. A newly encountered coherent MSX medium must be retained and investigated rather than silently rejected: primary documentation and at least one real sample must establish its profile, then the parser must receive an explicit acceptance contract, malformed-image negative tests, a real-artifact regression, and a self-contained regeneration entry before that profile is promoted.

## Native extraction and package boundary

The native FAT12 parser now accepts this measured MSX-DOS profile without an IBM-PC trailer, bounds every BPB-derived region, walks cycle-free cluster chains, and emits the five root members below. `tests/test_platform_media.py::test_extracts_retained_official_r4_msx_dos_disk` pins both member names, lengths, and SHA-256 values; a malformed BPB regression rejects the otherwise similar `EB FE 90` prefix. Source 250 was re-unpacked and fingerprinted so each member now has its own retained corpus record, lineage, and complete digest suite.

| Member | Length | Measured/derived role | Boundary |
| --- | ---: | --- | --- |
| `MSXDOS.SYS` | 2,432 bytes | MSX-DOS system-file candidate | Native filesystem membership is verified; system-runtime behavior is not inferred from a filename alone. |
| `COMMAND.COM` | 7,168 bytes | Command-processor candidate | Preserved opaque program image; no DAAD or interpreter identity claim. |
| `DAAD.MDG` | 2,105 bytes | Font/graphics package build input | The retained public MSX build script calls this the font-preparation input and replaces its central character-set region before disk staging.[3] Its complete internal grammar remains unpromoted. |
| `DAAD.Z80` | 8,400 bytes | Exact-hash MSX English DAAD interpreter profile | Its SHA-256 matches `daad-msx-msxedi-official` exactly.[4] The retained public build script proves the generic language-selection convention, but its currently retained `DMSXIEF3.BIN` and `DMSXISF3.BIN` samples have different hashes; they are not substituted for this R4 byte identity.[3] The recorded static analysis still has an unverified raw-base load model. |
| `YOURGAME.COM` | 559 bytes | Game launcher candidate | Preserved opaque program image; its invocation and load behavior require byte-level or runtime evidence. |

The extraction and report regeneration are repository-native; an emulator remains an independent validation aid only under the project-wide [self-contained regeneration standard](../SELF_CONTAINED_REGENERATION.md).

## References

[1]: [MSX2 Technical Handbook, Chapter 3: MSX-DOS](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter3.html)
[2]: [Design of the FAT file system — boot-sector compatibility and MSX-DOS 2 note](https://en.wikipedia.org/wiki/Design_of_the_FAT_file_system)
[3]: [Retained public MSX build script — DAAD.MDG font preparation and DAAD.Z80 interpreter selection](../../reverse_engineering/public_sources/daad-ready-public-source-material/MSX1.BAT)
[4]: [Official interpreter profile manifest — MSX English profile](../../reverse_engineering/manifests/official_interpreters.json)

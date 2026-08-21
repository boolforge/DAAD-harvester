# Amiga ADF/OFS Generation

| Header field | Value |
| --- | --- |
| **Question** | How can Harvester deterministically generate and independently validate a bounded Amiga ADF/OFS technical-medium fixture without treating ADP output as the primary specification or a historical-runtime oracle? |
| **Evidence scope** | P0: the ADF technical reference and independent FFS/OFS structure reference; P1: pinned ADP `dim_adf.cpp`; P2: native Harvester parser/extractor, writer, regressions, and report evidence; P3: retained authentic ADF releases; P4: recorded emulator observations. |
| **Status** | First bounded native fixture promoted as `generated_structurally_valid`: empty standard-DD `DOS0`/OFS ADF with explicit name/timestamp, boot/root/bitmap checksums, and no members. Member-writing, authentic-release comparison, and emulator observation remain separate evidence waves. |
| **Implementation links** | `daad_harvester.adf_generation`, `daad_harvester.media_inspection._inspect_adf`, `daad_harvester.platform_media.extract_adf`, `daad_harvester.unpack.Unpacker.unpack_adf`, `daad_harvester.generator_evidence`, `scripts/verify_native_generators.py`, `src-common/dim_adf.cpp` at the pinned ADP revision. |
| **Non-claims** | An ADF byte stream is a sector dump, not a statement that every physical disk sector, protection scheme, loader, boot path, interpreter, game database, or historical release behavior has been preserved or reproduced. |

## Scope and independent evidence

An ADF is a headerless sequence of disk blocks rather than an MFM-track preservation format. The targeted standard double-density floppy profile contains 1,760 512-byte blocks and therefore 901,120 bytes; a root block is conventionally located at block 880. Integers in the Amiga filesystem structures use big-endian representation.[1] An ADF writer consequently cannot represent nonstandard raw-track timing, sector ordering, copy-protection state, or an arbitrary physical-disk condition; those require a different preservation medium and evidence path.[1]

| Evidence input | What it can establish | What it cannot establish alone |
| --- | --- | --- |
| ADF technical reference | Standard floppy geometry, `DOS` boot-block fields, root/bitmap placement, block grammar, and checksums. | Correctness of any particular DAAD release or custom boot loader. |
| Independent FFS/OFS structure reference | Root/hash/file/data-block relationships and OFS-versus-FFS data-block distinction. | Compatibility with protected or malformed media. |
| Pinned ADP source | Behavior of this ADP revision’s ADF reader/writer, allocation choices, and nondeterministic clock use. | The original AmigaDOS or original DAAD interpreter’s behavior. |
| Native Harvester reader/writer | The exact documented parser/generator result and deterministic fixture bytes. | Authentic-release equivalence without retained comparative media. |
| Retained authentic ADF | Facts measured from that exact retained byte stream. | General compatibility across unmeasured releases. |

## First bounded native output profile

The first writer profile is `blank_adf_ofs_dd_v1`. It may write a standard, headerless 901,120-byte ADF containing a canonical `DOS0` Old File System bootstrap record, root block, and allocation bitmap. It is intentionally a **container/filesystem initialization fixture**, not a game disk image.

The promoted fixture record is `adf-ofs-blank-standard-dd-v1`. Its deterministic SHA-256 is `0579352c016748a32e12cc5900ce04b0f69e05d9bd04c5fd52764fd38e161468`; its complete 17-digest record, strict writer validation, and independent native inspection are emitted by `python scripts/verify_native_generators.py`. The fixture has `filesystem_claim: empty_ofs_filesystem_no_members`, uses the explicit `EMPTY` volume name and `(0, 0, 0)` timestamp tuple, and does not claim a bootable disk, game payload, historical-release equality, or target runtime behavior.

| Explicit input | Rule | Initial fixture value |
| --- | --- | --- |
| Block size | Exactly 512 bytes. | 512 |
| Block count | Standard double-density floppy geometry only. | 1,760 |
| Output size | Exactly `block_count × 512`. | 901,120 bytes |
| Filesystem type | Four-byte boot signature is explicit. | `DOS0` (OFS) |
| Root block | Determined from declared geometry, not a filename. | Block 880 |
| Bitmap block | Explicit root bitmap-page target. | Block 881 |
| Volume name | ASCII/Latin-1-compatible byte value limited to the on-disk name capacity; no host locale inference. | `EMPTY` |
| Amiga date/time | Explicit `days`, `minutes`, `ticks` tuple. | `(0, 0, 0)` relative to the Amiga epoch for the first fixture |
| Boot code | Exact optional bytes; omitted means all-zero post-header region. | Omitted |
| Directory/file members | Ordered, explicit future input only. | None |

The fixed timestamp is mandatory because ADP’s `ADF_CreateDisk` calls its current-time helper when populating root metadata. Its direct output therefore changes across runs; it is valid independent comparison evidence but cannot supply a byte-pinned native fixture baseline.[3]

## Required byte-level construction rules

The native writer must construct and validate each listed layer before recording `generated_structurally_valid`.

| Layer | Required native rule | Independent cross-check |
| --- | --- | --- |
| ADF byte stream | Output is a plain contiguous block dump with no external header, wrapper, host path, random byte, or wall-clock field. | ADF technical reference.[1] |
| Boot region | Blocks 0–1 form the 1,024-byte boot area. The first block begins `DOS` plus an explicit type byte; the root pointer uses the documented boot field. | ADF technical reference and ADP `ADF_CreateDisk`.[1] [3] |
| Boot checksum | Zero the checksum field, perform the documented end-around-carry 32-bit sum over the whole boot area, and write its one’s-complement result in big-endian form. | ADF technical reference and ADP `ADF_UpdateBootBlockChecksum`.[1] [3] |
| Root block | Write a 512-byte root structure at the geometry-derived root block; preserve the 72-entry hash-table size, volume BCPL string, bitmap-page pointer, timestamps, and root secondary type. | Independent root-block layout and ADP source crosswalk.[2] [3] |
| Root/metadata checksum | Zero the checksum word and set it so the unsigned 32-bit word sum wraps to zero. | Independent FFS/OFS block layout and ADP `ADF_UpdateChecksum`.[2] [3] |
| Bitmap block | Mark root and bitmap allocation blocks used; retain unused blocks as free; write the block checksum and reject out-of-range allocation bits. | ADF technical reference, independent block layout, and ADP bitmap code.[1] [2] [3] |
| OFS data blocks | When member writing is promoted, each data block carries the OFS metadata/checksum header and at most 488 payload bytes. | Independent OFS data-block structure.[2] |
| FFS data blocks | A future FFS profile must be separate: FFS payload blocks do not reuse the OFS metadata/checksum model. | Independent FFS data-block structure.[2] |

The native reader validates every condition written by the generator. The media inspector now verifies supported DOS type, boot checksum, in-range root pointer, root type/secondary type/checksum, first bitmap-page pointer/checksum, block count, filesystem kind, and root hash-table size. The bounded fixture validator additionally verifies its all-zero boot-code region, empty root hash table, exact name/time inputs, and root/bitmap allocation bits. It rejects boot, root, and bitmap checksum corruption in regression tests before the record can be promoted.

## ADP source crosswalk

The following observed ADP source functions guide comparison, not native requirements. ADP’s defaults are explicitly recorded because their clock-dependent root time is an important difference to eliminate in the native output.

| Pinned ADP area | Observed behavior | Native design response |
| --- | --- | --- |
| `ADF_GetFloppyRootBlock` | Returns `numBlocks / 2`. | Derive the root from explicit profile geometry and assert it in the generated evidence. |
| `ADF_CreateDisk` | Defaults to 901,120 bytes, zero-fills the image, writes `DOS0`, uses block 880 root/881 bitmap for standard DD, names the root `EMPTY`, and writes current time. | Use the same layout only where independent specifications agree; require size/name/date as explicit writer inputs. |
| `ADF_UpdateChecksumSized` | Clears the checksum field and stores the two’s-complement sum for normal 512-byte blocks. | Implement a separately tested native big-endian word-sum helper. |
| `ADF_UpdateBootBlockChecksum` | Uses carry-aware addition and one’s complement for the boot area. | Implement a separately tested native boot checksum helper. |
| `ADF_LoadBitmapFromDisk` / allocation helpers | Treat bitmap payload words as allocation state and verify checksum before loading. | Reject mismatched, truncated, impossible, or out-of-range bitmap states in the native verifier. |
| `ADF_GetCurrentAmigaTime` call path | Imports wall-clock state into root creation/access fields. | Prohibit implicit clock reads in the preservation-critical generator path. |

## Promotion ladder and tests

| Status | Required deterministic evidence | Public wording |
| --- | --- | --- |
| `contract_only` | This byte-format contract, source crosswalk, and no writer. | “ADF/OFS generation contract defined; no native output.” |
| `generated_structurally_valid` | Native blank writer; full 17-digest output record; independent root/bitmap/checksum validation; negative/corruption regressions. | “Native generated ADF/OFS fixture; structure validated.” |
| `generated_member_round_trip` | Explicit directory/file inputs; native write/extract byte round trips including block-extension boundaries. | “Native generated ADF/OFS fixture; member round trip verified.” |
| `authentic_comparison_recorded` | Retained authentic ADF bytes and a documented byte/layout/member equality or difference record. | “Compared with retained authentic ADF; see comparison record.” |
| `emulator_observed` | Above plus retained emulator/version/configuration/trace/capture record. | “Load behavior observed under recorded emulator configuration.” |

The initial regression set must include deterministic duplicate generation, exact byte length, independent boot/root/bitmap/checksum validation, fixed-date sensitivity, invalid geometry/name/date rejection, a corrupted boot checksum, a corrupted root checksum, a corrupted bitmap checksum, and a zero-file native extraction result. Member-writing work must additionally cover 488-byte OFS boundaries, nested directories, directory-hash collisions, extension blocks, files at allocation limits, and round-trip equality.

## Public evidence and non-claim discipline

The promoted generator uses the canonical `daad_harvester.generator_evidence` collection, primary CI verifier, static report `generator_evidence` export, Pages `#generators` route, and TUI Native Generators tab already used by the Extended DSK fixture. The report/Pages collection now carries both generator records; the TUI continues from the first record’s checksum window to the second ADF record with the same Up/Down control. Each record exposes generator ID, exact input tuple, output path where published, all 17 checksums, native validation result, authentic-comparison state, ADP-source comparison state, emulator state, and a reproducer for every mismatch. Output bytes may become downloadable only after they are manifest-controlled and their published copies have been checksum-verified.

## References

[1]: http://lclevy.free.fr/adflib/adf_info.html “The .ADF (Amiga Disk File) format FAQ”

[2]: http://wiki.osdev.org/FFS_(Amiga) “FFS (Amiga): root, file-header, and OFS/FFS data-block structures”

[3]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dim_adf.cpp “Pinned ADP ADF reader/writer and checksum helpers”

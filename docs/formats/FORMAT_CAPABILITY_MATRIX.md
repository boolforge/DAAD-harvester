# DAAD Harvester Format Capability Matrix

**Document status:** implementation contract, 2026-08-19. This matrix defines the required end state. A checked row means that the implementation, corruption tests, provenance emission, and an audited artifact result have all been reviewed together. It does **not** turn a filename extension into a verified claim.

> **Preservation rule.** Every input is retained as an artifact. A parser may either emit byte-exact members with a complete evidence trail, emit a structured *recognized but not semantically decoded* record, or reject malformed media with a reason. It must never silently copy guessed members, discard a recognized container, or report a partial result as complete.

## Common contract

Every adapter must identify by magic and internal structure before extension, enforce bounded reads and decompression expansion, validate declared geometry/length/checksums where the format supplies them, preserve the original member name and hierarchy, and attach a container lineage record. A resulting member must include the original artifact SHA-256, extraction depth, parser identifier/version, media/container family, member address or block/sector provenance, and validation outcome. Corruption, truncation, cycles, overlapping ranges, invalid checksums, invalid archive paths, and decompression bombs require deterministic tests.

The DAAD target list below is taken from the official repository, which lists C64, Plus/4/C16 64K, ZX Spectrum, CPC, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS.[1]

| Validation state | Meaning |
| --- | --- |
| `IMPLEMENTED` | Native reader is in-tree and has positive, negative, truncation, and provenance tests. |
| `NEEDS_COMPLETION` | A partial reader exists but does not meet this document’s native-decoding and complete-evidence contract. |
| `REQUIRED` | The format belongs to the supported preservation scope and must receive an implementation before release. |
| `RECOGNIZED_EVIDENCE` | The object is inherently non-file-oriented or protected. The harvester must parse and preserve its structure, then report why member reconstruction is unavailable instead of pretending extraction succeeded. |

## Target media matrix

| Target | Required input family | Required handling | Current contract state |
| --- | --- | --- | --- |
| ZX Spectrum | TAP; TZX; SNA; Z80; +3DOS DSK; ZIP/7z/RAR wrappers | Decode standard and turbo blocks, reconstruct named ROM-loadable members, retain pulse-only/custom blocks as structured evidence, parse snapshot memory/page maps, parse +3DOS/CP/M files. | `NEEDS_COMPLETION` |
| Amstrad CPC | standard DSK; extended DSK; CDT; SNA; ZIP/7z/RAR wrappers | Validate track/sector maps and CP/M extents, fully traverse CDT/TZX blocks, preserve tape timing/metadata, parse snapshot memory map, retain protected sectors as evidence. | `NEEDS_COMPLETION` |
| Commodore 64 | D64/D71/D81; G64/G71; T64; TAP; PRG; P00; ZIP/7z/RAR wrappers | Decode CBM DOS directory and chains across supported geometries, recover T64 entries, identify P00/PRG wrappers, parse TAP/G64 timing/track evidence and ROM-decodable files where possible. | `NEEDS_COMPLETION` |
| Commodore Plus/4 / C16 64K | D64/D71/D81; T64; C16/Plus4 TAP; PRG; P00; wrappers | Apply TED-aware tape identity, CBM disk rules, and Plus/4 interpreter/loader provenance without conflating C64 and Plus/4 runtime evidence. | `NEEDS_COMPLETION` |
| MSX | FAT12 DSK/DMK images; CAS; TSX; ROM; ZIP/7z/RAR wrappers | Validate FAT12 and directory trees, classify MSX cassette headers/records, parse TSX/TZX-style block records, fingerprint ROM layout/banking metadata, retain unsupported mapper schemes as evidence. | `NEEDS_COMPLETION` |
| Amstrad PCW | CP/M DSK variants; CP/M raw images; CDT where present; LHA/ZIP wrappers | Recover CP/M directory/extents for documented geometries, validate allocation maps, label CP/M profile/geometry, and preserve nonstandard/protected tracks. | `NEEDS_COMPLETION` |
| Atari ST | ST; MSA; STX/IPF; ZIP/LHA/ARC wrappers | Parse raw FAT12/16 geometry, fully verify MSA RLE tracks, classify STX/IPF low-level protection structure, retain protected tracks and emit safe sector reconstruction only when validated. | `NEEDS_COMPLETION` |
| Amiga | ADF; ADZ; DMS; LHA/LZH; HDF; ZIP wrappers | Support OFS/FFS hierarchy including extension blocks, recover ADZ, complete all DMS modes with CRC/checksum validation, parse LHA/LZH natively, identify HDF/RDB/partition metadata and filesystem boundaries. | `NEEDS_COMPLETION` |
| IBM PC/DOS | FAT12/16 disk images; COM; MZ EXE; ZIP/ARJ/LHA/CAB/SFX; installer archives | Parse filesystem directories and chains, recognize executable headers without executing them, decode supported archive formats natively, recursively inspect safe self-extracting archive payloads. | `NEEDS_COMPLETION` |

## Tape and stream media

The TZX specification defines a ten-byte header and named standard, turbo, pure-data, direct-recording, CSW, generalized-data, control, metadata, and custom block families. It identifies CPC CDT as the same inner representation under a different extension.[2] A complete reader therefore cannot stop at the first unhandled control or metadata block. It must maintain a bounded block cursor, model control flow, emit recoverable data blocks, preserve replay-only blocks and timing, and record a precise unsupported-block reason when actual bit reconstruction is outside the parser’s scope.

The current code handles only a small subset of these data blocks; it must gain a typed block model, checksum validation where defined, nested loop/call bounds, and a separate semantic layer for Spectrum, CPC, C64, and MSX tape encodings. C64/Plus4 raw TAP represents pulse timing rather than an ordinary filename directory, and VICE documents distinct C64 and C16/Plus4 identity fields.[3] The preservation output must therefore retain timing identity even if a custom loader is not safely decoded.

## Disk and filesystem media

Raw images must be distinguished from filesystems. C64 G64 is a low-level GCR track stream designed for nonstandard formats and protection, while D64 is a sector image; neither may be treated as the other.[3] Atari ST and MSX/DOS images are often FAT-family media, but geometry and BPB validation must occur before file traversal. CPC/PCW CP/M images require allocation/extents rather than FAT assumptions. Amiga images require block-level OFS/FFS semantics and may contain chained header extensions.

## Cross-platform format-profile dossiers

Every accepted physical or logical profile must have a linked dossier. A profile is an evidence-backed combination of medium geometry, filesystem/container layout, boot or loader convention, target/load model, and relevant companion relationship; it is **not** a filename-extension rule. The dossier must identify the retained samples and hashes, primary and independent references, acceptance predicates, malformed/rejection predicates, member/provenance behavior, current applicability boundary, unresolved variants that require further work, real-artifact regressions, and a self-contained regeneration command. It must cross-link the [evidence model](../schemas/EVIDENCE_MODEL.md), [coverage ledger](../../preservation_corpus/COVERAGE_LEDGER.md), and relevant parser tests.

| Profile family | Current dossier/evidence location | Critical non-generalization rule |
| --- | --- | --- |
| MSX-DOS FAT12 without IBM-PC trailer | [Official R4 `MSX.DSK` dossier](MSX_DOS_FAT12_VARIANT.md) | The presently documented MSX profiles justify only the no-trailer MSX exception; they do not validate arbitrary FAT images, other MSX geometries, or another platform’s boot convention. |
| CPC/PCW CP/M disk variants | [CPC/PCW coverage and blocker records](../../preservation_corpus/COVERAGE_LEDGER.md) | Track/sector and extent allocation must be proven from the actual DSK/raw-image profile; FAT assumptions are prohibited. |
| Atari ST raw/protected disk families | [Atari ST matrix contract](#target-media-matrix) and retained media evidence | FAT, MSA, STX, and IPF have distinct physical/structural predicates; an ST-compatible filename does not establish sector reconstruction. |
| Commodore C64/Plus-4 media and loaders | [Commodore loader evidence](../../preservation_corpus/derived/commodore_loader/) | ROM packet, custom pulse-reader, disk-chain, and scene-loader evidence are separate profiles; a result on one variant never proves another. |
| Amiga OFS/FFS and DMS media | [Amiga coverage records](../../preservation_corpus/COVERAGE_LEDGER.md) | Block hierarchy, compression mode, and checksum contracts are media-specific; a successful ADF path cannot be inferred for DMS/HDF/LHA. |
| ZX/CPC/MSX tape and snapshots | [Tape/stream contract](#tape-and-stream-media) | Physical blocks, target memory maps, and loader semantics must be documented separately even when containers share a TZX-like representation. |

An unknown but coherent profile is never a terminal unsupported omission. It becomes a retained-sample research and implementation loop: acquire evidence, consult primary references, state the contract, add positive and malformed fixtures plus a real artifact, regenerate deterministically, and then promote the profile. The active R4 MSX case is the first explicitly linked example of this rule; corresponding dossiers are required for all other format families.

For Amiga DMS, the required decoder must cover `NOCOMP`, `SIMPLE`, `QUICK`, `MEDIUM`, `DEEP`, `HEAVY1`, and `HEAVY2`, including track-header CRC, payload CRC, unpacked checksums, state-carry flags, encrypted-archive reporting, banner/FILEID metadata, and byte-exact ADF output. The independent xDMS reference documents these modes and its oracle-based test strategy.[4]

## Archive and executable media

Archive decoding is not delegated to the user’s host tools. ZIP, 7z, RAR, TAR, gzip, bzip2, xz, ARJ, ARC, LHA/LZH, ZOO, CAB, and executable self-extractors must each have a native or vendored deterministic decoder, a declared unsupported-encryption result, and archive-path containment checks. Subprocess fallback may be used only as an optional validator during development; it cannot be the production extraction authority.

DOS `COM` and `MZ` executable files, platform runtimes, ROMs, snapshots, G64/STX/IPF images, and protected tape streams are not automatically member containers. Their parser contract is structural identification, immutable preservation, safe bounded scanning for embedded DAAD evidence, and clear reporting of whether a member reconstruction occurred.

## Required test corpus

Each row requires generated minimal-valid fixtures, real public-domain or redistributable fixtures, intentionally malformed variants, truncation at every header boundary, checksum/CRC failures, directory/chain loops, path-traversal archive entries, nested-container depth limits, and provenance assertions. A real-artifact manifest must preserve source URL, retrieval date, license/redistribution status, SHA-256, expected parser decision, and expected output hashes.

## References

[1]: https://github.com/daad-adventure-writer/daad "Official DAAD repository"
[2]: https://worldofspectrum.net/TZXformat.html "TZX format specification"; https://cpctech.cpcwiki.de/docs/cdt.html "CPC CDT format specification"
[3]: https://vice-emu.sourceforge.io/vice_17.html "VICE emulator file-format reference"
[4]: https://github.com/mlund/xdms-rs "xDMS Rust reference implementation"

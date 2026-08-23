# DAAD Harvester implementation status matrix

> This matrix is an evidence-led implementation audit. It describes what the current repository code and tests demonstrate. It is not a claim that every format family, game, runtime, or TODO item is complete.

## Operational baseline

The repository currently contains 54 Python modules in `daad_harvester/`, 83 operational scripts, and 99 focused test modules. The retained corpus contains 1,015 artifact records from 265 sources. The `resource_review_manifest.json` records each artifact's parser status, evidence state, support-loop state, next action, and reproducer. The public catalog-discovery snapshot currently contains 79 candidates from 92 source records; they remain catalog-only.

| Area | Implemented and regression-covered | Explicit boundary |
| --- | --- | --- |
| Recursive ingestion | Hashes every artifact, records source lineage and inspection JSON, recursively extracts bounded container members, and emits embedded DDB ranges when the native DDB finder locates them. | Depth is bounded; exceptions are retained as `unpack_exception`; a recognized outer format does not prove a DAAD payload. |
| Archive containers | ZIP, 7z, RAR, TAR-family, ARJ, LHA, ZOO, ARC, and CAB routing is present, with native or command-line extraction where available. | Archive extraction alone does not establish platform, game, provenance, or license. |
| Spectrum media | TAP blocks, TZX/CDT v1.20 block streams, and header/data payload association are implemented. TZX control targets are retained. | The TZX parser does not execute loop, jump, call, or selection graphs; extracted bytes are not runtime claims. |
| Commodore media | D64, D71, T64, P00, C64/C16 TAP, G64/G71 inspection, and a strict C64 BASIC `SYS` launcher profile are routed. TAP KERNAL packet recovery is bounded and parity-checked. | G64/G71 remains structural evidence without filesystem extraction. C64 BASIC launchers are not DDBs or interpreter correlations. Custom tape loaders remain outside the KERNAL packet contract. |
| Amstrad CPC | Standard/extended DSK track and sector inspection, directory extraction for recognized CP/M geometries, and AMSDOS-header validation are implemented. | Nonstandard CPC layouts remain explicit non-promoted evidence. The CPC loader FNT profile is a container identity, not a generic glyph decoder. |
| MSX | MSX-DOS FAT12 geometry profiles, FAT12/FAT16 extraction, CAS splitting, ROM header inspection, an exact R4 MDG template profile, and a bounded R4 launcher profile are implemented. | The R4 MDG profile is exact-template-only; generic MDG grammar, generic font semantics, and mapper behavior are not inferred. |
| PCW | Torreoscura DAT V1 directory, image-resource bounds, byte-stream decode, monochrome layout reconstruction, and packed-pixel output are regression-covered. | `PARTE000.PIC` remains unresolved and is not decoded as a raw screen. Cross-file game semantics remain separate work. |
| Atari ST | MSA decompression, FAT extraction, STX/Pasti structural inspection, and IPF initial CAPS-record recognition are implemented. | STX/IPF protection-bearing media are preserved structurally; no generic protected-media reconstruction is claimed. |
| Amiga | ADF OFS/FFS structural inspection and filesystem extraction, ADZ decompression, DMS header inspection, and DMS-to-ADF decompression are implemented. | DMS header recognition alone does not establish full archive reconstruction; each retained image requires its own evidence path. |
| DOS | FAT12/FAT16 extraction and MZ header validation are implemented. | MZ header validation is not interpreter decompilation or runtime equivalence. |
| DDB | Native grammar, IR, round-trip evidence, token-boundary negative evidence, embedded-range discovery, and generated detection evidence are present. | Unsupported or ambiguous grammar regions remain blockers; round-trip coverage is not universal across every historical DDB profile. |
| Interpreter analysis | Official interpreter inventory profiles, immutable byte hashes, reverse-analysis scripts, and separate derived analysis records exist. | A hash match or disassembly output is not a behavioral equivalence claim; broad interpreter decompilation and cross-tool comparison remain pending. |
| Catalog discovery and acquisition queue | A public CASA snapshot is versioned and compared against the local catalog. The current 79 candidates are discovery records, and queue selection plus transfer planning require independently recorded source-specific authorization. | The snapshot and an institutional handling statement do not authorize downloading, retaining, or redistributing a new candidate byte. |
| Workflow | Portable preflight, skills, active-backlog indexing, resource inventory/review manifests, deterministic parallel gates, ordered recovery mode, tests, atomic Git delivery, and remote push workflow are versioned. | Automation does not substitute for missing game bytes, licenses, runtime traces, parser grammars, or independent evidence. |

## Immediate evidence gaps

The most material open gaps are not missing function names. They are evidence-bound work: generic companion-resource grammars, unresolved PCW PIC, universal bundle relationships, platform-specific cross-file reference semantics, source-specific catalog acquisition authorization, generic font/image/audio decoding, full interpreter behavior analysis, and emulator-equivalence. These gaps must be worked as bounded profile slices with retained inputs, negative tests, real-artifact regressions, deterministic regeneration, and explicit non-claims.

## Change-selection rule

Before implementing a new parser or acquiring a new candidate, an agent must identify the exact retained or authorized input, relevant profile/platform, existing router path, expected evidence output, negative control, real-artifact regression, regeneration target, and report boundary. If any one is absent, the correct outcome is a support loop or a discovery record, not a fabricated implementation claim.

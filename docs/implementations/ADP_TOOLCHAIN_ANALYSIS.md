# ADP Toolchain Analysis

> **Classification:** ADP is an independently maintained DAAD interpreter and toolchain. It is not a DAAD derivative and it does not establish equivalence with an unmeasured historical interpreter.

| Header field | Value |
| --- | --- |
| **Question** | What do the retained ADP source tree and host verification establish about its tool executables, their media/database operations, and the native Harvester comparison work required for each operation? |
| **Evidence scope** | P0: the ADP source and documentation at pinned revision `379a6710de11a2378f3d76c25a4d71bca75073bf`, plus published format specifications. P1: the retained source/release mirror, host-build record, source-path inventory, and native Harvester regressions. |
| **Status** | Source-backed operation map; first native Extended DSK generator fixture promoted. Most ADP format operations remain research and native-implementation work. |
| **Implementation links** | [ADP identity dossier](ADP.md), [pinned mirror manifest](../../reverse_engineering/manifests/adp_implementation.json), [retained host verification](../../reverse_engineering/manifests/adp_verification.json), [native Extended DSK contract](../formats/EXTENDED_DSK_GENERATION.md), [native generator verifier](../../scripts/verify_native_generators.py). |
| **Non-claims** | ADP acceptance, conversion, compilation, loading, or execution does not by itself prove that original DAAD bytes, original interpreters, media loaders, graphics resources, or game behavior are equivalent. A source-level map is not a native Harvester implementation. |

## Evidence model and retained implementation boundary

The retained ADP mirror contains **2,560 source-tree files** and **20 maintainer-published release assets** at the pinned revision, with one SHA-256 record for every retained file. The mirror is therefore a fixed implementation input for comparison, not an unpinned online dependency.[1] [2]

| Evidence layer | Retained record | Permitted conclusion | Prohibited shortcut |
| --- | --- | --- | --- |
| ADP source | Public source tree and per-file manifest. | What this ADP revision declares or implements. | Treating ADP behavior as original historical-runtime behavior. |
| ADP host verification | `make -f Makefile-linux test` record: 18 passed, 4 fixture-blocked, zero behavioral assertion failures. | A bounded result for the retained host test inputs. | Claiming universal media, game, or platform compatibility. |
| Primary byte specification | Published Extended DSK grammar and platform/media documentation. | Container grammar and stated platform rules. | Inferring a game payload, filesystem, or interpreter identity from a container alone. |
| Authentic retained release | Source, artifact, and complete digest record. | Facts measured from that exact byte sequence. | Generalizing one release result to another variant or platform. |
| Harvester native implementation | Versioned deterministic source, tests, manifests, and report evidence. | The exact documented parser/generator claim. | Replacing unimplemented native logic with an ADP invocation. |

The exact build command is retained because it is useful corroboration: ADP’s Linux makefile selects a GNU++14 build with libpng and SDL2 and produces `player`, `dmg`, `chr`, `ddb`, `dsk`, and `adpc`. Its test target delegates first to toolchain fixture creation and then to host game scenarios.[3] [4] Harvester’s primary workflow does **not** invoke that command: it must remain independently reproducible using repository-native Python and committed inputs.

## Source-tree architecture and tool boundary

The retained source tree separates common DAAD/database/media code, command-line tools, portable/host layers, and platform ports. The table is an architecture map drawn from the pinned tree, not a claim that every listed subsystem has been behaviorally validated for every release.[2]

| Source area | Observed responsibility | Preservation use |
| --- | --- | --- |
| `src-common/` | Shared database, disk-image, graphics, font, snapshot, video, input, and operating-service code. | Source crosswalk for byte grammars and validation predicates. |
| `src-tools/` | Tool front ends, source compiler modules, graphics/font utilities, and disk operations. | Independent command and fixture behavior to compare against native code. |
| `src-sdl/`, `src-unix/`, `src-windows/`, `src-web/` | Portable or host integration. | Host-specific behavior; never original-target runtime evidence by default. |
| `src-amiga/`, `src-atarist/`, `src-dos/` | Native replacement player and device/service implementations. | Separate, analyzable implementation families, not historical interpreter replacements by label alone. |
| `tests/`, `games/`, `scripts/` | Regression fixtures, curated releases, artifact assembly, and scenario runners. | Reproducible comparison inputs subject to source/release provenance. |

## Database loading, checking, and writing

ADP’s public `include/ddb.h` declares a loader (`DDB_Load`), a metadata checker (`DDB_Check`), video/data-file probes, a database constructor (`DDB_Create`), a writer (`DDB_Write`), interpreter lifecycle functions, snapshot loading, vector-database read/write operations, and PAWS graphics hooks.[5] The declaration confirms an ADP API surface; it does not define a complete binary grammar or prove that every accepted file is a valid historical DAAD game.

| ADP operation | Pinned declaration boundary | Native Harvester requirement |
| --- | --- | --- |
| Load | `DDB_Load(const char* filename)` may operate on direct input and bounded container carving. | Preserve original container/member provenance; make byte-range recovery explicit; never silently convert a carve result into a container-level identity claim. |
| Check | `DDB_Check` returns target, language, and version outputs. | Compare with Harvester’s independent structural fingerprint and profile evidence; retain disagreements as test fixtures. |
| Create/write | `DDB_Create` and `DDB_Write` expose ADP construction/emission. | Define a native source/IR/recompiler contract before claiming any byte-exact DDB output. |
| Runtime and resource probes | Video/data-file, snapshot, vector, and PAWS helper declarations. | Test resource bytes and target profile independently; do not merge a graphics/font observation into interpreter identity. |

> **DDB-recompiler rule:** A future native recompiler must decompile one exact source byte stream to an explicit, lossless intermediate representation, recompile it under an explicit target/version/profile tuple, and compare every output byte. A passing ADP compile is supplementary comparison evidence, never the primary round-trip oracle.

## `adpc`: source-to-database compiler comparison path

The pinned `adpc` help declares `.SCE` input and `.DDB` output, or `.SDB` for PAWS. It exposes version selection (`v1`, `v2`, `v3`, and PAWS parsing), ten target names—IBM PC, Spectrum, C64, CPC, MSX, Atari ST, Amiga, PCW, Plus/4, and MSX2—plus language, character-set, include-path, preprocessor definition, character translation, strictness, and optional PAWS donor-graphics inputs.[6]

| Compiler input dimension | ADP-declared control | Required native preservation record |
| --- | --- | --- |
| Semantic source | `.SCE` source and any included source files. | Exact source digests, include graph, encoding, preprocessed source, and failure diagnostics. |
| Database variant | Version and PAWS mode. | Explicit grammar branch, feature ledger, and round-trip support state per construct. |
| Target | One named machine profile from ADP’s target set. | Explicit target layout/profile and a separately verified interpreter/loader compatibility boundary. |
| Text | English/Spanish, automatic/UTF-8/CP437 handling, mappings. | Exact text-encoding policy and unrepresentable-character rejection tests. |
| PAWS resources | Optional donor SDB and compression switch. | Independent PAWS dialect handling and resource provenance; no DAAD inference from PAWS output. |

The current Harvester does **not** compile `.SCE` to `.DDB`. The first compiler wave will analyze `dc_main.cpp`, `dc_condacts.cpp`, and `ddb_writ.cpp`, construct a documented native intermediate representation, and use retained sources plus authentic database fixtures to establish byte-for-byte behavior one profile at a time.

## `dsk`: container creation and media operations

ADP’s `dsk` front end exposes create, add, extract, directory, tree, and boot-block operations. Its common disk dispatcher selects an implementation by requested extension: `.dsk` routes to the CPC-family writer, `.adf` to the Amiga writer, and `.img`/`.st` to the FAT writer.[7] The dispatch is a tool design fact, not proof that every file with one of those suffixes is compatible.

### CPC-family Extended DSK presets

The source-backed preset table below comes from `dim_cpc.cpp`; all three presets create an Extended DSK stream with nine 512-byte sectors per formatted track.[8] The published Extended DSK definition independently specifies the 256-byte disk-information block, ordered track-size table, 256-byte track-information blocks, unformatted-track marker, and sector-length representation used to validate the outer stream.[9]

| ADP preset | Tracks × sides | Sector IDs | Reserved tracks | Extra source-observed rule | Native status |
| --- | ---: | --- | ---: | --- | --- |
| `plus3` | 40 × 1 | `0x01`–`0x09` | 1 | No special track-zero specification. | Container only is not yet a promoted Plus3 filesystem/media profile. |
| `cpc` | 40 × 1 | `0x41`–`0x49` | 2 | `Track-Info`, size code 2, gap `0x2A`, filler `0xE5`, zero FDC status bytes. | **First native generated fixture promoted** as a blank container profile. |
| `pcw` | 80 × 2 | `0x01`–`0x09` | 2 | Writes a PCW disk specification into track 0, sector 0. | Pending a native specification encoder, filesystem checks, and authentic media comparison. |

The native generator `build_blank_cpc_system_dsk()` is deliberately narrower than the ADP preset. It emits a deterministic 40×1 Extended DSK container with those CPC-oriented sector identifiers and `0xE5` payload fill; it explicitly makes **no populated CP/M directory, game, bootability, Plus3, PCW, or historical-equivalence claim**. The pinned output is 194,816 bytes with SHA-256 `ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b`. The primary workflow regenerates the bytes, verifies the hash, and runs the independent native DSK inspector before passing.[10] [11]

| Native generator evidence field | Current value |
| --- | --- |
| Generator ID | `extended-dsk-blank-cpc-system-v1` |
| Status | `generated_structurally_valid` |
| Structural predicate | `validated_cpc_dsk_track_stream` |
| Native observed geometry | 40 tracks, 1 side, 360 sectors, nine 512-byte sectors per formatted track |
| Authentic-release comparison | Not applicable to the intentionally blank fixture; a future populated profile requires retained authentic-media comparison. |
| CI command | `python scripts/verify_native_generators.py` |

The generation contract defines the promotion ladder for profile-specific CPC, Plus3, and PCW media. CP/M allocation, directory extents, boot sectors, application membership, and target execution remain separate layers that require their own source/specification, authentic media, tests, and output records.[10]

## Amiga ADF path and determinism boundary

ADP’s ADF code operates on 512-byte blocks, recognizes the `DOS` type range it uses for OFS/FFS variants, validates root/hash/bitmap conditions when reading, and creates a 901,120-byte double-density `DOS0` OFS image by default.[12] The observed creation path writes an Amiga boot block, places the root at the disk midpoint, initializes a bitmap after it, and uses `EMPTY` as the initial volume label.

ADP uses current Amiga time for root creation/access fields. Consequently, an ADP ADF creation result is **not** suitable as a byte-stable fixture unless its time input is controlled. A native Harvester ADF writer must accept a fixed timestamp as an explicit input, define allocation/root/header/file checksums and directory hashing, and compare its output with retained media plus an independent filesystem specification before any exact-byte claim is promoted.[12] [13]

## Graphics and character/font tools

`dmg` is an ADP graphics-database tool. Its source identifies PNG, PCX, VGA, Atari PI1/PL1, and IFF/ILBM image inputs, PNG/PI1/PL1/IFF extraction outputs, legacy and DAT5 creation settings, palette/remapping controls, optional compression, and audio rate handling.[14] The presence of a converter does not establish that a resource has the correct parent game, target rendering mode, or historical interpreter semantics.

`chr` declares conversion among PNG, `.CHR`, and `.FNT`. The source detects PNG signatures, `JSJ SINTAC FNT3`/`FNT4` signatures, and the exact 2,176-byte `.CHR` form; its help specifies the accepted PNG sheet dimensions for legacy and V4 layouts.[15]

| Tool family | ADP source observation | Native Harvester research/generation requirement |
| --- | --- | --- |
| Graphics database | Legacy/DAT5 construction and image/resource conversion surface. | Document every selected legacy/DAT5 grammar, compression state, palette/mode mapping, source image normalization, and exact authentic-resource comparison. |
| Audio in graphics context | `dmg` has discrete declared sample-rate mappings and optional mono conversion. | Preserve source audio identity and conversion parameters; prohibit lossy conversion as a preservation primary path. |
| Character set | `.CHR` detection includes exact fixed-length form. | Implement size/signature validation, layout extraction, and byte-preserving write path with corruption regressions. |
| SINTAC font | `.FNT` detection recognizes FNT3/FNT4 headers and different legacy/V4 PNG layouts. | Define FNT headers/layouts independently, retain source and rendered evidence, and establish deterministic PNG policy before any round-trip claim. |

## Test-suite model and comparison use

The ADP makefile’s `test` target invokes `run-adpc-tests.py` and `run-game-tests.py`. The first assembles selected fixtures, compiles source for declared targets, creates selected graphics databases, packages an Amiga disk image, and compares expected sizes/hashes. The second discovers and probes media families, runs scenario manifests, supports multi-disk/part selection and headless SDL, normalizes transcripts, and writes logs/captures.[3] [16] [17]

| ADP test component | What it can corroborate | What Harvester must retain separately |
| --- | --- | --- |
| Toolchain fixture runner | Repeatable behavior of ADP tool versions and selected pinned input tuples. | Source/input/output digests, native reproduction, and an exact statement of ADP-only differences. |
| Host scenario runner | ADP scenario output for selected game/media fixtures. | Original runtime/emulator evidence, loader state, snapshot/configuration, and byte-level artifact lineage. |
| Expected hashes | A reference for that ADP script/input/version. | Native independently regenerated outputs and authentic-release equality/difference result. |

## Promotion protocol for each ADP-related format

No ADP operation becomes a Harvester support claim solely because it is documented or produces an output. The following evidence ladder applies to CPC/PCW/Plus3 disks, ADF, DDB, graphics databases, fonts, snapshots, tape/container handling, and future media paths.

| Step | Required retained result | Failure handling |
| --- | --- | --- |
| 1. Source crosswalk | Pinned ADP paths/functions and input/output observation. | Record untraced function or ambiguity as a blocker with source location. |
| 2. Independent grammar | Primary specification or original-system documentation with byte/layout citations. | Do not implement from ADP behavior alone. |
| 3. Native implementation | Deterministic parser/generator with explicit inputs and bounded output. | Reject inferred defaults, wall-clock state, host filesystem metadata, and opaque external dependence. |
| 4. Structural validation | Native independent reader/checker and corruption regressions. | Preserve a minimal reproducer for every rejection or mismatch. |
| 5. Authentic comparison | Exact retained public release byte comparison or a recorded justified structural difference. | Retain both outputs, complete digests, version/profile tuple, and byte-range explanation. |
| 6. Runtime corroboration | Retained interpreter analysis and emulator observations where they apply. | Keep emulator evidence optional, versioned, and non-primary. |
| 7. Publication | Report/TUI/web/package record with checksums, provenance, status, and non-claim. | Fail the primary/report interface checks if required fields are absent. |

## Next native implementation waves

The current order keeps every increment independently testable. It does not imply that one DAAD platform is more important than another.

| Wave | Native objective | Evidence required before promotion |
| --- | --- | --- |
| ADF | Deterministic OFS writer with explicit timestamp, boot block, bitmap/root/header/file checksums, and bounded directory/file model. | Independent Amiga filesystem source, authentic retained ADF comparison, native parser round trip, and comparison record. |
| Tape streams | Deterministic TAP/TZX block writing that preserves explicit block metadata and timing semantics. | Retained Spectrum media, independent tape format specification, native parse/write comparisons, and loader/emulator evidence where applicable. |
| DDB compiler/recompiler | Lossless decompiler intermediate representation plus per-profile recompiler. | Construct ledger, byte-exact round trip, official/runtime analysis, and retained source/fixture tuple. |
| Graphics and fonts | Exact reader/writer contracts for selected resource grammars. | Resource-specific structural validation, visual/data checksum evidence, and authentic byte comparison. |
| Platform disk profiles | CPC/Plus3/PCW populated filesystem compositions and media-specific boot/resource rules. | Exact profile documentation, real disk samples, directory/filesystem validation, and target-specific evidence. |

## References

[1]: [ADP implementation dossier](ADP.md) “ADP identity, retention, scope, and host-verification boundary”
[2]: [Pinned ADP implementation manifest](../../reverse_engineering/manifests/adp_implementation.json) “Retained source/release file inventory and revision”
[3]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/Makefile-linux “ADP Linux build products and test targets”
[4]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/scripts/run-adpc-tests.py “ADP toolchain fixture runner”
[5]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/include/ddb.h “ADP DDB API declarations”
[6]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/tool_adpc.cpp “ADP compiler command surface and target parser”
[7]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dim.cpp “ADP disk-image creation dispatch”
[8]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dim_cpc.cpp “ADP CPC/Plus3/PCW Extended DSK implementation”
[9]: https://cpctech.cpcwiki.de/docs/extdsk.html “Extended DSK File Format, Revision 5”
[10]: [Native Extended DSK generation contract](../formats/EXTENDED_DSK_GENERATION.md) “Harvester generation evidence and promotion ladder”
[11]: [Native generator verifier](../../scripts/verify_native_generators.py) “Pinned blank CPC-system fixture and structural validation”
[12]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dim_adf.cpp “ADP ADF implementation”
[13]: https://www.kernel.org/doc/html/latest/filesystems/affs.html “Linux AFFS filesystem documentation”
[14]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/tool_dmg.cpp “ADP graphics-database tool”
[15]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/tool_chr.cpp “ADP character/font tool”
[16]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/scripts/run-game-tests.py “ADP scenario and media-runner framework”
[17]: [Retained ADP verification record](../../reverse_engineering/manifests/adp_verification.json) “Pinned host test outcome and fixture block”

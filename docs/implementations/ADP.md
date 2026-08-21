# ADP — ADventure Player

> **Classification:** ADP is an independently maintained DAAD interpreter and toolchain. It is not a DAAD derivative or an extension of the historical DAAD format.

| Header field | Value |
| --- | --- |
| **Question** | What can the maintained public ADP implementation establish about its own DAAD compatibility, platforms, tools, and current verification result? |
| **Evidence scope** | P0 ADP maintainer README, distribution documentation, MIT license, source tree, and published releases at the pinned revision; P1 retained mirror and local build/test log. |
| **Status** | source-backed; complete pinned source and published-release mirror retained. |
| **Implementation links** | [`../../reverse_engineering/manifests/adp_implementation.json`](../../reverse_engineering/manifests/adp_implementation.json), [`../../reverse_engineering/manifests/adp_verification.json`](../../reverse_engineering/manifests/adp_verification.json), [`../reverse_engineering/ARCHITECTURE_WORKFLOWS.md`](../reverse_engineering/ARCHITECTURE_WORKFLOWS.md) |
| **Non-claims** | ADP source, binaries, tests, and tool output do not recover original DAAD interpreter source, prove byte identity with an official runtime, or establish behavior of an unmeasured historical game. |

## Identity and retained material

ADP is a maintained C++ “ADventure Player” implementation and toolchain for DAAD adventures. The corpus retains the complete public repository at revision `379a6710de11a2378f3d76c25a4d71bca75073bf`, its project MIT license, and **every published release asset** for beta-0.1, beta-0.2, and beta-0.3.[1] [2]

| Retained class | Location | Measured count | Role |
| --- | --- | ---: | --- |
| Pinned public source tree | [`public_implementations/adp/source`](../../reverse_engineering/public_implementations/adp/source/) | 2,560 files | Public implementation, tools, tests, included component notices, and project game material. |
| Published release assets | [`public_implementations/adp/releases`](../../reverse_engineering/public_implementations/adp/releases/) | 20 files | Maintainer-published Amiga, Atari ST, DOS, web, Windows, macOS/Linux package, and game-bundle releases. |
| Mirror manifest | [`adp_implementation.json`](../../reverse_engineering/manifests/adp_implementation.json) | 2,580 file hashes | Immutable per-file source/release provenance and SHA-256 inventory. |
| Build/test record | [`adp_verification.json`](../../reverse_engineering/manifests/adp_verification.json) | 1 retained log | Pinned host build/test command, outcome, fixture gap, and log hash. |

The project license is MIT for ADP source and documentation; bundled component licenses remain retained in place and must be interpreted at component level.[3]

## Stated runtime and platform scope

ADP describes itself as a portable interpreter designed for DAAD games. Its distribution documentation states support for 16-bit Amiga, Atari ST, and PC adventures; it also identifies Spectrum, CPC, MSX, C64, and PCW support as experimental, including databases, snapshots, disk/tape images, and vector graphics.[2]

| Scope stated by ADP | Directly documented claim | Preservation interpretation |
| --- | --- | --- |
| Modern hosts and web | Linux, macOS, Windows, and web builds. | A modern implementation target, not a historical runtime identity. |
| Native retro ports | MS-DOS, Amiga, and Atari ST native players. | Public replacement implementations whose binaries are retained and can be analyzed separately. |
| DAAD versions | V1, V2, and V3; V1 reconstructed from games, V3 extensions associated with DAAD Ready. | Source-scoped compatibility claim; historical equivalence remains a measured question. |
| 8-bit media | Experimental Spectrum, CPC, MSX, C64, and PCW support. | Useful comparative behavior and media evidence, explicitly not a universal 8-bit compatibility guarantee. |
| PAWS | Experimental 48K/128K support; known parser/condact differences; no PC PAW `.PDB`. | Separate PAWS evidence path, never evidence for DAAD equivalence by itself. |

## Public tools and evidence value

ADP packages a graphical `player`, command-line `ddb` player/diagnostic tool, `adpc` compiler, `dmg` graphics-database tool, `chr` character/font converter, and `dsk` disk-image utility.[1] These are valuable independent implementations for comparison with the Harvester’s structural parsers and future execution traces. They do not supersede original media evidence, official profile identity, or per-game DDB measurements.

## Pinned format and medium capability matrix

This matrix reports what the retained ADP revision documents or includes in its own curated game material. It is deliberately **not** a claim that every file with a matching suffix is playable, structurally valid, or behaviorally equivalent to an original interpreter. `Native Harvester status` is independently governed by the format capability matrix and retained-artifact evidence; ADP is a comparison implementation and does not replace a native parser.[2] [5]

| Family or exact extension | ADP role at pinned revision | Scope or boundary recorded by ADP | Native Harvester status / integration boundary |
| --- | --- | --- | --- |
| `.DDB` | Primary DAAD game database accepted by `ddb` and `player`. | Direct 16-bit Amiga, Atari ST, and PC DDB operation is documented; V1/V2/V3 are stated supported, with reconstructed V1 compatibility boundaries. | Native structural DDB fingerprinting remains authoritative. ADP loading is optional execution/comparison evidence. |
| `.DAT`, `.EGA`, `.CGA` | Companion graphics database for a same-base-name DDB; `dmg` inspects and modifies graphics databases. | ADP also documents DAT5 as an ADP-specific extension. | Retain and classify each exact byte independently; do not infer a game database from graphics presence. |
| `.CHR`, Atari ST `.CH0`, `.FNT` | Character set or font companions; `chr` converts character/font data. | `.FNT` takes precedence where present; SINTAC proportional font support is described for PC DAAD. | Resource payloads require their own media/evidence role, checksums, and parent relationship. |
| `.SCR`, `.EGS`, `.CGS`, `.VGS`; PC `.PCX` | Loading/splash or external graphics companions. | `.PCX` support is stated for PC VGA/SVGA games. | Support-asset identity must never be rendered as a DDB/interpreter correlation. |
| Amiga `.ADF`; Atari ST `.ST`; PC/DOS FAT images; PCW/other 8-bit PCM disk images | Desktop/web discovery and `dsk` inspection/manipulation. | ADP calls image discovery experimental and expects well-formed, unprotected images; `dsk` documents MS-DOS/Atari ST FAT, Amiga ADF, and PCM disk support. | Native medium parsers remain required per geometry/filesystem profile. ADP can be recorded as an independent parser/runner observation only. |
| Spectrum `.TAP`, `.TZX`, `.SNA`, `.Z80` | Experimental 8-bit loading/extraction; retained ADP source explicitly documents PAWS SDB extraction from TAP/TZX and 48K/128K SNA/Z80. | BASIC loaders, presentation code, and unrelated blocks can be ignored by ADP’s PAWS extractor; this is not universal tape reconstruction. | Harvester must preserve block/timing/snapshot evidence and cannot promote ADP extraction to a complete tape decode. |
| CPC `.CDT` / `.DSK`; MSX `.CAS` / `.DSK`; C64 direct `.DDB` plus `.CDG` | Present in ADP’s curated multi-platform release-game manifest. | These retained ADP fixtures demonstrate the project’s tested media set, but a fixture suffix does not define a general parser contract. | Treat each as an ADP fixture/provenance reference. Native CPC/MSX/C64 support must meet the separate Harvester format contract. |
| PAWS `.SDB`, source `.SCE` | `ddb`/`player` may load SDB; `adpc` compiles PAWS source, including a donor-SDB mode. | ADP documents experimental 48K/128K PAWS support and explicitly excludes PC PAW `.PDB`. | PAWS is a separate dialect and must not contaminate DAAD measurements; ADP SDB output is comparison evidence only. |
| PC PAW `.PDB` | Explicitly unsupported. | ADP distinguishes it from Spectrum PAWS/SDB. | Record as an unimplemented external capability, never as a DAAD media claim. |

The existing retained package already satisfies source and release packaging: its manifest pins 2,560 source files, 20 published release assets, the license, and the exact upstream revision. A future **deterministic Harvester interoperability adapter** may invoke a locally built ADP tool only as an optional validator, store command/version/input/output hashes, and compare the result with a native Harvester parser. It may not make network calls, replace native promotion logic, or turn ADP’s beta compatibility statement into an all-format support claim.[1] [4]

> “ADP is beta software. Bugs and compatibility problems are expected, particularly with experimental formats.” — ADP maintainer README.[1]

The distribution also identifies intentional implementation differences, including command-history/editor behavior, optional keypress sound, multi-picture buffering, and forced delays. Such features are ADP behavior and must be tagged as such in comparisons rather than being back-projected onto historical DAAD runtimes.[2]

## Reproducible host verification

The retained revision was built using `make -f Makefile-linux test`. The initial attempt correctly exposed a missing documented SDL2 development dependency; after it was installed, the pinned test target compiled and probed 22 baseline fixture images. Eighteen passed. Four scenarios were **fixture-blocked**, not behavioral assertion failures, because two expected paths—`games/original256/release/amiga-hd/part1.ddb` and `part2.ddb`—were absent from both the pinned source checkout and the retained `Games-AD.zip` release bundles. The complete log and its SHA-256 are preserved in the verification manifest.[4]

| Verification field | Recorded result |
| --- | --- |
| Source revision | `379a6710de11a2378f3d76c25a4d71bca75073bf` |
| Command | `make -f Makefile-linux test` |
| Host dependencies | C++ compiler, GNU Make, libpng, SDL2 development files. |
| Fixture images probed | 22 |
| Passed | 18 |
| Fixture-blocked | 4 |
| Failed behavioral assertions | 0 |
| Conclusion | A successful partial host-suite execution with a retained upstream fixture gap; not a universal compatibility result. |

## Comparison protocol

ADP should be compared as an independently maintained implementation, using the following order: exact original/game bytes and their container evidence; Harvester structural parser evidence; official interpreter hashes; ADP tool/runtime behavior; then source-level ADP claims. Any disagreement remains stored as a concrete comparison result, with both inputs and tool output retained.

## References

[1]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/README.md "ADP README at pinned revision"
[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/docs/dist/README.md "ADP distribution documentation at pinned revision"
[3]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/docs/LICENSE "ADP MIT license"
[4]: [`adp_verification.json`](../../reverse_engineering/manifests/adp_verification.json) "Retained local verification record"

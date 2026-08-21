# Retained DDB Profile Inventory

| Header field | Value |
| --- | --- |
| **Question** | Which parser-verified retained DDB profiles establish the first native CondAct grammar and byte-identical round-trip implementation targets? |
| **Evidence scope** | P0 deterministic Harvester survey; P1 target-aware structural parser; P2 retained extracted and derived corpus bytes; P3 pinned ADP and DRC source cross-checks. |
| **Status** | Reproducible observed-profile inventory; not a semantic-decompilation or runtime-compatibility claim. |
| **Reproduction command** | `python3 scripts/survey_ddb_profiles.py --format json` |
| **Implementation links** | [`../../scripts/survey_ddb_profiles.py`](../../scripts/survey_ddb_profiles.py), [`../../daad_harvester/daad_parser.py`](../../daad_harvester/daad_parser.py), and [DDB round-trip contract](DDB_DECOMPILER_ROUND_TRIP.md). |

## Method and profile boundary

The inventory executes the native `DAADBytecodeParser` against every regular file under `preservation_corpus/extracted/` and `preservation_corpus/derived/`. A file is reported as `direct` only when the complete candidate validates structurally. The survey searches for one `embedded` candidate only when the complete source file is not itself a validated DDB, preventing a raw DDB from being counted again as an embedded range.

Each row binds the layout family, major version, machine ID, normalized target platform, measured word order, base-address model, language bit, wrapper format, source kind, representative parent path, source byte offset, and payload size. The output ordering is deterministic. The command only reads retained bytes; it performs no acquisition, extraction, modification, or classification by file name.

> A profile record is a **grammar-selection input**, not a claim that the retained bytes are semantically decompiled, universally compatible, or produced by a named historical compiler.

## Measured inventory at the current committed corpus state

The table below is the output measured on the corpus state associated with this dossier. Regenerate it rather than copying it forward after retained inputs change.

| Count | Layout | Version | Platform | Language | Byte order | Source kind | Wrapper | Representative retained evidence |
| ---: | --- | ---: | --- | --- | --- | --- | --- | --- |
| 4 | `legacy` | 1 | `c64` | Spanish | little-endian | direct | raw | `derived/commodore_loader/jabato_ass_part1_post_mirar.ddb` |
| 27 | `legacy` | 1 | `c64` | Spanish | little-endian | embedded | raw | `derived/commodore_loader/vice/jabato_c64_after_space.bin` at `0x3880` |
| 1 | `legacy` | 2 | `dos` | English | little-endian | direct | raw | `extracted/depth1_98397784_BLANK.DDB` |
| 1 | `legacy` | 2 | `dos` | Spanish | little-endian | direct | raw | `extracted/depth1_f14c8b04_SPANISH.DDB` |
| 2 | `legacy` | 2 | `zx` | Spanish | little-endian | direct | raw | `extracted/depth3_25a67864_CODE__embedded_002400.ddb` |
| 6 | `legacy` | 2 | `zx` | Spanish | little-endian | embedded | raw | `extracted/depth1_13421478_Chichen Itza - Side 2.tzx` at `0x40E9` |
| 1 | `legacy` | 2 | `amiga` | English | big-endian | direct | raw | `extracted/depth2_92aef478_PART1.DDB` |
| 2 | `legacy` | 2 | `amiga` | Spanish | big-endian | direct | raw | `extracted/depth1_806a1c74_PART2.DDB` |

The observed groups show why a generic decoder is insufficient. The first native grammar must distinguish at least V1 and V2 CondAct tables, preserve the recorded endianness and base-address characteristics at the profile boundary, and distinguish an executable DDB byte range from its parent container. The smallest current direct profile is the 2,652-byte legacy V2 DOS `BLANK.DDB`; it is therefore the first retained byte-identical round-trip target after grammar and IR coverage exist.

## Implementation order

| Order | Measured target | Native implementation objective | Evidence needed before promotion |
| ---: | --- | --- | --- |
| 1 | Legacy V2 DOS direct/raw | Establish V2 CondAct tables, terminators, indirection representation, and lossless IR byte ledger. | Byte-identical retained `BLANK.DDB` recompile plus corruption regressions. |
| 2 | Legacy V1 C64 direct and embedded | Establish the V1 table differences and associate extracted range with parent lineage. | Direct and parent-range byte comparison; runtime evidence remains separately scoped. |
| 3 | Legacy V2 ZX direct and embedded | Validate profile reuse across raw extracted and tape-contained ranges without conflating the container with DDB bytes. | Direct and embedded-range byte comparison with exact source offsets. |
| 4 | Legacy V2 Amiga direct | Exercise Motorola byte order and the profile-specific header/pointer model. | Big-endian retained round-trip and pointer-range regressions. |

## **Non-claims**

This inventory does not claim complete corpus coverage, discovery of every DDB embedded range, support for modern DRC V2/V3, PAWS, derivative extensions, semantic decoding, source reconstruction, valid execution in any interpreter, emulator equivalence, or ScummVM readiness. It does not equate parser validation, a profile count, a C64 runtime memory image, or a named file with a complete DDB grammar or a verified recompiler.

## References

[1]: [DDB decompiler and recompiler round-trip contract](DDB_DECOMPILER_ROUND_TRIP.md) “Profile-scoped lossless IR, byte-comparison, and blocker-closure requirements”

[2]: [DDB structural fields](../schemas/DDB_STRUCTURAL_FIELDS.md) “Native parser field, wrapper, and structural-validation semantics”

[3]: [ADP CondAct definitions](https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/include/ddb_condact_defs.h) “Pinned version-specific V1, V2, and PAWS CondAct names and arities”

[4]: [DRC serializer](https://github.com/daad-adventure-writer/DRC/blob/e7bb170ef94e7b4965c0719b497638cec7aeaca9/src/drb.php) “Public first- and second-parameter indirection serialization evidence”

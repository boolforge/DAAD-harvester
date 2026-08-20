# ADP as a Comparator for the C64 *Jabato* Reconstruction

> **Evidence class:** P1/P2 comparison input. The retained ADP mirror is a public implementation and its claims are useful only after byte-level and emulator-backed validation against the retained C64 releases.

## Scope established from retained ADP materials

The retained ADP project describes itself as a portable DAAD text-adventure interpreter and toolchain. It states that it supports 16-bit games and has **experimental** support for 8-bit DAAD and PAWS games. Its own warning states that compatibility problems are expected, particularly with experimental formats.[1]

The retained mirror contains two purpose-named C64 Jabato database fixtures:

| Retained path | Role to verify | Immediate comparison use |
| --- | --- | --- |
| `reverse_engineering/public_implementations/adp/source/tests/games/jabato/c64/JABATO-C64 1.DDB` | Claimed C64 Jabato part 1 database fixture | Candidate semantic/reference DDB for structural and runtime comparison |
| `reverse_engineering/public_implementations/adp/source/tests/games/jabato/c64/JABATO-C64 2.DDB` | Claimed C64 Jabato part 2 database fixture | Candidate semantic/reference DDB for multipart/autoload comparison |

ADP’s retained DDB specification states that version 1 applies to *Aventura Original* and *Jabato* (1989), identifies the C64 target code as `2` with base offset `$3880`, and explains that DDB pointer fields may be interpreter-ready memory addresses rather than file offsets. For old version-1 files, it places file length at offset `$001E` instead of the newer offset. These are directly testable hypotheses for the original Side A game representation.[2]

## Verified Part 1 outcome

The stated C64 V1 model is now corroborated by independent original-runtime evidence. The active Side A gameplay snapshot has a structurally valid V1 DDB at `$3880`–`$99C2` (24,899 bytes). The range was extracted deterministically as `jabato_side_a_tap_second_space_part1.ddb`; its SHA-256, `7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6`, is byte-identical to ADP’s `JABATO-C64 1.DDB` fixture.

This comparison exposed and corrected a Harvester V1 parser defect: V1 has eleven section pointers, no extra-object-attributes field, and file length at `$001E`; it is not a 34-byte V2 header with a field omitted semantically. The corrected parser validates both the ADP fixture and the extracted original runtime range as Spanish C64 DAAD legacy V1. The real-artifact regression runs with the complete suite, which passes 221 tests at this checkpoint.

| Input | SHA-256 | Original-runtime relation | Status |
| --- | --- | --- | --- |
| ADP `JABATO-C64 1.DDB` | `7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6` | Exact 24,899-byte match to Side A RAM `$3880`–`$99C2` | **Verified comparator and recovered Part 1 DDB** |
| ADP `JABATO-C64 2.DDB` | `ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69` | Not present at `$3880` in the retained Side A Part 1 gameplay state | Active Part 2/Side B or later-load research target |

## Boundary for the active C64 investigation

ADP can provide a valuable **semantic and database-layout oracle**: it may reveal expected version-1 header fields, pointer normalization, multipart boundaries, vocabulary/messages/processes, and independently runnable interpretation of known C64 Jabato DDB inputs. It is not, based on the materials examined so far, evidence that it decodes this release’s physical Commodore raw-TAP stream, its `$01B6` timer-based loader, its `$16` synchronization protocol, or scene-specific D64 modifications.

The initial integration sequence is complete for Part 1: fixture hashing, structural validation, and exact original-runtime correspondence are all retained. The remaining sequence is to reproduce those bytes through a physical TAP decoder, recover the independently retained Part 2 fixture through Side B or a later original load state, and validate the scene-packaged ASS D64 against both parts. Only exact correspondence or emulator-backed behavioral agreement may promote an ADP-derived claim into Jabato release evidence.

## References

[1]: https://github.com/jlcebrian/ADP "jlcebrian/ADP — ADventure Player"
[2]: https://github.com/jlcebrian/ADP/blob/main/docs/DDB%20Specs.txt "ADP — DDB Specs"

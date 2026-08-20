# Jabato C64 ASS D64 — Execution Findings

| Field | Value |
| --- | --- |
| Retained source | `121_Jabato_1989_Aventuras_AD_es_cr_ASS.d64`, SHA-256 `4f2c17a2324f539dbf0c121b88fb1101602ffed0473481be61800571424c157f` |
| Scene members | `JABATO P.1`, `JABATO P.2`, and `JABATO PIC` |
| Evidence status | verified scene-variant runtime comparison; Part 1 and Part 2 DDBs materialized and registered as source-121 artifacts 107 and 108 |
| Self-contained boundary | Retained snapshots/RAM are immutable inputs. Future DDB detection and byte comparison must use repository-local scripts and be registered in `preservation_corpus/regeneration_manifest.json`; VICE is not a regeneration prerequisite. |

## Visual observations

The retained ASS D64 post-input screen presents Spanish in-game text and a command cursor, showing that the scene release can reach an interactive presentation state. The early capture contains no structurally verified DDB in its extracted RAM image; this is a loader-state observation, not a negative conclusion about the release.

Direct injection of the extracted `JABATO P.1` program reached the original **JABATO VS IMPERIO: LIBERTAD** title/credit screen at a measured C64 cycle count of `325306812`. The title identifies the original game presentation and lists the 1989 Aventuras A.D. credits. This confirms that the extracted scene member is executable program material rather than an empty/invalid D64 member; it does not yet establish which RAM range holds Part 1 or whether the scene runtime data is byte-identical to either original TAP DDB.

## Verified post-command comparison

The retained `JABATO P.1` and `JABATO P.2` members were each executed through the title transition and a first `MIRAR` command. Their committed post-command RAM captures both hold a DDB at `$3880`. `JABATO P.1` yields 24,899 bytes with SHA-256 `7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6`, exactly equal to original Side A Part 1. `JABATO P.2` yields 24,680 bytes with SHA-256 `ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69`, exactly equal to original Side B Part 2. Both ranges pass the native C64 legacy V1 DDB structural parser and are retained as `jabato_ass_part1_post_mirar.ddb` and `jabato_ass_part2_post_mirar.ddb`.

`python3 scripts/verify_jabato_c64_ass_scene_variant.py` reproduces the promoted comparison from the retained scene PRGs, RAM captures, scene DDB outputs, original DDB outputs, and the repository-native parser. It does not invoke VICE or ADP.

## Reproducible analysis boundary

The retained snapshots are converted with `scripts/extract_vice_snapshot_ram.py` and inspected with `scripts/inspect_ddb_candidates.py`. The `ass_wait`, `ass_input`, `ass_then_space`, and early injected-Part-1 states produce no structurally valid standalone DDB candidate, while the retained post-command states provide the bounded DDB-resident evidence described above. Future scene-loader variations must retain the same execution-stage distinction and use the repository-native verifier pattern before promotion.

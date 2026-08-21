# DAAD Legacy `.CHR` Generation

| Header field | Value |
| --- | --- |
| **Question** | How can Harvester generate and validate the known legacy DAAD `.CHR` outer container without inventing undocumented prefix semantics or claiming that a generated character set reproduces a historical title? |
| **Evidence scope** | P0 retained ADP source; P1 independent ZXDAAD128 documentation; P2 retained corpus and ADP fixture bytes; P3 native writer/validator and media inspector. |
| **Status** | Bounded native structural writer and validated ADP-writer header profile implemented. It preserves caller-supplied 128-byte prefix bytes and 2,048-byte glyph bytes exactly; unrecognized prefix fields, per-runtime interpretation, and authentic glyph equivalence remain unpromoted. |
| **Implementation links** | `daad_harvester.chr_generation`, `daad_harvester.media_inspection._inspect_daad_chr`, `tests/test_chr_generation.py`, `src-common/vid_font.cpp` and `src-tools/tool_chr.cpp` at pinned ADP revision `379a6710de11a2378f3d76c25a4d71bca75073bf`. |
| **Non-claims** | A structurally valid `.CHR` file does not establish complete prefix semantics, an intended glyph design, interpreter acceptance for every historical/runtime variant, source title identity, or executable behavior. |

## Structural boundary

ADP’s retained `SCR_LoadCharset` implementation rejects any file whose size is not 2,176 bytes and copies exactly 2,048 bytes beginning at offset 128 into the active character-set buffer. Independently, ZXDAAD128 documents a 2,048-byte character set as 256 characters at eight bytes per character.[1] This establishes the promoted outer partition, not the complete semantic interpretation of the prefix.

| Region | Offset | Length | Promoted meaning |
| --- | ---: | ---: | --- |
| Prefix | `0x0000` | 128 bytes | Explicit bytes. The generator preserves supplied bytes; the narrow ADP-writer profile below is recognized without promoting other fields. |
| Glyph payload | `0x0080` | 2,048 bytes | 256 consecutive eight-byte character bitmaps. |
| File | `0x0000` | 2,176 bytes | Fixed-size legacy `.CHR` outer container. |

The native builder accepts only explicit `bytes` values with those exact lengths. `build_blank_daad_chr()` emits an all-zero structural fixture. A nonmatching header remains `opaque_explicit_bytes_not_promoted`; `.chr` inspection always reports the bounded container without treating an extension as a complete format claim.

## ADP-writer header profile

Pinned ADP `SaveCHR` writes a repeatable subset of the prefix fields.[2] The native validator recognizes that conjunction only when all measured constants match, then records an `adp_legacy_chr_writer` profile. Recognition does not reject another valid fixed-size CHR container and does not assign semantics to fields that the retained writer merely emits.

| Offset | Measured value | Native evidence field | Promotion boundary |
| --- | --- | --- | --- |
| `0x01–0x08` | Uppercase padded filename stem | `header_filename_stem` | Observable writer output, not a game-title identity claim. |
| `0x09–0x0B` | ASCII `CHR` | `header_tag` | Narrow ADP-writer signature only. |
| `0x12` | `0x02` | `header_writer_marker` | Writer-emitted constant; version semantics remain unpromoted. |
| `0x41` | `0x08` | `glyph_height` | Consistent with the promoted eight-row glyph payload. |
| `0x43–0x44` | Little-endian `0x0224` | `header_trailer_word` | Recorded writer constant; field meaning remains unknown. |

The retained Torreoscura PCW `PARTE001.CHR` and `PARTE002.CHR` both match this profile with a `D1` stem and a `256 glyphs × 8 rows × 8 bits` payload geometry. The profile is pinned by a real-artifact regression; malformed or unrelated 128-byte prefixes remain explicit, non-promoted bytes.

## Cross-comparison record

The retained corpus contains two 2,176-byte `PART1.CHR`/`PART2.CHR` artifacts. Pinned ADP `original256` fixtures also contain `part1.chr` and `part2.chr` at 2,176 bytes. The first 128 bytes differ in observable title/header text, and the extracted 2,048-byte payloads also differ. This is format-level evidence, **not** equality evidence.

| Compared payload | Corpus SHA-256 | Pinned ADP fixture SHA-256 | Result |
| --- | --- | --- | --- |
| Corpus `PART1.CHR[128:2176]` vs ADP `part1.chr[128:2176]` | `7e8e9d58ec1c8ce40d2b3a16f593995df26c2faba1927634e2e3e13e4b71e54a` | `c0e0740da59da3a0272b011167e0de61ef9438687806915077ae9f9d594a18fc` | Different bytes; identical fixed-size partition only. |
| Corpus `PART2.CHR[128:2176]` vs ADP `part2.chr[128:2176]` | `7e8e9d58ec1c8ce40d2b3a16f593995df26c2faba1927634e2e3e13e4b71e54a` | `ac562ffd99bc714467e6854ef8dac615d9dca3e0641d80f96976abd5319ba9a6` | Different bytes; identical fixed-size partition only. |

## Promotion and next evidence

The current builder is not yet in canonical generator evidence because a blank opaque-prefix fixture cannot provide a meaningful authentic-output comparison. Promotion requires a retained-byte fixture with a documented input tuple, parser/reader validation, all 17 digests, explicit source/corpus comparison record, and only then CI/report/Pages/TUI exposure. Resolving the 128-byte prefix structure and comparing runtime-visible glyph behavior across interpreter families remain required follow-up work.

## References

[1]: https://github.com/cronomantic/ZXDAAD128 “ZXDAAD128 README: character set file requirements”
[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/tool_chr.cpp#L562-L599 “Pinned ADP CHR writer”

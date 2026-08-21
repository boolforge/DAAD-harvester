# TZX/CDT Generation

| Header field | Value |
| --- | --- |
| **Question** | How can Harvester generate deterministic, structurally validated TZX/CDT tape streams without treating a byte stream as proof of replay, loader, runtime, or game equivalence? |
| **Evidence scope** | P0 TZX v1.20 and CPC CDT specifications; P1 native typed parser/extractor; P2 native writer, fixtures, complete checksums, report/TUI/Pages evidence; P3 retained authentic tape comparison; P4 emulator observations. |
| **Status** | First bounded native fixture promoted as `generated_extraction_verified`: a deterministic TZX v1.20 standard-data header/data pair with parser validation and exact supported member extraction. Authentic-tape comparison, custom-loader semantics, and emulator observation remain separate evidence waves. |
| **Implementation links** | `daad_harvester.tzx_generation`, `daad_harvester.platform_media.parse_tzx_blocks`, `daad_harvester.platform_media.extract_tzx`, `daad_harvester.media_inspection._inspect_tzx`, `daad_harvester.unpack.Unpacker.unpack_tzx`, `daad_harvester.generator_evidence`, `scripts/verify_native_generators.py`, `tests/test_tzx_generation.py`. |
| **Non-claims** | A structurally valid TZX/CDT stream is not proof that a custom loader is decoded, that pulses reproduce an original tape, that a title runs, or that it is an authentic historical release. |

## Scope and source roles

TZX has a ten-byte `ZXTape!` header followed by typed blocks. Multi-byte fields are little-endian; the standard-speed data block (`0x10`) stores an explicit post-block pause, a 16-bit payload length, and the data bytes themselves.[1] CDT uses the same inner TZX block representation, with the `.cdt` extension distinguishing CPC tape images from Spectrum tape images.[2]

| Evidence input | Establishes | Does not establish alone |
| --- | --- | --- |
| TZX v1.20 specification | Header version, block IDs, standard-speed block fields, little-endian field order, and declared-span rules. | Accuracy of a particular historical tape’s timing or custom loader. |
| CPC CDT specification | CDT/TZX inner-format identity and CPC naming boundary. | That a generic standard-speed TZX block is a CPC runtime tape. |
| Native parser | Complete bounded scan and typed representation of supported standardized blocks. | Replay behavior or unimplemented custom-block semantics. |
| Native writer | Exact deterministic serialization for explicitly supported block families. | Authentic-release equivalence without a retained comparison target. |
| Retained tape and emulator observation | Facts about those exact retained bytes and recorded execution environment. | Cross-title or cross-loader behavior. |

## First bounded writer profile

The first profile, `tzx_standard_data_v1`, may serialize a TZX v1.20 header followed only by ordered standard-speed data blocks (`0x10`). It deliberately excludes turbo data, pure data, direct recording, pulse sequences, CSW, generalized data, jumps, loops, calls, selections, metadata, custom blocks, and glue records. Each input block is explicit and no filename, host clock, locale, random value, or inferred pulse encoding is accepted.

The promoted record is `tzx-standard-data-synthetic-pair-v1`: a 48-byte version-1.20 header/data fixture with SHA-256 `a6175d4413b42e61d9b5e2dd7956ba547a48ad48ca1c71b121ad9e5dcab48411`. It contains one explicit Spectrum-compatible header block and one explicit data block, allowing the bounded extractor to recover `DAAD GAME.bas` with the exact seven-byte `PAYLOAD` member. The fixture’s full 17-digest record, native structural validation, and extraction evidence are regenerated and pinned by `python scripts/verify_native_generators.py`; it does not establish an authentic tape, a CPC runtime tape, a custom loader, or emulator behavior.

| Input | Required rule | Deterministic treatment |
| --- | --- | --- |
| Container kind | Explicit `tzx` or `cdt` presentation label. | Identical inner bytes; filename extension is external presentation only. |
| Header version | Explicit supported revision. | Initial fixture: major 1, minor 20. |
| Ordered data blocks | At least one, serialized in caller order. | One `0x10` record per supplied payload. |
| Pause | Explicit unsigned 16-bit milliseconds. | Stored little-endian at the beginning of each block body. |
| Block data | Exact non-empty bytes including any flag/checksum bytes. | Stored verbatim after the declared 16-bit length. |
| Block length | Derived from supplied data, never trusted as an external input. | Recomputed little-endian 16-bit field. |

The writer does not manufacture Spectrum or CPC header/data pairs, flags, XOR checksums, loading addresses, timing traces, names, or pulse samples. Those are semantic-level inputs and must be supplied by a later explicitly scoped compiler/encoder contract. The first fixture uses a deliberately synthetic standard-data byte sequence only to prove byte framing and parser round trip; its comparison boundary is `not_applicable_blank_fixture`.

## Required byte and parser invariants

| Invariant | Native check | Independent cross-check |
| --- | --- | --- |
| File header | Exactly `ZXTape!\x1A`, major `1`, minor `20`. | TZX v1.20 header.[1] |
| Standard block ID | Exactly `0x10` for every first-wave generated block. | TZX standard-speed data block.[1] |
| Pause field | Two little-endian bytes, exact supplied value. | TZX standard-speed data block.[1] |
| Data length | Two little-endian bytes equal exact supplied data length. | TZX standard-speed data block.[1] |
| Payload | Exact supplied bytes, no pad, transform, or synthetic trailing checksum. | TZX standard-speed data block.[1] |
| Parser round trip | `parse_tzx_blocks` returns every record as `standard_data`, with exact body/data and no trailing bytes. | Existing typed scanner. |
| Extraction boundary | `extract_tzx` may expose a supported Spectrum header/data pairing; absent pairing remains raw typed tape evidence. | Existing extractor; no generic replay claim. |
| CDT presentation | The same bytes can be inspected under `.cdt`; no CPC semantics are inferred from extension alone. | CDT specification.[2] |

## Promotion ladder

| Status | Required deterministic evidence | Public wording |
| --- | --- | --- |
| `contract_only` | This contract, source crosswalk, and no native writer. | “TZX/CDT generation contract defined; no native output.” |
| `generated_structurally_valid` | Native first-wave writer, parser round trip, complete 17-digest record, truncation/malformed-input negatives, and explicit comparison boundary. | “Native generated TZX/CDT structure validated.” |
| `generated_extraction_verified` | Explicit compatible header/data inputs, extractor round trip, and byte equality of extracted member payloads. | “Native generated stream; supported member extraction verified.” |
| `authentic_comparison_recorded` | Retained authentic tape, per-block byte/layout comparison, and equality/difference record. | “Compared with retained authentic tape; see comparison record.” |
| `emulator_observed` | Above plus emulator name/version/configuration, command, trace/capture, and result. | “Load behavior observed under recorded emulator configuration.” |

## Public evidence and CI

The writer now joins the same canonical `daad_harvester.generator_evidence` collection used by the Extended DSK and ADF/OFS fixtures. The primary workflow regenerates and pins its output; the static report, Pages `#generators` route, and TUI Native Generators tab expose its ID, profile, all 17 checksums, validation record, supported extracted member, and explicit comparison boundaries. Generated bytes can be published only via the manifest-controlled artifact pipeline after their published copies are checksum-verified.

## References

[1]: https://worldofspectrum.net/TZXformat.html “TZX Format v1.20”

[2]: https://cpctech.cpcwiki.de/docs/cdt.html “Tape-Image (.CDT) file format”

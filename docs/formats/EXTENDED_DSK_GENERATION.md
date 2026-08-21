# Deterministic Extended DSK generation contract

| Header field | Value |
| --- | --- |
| **Question** | How does Harvester generate and validate a bounded Extended CPC DSK image without treating ADP output as an authority? |
| **Evidence scope** | P0 maintained Extended DSK definition; P1 deterministic native writer, validator, and fixtures; P2 pinned ADP source/output comparison; P3 authentic retained-release comparison; P4 emulator behavior where required. |
| **Status** | First bounded native fixture promoted as `generated_structurally_valid`; profile-specific populated filesystem generation and authentic-release comparison remain separate work. |
| **Implementation links** | `daad_harvester.dsk_generation`, `daad_harvester.generator_evidence`, `scripts/verify_native_generators.py`, `daad_harvester.media_inspection._inspect_cpc_dsk`, `daad_harvester.unpack.Unpacker.unpack_dsk`, `daad_harvester.report_export.StaticReportExporter`, `daad_harvester.tui.TUIDashboard`, `web/report-viewer/src/Home.tsx`. |
| **Non-claims** | A structurally valid DSK does not prove CP/M bootability, game equivalence, DAAD interpreter compatibility, or equality with a historic release. |

## Scope and first bounded output

The first native generator writes **Extended CPC DSK Rev.5** containers only. It accepts explicit track/side geometry, ordered formatted-track records, sector identifiers, sector sizes, payload bytes, creator text, and filler bytes. It does not infer geometry, filesystem, bootability, platform, interpreter, or game identity from a filename. The first generator may emit a blank or explicitly supplied sector map; it must not claim to construct a CPC, PCW, or Spectrum +3 CP/M filesystem until that filesystem layer has its own deterministic writer and comparison fixtures.

The Extended DSK definition requires a 256-byte disk-information block, track-size table, ordered track records, track information blocks, sector descriptors, and bounded payload lengths.[1] ADP’s pinned `dim_cpc.cpp` independently demonstrates named `cpc`, `pcw`, and `plus3` presets, but those presets are an implementation observation—not the native profile specification.[2]

The first promoted fixture is `extended-dsk-blank-cpc-system-v1`: a 194,816-byte, 40-track, single-sided, nine-sector-per-track Extended DSK stream. Its exact SHA-256 is `ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b`. `python scripts/verify_native_generators.py` rebuilds it, validates the pinned output hash, and independently recognizes its track stream. The evidence record carries the same complete 17-digest suite used for every retained artifact; it deliberately records `filesystem_claim: none` and a blank-fixture authentic-release comparison boundary.[3]

| Input field | Required rule | Deterministic treatment |
| --- | --- | --- |
| `tracks`, `sides` | Positive geometry within the native validator’s bound. | Serialized exactly at offsets `0x30` and `0x31`. |
| Ordered track records | One entry per `track × side`; unformatted tracks are explicit. | Track-size table uses 256-byte units; no omitted implicit records. |
| Sector descriptor | Track, side, ID, size code, FDC status, and exact data length. | Serialized in canonical supplied order; data length must equal payload length. |
| Sector payload | Exact byte sequence. | Preserved verbatim; no compression, padding guess, or reinterpretation. |
| Creator text | Explicit ASCII value at most 14 bytes. | Padded deterministically with zero bytes. |
| Filler byte | Explicit value for formatted sectors. | Used only when the supplied sector payload is intentionally generated as filler. |

## Mandatory invariants

The writer and validator must agree on the following invariants before an output can receive `generated_structurally_valid` status.

| Invariant | Native check | Independent comparison |
| --- | --- | --- |
| Container header | `EXTENDED CPC DSK File\r\nDisk-Info\r\n`, 256-byte header, declared geometry, bounded table. | Extended DSK definition.[1] |
| Track ordering | Track 0/side 0, Track 0/side 1 when present, then ascending tracks. | Extended DSK definition.[1] and ADP `CPC_CreateDisk` loop.[2] |
| Track size | Table entry equals full track bytes divided by 256; zero represents an unformatted track. | Extended DSK definition.[1] |
| Sector layout | `Track-Info\r\n`, descriptor table within 256-byte header, exact sector data lengths, no payload overflow. | Native inspector plus specification.[1] |
| Parser round trip | Native inspector recognizes the generated image and reports its exact geometry/layout. | `inspect_native_media`. |
| Extraction round trip | For a separately supported CP/M profile, native unpacking recovers exact committed fixture members. | `Unpacker.unpack_dsk`; no profile is assumed merely from container validity. |
| ADP observation | Optional ADP `dsk` listing/opening result is recorded with pinned revision and command. | ADP source/test record; never a promotion shortcut. |
| Authentic comparison | A retained real image is compared at byte, geometry, filesystem, and member levels. | Release manifest, complete checksums, and documented difference record. |

## Determinism and comparison record

Generation must depend only on committed inputs and explicit options. It must not use wall-clock time, locale, host filesystem ordering, random data, temporary paths, or an external program in the preservation-critical path. The record for each generated image must include input hashes, generator version, canonical JSON options, output checksums, inspector result, optional extractor result, ADP comparison observation, authentic-release comparison status, and the exact failure/reproducer when a condition is unmet.

The initial native DSK fixture is intentionally smaller than a historic game release. Its purpose is to prove container serialization and parser/extractor round trips. It cannot establish that an arbitrary commercial image’s mixed geometry, boot track, protection, or loader is generated correctly.

## Promotion ladder and public surfaces

| Status | Required evidence | Web/TUI wording |
| --- | --- | --- |
| `contract_only` | Documented grammar and unimplemented generator. | “Generation contract defined; no native output.” |
| `generated_structurally_valid` | Native writer output plus inspector round trip and complete checksums. | “Native generated container; structure validated.” |
| `generated_extraction_verified` | Structural result plus supported-profile member round trip. | “Native generated container; member extraction verified.” |
| `authentic_comparison_recorded` | Above plus recorded real-release comparison. | “Compared with retained authentic release; see difference/equality record.” |
| `emulator_observed` | Above plus retained emulator command, version, trace/capture, and result. | “Load behavior observed under recorded emulator configuration.” |

The static report exports `generator_evidence.generators`; the Pages portal exposes it at `#generators`; and the TUI exposes it as **Native Generators**. All three consume the canonical package evidence builder and render the same status, input/output checksums, generator options, technical-medium role, native validation, and comparison boundary. The web route shows every digest with a copy control. The TUI overview states the complete-digest count and its Up/Down integrity window traverses the complete digest set without terminal clipping. A production-style local Pages staging check loaded the route with the committed report and manifest data and confirmed the generator identifier, 17 digests, measured geometry, and non-claim boundary. Generated bytes become publicly downloadable only through the manifest-controlled public artifact pipeline.

## CI gate

The primary workflow must execute native generation and verify all promoted fixture hashes, native inspection, expected extraction result where applicable, schema export, generated-report consistency, documentation links, web build, and TUI rendering. An optional ADP comparison may add evidence but cannot make the primary workflow depend on an unpinned external binary or a network resource.

## References

[1]: https://cpctech.cpcwiki.de/docs/extdsk.html "Extended DSK image definition, Rev.5"

[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dim_cpc.cpp "Pinned ADP CPC disk implementation"

[3]: [`scripts/verify_native_generators.py`](../../scripts/verify_native_generators.py) "Deterministic native generator verifier"

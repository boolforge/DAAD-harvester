# Legacy DAAD Graphics DAT V2 Inspection

| Header field | Value |
| --- | --- |
| **Question** | Which retained `.DAT` bytes can be classified as legacy DAAD V2 graphics databases without inferring graphics payload semantics from an extension? |
| **Evidence scope** | P0 pinned ADP source; P1 original DAAD V2 manual; P2 retained corpus header bytes; P3 native Harvester structural inspector and regressions. |
| **Status** | Native bounded V2 header/table inspection is implemented for big- and little-endian signature candidates. Payload reconstruction, compression, palette rendering, format generation, and runtime equivalence remain outside the promoted boundary. |
| **Implementation links** | `daad_harvester.media_inspection._inspect_legacy_dat_v2`, `tests/test_legacy_dat_v2_inspection.py`, and pinned ADP `src-common/dmg.cpp` (`DMG_Open`, `DMG_ReadV2Entries`). |

## Recognition and table boundary

The retained ADP `DMG_Open` implementation selects legacy DAT V2 for a big-endian `0x0300` signature or a little-endian `0xFFFF` signature. Its V2 reader starts the fixed 256-record table at offset `0x000A`; each record is 48 bytes, so the first legal payload offset is `0x300A`.[1] The native inspector follows only those source-backed bounds. It recognizes the two signatures, checks the full fixed table exists, reads the declared size at offset `0x0006` in the selected byte order, and rejects every nonzero member offset below `0x300A` or at/after the file size.

| Field | Offset | Width | Current native treatment |
| --- | ---: | ---: | --- |
| Signature | `0x0000` | 2 | Recognize `0x0300` (big-endian) or `0xFFFF` (little-endian). |
| Declared file size | `0x0006` | 4 | Record in the signature’s byte order; a mismatch is preserved as evidence, matching ADP’s warning-only behavior. |
| Entry table | `0x000A` | 12,288 | Require all 256 × 48-byte records. |
| Member offset | record `+0x00` | 4 | Require `0` or an in-file offset at/after `0x300A`. |
| Flags | record `+0x04` | 2 | Count image/audio, buffered, and fixed flags without decoding their payloads. |

## Retained-corpus crosswalk

The retained corpus includes both V2 byte-order families. The following are source-classification candidates, not a claim that every payload decodes or renders correctly.

| Retained file | Size | Signature family |
| --- | ---: | --- |
| `depth1_863c7f50_PART1.DAT` | 12,298 | V2 big-endian candidate |
| `depth1_c1c0a02b_PART1.DAT` | 12,298 | V2 little-endian candidate |
| `depth2_d860243f_STT1.DAT` | 236,466 | V2 big-endian candidate |
| `depth1_83f16a8c_PART1.DAT` | 283,318 | V2 big-endian candidate |
| `depth1_c7afe732_PART2.DAT` | 293,506 | V2 big-endian candidate |

The two-byte `ACHTUNG.DAT` does not match this grammar and remains a separate observed artifact, not a malformed V2 claim.

## Explicit boundary and next evidence

This parser records `payload_boundary: offsets_only_no_length_or_codec_validation`. The ADP reader contains further logic for legacy RLE, platform image layouts, conversion palettes, and an Amiga palette marker; none is yet a Harvester format-support claim. A later wave must add retained-sample entry decoding, corruption cases, independent behavior comparison, format-specific generation input grammar, and byte/equivalence evidence before these records can become generated or runtime-compatible outputs.

## **Non-claims**

Recognition of a DAT V2 signature and its bounded entry table does **not** claim image-payload length recovery, RLE decompression, palette rendering, per-platform pixel conversion, audio decoding, target-interpreter acceptance, historical-release equivalence, or native generation. It also does not classify an extension-only or non-V2-signature `.DAT` artifact.

## References

[1]: http://www.rockersuke.com/if/ebbp/DAAD_Manual.pdf “DAAD Adventure Writer Version 2 Release 1 technical guide”

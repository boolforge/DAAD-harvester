# PCW DAAD DAT V1 Resource Directory

| Field | Value |
| --- | --- |
| **Question** | How can the legacy PCW DAAD V1 DAT directory be recognized and structurally validated without claiming an undocumented picture codec? |
| **Evidence scope** | P0 pinned ADP reader source; P1 retained Torreoscura PCW DAT artifacts; P2 native validator and corruption regression. |
| **Status** | Structural directory implementation. Picture payload decoding, resource length derivation, compression semantics, and the relationship to a sibling `.PIC` remain active support loops. |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../tests/test_media_inspection.py`](../../tests/test_media_inspection.py), [`CP/M DSK`](CPM_DSK.md). |
| **Non-claims** | A `.dat` extension alone does not establish PCW, DAAD, image-codec support, a rendered picture, or a relationship to a same-named `.PIC` file. |

## Evidence-backed directory contract

Pinned ADP source first identifies the PCW profile from a six-byte little-endian header: machine `0`, high-resolution mode `4`, and a picture count not greater than `256`. It then reads a fixed directory of 256 entries, each ten bytes wide, from offset `0x0006`; every nonzero resource offset must begin at or after `0x0A06`, immediately after the full directory.[1]

| Region | Offset | Size | Native validation |
| --- | ---: | ---: | --- |
| Header | `0x0000` | 6 bytes | Little-endian machine, screen mode, and picture count. |
| Directory | `0x0006` | 2,560 bytes | Exactly 256 ten-byte entries. |
| Entry | `0x0006 + 10n` | 10 bytes | 32-bit little-endian resource offset, 16-bit flags, signed 16-bit X, signed 16-bit Y. |
| Resource region | `0x0A06` | Variable | Nonzero offsets must fall within the retained DAT byte range. |

The native validator additionally requires the header’s picture count to equal the number of populated directory entries for this promoted PCW profile. It reports each validated resource reference but intentionally describes the payload codec as unresolved. This is stricter than a filename-based acceptance rule and does not infer a picture’s byte length from the next offset until that convention is independently evidenced.

## Retained Torreoscura PCW evidence

The source-253 PCW package contains two structurally validated DAT files. Their resource directories are internal to the DAT files. A sibling `PARTE000.PIC` is retained as a separate artifact, but its format and semantic relationship to these directory entries have not been established and are not implied here.

| Retained member | Size | Header picture count | Native result |
| --- | ---: | ---: | --- |
| `PARTE001.DAT` | 102,144 bytes | 20 | `validated_pcw_v1_resource_directory` |
| `PARTE002.DAT` | 38,528 bytes | 10 | `validated_pcw_v1_resource_directory` |
| `PARTE000.PIC` | 16,000 bytes | Not yet decoded | Retained, explicitly unresolved picture-resource profile. |

## Rejection behavior and next evidence

The native inspector rejects a truncated fixed directory, invalid machine/mode/count header, any nonzero resource offset before `0x0A06`, any offset outside the file, and a declared-count/directory-population mismatch. The retained-artifact regression covers both Torreoscura DAT files and a synthetic offset-before-directory corruption case.

The next closure steps are to derive the resource payload grammar and lengths, identify any compression or pixel-plane encoding, decode and validate `PARTE000.PIC`, and establish only evidence-backed DDB/DAT/PIC cross-file references. No rendering, codec, or bundled-resource claim is currently promoted.

## References

[1]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dmg.cpp#L1174-L1334 "Pinned ADP PCW DAT V1 reader and profile detector"

# PCW DAAD DAT V1 Resource Directory

| Field | Value |
| --- | --- |
| **Question** | How can the legacy PCW DAAD V1 DAT directory be recognized and structurally validated without claiming an undocumented picture codec? |
| **Evidence scope** | P0 pinned ADP reader source; P1 retained Torreoscura PCW DAT artifacts; P2 native validator and corruption regression. |
| **Status** | Structural directory, per-resource-header, and native PCW DAT image-decoding implementation. The relationship to a sibling `.PIC` remains an active support loop. |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../tests/test_media_inspection.py`](../../tests/test_media_inspection.py), [`CP/M DSK`](CPM_DSK.md). |
| **Non-claims** | A `.dat` extension alone does not establish PCW, DAAD, image-codec support, a rendered picture, or a relationship to a same-named `.PIC` file. |

## Evidence-backed directory contract

Pinned ADP source first identifies the PCW profile from a six-byte little-endian header: machine `0`, high-resolution mode `4`, and a picture count not greater than `256`. It then reads a fixed directory of 256 entries, each ten bytes wide, from offset `0x0006`; every nonzero resource offset must begin at or after `0x0A06`, immediately after the full directory.[1]

| Region | Offset | Size | Native validation |
| --- | ---: | ---: | --- |
| Header | `0x0000` | 6 bytes | Little-endian machine, screen mode, and picture count. |
| Directory | `0x0006` | 2,560 bytes | Exactly 256 ten-byte entries. |
| Entry | `0x0006 + 10n` | 10 bytes | 32-bit little-endian resource offset, 16-bit flags, signed 16-bit X, signed 16-bit Y. |
| Resource region | `0x0A06` | Variable | Nonzero offsets must point to a complete six-byte resource header and its bounded payload. |

Every referenced resource begins with a six-byte little-endian internal header: width (high bit means compressed), height (high bit means audio), and payload length. The native validator requires each complete payload to remain in bounds; image entries must have nonzero dimensions and length, with dimensions no greater than 1,024. The header’s picture count must equal the number of populated directory entries for this promoted PCW profile. This is stricter than a filename-based acceptance rule and does not infer a resource’s byte length from the next directory offset.

## Retained Torreoscura PCW evidence

The source-253 PCW package contains two structurally validated DAT files. Their resource directories are internal to the DAT files. A sibling `PARTE000.PIC` is retained as a separate artifact, but its format and semantic relationship to these directory entries have not been established and are not implied here.

| Retained member | Size | Header picture count | Native result |
| --- | ---: | ---: | --- |
| `PARTE001.DAT` | 102,144 bytes | 20 | `validated_pcw_v1_resource_directory` |
| `PARTE002.DAT` | 38,528 bytes | 10 | `validated_pcw_v1_resource_directory` |
| `PARTE000.PIC` | 16,000 bytes | Not yet decoded | Retained, explicitly unresolved picture-resource profile. |

The PIC size alone is insufficient to identify a PCW screen profile. An independent PCW video-memory reference describes a native 720×256 monochrome image with roller-RAM line addressing, which does not match an unqualified 16,000-byte full-frame claim.[3] The file is therefore not routed through the DAT resource decoder or labelled a raw PCW screen.

## Rejection behavior and next evidence

The native inspector rejects a truncated fixed directory, invalid machine/mode/count header, any nonzero resource offset before `0x0A06`, any offset outside the file, and a declared-count/directory-population mismatch. The retained-artifact regression covers both Torreoscura DAT files and a synthetic offset-before-directory corruption case.

Native Harvester now implements the pinned ADP PCW-specific byte-stream decompressor, the monochrome storage-layout reconstruction, and deterministic expansion to four-bit packed pixels.[2] All 30 retained Torreoscura DAT image entries—24 compressed and 6 uncompressed—validate to 23,040 packed-pixel bytes for their measured 640×72 geometry. The next closure steps are to decode and validate `PARTE000.PIC` and establish only evidence-backed DDB/DAT/PIC cross-file references. No relationship between the standalone PIC file and these DAT entries is currently promoted.

## References

[1]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dmg.cpp#L1174-L1334 "Pinned ADP PCW DAT V1 reader and profile detector"
[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/dmg_imgc.cpp#L8-L123 "Pinned ADP PCW resource decompression and pixel-layout conversion"
[3]: https://github.com/Zigazou/amstrad-pcw-technical-info/blob/master/video-memory/README.md "Amstrad PCW video memory and controller"

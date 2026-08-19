# CP/M DSK: CPC, PCW, and Related Amstrad Media

| Header field | Value |
| --- | --- |
| **Question** | How are CPC/PCW disk images recognized, geometrically bounded, traversed, and preserved without mistaking CP/M extents for FAT files? |
| **Evidence scope** | P0 Amstrad CP/M format documentation; P1 Harvester DSK/CP-M extraction tests. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/unpack.py`](../../daad_harvester/unpack.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../tests/test_unpack.py`](../../tests/test_unpack.py) |
| **Non-claims** | A `.dsk` suffix, disk size, or one directory name does not prove CPC, PCW, +3DOS profile, valid file content, or runtime identity. |

## Recognition and geometry first

Harvester recognizes standard and extended CPC DSK signatures, then reads track/sector descriptors before directory/extent interpretation. A valid signature alone is insufficient: every track offset, declared size, sector map, and logical sector relationship must remain bounded by the image.[1]

| Stage | Required decision | Failure result |
| --- | --- | --- |
| Container | Standard/extended DSK header and declared track layout. | `rejected` with header/track-range reason. |
| Geometry | Track header, sector descriptors, and sector spans. | Retain image; emit no guessed sector tree. |
| CP/M profile | In-media XDPB/allocation/extent rules appropriate to documented layout. | `recognized_evidence` when geometry exists but profile is unresolved. |
| File assembly | Bounded extent allocation and deduplicated member path. | Reject looping/out-of-range/incomplete extents. |

## CPC/PCW separation

The same broad CP/M family can appear across CPC, PCW, and related Amstrad disk contexts, but target identity belongs to the platform dossier and runtime profile—not to the DSK parser. The parser reports media geometry/profile evidence; the report composes it with `cpc` or `pcw` runtime/DDB/bundle evidence only after independent validation.[1] [2]

## Provenance and preservation

Extracted members retain image hash, track/sector/extent provenance, parser status, and original directory name. Nonstandard/protected/unresolved layouts retain their original image and structured geometry evidence. This keeps a future implementation from silently translating CP/M media into falsely authoritative host files.

## References

[1]: https://www.seasip.info/Cpm/amsform.html "Amstrad CP/M disc formats"
[2]: [Amstrad CPC dossier](../platforms/AMSTRAD_CPC.md); [Amstrad PCW dossier](../platforms/AMSTRAD_PCW.md)

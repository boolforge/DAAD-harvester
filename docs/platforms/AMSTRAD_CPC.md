# Amstrad CPC Dossier

| Header field | Value |
| --- | --- |
| **Question** | What CPC-specific runtime, tape/disk, and provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official distribution/profile anchors and CPC/CDT/CP-M documentation; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../formats/CPM_DSK.md`](../formats/CPM_DSK.md) |
| **Non-claims** | CPC is one peer canonical target. A DSK/CDT extension, a `DCPCI*` filename, or target ID `0x03` is insufficient for an unqualified historical claim. |

## Target evidence

The official-profile ledger records English `dcpcie.z80` and Spanish `dcpcis.z80` hash anchors for `cpc`.[1] DRC maps the CPC target to machine ID `0x03` and its own default base address `0x2880`; both are compiler-contract data, not an original-runtime identity.[2]

| Evidence layer | CPC-specific observation | Report effect |
| --- | --- | --- |
| Runtime | Exact `DCPCI*` profile hash. | Verified original runtime anchor. |
| DDB | DRC CPC target fields plus bounded parser validation. | Compiler-compatible structural evidence. |
| Tape | CDT/TZX typed block stream. | Preserve both reconstructable data and timing/control evidence. |
| Disk | Standard/extended CPC DSK geometry and CP/M directory/extent traversal. | Emit files only after geometry and bounds validation. |

## Preservation procedure

CPC DSK processing begins with the disk/track geometry and sector descriptors, then applies the CP/M family’s bounded directory/extent rules. CPC, PCW, and +3DOS-like media must remain distinguishable by their in-media evidence; a `.dsk` suffix alone does not select a filesystem profile.[3]

The dossier links to [CP/M DSK](../formats/CPM_DSK.md) and [tape streams](../formats/TAPE_STREAMS.md) for media detail, [DDB generations](../versions/DDB_GENERATIONS.md) for the target field, and the [profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md) for hash anchors.

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: https://www.seasip.info/Cpm/amsform.html "Amstrad CP/M disc formats"; https://cpctech.cpcwiki.de/docs/cdt.html "CDT format specification"

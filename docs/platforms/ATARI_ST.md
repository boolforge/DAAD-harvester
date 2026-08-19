# Atari ST Dossier

| Header field | Value |
| --- | --- |
| **Question** | What Atari ST-specific runtime, FAT-image, and protected-media provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and STX/IPF references; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../formats/ATARI_PROTECTED_MEDIA.md`](../formats/ATARI_PROTECTED_MEDIA.md) |
| **Non-claims** | A STX/IPF recognition result does not reconstruct protected sectors or identify a runtime; an ST/MSA filesystem result does not establish an original release. |

## Target evidence

The official ledger contains four Atari ST anchors: English `edi1.prg`/`edi2.prg` and Spanish `sdi1.prg`/`sdi2.prg`.[1] DRC assigns target `ST` ID `0x05` and treats its target’s external-vector words as little-endian; this is compiler output evidence only.[2]

| Media family | Atari ST report rule |
| --- | --- |
| ST/MSA | Validate/decompress image and FAT structures before extracting files. |
| STX | Recognize Pasti `RSY`/track metadata and retain it as protected-media evidence. |
| IPF | Preserve format identity and metadata when full sector/file reconstruction is unavailable. |
| Runtime | Profile-hash separately from media result and DDB structural result. |

## Preservation procedure

For protected formats, the preservation success condition is accurate structured retention, not an invented DOS/FAT view. The scanner must state whether it recognized the format, validated available bounds/metadata, extracted members, or deliberately retained evidence only.[3]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: http://justsolve.archiveteam.org/wiki/STX "STX preservation reference"; http://fileformats.archiveteam.org/wiki/IPF "IPF format registry"

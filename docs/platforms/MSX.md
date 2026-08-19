# MSX Dossier

| Header field | Value |
| --- | --- |
| **Question** | What MSX-specific runtime, cassette/disk/ROM, and derivative-provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors, public MSX2DAAD source, and MSX media evidence; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../derivatives/MSX2DAAD.md`](../derivatives/MSX2DAAD.md) |
| **Non-claims** | MSX2DAAD compatibility does not establish original MSX interpreter identity, and a ROM header does not resolve a mapper/loader without measured evidence. |

## Target evidence

The official-profile ledger anchors `msxedi.z80` (English) and `msxsdi.z80` (Spanish) for canonical `msx`.[1] DRC separates `MSX` target ID `0x04` from its `MSX2` target ID `0x0F`; an MSX2 target byte is compiler-output evidence rather than a generic MSX2 machine proof.[2]

| Media form | MSX preservation rule |
| --- | --- |
| CAS | Parse record framing conservatively; preserve unresolved record/loader evidence. |
| FAT disk image | Traverse FAT only after bounded boot/cluster/root validation. |
| ROM | Record header evidence and unresolved mapper conditions separately. |
| MSX2DAAD bundle | Record public derivative identity/compatibility independently from original profiles. |

## Preservation procedure

An MSX record should retain DDB structural evidence, exact original-profile result (if any), and public derivative association as three separate claims. This protects artifacts whose DDB may be structurally V2/V3 while the executable is an independent MSX2DAAD build or an unknown loader.[3]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: [MSX2DAAD derivative dossier](../derivatives/MSX2DAAD.md)

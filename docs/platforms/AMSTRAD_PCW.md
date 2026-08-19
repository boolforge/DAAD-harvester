# Amstrad PCW Dossier

| Header field | Value |
| --- | --- |
| **Question** | What PCW-specific runtime and CP/M-media provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and Amstrad CP/M documentation; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/interpreter_profiles.py`](../../daad_harvester/interpreter_profiles.py), [`../formats/CPM_DSK.md`](../formats/CPM_DSK.md) |
| **Non-claims** | A CP/M-like disk image or PCW language filename cannot prove one PCW interpreter binary without the profile protocol. |

## Target evidence

The official profile ledger supplies `pcwedi.bin` (English) and `pcwsdi.bin` (Spanish) exact anchors for canonical `pcw`.[1] DRC’s PCW target contract uses machine ID `0x07` and default base address `0x0100`; these are structural compiler facts, not a complete operating-system/media profile.[2]

| Evidence layer | PCW-specific report rule |
| --- | --- |
| Runtime | Exact profile matching identifies only the captured PCW binary. |
| Disk | Identify XDPB/profile geometry from in-media values before CP/M traversal. |
| Language | Preserve profile language separately from DDB low-bit/language interpretation. |
| DDB | Retain target/generation measurement separately from disk extraction. |

## Preservation procedure

The PCW dossier delegates geometry, directory, extent, and extraction rules to [CP/M DSK](../formats/CPM_DSK.md). A valid DSK container with unresolved layout remains a recognized evidence object rather than a silently misparsed filesystem. This gives PCW equal treatment with CPC and ZX +3-oriented CP/M media while preserving the platform/runtime distinction.[3]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: https://www.seasip.info/Cpm/amsform.html "Amstrad CP/M disc formats"

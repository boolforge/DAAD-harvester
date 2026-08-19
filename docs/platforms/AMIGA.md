# Amiga Dossier

| Header field | Value |
| --- | --- |
| **Question** | What Amiga-specific runtime, disk/archive, and filesystem provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and ADF/DMS documentation; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/dms.py`](../../daad_harvester/dms.py), [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../formats/AMIGA_MEDIA.md`](../formats/AMIGA_MEDIA.md) |
| **Non-claims** | ADF/ADZ/DMS recognition, filesystem extraction, or DRC `AMIGA` structure does not establish unmodified original runtime identity or a complete protected-disk reconstruction. |

## Target evidence

The official profile ledger records English `edi1`/`edi2` and Spanish `sdi1`/`sdi2` hashes, including `.prg` filename aliases, for canonical `amiga`.[1] DRC assigns machine ID `0x06` and marks its target’s external-vector words little-endian; this does not generalize to all Amiga data structures.[2]

| Media form | Amiga preservation rule |
| --- | --- |
| ADF | Retain raw sector image identity; validate AmigaDOS block references/checksums before emitting files. |
| ADZ | Record decompression relation to the preserved compressed member and its extracted ADF. |
| DMS | Validate archive/track framing, compression, and checksums before emitting a reconstructed ADF. |
| IPF | Preserve protected-media metadata/evidence if full decoding is not supported. |

## Preservation procedure

Amiga records preserve container, decompression result, raw ADF, filesystem traversal, DDB result, and runtime result as separate graph nodes. A raw ADF signature or expected size is not proof of a valid OFS/FFS directory extraction; likewise, valid DMS syntax is not proof every track safely reconstructs.[3] [4]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: http://lclevy.free.fr/adflib/adf_info.html "ADF format FAQ"
[4]: https://github.com/mlund/xdms-rs "xDMS reference implementation"

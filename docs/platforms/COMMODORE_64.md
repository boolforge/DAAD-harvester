# Commodore 64 Dossier

| Header field | Value |
| --- | --- |
| **Question** | What C64-specific runtime, program/container, and provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and CBM format documentation; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../formats/CBM_DISK_AND_PROGRAM.md`](../formats/CBM_DISK_AND_PROGRAM.md) |
| **Non-claims** | A PRG/P00/T64/G64/TAP member or `EDI64`/`SDI64` name does not, by itself, establish an original runtime or DDB generation. |

## Target evidence

The official profile ledger anchors English `edi64.prg` and Spanish `sdi64.prg` for canonical `c64` runtime identity.[1] DRC target ID `0x02` and base address `0x3880` are public compiler-output facts; they are not a substitute for exact runtime hashes.[2]

| Media/provenance item | C64 handling rule |
| --- | --- |
| PRG/P00 | Preserve load/header wrapper evidence and program bytes as distinct observations. |
| T64 | Traverse directory entries only after declared offsets and lengths validate. |
| Disk image | Preserve sector/filesystem results with the image identity. |
| CBM TAP/G64 | Treat pulse/GCR media as low-level evidence; never fabricate filesystem members from an unsupported reconstruction. |

## Preservation procedure

C64 artifacts often place presentation/load information in wrappers or tape/disk structure rather than in the DDB body. Harvester preserves outer container, normalized extracted member, original member name, and target identity separately. This supports later emulator or ScummVM analysis without discarding loader provenance.[3]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: https://vice-emu.sourceforge.io/vice_17.html "VICE CBM file-format reference"

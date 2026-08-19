# IBM PC/DOS Dossier

| Header field | Value |
| --- | --- |
| **Question** | What IBM PC/DOS-specific runtime, FAT/executable, and derivative-provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and public PCDAAD source; P1 FAT/MZ parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../formats/FAT_MEDIA.md`](../formats/FAT_MEDIA.md) |
| **Non-claims** | A DOS executable, MZ header, FAT directory, PCDAAD run, or DRC PC target field does not establish an original DOS interpreter or universal compatibility. |

## Target evidence

The official ledger lists an English/Spanish `INTE*`/`INTS*` family of exact DOS runtime anchors, including CGA and other named variants.[1] DRC target `PC` has ID `0x00`, while the `PC` `VGA256` subtarget and `HTML` are an explicit `0x0D` compiler exception for derivative-oriented output.[2]

| Evidence layer | DOS-specific report rule |
| --- | --- |
| Runtime | Hash against the detailed official DOS family; retain exact variant profile ID. |
| FAT media | Validate boot/FAT/root/cluster-chain bounds and loops before export. |
| MZ EXE | Record arithmetic/header evidence; do not equate MZ validity with DAAD identity. |
| PCDAAD | Report its public, explicitly non-equivalent VGA/SVGA behavior as derivative evidence. |

## Preservation procedure

DOS bundles may include DDB, interpreter, fonts, images, batch files, and installers. Harvester preserves their exact names, hashes, and filesystem relationship while keeping DDB structural parsing and runtime identity independent. PCDAAD may be an optional public behavior reference, but its own stated unsupported features must be surfaced rather than hidden.[3]

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: [PCDAAD derivative dossier](../derivatives/PCDAAD.md)

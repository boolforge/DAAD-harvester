# Commodore Plus/4 Dossier

| Header field | Value |
| --- | --- |
| **Question** | What Plus/4-specific runtime, program/container, and provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official profile anchors and DRC/source documentation; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/interpreter_profiles.py`](../../daad_harvester/interpreter_profiles.py), [`../formats/CBM_DISK_AND_PROGRAM.md`](../formats/CBM_DISK_AND_PROGRAM.md) |
| **Non-claims** | Plus/4 must not be collapsed into C64. Shared Commodore wrappers or a C64-like disk path do not establish C64 runtime compatibility. |

## Target evidence

The official profile ledger contains exact English `ediplus4.prg` and Spanish `sdiplus4.prg` anchors. It also deliberately retains an extensionless historical `ediplus4` name as filename-only evidence, which cannot become verified without a measured official hash.[1]

DRC uses target `CP4` for Commodore Plus/4, assigns it machine ID `0x0E`, and documents default base address `0x7080`; this is a compiler-specific output contract.[2]

| Evidence layer | Plus/4 rule |
| --- | --- |
| Runtime | Resolve exact hash within `plus4`; never borrow a same-named C64 profile. |
| DDB | Treat DRC `CP4` evidence as target-structure affinity only. |
| Program/container | Retain PRG/P00/CBM tape/disk wrapper context before normalizing extracted bytes. |
| Historical extensionless name | Record as strong filename evidence, never verified identity. |

## Preservation procedure

Plus/4 reports must name the canonical target as `plus4`, even where a storage wrapper resembles a Commodore 64 family representation. The output’s `library/plus4/<game>/ready_to_use/` classification is based on accumulated evidence, not a filename shortcut.

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [DRC DDB-generation contract](../versions/DDB_GENERATIONS.md)
[3]: https://vice-emu.sourceforge.io/vice_17.html "VICE CBM file-format reference"

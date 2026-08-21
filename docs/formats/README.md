# Media and Container Formats Index

**Question:** How is one media/container family recognized, bounded, validated, extracted, or preserved as structured evidence?

| Module | Single responsibility | Status |
| --- | --- | --- |
| [Tape streams](TAPE_STREAMS.md) | TAP, TZX/CDT, CBM TAP, CAS/TSX boundaries. | Implementation contract |
| [CBM disk and program media](CBM_DISK_AND_PROGRAM.md) | D64/D71, T64, P00/PRG, G64 preservation evidence. | Implementation contract |
| [CP/M DSK](CPM_DSK.md) | CPC/PCW DSK and allocation/extent rules. | Implementation contract |
| [Extended DSK generation](EXTENDED_DSK_GENERATION.md) | Deterministic Extended DSK writer, validator, comparison, and public-evidence contract. | Implementation contract |
| [FAT media](FAT_MEDIA.md) | FAT12/FAT16, VFAT, MSX/Atari/DOS media. | Implementation contract |
| [Amiga media](AMIGA_MEDIA.md) | ADF/ADZ/DMS and OFS/FFS boundaries. | Implementation contract |
| [Atari protected media](ATARI_PROTECTED_MEDIA.md) | STX/Pasti and IPF preservation evidence. | Implementation contract |
| [Archive wrappers](ARCHIVE_WRAPPERS.md) | Recursive archive/container safety contract. | Contract plus open native-decoder gates |
| [Executable and snapshot evidence](EXECUTABLE_AND_SNAPSHOT_EVIDENCE.md) | MZ/COM, ROM, and snapshot structural-only handling. | Implementation contract |
| [Capability matrix](FORMAT_CAPABILITY_MATRIX.md) | Cross-family implementation/release gate; not a byte-format manual. | Maintained matrix |

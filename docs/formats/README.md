# Media and Container Formats Index

**Question:** How is one media/container family recognized, bounded, validated, extracted, or preserved as structured evidence?

| Module | Single responsibility | Status |
| --- | --- | --- |
| [Tape streams](TAPE_STREAMS.md) | TAP, TZX/CDT, CBM TAP, CAS/TSX boundaries. | Implementation contract |
| [TZX/CDT generation](TZX_CDT_GENERATION.md) | Deterministic standard-speed TZX/CDT writer, validation, comparison, and publication contract. | Generation contract |
| [Legacy `.CHR` generation](DAAD_CHR_GENERATION.md) | Fixed-size DAAD character-set container, opaque-prefix boundary, corpus comparison, and promotion requirements. | Structural implementation |
| [Legacy DAT V2 inspection](LEGACY_DAT_V2.md) | Endian-aware legacy graphics database header/table validation with retained-corpus crosswalk and explicit payload boundary. | Structural implementation |
| [CBM disk and program media](CBM_DISK_AND_PROGRAM.md) | D64/D71, T64, P00/PRG, G64 preservation evidence. | Implementation contract |
| [CP/M DSK](CPM_DSK.md) | CPC/PCW DSK and allocation/extent rules. | Implementation contract |
| [Extended DSK generation](EXTENDED_DSK_GENERATION.md) | Deterministic Extended DSK writer, validator, comparison, and public-evidence contract. | Implementation contract |
| [FAT media](FAT_MEDIA.md) | FAT12/FAT16, VFAT, MSX/Atari/DOS media. | Implementation contract |
| [Amiga media](AMIGA_MEDIA.md) | ADF/ADZ/DMS and OFS/FFS boundaries. | Implementation contract |
| [Amiga ADF/OFS generation](AMIGA_ADF_GENERATION.md) | Deterministic blank ADF/OFS writer, validation, comparison, and publication contract. | Generation contract |
| [Atari protected media](ATARI_PROTECTED_MEDIA.md) | STX/Pasti and IPF preservation evidence. | Implementation contract |
| [Archive wrappers](ARCHIVE_WRAPPERS.md) | Recursive archive/container safety contract. | Contract plus open native-decoder gates |
| [Executable and snapshot evidence](EXECUTABLE_AND_SNAPSHOT_EVIDENCE.md) | MZ/COM, ROM, and snapshot structural-only handling. | Implementation contract |
| [Capability matrix](FORMAT_CAPABILITY_MATRIX.md) | Cross-family implementation/release gate; not a byte-format manual. | Maintained matrix |

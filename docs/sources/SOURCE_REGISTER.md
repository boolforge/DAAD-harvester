# Preservation Source Register

## Purpose

This register records sources used for discovery, implementation, or documentation. A source’s inclusion does not imply that it is unrestricted, complete, or a direct-download contract. The source adapter records its own observed accessibility and errors at run time.

| Source | Role | Platform/media coverage | Use boundary |
| --- | --- | --- | --- |
| [Official DAAD distribution][1] | Primary runtime/template/release source | All canonical targets | Used for measured interpreter hashes and release context; source code does not supply interpreter source. |
| [Official changelog][2] | Release chronology | R2–R5 | Used for release history, never to assign a game’s binary version. |
| [World of Spectrum TZX spec][3] | Tape format specification | ZX TZX and CPC CDT representation | Used for typed block boundaries and control evidence. |
| [VICE format reference][4] | Commodore format reference | TAP, T64, D64, G64 | Used to separate pulse/GCR evidence from named-file extraction. |
| [Pasti/STX documentation][5] | Protected Atari media | Atari STX | Used for track, fuzzy-mask, timing, and status evidence. |
| [SPS/IPF registry][6] | Preservation container identification | IPF | Used only for initial CAPS record recognition. |
| [MSX2 Technical Handbook][7] | Hardware/cartridge contract | MSX ROM | Used for standard cartridge-header evidence. |
| [MSX Game Library][8] | ROM layout explanation | MSX ROM | Used to document legal header page origins and page mapping. |
| [MSX2DAAD][9] | Derivative documentation | MSX2/MSX2+ | Used for documented compatibility and behavioral differences. |
| [PCDAAD][10] | Derivative documentation | DOS | Used for documented compatibility limits and runtime conventions. |
| [Maluva and DRC][11] | Compiler/extension documentation | Multi-target | Used to distinguish DRC and Maluva roles. |
| [Uto project index][12] | Tool taxonomy | Multi-target | Used to classify packaging, extractor, migration, and editor tools. |

## Operational source policy

Direct downloads are admitted only when the source adapter has a current, permitted direct-media contract. Catalog-only pages remain valuable for citation and title/platform evidence but are not silently promoted to media evidence. When a source fails, changes structure, or rejects automated access, the failure is recorded rather than bypassed.

## References

[1]: https://github.com/daad-adventure-writer/daad "Official DAAD distribution"
[2]: https://github.com/daad-adventure-writer/daad/blob/master/CHANGELOG.md "Official DAAD changelog"
[3]: https://worldofspectrum.net/TZXformat.html "TZX technical specifications"
[4]: https://vice-emu.sourceforge.io/vice_17.html "VICE emulator file format reference"
[5]: http://atari.8bitchip.info/STXdesc.html "Pasti/STX floppy image format"
[6]: http://fileformats.archiveteam.org/wiki/IPF "IPF file format registry"
[7]: https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter5b.html "MSX2 Technical Handbook: Slots and Cartridges"
[8]: https://aoineko.org/msxgl/index.php?title=Create_a_plain_ROM "MSX Game Library: Create a plain ROM"
[9]: https://github.com/nataliapc/msx2daad "MSX2DAAD"
[10]: https://github.com/Utodev/PCDAAD "PCDAAD"
[11]: https://medium.com/@uto_dev/maluva-and-drc-e1f655f9cff1 "Maluva and DRC"
[12]: https://uto.speccy.org/ "Uto project index"

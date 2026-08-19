# Platform Runtime and Media Guide

## Canonical target vocabulary

The official DAAD distribution names ZX Spectrum, Amstrad CPC, Commodore 64, Plus/4/C16 64K, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS as target families.[1] Harvester stores these canonical identifiers: `zx`, `cpc`, `c64`, `plus4`, `msx`, `pcw`, `atarist`, `amiga`, and `dos`.

| Canonical target | Typical runtime evidence | Native media evidence handled | Current preservation posture |
| --- | --- | --- | --- |
| ZX Spectrum | DS48IE/DS48IS profile hashes; compact/DRC DDB structure | TAP, TZX, +3DOS wrapper evidence | Extract data blocks; preserve control/pulse evidence. |
| Amstrad CPC | DCPCIE/DCPCIS hashes | Standard/extended CPC DSK, CDT | Validate tracks/sectors and CP/M members. |
| Commodore 64 | EDI64/SDI64 hashes | D64, T64, PRG, P00, CBM TAP, G64 | Extract sector/tape-directory media; preserve low-level TAP/G64 evidence. |
| Commodore Plus/4 | EDIPLUS4/SDIPLUS4 hashes | D64/D71-compatible archive paths, PRG, P00, CBM TAP | Preserve machine identity and wrapper/load evidence. |
| MSX | MSXEDI/MSXSDI hashes | CAS, FAT disk images, ROM | Parse cassette/FAT members; record AB ROM header and unresolved mapper evidence. |
| Amstrad PCW | PCWEDI/PCWSDI hashes | CP/M/FAT-like retained disk media | Use bounded filesystem and DDB evidence. |
| Atari ST | EDI/SDI hash profiles | ST, MSA, STX, IPF | Extract FAT/ MSA material; retain protected-track metadata without fictitious sector recovery. |
| Amiga | EDI1/EDI2/SDI1/SDI2 hashes | ADF, ADZ, DMS, IPF | Traverse Amiga file and extension blocks; validate DMS tracks before emitting ADF output. |
| IBM PC/DOS | INTE/INTS family hashes | FAT12/FAT16, COM, MZ EXE | Extract bounded filesystem trees; record MZ header arithmetic. |

## Evidence hierarchy

Platform identity can come from a validated DDB target field, a same-platform exact interpreter hash, or native-media structure. It must not be inferred solely from an archive filename. A low-level protected format is retained even when it cannot be expanded safely, because its pulse, GCR, fuzzy-bit, timing, or protection metadata is itself preservation evidence.

| Confidence | Example | Meaning |
| --- | --- | --- |
| `verified` | Exact runtime SHA-256 or structurally valid DDB | Measured facts support the exact statement. |
| `strong` | Original member runtime filename with unmatched bytes | Useful qualified bundle evidence; byte identity remains unproved. |
| `recognized_evidence` | Valid STX/IPF/TAP/G64 container | Container is structurally recognized but not misrepresented as extracted files. |
| `rejected` | Invalid CRC, geometry, pointer chain, or block length | Input is retained/logged, but produces no trusted member. |

## Format-level rules

The [format capability matrix](../formats/FORMAT_CAPABILITY_MATRIX.md) is the detailed contract. Its universal requirements are bounded parsing, declared-length validation, cycle detection, checksum/geometry verification where specified, and separate evidence for wrappers and extracted children.

> **No silent conversion rule.** A valid Pasti STX or SPS IPF image can preserve copy-protection-relevant metadata. Converting it to a generic filesystem view without a validated decoder would lose evidence, so Harvester records the structure instead.[2] [3]

## References

[1]: https://github.com/daad-adventure-writer/daad "Official DAAD distribution"
[2]: http://atari.8bitchip.info/STXdesc.html "Pasti/STX floppy image format"
[3]: http://fileformats.archiveteam.org/wiki/IPF "IPF file format registry"

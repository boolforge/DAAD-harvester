# Commodore Runtime Resources for Loader Reconstruction

| Field | Value |
| --- | --- |
| **Purpose** | Deterministic C64 and Plus/4 runtime reconstruction for DAAD loader packages that cannot be resolved from static member scans alone. |
| **Authorization** | Universal institutional authorization; see [`AUTHORIZATION_AND_HANDLING.md`](../../../docs/reverse_engineering/AUTHORIZATION_AND_HANDLING.md). |
| **Machine-readable inventory** | [`manifest.json`](manifest.json) |
| **Runtime emulator** | VICE `x64sc` 3.7.1, used only in bounded, local, scripted sessions. |

## Directive and reproducibility boundary

All firmware, emulator configuration, execution captures, and derived RAM images in this directory are retained under the project’s universal institutional preservation authorization. Every resource has a source/build route, SHA-256, target role, and reproducible execution context in [`manifest.json`](manifest.json). Authorization permits use; it does not collapse the distinction between an original game image, a firmware dependency, a RAM capture, and a reverse-engineering inference.

The C64 BASIC and KERNAL images are built from the pinned, committed [`source/c64rom/`](source/c64rom/) mirror and were compared byte-for-byte to independent archived binaries. The character ROM and Plus/4 ROMs are retained directly from the primary preservation archive. The `C64` symbolic link exists solely because VICE resolves C64 system files under a machine-named subdirectory of its configured search root.

VICE resolves the retained Plus/4 PAL system files below a `PLUS4` machine directory, using `kernal-318004-05.bin` and `basic-318006-01.bin`. The retained `plus4` directory preserves the primary archive filenames; the corresponding `PLUS4` directory and VICE-default names are symbolic links only. This arrangement keeps byte identity, source naming, and emulator compatibility independently visible. [1] [5]

The Plus/4 path now boots reproducibly with the retained BASIC, KERNAL, and both 3-Plus-1 function ROMs. The project also retains the primary 1541C DOS ROM used for hardware-level serial-drive tests. The retained `EDIPLUS4` loader decodes to `1 SYS2063:REM`, with a machine-code jump from `$080f` to `$356b`. Its D64 directory has been independently listed as containing `EDIPLUS4`; nevertheless, the hardware-emulated Plus/4 run currently reports `FILE NOT FOUND` for that entry. The complete logs, screen captures, snapshots, command transcripts, and static BASIC evidence are retained as a reproducible media/target-interaction loop, not presented as a completed execution result.

## Bounded C64 loader capture

The Jabato C64 D64 was run with the retained ROM resources, VICE virtual IEC drive traps, a fixed local monitor address, and an explicit cycle ceiling. The title screen was advanced by a single space input. The resulting screenshot, VICE snapshot, exact 64 KiB `C64MEM` RAM range, monitor transcript, and structural DDB-candidate report are retained under [`../../derived/commodore_loader/vice/`](../../derived/commodore_loader/vice/).

> The captured introduction state does **not** yet expose a structurally valid DDB range. It is evidence that the runtime path works and an explicit starting point for controlled input, disk-I/O, decompression, and part-transition reconstruction—not an unsupported omission or a completed C64 decompilation.

## References

[1]: [VICE system files](https://www.cs.cmu.edu/~dsladic/vice/doc/html/vice_4.html) "Required C64 ROM roles and search-path behavior"

[2]: [VICE monitor](https://vice-emu.sourceforge.io/vice_12.html) "Snapshot, memory-save, and scripted monitor commands"

[3]: [C64 BASIC and KERNAL source](https://github.com/mist64/c64rom) "Build inputs and documented binary identities"

[4]: [Zimmers C64 firmware archive](https://www.zimmers.net/anonftp/pub/cbm/firmware/computers/c64/) "Independent C64 firmware preservation binaries"

[5]: [Zimmers Plus/4 firmware archive](https://www.zimmers.net/anonftp/pub/cbm/firmware/computers/plus4/index.html) "Plus/4 BASIC and KERNAL preservation binaries"

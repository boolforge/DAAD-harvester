# C64 6510 Entry-State Sources

| Source | Bounded use |
| --- | --- |
| [C64 OS: The 6510 Processor Port](https://c64os.com/post/6510procport) | The 6510 has a six-bit processor port; its address-space behavior depends on port direction and data state. |
| [Ultimate C64 Reference: Memory Map](https://www.pagetable.com/c64ref/c64mem/) | Processor-port state controls RAM/ROM/I/O visibility in C64 address-space regions. |
| [C64 Memory Map](https://sta.c64.org/cbm64mem.html) | Addresses `$0000` and `$0001` are processor-port direction and configuration registers. |
| [VICE manual](https://vice-emu.sourceforge.io/vice_toc.html) | VICE is a C64 emulator reference, but a default configuration is not evidence of the state for a retained official PRG. |

These sources establish that the C64 entry environment requires explicit
processor-port and memory-visibility evidence. They do not supply a measured
official EDI64/SDI64 launch capture, so they cannot by themselves authorize the
official PRG entry state or a qualified analyzer invocation.

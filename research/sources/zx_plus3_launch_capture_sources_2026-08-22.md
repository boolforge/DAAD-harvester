# ZX Spectrum +3 Future Launch-Capture Source Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which +3DOS loader and banking facts must a future official PLUS3DOS interpreter launch capture retain? |
| **Evidence scope** | Spectrum +3 manual and +3DOS technical references, not an observation of either retained DAAD PLUS3DOS image launching. |
| **Non-claims** | No hash-bound DS48IE or DS48IS launch capture is retained. These references do not establish a loader action, effective entry, bank state, or runtime behavior for either image. |

The Spectrum +3 documentation identifies the menu loader and +3DOS boot paths,
the four ROMs and ROM 2 +3DOS interface, and the write-only paging ports
`0x7FFD` and `0x1FFD` with their `BANKM` and `BANK678` system-variable mirrors.
It also documents the boot-sector and bootstrap context. A future official
capture must therefore bind the exact image and disk/loader context, system
ROMs, loader trace, snapshot, model, registers, paging ports and mirrors, RAM
pages, ROM selection, stack state, relevant +3DOS vectors, and bootstrap state.

## References

1. [Sinclair ZX Spectrum +3 Manual](https://zxspectrumvault.github.io/Manuals/Hardware/SpectrumPlus3Manual.html)
2. [Spectrum +3 Manual, Part 27: Guide to +3DOS](https://worldofspectrum.org/ZXSpectrum128+3Manual/chapter8pt27.html)
3. [Spectrum +3 Manual, Part 26: Using Machine Code](https://worldofspectrum.net/ZXSpectrum128+3Manual/chapter8pt26.html)

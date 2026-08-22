# MSX Future Launch-Capture Source Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which loader, slot, mapper, and machine-state facts must a future official MSX interpreter launch capture retain? |
| **Evidence scope** | MSX2 technical handbook system, MSX-DOS, and slot documentation; not an observation of either retained DAAD image launching. |
| **Non-claims** | No hash-bound `MSXEDI.Z80` or `MSXSDI.Z80` launch capture is retained. These references do not establish a loader, effective entry, slot mapping, or runtime behavior for either image. |

The MSX2 technical handbook describes the 64 KiB CPU space as four 16 KiB
pages selected from slots, with primary selection through I/O port `0xA8` and
expanded-slot state through the selection register at `0xFFFF`. It also
describes MSX-DOS boot and external-command loading through the TPA, including
the documented `0x0100` external-command start convention. A future official
capture must therefore bind the exact image and loader/disk context, system
images, launch trace, snapshot, model, CPU register state, primary and expanded
slot state, mapper state, page mappings, TPA state, and relevant BIOS/BDOS
vectors.

## References

1. [MSX2 Technical Handbook, Chapter 1: System Overview](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter1.html)
2. [MSX2 Technical Handbook, Chapter 3: MSX-DOS](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter3.html)
3. [MSX2 Technical Handbook, Chapter 5: Slots and Cartridges](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter5b.html)

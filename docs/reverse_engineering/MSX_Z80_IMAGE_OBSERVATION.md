# MSX Z80 Image and Leading-Jump Boundary

| Header field | Value |
| --- | --- |
| **Question** | What can be proven directly from the two retained original MSX Z80 program-image files before their loader and memory model are known? |
| **Evidence scope** | Immutable original-image hashes, file sizes, and the absolute `JP` instruction encoded at file offset zero. |
| **Status** | Both images begin with `JP`; their operands are recorded but do not establish loading or executable entry. |
| **Non-claims** | The observation does not establish an MSX load address, slot/mapper state, BIOS environment, effective entry point, source recovery, or runtime behavior. |

`MSXEDI.Z80` and `MSXSDI.Z80` begin with the Z80 opcode `0xC3`, carrying the
absolute operands `0xCF3A` and `0xCFCF`. The contract also binds the instruction's
**file offset** as zero. These bytes are exact observations.
Without the original loader or disk/cassette/ROM context, however, the
repository cannot establish where either image was placed in MSX address space
or that control began at file offset zero. The MSX platform dossier separately
requires preserving loader and mapper uncertainty.[1]

```bash
python3 scripts/verify_msx_z80_image_observation.py
```

The verifier reads retained bytes only; it does not invoke MSX BIOS routines,
mount media, start an emulator, or disassemble either image.

Every profile therefore records `launch_capture_observation: null`. A future
official capture must bind the exact image and loader/disk context, MSX-DOS and
COMMAND.COM images, disk-interface ROM, launch trace, snapshot, model,
registers, primary and expanded slot state, mapper/page mapping, TPA range, and
BIOS/BDOS vector bytes. A generic Z80 default or unrelated MSX launch cannot
fill this field.[3] [4] [5]

## References

[1]: [MSX platform dossier](../platforms/MSX.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
[3]: [MSX2 Technical Handbook: System Overview](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter1.html)
[4]: [MSX2 Technical Handbook: MSX-DOS](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter3.html)
[5]: [MSX2 Technical Handbook: Slots and Cartridges](https://konamiman.github.io/MSX2-Technical-Handbook/md/Chapter5b.html)

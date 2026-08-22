# ZX Spectrum PLUS3DOS Header and Payload Boundary

| Header field | Value |
| --- | --- |
| **Question** | What load-model facts can be verified for the retained ZX `DS48I*.P3F` members before identifying an executable interpreter payload? |
| **Evidence scope** | Immutable P3F identities, PLUS3DOS signatures, header checksums, declared totals, declared payload sizes, and retained physical-tail sizes. |
| **Status** | Two PLUS3DOS headers and their bounded declared payload facts are validated; payload execution is unresolved. |
| **Non-claims** | The contract does not identify an interpreter payload, load command, bank mapping, memory model, machine-code entry, source, or runtime behavior. |

The English and Spanish `DS48I*.P3F` members are retained +3DOS/CP/M-style
container evidence. Their headers validate, but the declared payload is not
silently equated to an executable interpreter. The files also retain different
physical tails beyond their declared totals; these are hash-bound observations,
not discarded padding. The ZX platform contract requires preserving this disk
context without inferring tape or runtime equivalence.[1]

```bash
python3 scripts/verify_zx_plus3dos_load_model.py
```

The verifier reads retained P3F bytes only. It does not mount a disk, run
+3DOS, launch an emulator, or invoke a disassembler.

Every profile therefore records `launch_capture_observation: null`. A future
official capture must bind the exact P3F and disk/loader context, +3DOS ROM,
loader transition, bootstrap sector, snapshot, model, registers, `0x7FFD` and
`0x1FFD` paging state with `BANKM` and `BANK678`, RAM/ROM mappings, stack, and
+3DOS vector bytes. A generic Z80 default, unrelated Spectrum capture, or
different PLUS3DOS title cannot fill this field.[3] [4] [5]

## References

[1]: [ZX Spectrum platform dossier](../platforms/ZX_SPECTRUM.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
[3]: [Sinclair ZX Spectrum +3 Manual](https://zxspectrumvault.github.io/Manuals/Hardware/SpectrumPlus3Manual.html)
[4]: [Spectrum +3 Manual, Part 27: Guide to +3DOS](https://worldofspectrum.org/ZXSpectrum128+3Manual/chapter8pt27.html)
[5]: [Spectrum +3 Manual, Part 26: Using Machine Code](https://worldofspectrum.net/ZXSpectrum128+3Manual/chapter8pt26.html)

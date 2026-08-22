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

## References

[1]: [ZX Spectrum platform dossier](../platforms/ZX_SPECTRUM.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)

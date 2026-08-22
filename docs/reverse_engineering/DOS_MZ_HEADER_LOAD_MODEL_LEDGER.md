# DOS MZ Header and Relative-Entry Ledger

| Header field | Value |
| --- | --- |
| **Question** | Which i8086 load and entry fields can be verified for all retained DOS interpreter profiles from their MZ containers? |
| **Evidence scope** | Immutable retained EXE identities and bounded MZ header/relocation-table parsing. |
| **Status** | All 22 retained DOS profiles validate as MZ containers with relative entry fields. |
| **Non-claims** | MZ validation does not establish the DOS PSP, actual load segment, runtime behavior, source recovery, or qualified analyzer output. |

`verify_dos_mz_load_model.py` verifies the retained file identity, declared size,
header and hash-bound load-module byte range, relocation-table bounds and
targets, initial CS:IP, initial SS:SP, and overlay field for every retained DOS
profile. All current profiles have a relative entry offset of zero and overlay
number zero.
The result is deliberately still non-executable: DOS supplies a PSP and a load
segment outside the MZ image, and those platform conditions remain separate
requirements of the committed DOS admission contract.

The MZ ledger now machine-checks that contract’s candidate states, required
MZ evidence, PSP and load-segment requirements, and fail-closed conditions,
including `raw_base_zero_only`. This prevents the independently verified
container fields from silently relaxing the separate runtime admission gate.

The separate future-capture contract covers exactly these 22 retained MZ
profiles and retains every observation as `null`. A future official capture
must bind the exact MZ and loader context, DOS and `COMMAND.COM` identities,
EXEC/relocation transition, boot medium, snapshot, machine configuration,
actual load segment, PSP/allocation/environment/command-tail/FCB/handle/DTA
state, and i8086 registers and stack. A generic DOSBox default, different
title, arbitrary segment, or raw-base-zero listing cannot substitute.[3]

```bash
python3 scripts/verify_dos_mz_load_model.py
```

The verifier reads bytes only; it does not invoke DOS, an emulator, a
disassembler, or the retained executables.

## References

1. [DOS i8086 load-model admission contract](../../reverse_engineering/workflows/dos_i8086_load_model_admission.json)
2. [Architecture-family qualified analysis campaign](ARCHITECTURE_FAMILY_VERIFICATION_CAMPAIGN.md)
3. [DOS MZ future launch-capture source record](../../research/sources/dos_mz_launch_capture_sources_2026-08-22.md)

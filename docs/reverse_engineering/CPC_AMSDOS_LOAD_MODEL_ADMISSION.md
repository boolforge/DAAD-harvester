# Amstrad CPC AMSDOS Load and Entry Boundary

| Header field | Value |
| --- | --- |
| **Question** | What load and entry facts do the two retained CPC DAAD program containers establish directly? |
| **Evidence scope** | Immutable `.Z80` identities and validated AMSDOS binary-header checksum, type, payload size, load address, and entry address. |
| **Status** | Both CPC containers establish bounded payload images at `0x0840` with declared entries inside those images. |
| **Non-claims** | The contract does not establish CPC RAM/banking, firmware state, peripheral state, tool correctness, source recovery, or runtime behavior. |

The retained English and Spanish CPC containers are AMSDOS binary type 2 records.
Their header checksums and declared payload sizes match their physical payloads.
Both declare loading at `0x0840`; their declared entry addresses are `0x2417`
and `0x2479`, respectively, and both fall within the associated loaded payload
range. These are CPC-specific header facts. They do not authorize execution or
qualified static analysis until CPC memory and environment conditions are
evidenced. Each retained profile records a null entry-environment observation;
a generic emulator default or an unrelated CPC capture cannot fill this field.

The future-capture schema requires a hash-bound official program, snapshot,
and loader transition; emulator identity and machine model; the entry PC and
Z80-register digest; Gate Array configuration and RAM configuration; upper-ROM
selection and firmware-ROM digest; PIO and PSG state digests; and the memory
dump digest and size. CPCEMU documents that its snapshot header stores Z80,
Gate Array, RAM-configuration, upper-ROM, PIO, PSG, and memory-dump fields.[3]
The schema records what a future official capture must preserve; it does not
state that a capture of either retained DAAD program exists.

```bash
python3 scripts/verify_cpc_amsdos_load_model.py
```

The verifier reads bytes only; it does not load AMSDOS, start a CPC emulator,
or invoke any disassembler.

## References

1. [Amstrad CPC platform dossier](../platforms/AMSTRAD_CPC.md)
2. [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
3. [CPC entry-environment source record](../../research/sources/cpc_entry_environment_sources_2026-08-22.md)

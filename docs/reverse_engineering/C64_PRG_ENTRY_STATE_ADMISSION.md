# C64 Official PRG Entry-State Admission

| Header field | Value |
| --- | --- |
| **Question** | What evidence is required before the official C64 PRGs can use their measured BASIC `SYS 2063` declaration as a qualified machine-code entry? |
| **Evidence scope** | Official PRG hashes, measured BASIC entry declaration, and the mandatory fields of a future hash-bound official launch capture. |
| **Status** | Fail closed: no official EDI64/SDI64 entry-state capture is retained. |
| **Non-claims** | The contract does not establish a 6510 processor-port state, ROM/I/O visibility, qualified analyzer configuration, source recovery, or runtime behavior. |

The verified PRG wrapper shows a BASIC `SYS 2063` declaration. The 6510
processor port at `$0000`/`$0001` controls C64 memory visibility, so a default
emulator configuration is not a substitute for a captured official launch.[1]
The existing JABATO observation is also rejected because it identifies a
different retained program and capture chain. A future admissible capture must
bind the matching official PRG hash, capture hash, emulator identity, model,
processor-port direction/data, memory-visibility facts, and `PC=2063`.
Every current profile records a null entry-state observation. A generic default,
an incomplete record, or a synthetically complete observation cannot substitute
for a retained hash-bound official launch capture.

```bash
python3 scripts/verify_c64_prg_entry_state_admission.py
```

## References

[1]: [C64 6510 entry-state source record](../../research/sources/c64_6510_entry_state_sources_2026-08-22.md)
[2]: [C64 PRG load-model admission](C64_PRG_LOAD_MODEL_ADMISSION.md)

# Official C64 PRG Load and BASIC-Entry Admission

| Header field | Value |
| --- | --- |
| **Question** | What non-raw load and entry facts can be verified directly from the two retained official C64 interpreter PRGs? |
| **Evidence scope** | Immutable PRG hashes, two-byte PRG load wrappers, strict tokenized BASIC `SYS` launcher validation, and measured entry bytes. |
| **Status** | PRG load address and BASIC-declared entry are verified; banking and I/O remain unresolved. |
| **Non-claims** | The contract does not verify C64 memory banking, I/O state, interpreter semantics, correct tool output, recovered source, or runtime behavior. |

Both official profiles have a PRG load address of `0x0801`, a strict tokenized
BASIC `SYS 2063:REM` launcher, and a machine-code offset of 16 bytes. The
decimal `SYS` target is `2063` (`0x080F`), which is the first mapped machine-code
address after the PRG wrapper and BASIC stub. The byte at that offset is a `JMP`
opcode in both profiles. These are container and launcher facts, not a full
machine-state model.

```bash
python3 scripts/verify_c64_prg_load_model.py
```

The verifier reads only the two retained PRGs and the committed contract. It
does not launch an emulator or execute the programs. Qualified reanalysis still
requires the contract’s unresolved banking/I/O requirement and a preserved
cross-tool disagreement record.

## References

1. [Commodore 64 platform dossier](../platforms/COMMODORE_64.md)
2. [Official interpreter profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
3. [Architecture-specific analysis workflows](ARCHITECTURE_WORKFLOWS.md)

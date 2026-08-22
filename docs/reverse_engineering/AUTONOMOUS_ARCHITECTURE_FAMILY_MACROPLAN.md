# Autonomous Architecture-Family Verification Macroplan

| Header field | Value |
| --- | --- |
| **Question** | How does the repository advance all retained DAAD analysis families without waiting for a separate user prompt for each finite increment? |
| **Evidence scope** | `reverse_engineering/workflows/architecture_family_macroplan.json`, which records the control state for each independent workstream. |
| **Status** | Active; eight independent workstreams are tracked. |
| **Non-claims** | The macroplan neither enables retained execution nor converts a static-analysis result into source recovery or runtime behavior. |

The macroplan is an autonomous execution order, not a statement that any family
is complete. After each atomic validation and push, work continues with the
next unblocked family prerequisite. A stop is justified only by a missing input,
an external decision, a policy boundary, or an explicit user pause.

| Order | Workstream | Current population | Immediate gate | Progress condition |
| ---: | --- | ---: | --- | --- |
| 1 | C64 / MOS 6502 | 2 | 6510 port, banking, and I/O at the official PRG entry. | A C64-only qualified configuration plus disagreement record. |
| 2 | Plus/4 / MOS 8501 | 2 | Meaning of the `SYS 2063` transfer, 7501 banking, TED/ROM/RAM. | A Plus/4-only machine-code entry and qualified configuration. |
| 3 | Z80 by platform | 8 | Separate ZX, CPC, MSX, and PCW loader/memory/entry contracts. | One platform-specific qualified result at a time. |
| 4 | Amiga / 68000 | 4 | Hunk segments, relocation, Amiga OS and memory model. | Qualified 68000 configuration and disagreement record. |
| 5 | Atari ST / 68000 | 4 | PRG segments, relocation, TOS memory and entry model. | Qualified 68000 configuration and disagreement record. |
| 6 | DOS / i8086 | 22 | PSP/load segment and DOS environment after current MZ-relative evidence. | Qualified 8086 configuration and disagreement record. |
| 7 | Behavioral evidence | 1 | Differential observations beyond a non-equivalence capture. | Scoped original-runtime comparison. |
| 8 | ScummVM readiness | 0 | All relevant family gates, corpus, detector, save/load, and differential requirements. | Independent readiness audit; no engine source before it passes. |

The JSON validator rejects omitted workstreams, missing unresolved fields,
unrecorded next reproducers, invalid state names, and any workstream missing an
explicit cross-family boundary. This prevents a successful DOS MZ structural
check from becoming apparent progress on a C64 PRG, or a C64 capture from
becoming evidence for a Plus/4 launch.

```bash
python3 scripts/verify_architecture_family_macroplan.py
```

## References

1. [Architecture-family qualified analysis campaign](ARCHITECTURE_FAMILY_VERIFICATION_CAMPAIGN.md)
2. [ScummVM DAAD engine readiness gate](../requirements/SCUMMVM_DAAD_ENGINE_READINESS.md)
3. [Behavioral evidence schema](../requirements/BEHAVIORAL_EVIDENCE_SCHEMA.md)

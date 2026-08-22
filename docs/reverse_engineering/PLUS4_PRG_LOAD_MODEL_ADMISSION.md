# Plus/4 PRG Wrapper and Launcher-Target Boundary

| Header field | Value |
| --- | --- |
| **Question** | What can the two retained official Plus/4 PRG wrappers establish without applying C64 conventions? |
| **Evidence scope** | Immutable Plus/4 PRG hashes, wrapper bytes, and a target-specific BASIC-line observation. |
| **Status** | Both wrappers validate at `0x4001`; the encoded `SYS 2063` remains outside the loaded PRG image and is not accepted as a machine-code entry. |
| **Non-claims** | The record does not establish TED/ROM/RAM configuration, 7501 banking, machine-code entry, runtime behavior, source recovery, or C64 compatibility. |

The two official Plus/4 PRGs contain the same measured one-line BASIC form and
the same two-byte PRG load address. Unlike the C64 records, their `SYS 2063`
target lies outside the image loaded at `0x4001`. The repository therefore
records the target bytes but rejects it as entry evidence until Plus/4-specific
loader and memory evidence explains the transfer.

Each profile contract binds its measured load address, BASIC line number,
encoded SYS target, BASIC-program terminator offset, loaded-image range, and
the false containment result. Those fields establish only retained wrapper byte
structure: the out-of-image `SYS 2063` value remains neither a machine-code
entry nor evidence of TED, ROM, RAM, or 7501 state.

```bash
python3 scripts/verify_plus4_prg_load_model.py
```

The verifier reads retained bytes only. It does not execute a PRG, invoke an
emulator, or apply C64 processor-port rules. The Plus/4 memory map includes its
own 7501 processor port and banking facilities, which remain a separate
platform-specific gate.[1]

Every profile therefore retains `launch_capture_observation: null`. A future
official capture must bind the exact PRG and loader context, BASIC and KERNAL
ROM identities, loader transition, bootstrap medium, snapshot, machine model,
7501 registers and port state, TED paging/configuration/interrupt state,
upper-memory selection, RAM mapping, and stack. A C64 default, generic 6502
state, or another Plus/4 title cannot substitute for this profile-specific
evidence.[1] [4]

## References

[1]: https://www.floodgap.com/retrobits/ckb/secret/264memory.txt "Annotated Commodore 264/Plus/4 memory map"
[2]: https://plus4world.powweb.com/forum/37848 "Plus/4 World discussion of PRG load-address wrapper semantics"
[3]: [Commodore Plus/4 platform dossier](../platforms/COMMODORE_PLUS4.md)
[4]: ../../research/sources/plus4_launch_capture_sources_2026-08-22.md "Plus/4 future launch-capture source record"

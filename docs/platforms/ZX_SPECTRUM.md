# ZX Spectrum Dossier

| Header field | Value |
| --- | --- |
| **Question** | What ZX-specific runtime, tape/disk, and provenance evidence does a DAAD preservation record require? |
| **Evidence scope** | P0 official distribution/profile anchors and TZX/CDT specification; P1 native parser observations. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/interpreter_profiles.py`](../../daad_harvester/interpreter_profiles.py), [`../formats/TAPE_STREAMS.md`](../formats/TAPE_STREAMS.md) |
| **Non-claims** | A TAP/TZX container, `DS48I*` filename, or ZX target nibble does not alone prove an original runtime or one release lineage. |

## Target evidence

The official-profile ledger contains English `ds48ie.p3f` and Spanish `ds48is.p3f` SHA-256 anchors for the canonical `zx` target.[1] A verified hash identifies the captured runtime member; a filename-only observation remains strong candidate evidence under the identity protocol.[2]

| Evidence layer | ZX-specific observation | Report effect |
| --- | --- | --- |
| Runtime | Exact `DS48I*` profile hash. | Verified original runtime anchor. |
| DDB | DRC target ID `0x01` or bounded legacy/DRC structural result. | Structural target/generation evidence only. |
| Tape | TAP/TZX block stream and declared lengths. | Preserve data extraction and timing/control blocks separately. |
| Disk | +3DOS/CP/M-style context where present. | Preserve container/filesystem provenance; do not infer tape equivalence. |

## Preservation procedure

Harvester retains the original container, scans typed TZX/CDT blocks, validates declared bounds, and emits extracted payloads only where the format contract permits. Pulse, pause, group, control, and unknown blocks remain structured evidence because they can be necessary to reproduce loading behavior.[3]

The ZX dossier deliberately delegates byte-level tape rules to [tape streams](../formats/TAPE_STREAMS.md), DDB fields to [DDB generations](../versions/DDB_GENERATIONS.md), and runtime matching to the [identity protocol](../interpreters/IDENTITY_PROTOCOL.md).

## References

[1]: [Official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[2]: [Interpreter identity protocol](../interpreters/IDENTITY_PROTOCOL.md)
[3]: https://worldofspectrum.net/TZXformat.html "TZX format specification"

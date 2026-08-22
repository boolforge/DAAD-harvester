# Behavioral Evidence Schema — Initial C64 Capture Slice

| Header field | Value |
| --- | --- |
| **Question** | How can a retained original-runtime capture be recorded for future differential testing without claiming behavior equivalence? |
| **Evidence scope** | P1 hashes and paths for one C64 release medium, VICE capture logs, snapshot, RAM extraction, monitor checkpoint, and recovered DDB range. |
| **Status** | One non-equivalence observation validates natively; it is not an engine test. |
| **Non-claims** | The observation does not prove complete gameplay, command semantics, timing equivalence, emulator accuracy, source recovery, or ScummVM readiness. |

## Contract

`daad_harvester.behavioral_evidence` validates a versioned
`runtime_capture_observation`. Every record binds immutable release media,
emulator name/version/frontend, cycle limit, command log, input log, monitor
checkpoint, snapshot, RAM extraction, and one observable byte range. Paths must
be repository-relative and every referenced hash must match its retained file.
The initial schema requires `eligible_for_equivalence: false`.

The first record validates the already retained JABATO C64 Side A capture. It
checks that the range at `0x3880` in the 64 KiB RAM extraction is byte-identical
to the separately retained Part 1 DDB. This is a reproducible capture-observation
fact, not a claim that the capture represents a complete original runtime or a
behavioral oracle.

## Reproduction

```bash
python3 -m pytest -q tests/test_behavioral_evidence.py
```

The test validates only committed files and does not launch VICE or execute
retained game media. Future differential records must add explicit authorization,
input semantics, observable engine state, and original-runtime comparison rules
before their `eligible_for_equivalence` state can change.

## References

1. [JABATO C64 runtime recovery verifier](../../scripts/verify_jabato_c64_runtime_recovery.py)
2. [ScummVM DAAD engine readiness gate](SCUMMVM_DAAD_ENGINE_READINESS.md)
3. [DAAD preservation research methodology](../RESEARCH_METHODOLOGY.md)

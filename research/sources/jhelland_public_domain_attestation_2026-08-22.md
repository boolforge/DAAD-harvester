# j-helland Public-Domain Attestation Boundary — 2026-08-22

| Header field | Value |
| --- | --- |
| **Candidate** | [`j-helland/8086-disassembler`](https://github.com/j-helland/8086-disassembler), pinned revision `1979e794d1cbcd92714d0863a2fd17fd89af4fcd` |
| **Attestation received** | The project user states that this candidate is public domain. |
| **External source evidence at record time** | No public-domain declaration, `UNLICENSE`, CC0 text, or source license notice was observed in the pinned checkout. |
| **Classification** | `user_attested_public_domain_pending_external_evidence`; this is not a license conclusion. |
| **Execution result** | The candidate remains non-executable for retained bytes. |

## Evidence distinction

The user’s statement is preserved as project provenance and is not discarded.
For a repository intended to remain auditable without this conversation, it is
kept separate from independently inspectable upstream licensing material. A
future public author declaration, repository license file, dedicated waiver, or
equivalent verifiable material can update the external-evidence field without
rewriting this attestation.

## Independent technical blocks

The prior build result remains independent of this claim: the pinned CMake build
fails on the observed host because `instruction.cpp` lacks declarations used for
`abs`, `printf`, and `std::out_of_range`. The upstream NASM round-trip suite was
therefore not reached. A future build repair would still require its own source
pin, reproducible health fixture, and command record.

Even if licensing becomes externally evidenced, retained i8086 input remains
blocked on the DOS COM/MZ admission contract: container identity, origin or load
segment, entry evidence, relocation and PSP facts where applicable, and preserved
cross-tool disagreement evidence are all separate requirements.

> A user attestation may be important project provenance. It does not convert an
> unverified upstream declaration into evidence, repair a source build, or turn
> disassembler output into recovered source or runtime behavior.

## References

1. [Pinned candidate repository](https://github.com/j-helland/8086-disassembler/tree/1979e794d1cbcd92714d0863a2fd17fd89af4fcd)
2. [Existing source and build boundary](jhelland_8086_disassembler_boundary_2026-08-22.md)
3. [DOS i8086 admission contract](../../reverse_engineering/workflows/dos_i8086_load_model_admission.json)

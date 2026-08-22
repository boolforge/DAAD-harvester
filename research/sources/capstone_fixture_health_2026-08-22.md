# Capstone Controlled-Fixture Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does the exact pinned Capstone source supply a reproducible static-decoding harness for DAAD-relevant 68000 and i8086 comparison without reading retained DAAD bytes? |
| **Candidate** | [`capstone-engine/capstone`](https://github.com/capstone-engine/capstone), revision `3a8d30a66726fd31990fa584f62fd30dcd9f9b50` |
| **Observed license** | BSD 3-Clause text in the pinned `LICENSES/LICENSE.TXT`. |
| **Health result** | Source-built Python binding reported version `6.0.0`; controlled 68000 and i8086 fixture output was byte-identical across two separate harness processes. |
| **Admission result** | `health_checked`; `execution_eligible: false`. |

## Pinned source and harness boundary

The source was checked out outside the repository at the recorded revision. Its
Python binding documentation describes a source build through the binding
directory and notes that the native core is built by default. The binding was
installed from that checked-out source with no package-index fallback. The
repository-owned [`run_capstone_fixture_health.py`](../../scripts/run_capstone_fixture_health.py)
harness has a fixed source revision, accepts no input path, and creates only two
literal byte fixtures in memory. It emits deterministic JSON and has
dependency-free regression coverage using a fake binding.

The 68000 fixture `4e 71 4e 75` used `CS_ARCH_M68K` with
`CS_MODE_BIG_ENDIAN | CS_MODE_M68K_000` and emitted `nop; rts`. The i8086
fixture `90 c3` used `CS_ARCH_X86` with `CS_MODE_16` and emitted `nop; ret`.
The two process outputs were byte-identical, with JSON SHA-256
`c85a11643c8715292479b15a5f3f67af2cdf402794bb3d8ddb78ca2d3f02f161`.

## Source-suite result and runner distinction

The eight pinned standalone Python test modules completed successfully. A direct
generic `pytest` invocation produced 14 passes and one error because pytest
mistook the source module's `testcb(buffer, size, offset, userdata)` callback
as a fixture-based test. That is recorded as an invocation incompatibility, not
a Capstone decoding failure. The candidate health record relies on the source's
standalone module entry points and the repository harness, not on that generic
pytest result.

## MOS 6502 and MOS 8501 refusal

The pinned public binding exposed `CS_ARCH_X86` and `CS_ARCH_M68K`, but did not
expose `CS_ARCH_M6502`. The pinned C public header likewise did not declare
that architecture. This candidate is therefore **not** a MOS 6502 or MOS 8501
candidate. It must not be relabeled as MOS65XX, routed through a nearby 680x
mode, or used to decode C64 or Plus/4 retained bytes.

> The controlled results prove only one pinned binding's instruction decoding
> for two synthetic byte sequences at raw address zero. They do not recover
> source, validate an Amiga, Atari ST, DOS, or Windows load model, establish a
> function or entry point, or demonstrate behavior.

## Remaining admission blockers

For 68000 material, an Amiga or Atari ST CPU/origin/base/entry model and a
retained-byte disagreement record against Ghidra, radare2, and the configured
family disassembler remain required. For i8086 material, a DOS COM/MZ segment,
origin, and entry model plus the same cross-tool disagreement discipline remain
required. Capstone remains an `external_candidate` and is not called by the
retained reverse-analysis runner.

## References

1. [Capstone pinned repository](https://github.com/capstone-engine/capstone)
2. [Capstone Python binding build documentation](https://github.com/capstone-engine/capstone/blob/3a8d30a66726fd31990fa584f62fd30dcd9f9b50/bindings/python/BUILDING.md)
3. [Capstone BSD license text](https://github.com/capstone-engine/capstone/blob/3a8d30a66726fd31990fa584f62fd30dcd9f9b50/LICENSES/LICENSE.TXT)

# j-helland 8086-disassembler Build-Repair Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Candidate source** | `j-helland/8086-disassembler` revision `1979e794d1cbcd92714d0863a2fd17fd89af4fcd` |
| **Repair scope** | An isolated copy of `src/instruction.cpp` received only `<cstdio>`, `<cstdlib>`, and `<stdexcept>` includes. |
| **Build result** | CMake Release build produced `disassemble-8086`. |
| **Fixture result** | All 19 upstream NASM assemble/disassemble/reassemble fixtures passed. |
| **Retained input** | None. |
| **Admission result** | Still non-executable for retained bytes. |

## Exact boundary

The unmodified pinned source continues to fail on the observed host because the
translation unit uses `abs`, `printf`, and `std::out_of_range` without declarations.
The three standard headers repair that compilation condition in an isolated copy.
The project did not modify or vendor the upstream source; this is health evidence
for a future reproducible patch recipe, not a source replacement.

The upstream `test.py` command was invoked only against its `asm/` fixture
directory using `/usr/bin/nasm` and the repaired temporary executable. It emitted
19 `OK` records and no `FAILED` records. This establishes a narrow upstream
round-trip observation, not a claim about arbitrary i8086 binaries, DAAD bytes,
or the tool's jump labels.

> Passing a fixture round trip after a minimal build repair does not establish a
> DOS COM/MZ load model, recovered source, or runtime behavior.

## Remaining admission requirements

Any retained i8086 comparison still requires the repository’s DOS admission
contract, including container identity, origin or load segment, entry evidence,
COM PSP or MZ relocation facts as applicable, and a preserved cross-tool
disagreement record. The candidate remains outside the configured runner.

## References

1. [Pinned source](https://github.com/j-helland/8086-disassembler/tree/1979e794d1cbcd92714d0863a2fd17fd89af4fcd)
2. [Pinned build definition](https://github.com/j-helland/8086-disassembler/blob/1979e794d1cbcd92714d0863a2fd17fd89af4fcd/CMakeLists.txt)
3. [Pinned upstream test runner](https://github.com/j-helland/8086-disassembler/blob/1979e794d1cbcd92714d0863a2fd17fd89af4fcd/test.py)

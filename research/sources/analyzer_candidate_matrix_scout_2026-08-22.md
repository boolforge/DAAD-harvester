# Multi-Architecture Analyzer Candidate Scout — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which additional architecture-scoped static-analysis tools warrant a reproducible admission review beyond the configured Ghidra, radare2, family disassembler, da65, m68k objdump, and NDISASM paths? |
| **Evidence scope** | Read-only GitHub repository metadata and official README material captured on 2026-08-22. No newly listed candidate was downloaded, built, or applied to a retained DAAD byte by this scout. |
| **Status** | discovery and admission triage only |
| **Non-claims** | Repository metadata, a README feature list, an upstream fixture, an emitted listing, or a successful build does not validate a candidate’s load model, CPU variant, disassembly correctness, decompilation quality, behavior, or suitability for a retained DAAD interpreter. |

## Candidate matrix

| CPU family | Candidate | Observed interface and scope | First admission blocker |
| --- | --- | --- | --- |
| Z80 | [DazzleStar](https://github.com/durgadas311/dazzlestar) at `8841d4fa48bfeabd52b090b8e785637b767dafa3` | Repository metadata describes a modern Z80 disassembler. | No license was reported in the inspected metadata; invocation, raw origin, fixture, and output determinism require source review. |
| Z80 | [z80dismblr](https://github.com/maziac/z80dismblr) at `2ff52822f0d706f9f39762e079f300f45cfd451d` | Existing pinned candidate; documented CFG analysis accepts start, snapshot, trace, and label assumptions. | Unconfigured because retained records have no independently evidenced origin and start/trace model; the standard TypeScript build also has a host declaration conflict. |
| MOS 6502 | [lybrown/dis](https://github.com/lybrown/dis) at `b4954cc90f210a64a3c63e87101a9a8786cd0247` | Repository metadata identifies a statically tracing 6502 disassembler with an MIT license; README material documents address-oriented command options. | Requires source inspection, a pinned command/fixture, and an explicit C64 6502 versus Plus/4 8501 profile and origin. |
| MOS 6502 | [py8dis](https://github.com/ZornsLemma/py8dis) at `2a6046356e20e93c4a2d484bc04bd5d74d66254e` | Existing pinned candidate supports explicit binary load addresses and a 6502 profile. | Health-checked only on upstream material; retained DAAD use remains blocked on an independent origin and CPU-profile comparison. |
| 68000 | [m68k-disasm](https://github.com/Oxore/m68k-disasm) at `bb6d83981bbb53de352061b793c8215e45af895a` | README documents a CMake-built command-line disassembler, trace input, and byte-round-trip goals. It also states that its base address is currently fixed at zero. | Candidate source/build and fixture must be pinned. Base-zero compatibility is not a validated Amiga or Atari ST load model, and no behavior claim may follow. |
| 68000 / i8086 | [Capstone](https://github.com/capstone-engine/capstone) at `3a8d30a66726fd31990fa584f62fd30dcd9f9b50` | The initial discovery metadata suggested M68K, MOS65XX, and X86. Later pinned source inspection found BSD 3-Clause licensing and M68K/X86 bindings, but no `CS_ARCH_M6502` binding constant. | The later [health record](capstone_fixture_health_2026-08-22.md) preserves the controlled 68000/i8086 fixture result and MOS 6502/8501 refusal. Retained-byte origin, load, entry, and disagreement evidence remain required. |
| i8086 | [j-helland/8086-disassembler](https://github.com/j-helland/8086-disassembler) at `1979e794d1cbcd92714d0863a2fd17fd89af4fcd` | README describes a C++17 command-line output tool with two-pass jump labeling. | No license was reported in the inspected metadata; source/test, raw COM/MZ versus segmented model, and reproducibility need review. |
| i8086 | [REDasm](https://github.com/redasm-dev/redasm) at `113245ef02090602978e461fcb7031b75da448d6` | Existing candidate; README describes GUI/core separation and DOS executable formats. | Workspace/core review has not established a stable standalone batch command or the required DOS segment/load model. |

## Admission protocol

Every candidate requires a source revision, license review, isolated source or
fixture health result, noninteractive invocation, recorded host dependencies,
deterministic captured output, CPU and endian declaration, explicit input
origin/load model, hashes, and a negative refusal test before it can be added as
a configured adapter. Retained-byte comparison additionally requires a
platform-specific load/entry model and a preserved disagreement record against
the existing configured tool roles.

## References

1. [DazzleStar repository](https://github.com/durgadas311/dazzlestar)
2. [lybrown/dis repository](https://github.com/lybrown/dis)
3. [Oxore m68k-disasm repository](https://github.com/Oxore/m68k-disasm)
4. [Capstone repository](https://github.com/capstone-engine/capstone)
5. [j-helland 8086-disassembler repository](https://github.com/j-helland/8086-disassembler)
6. [Existing analyzer candidate scout](analyzer_candidate_scout_2026-08-22.md)

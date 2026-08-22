# Oxore m68k-disasm Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Can the pinned Oxore m68k-disasm source build reproducibly enough to justify a *non-executable* health-checked entry in the analyzer candidate matrix? |
| **Candidate** | [`Oxore/m68k-disasm`](https://github.com/Oxore/m68k-disasm), revision `bb6d83981bbb53de352061b793c8215e45af895a` |
| **Observed license status** | Unlicense marker observed in the pinned repository metadata. |
| **Input boundary** | A new, controlled four-byte `NOP; RTS` fixture only. No retained DAAD artifact, extracted interpreter, game image, or acquired source was read or modified. |
| **Admission result** | `health_checked`; `execution_eligible: false`. |

## Bounded host build and fixture observation

The pinned source built in an isolated temporary directory with CMake `3.28.3`
and the host C/C++ compiler. CMake was absent before this check and was installed
from the operating system package repository; it is an observed host dependency,
not a mandatory DAAD Harvester workflow dependency. The resulting
`m68k-disasm` binary hash was
`0902194e1f99c559de6ff410ba668b0326a973c9cf31dcff28bc85f48bc12145`.

The controlled input was exactly `4e 71 4e 75` (`NOP; RTS`) and had SHA-256
`8e87b3a2dd2cf6b970e38bb62f460570a8a9c6f9a6e7afeedee921e99947b58f`.
Two independent invocations of the pinned executable, each using
`--output <listing> <fixture>`, produced byte-identical ten-byte listings. The
listing SHA-256 was
`9030bdb42685acd362f53dcb6e89e823d86557506972ca7f522afd952a9ad5de`.
The observed listing contained only `nop` and `rts`.

> This is a controlled command-and-output determinism observation, not a
> decoder conformance proof, a decompilation, a recovered source claim, a
> platform origin claim, or evidence of runtime behavior.

## Remaining admission blockers

The pinned source's `tests/test.bash` documents a round-trip test that invokes
`m68k-none-elf-as`, `m68k-none-elf-ld`, and `m68k-none-elf-objcopy`. All three
were absent in this host check, so that upstream suite was not run and no
round-trip claim is recorded. Its observed CLI accepts raw binary or ELF input,
optional PC traces, label features, and split output, but the command help does
not independently establish an Amiga or Atari ST raw-input base, entry point,
or trace model.

Accordingly, this candidate remains excluded from `analyzer_adapters.json` and
must not run against retained DAAD bytes. Promotion requires separately
recorded platform origin, entry, and load evidence; explicit mapping of any raw
base and trace or label assumptions; and a retained-byte disagreement record
against the already configured analysis tools.

## Reproduction boundary

A fresh evaluator may clone the cited revision outside the repository, configure
and build it with CMake, create only the four fixture bytes above, invoke the
binary twice with `--output`, and compare the two listings. That procedure
reproduces this narrow health check only. It does not authorize a retained-byte
invocation or substitute for the missing upstream cross-toolchain test suite.

## References

1. [Oxore m68k-disasm repository and pinned source](https://github.com/Oxore/m68k-disasm)

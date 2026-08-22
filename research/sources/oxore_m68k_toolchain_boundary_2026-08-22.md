# Oxore m68k-disasm Toolchain Boundary — 2026-08-22

| Header field | Value |
| --- | --- |
| **Candidate** | `Oxore/m68k-disasm` revision `bb6d83981bbb53de352061b793c8215e45af895a` |
| **Upstream test requirement** | `m68k-none-elf-as`, `m68k-none-elf-ld`, and `m68k-none-elf-objcopy` |
| **Observed host state** | None of the three required executable names is installed. |
| **Distribution candidate** | Ubuntu exposes `binutils-m68k-linux-gnu`, which does not establish the required `m68k-none-elf-*` target or invocation compatibility. |
| **Documented source route** | `ddraig68k/m68k-elf-toolchain` documents a Makefile-based binutils build for Ubuntu and Windows environments, but no revision or resulting executable-name compatibility has yet been pinned. |
| **Admission result** | Upstream round-trip suite remains unrun; candidate remains non-executable for retained bytes. |

## Exact boundary

The Oxore test launcher names the `m68k-none-elf-*` tools explicitly. Installing or
substituting a host package with a different target prefix would not demonstrate
the upstream test contract. A documented cross-toolchain repository is a possible
future route, but it must first be pinned, built noninteractively, and shown to
provide the required names before the upstream suite can be considered a health
check.

No Amiga, Atari ST, or other retained DAAD input was read. Passing a future
round-trip fixture suite would still not establish a platform origin, entry point,
load model, labels, recovered source, or runtime behavior.

## References

1. [Pinned Oxore test launcher](https://github.com/Oxore/m68k-disasm/blob/bb6d83981bbb53de352061b793c8215e45af895a/tests/test.bash)
2. [Documented m68k-elf toolchain source route](https://github.com/ddraig68k/m68k-elf-toolchain)

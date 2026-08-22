# Oxore m68k-disasm Toolchain Boundary — 2026-08-22

| Header field | Value |
| --- | --- |
| **Candidate** | `Oxore/m68k-disasm` revision `bb6d83981bbb53de352061b793c8215e45af895a` |
| **Upstream test requirement** | `m68k-none-elf-as`, `m68k-none-elf-ld`, and `m68k-none-elf-objcopy` |
| **Observed host state** | None of the three required executable names is installed. |
| **Distribution candidate** | Ubuntu exposes `binutils-m68k-linux-gnu`, which does not establish the required `m68k-none-elf-*` target or invocation compatibility. |
| **Documented source route** | `ddraig68k/m68k-elf-toolchain` revision `b3c964f1dc2b10396b89abf6c916cae88b25c645` documents a Makefile-based route, but its target tools are named `m68k-elf-*`, not Oxore's required `m68k-none-elf-*`. |
| **Admission result** | Upstream round-trip suite remains unrun; candidate remains non-executable for retained bytes. |

## Exact boundary

The Oxore test launcher names the `m68k-none-elf-*` tools explicitly. Installing or
substituting a host package with a different target prefix would not demonstrate
the upstream test contract. The documented cross-toolchain repository was pinned
at revision `b3c964f1dc2b10396b89abf6c916cae88b25c645`. Its Makefile exports
`m68k-elf-as`, `m68k-elf-ld`, and `m68k-elf-objcopy`, while the pinned Oxore
test launcher names `m68k-none-elf-as`, `m68k-none-elf-ld`, and
`m68k-none-elf-objcopy`. The route therefore does not directly satisfy the
upstream contract. Creating aliases or substituting a differently prefixed
toolchain would be a new compatibility experiment, not evidence that the
upstream suite ran under its documented prerequisites.

No Amiga, Atari ST, or other retained DAAD input was read. Passing a future
round-trip fixture suite would still not establish a platform origin, entry point,
load model, labels, recovered source, or runtime behavior.

## References

1. [Pinned Oxore test launcher](https://github.com/Oxore/m68k-disasm/blob/bb6d83981bbb53de352061b793c8215e45af895a/tests/test.bash)
2. [Documented m68k-elf toolchain source route](https://github.com/ddraig68k/m68k-elf-toolchain)
3. [Pinned m68k-elf toolchain Makefile](https://github.com/ddraig68k/m68k-elf-toolchain/blob/b3c964f1dc2b10396b89abf6c916cae88b25c645/Makefile)

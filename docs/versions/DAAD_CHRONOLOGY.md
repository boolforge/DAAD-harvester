# DAAD Version and Database Chronology

## Scope and terminology

DAAD has both **authoring-tool releases** and **database layouts**. They must not be collapsed. A release may ship multiple target runtimes and tools; a DDB carries only the layout/version fields that its interpreter contract defines. The Harvester therefore records the structural DDB format separately from interpreter binary identity.

| Term | Meaning in Harvester | Evidence threshold |
| --- | --- | --- |
| DAAD release | A documented distribution-era release such as R2–R5. | Explicit release notes or distributed release material. |
| DDB layout | The measured internal DDB header and bounded offsets. | Structural parser validation. |
| Interpreter identity | A target runtime binary or qualified filename. | Exact SHA-256 for `verified`; original member filename for `strong`. |
| Derivative compatibility | A separately authored runtime/compiler’s documented supported behavior. | The derivative’s own documentation, never branding alone. |

## Recovered distribution lineage

The official modern DAAD distribution publishes a release history that is directly relevant to preservation. R2 re-established templates and recovered platform components; R3 introduced DC 2.42 while retaining the 1991 DC 2.40 tool; R4 restored MSX and PCW material; and R5 made DRC the standard compiler and added Plus/4/C16 64K support.[1]

| Release | Documented preservation significance | What it does **not** prove by itself |
| --- | --- | --- |
| R2 | Post-1991 recovery release with reconstructed templates and recovered interpreters/tooling. | That an arbitrary game file uses an R2 database or runtime. |
| R3 | DC 2.42 improvement, retained legacy DC 2.40, refreshed Atari ST material. | That every R3 bundle is byte-identical across targets. |
| R4 | Recovered MSX support; PCW English/Spanish interpreters; C64 tooling and German templates. | That a Spanish filename establishes a specific runtime hash. |
| R5 | Adds Plus/4/C16 64K support and shifts the standard compiler to DRC. | That a DRC-built DDB has a single universal runtime behavior. |

## DDB layout evidence

The Harvester recognizes two measured layout families. The parser validates counts, pointer ranges, target endianness, process-entry references, and bounded bytecode terminators; it does not identify a database merely because it has a `.ddb` extension.

| Layout | Measured marker and structure | Current label | Preservation interpretation |
| --- | --- | --- | --- |
| Historical compact | V1/V2 header, target/language byte, literal `0x5F`, counts, file-relative offsets. | `daad-v1-legacy`, `daad-v2-legacy` | Historical/interpreter-derived compact database contract. |
| DRC-compatible | V2/V3 header, target/language byte, target base-address pointers, process table, bytecode streams. | `daad-v2`, `daad-v3` | Modern documented DRC layout; this is a layout claim, not an authoring-history claim. |

The DRC documentation is important because it is a modern compiler replacement for the original DOS DC toolchain, not because every DDB it produces is indistinguishable from every historical release.[2]

## Reporting rules

Harvester reports `daad_version_guess` as an intentionally narrow structural label such as **DAAD DDB v3**. It reports an interpreter profile separately. A verified source hash can identify the exact repository binary; a qualified original member name can indicate a likely runtime family but remains `strong`, not `verified`.

> **Archaeology boundary.** Multi-part commercial layouts, undocumented loaders, modified runtimes, and repacked databases remain explicit research targets until retained media and format evidence support a stronger conclusion.

## References

[1]: https://github.com/daad-adventure-writer/daad/blob/master/CHANGELOG.md "Official DAAD distribution changelog"
[2]: https://github.com/daad-adventure-writer/daad "Official DAAD distribution"

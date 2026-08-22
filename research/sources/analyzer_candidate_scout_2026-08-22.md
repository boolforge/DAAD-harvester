# Analyzer Candidate Scout — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which additional open-source static-analysis candidates merit architecture-scoped evaluation for the DAAD interpreter-analysis framework? |
| **Evidence scope** | Read-only GitHub repository metadata and official README material captured on 2026-08-22; no candidate was downloaded, installed, configured against a retained DAAD byte, or made a workflow dependency. |
| **Status** | candidate classification only |
| **Non-claims** | A repository description, star count, update timestamp, README claim, or source inspection does not prove CPU compatibility for a retained artifact, reproducible command-line operation, correct load model, disassembly correctness, decompilation quality, or runtime behavior. |

## Candidate observations

| Candidate | Observed declared scope | Initial architecture classification | Current decision |
| --- | --- | --- | --- |
| [py8dis](https://github.com/ZornsLemma/py8dis) | Python-based programmable static tracing disassembler; repository metadata reports an MIT license. Revision `2a6046356e20e93c4a2d484bc04bd5d74d66254e` passed its own isolated 6502 demonstration fixture, with output identical to its pinned known-good assembly fixture. | Pinned, health-checked candidate for MOS 6502-family research only. | Do not configure against retained C64 or Plus/4 bytes until an independent load origin and 6502-versus-8501 semantics are established and compared with the current `da65`, Ghidra, and radare2 records. |
| [SkoolKit](https://github.com/skoolkid/skoolkit) | Spectrum-oriented disassembly suite; the repository is GPL-3.0. | Z80/Spectrum comparison candidate. | Retain the existing optional-candidate status. Its snapshot and execution-map assumptions do not validate the retained raw-base-zero Z80 profile. |
| [z80dismblr](https://github.com/maziac/z80dismblr) | Command-line Z80 disassembler whose README describes CFG-based traversal, optional trace input, labels, comments, call graphs, and warnings for incompletely understood binaries. | Z80 comparison candidate. | Candidate only. A trace, start address, SNA, or command-specific label must not be inferred for a raw retained interpreter; any future adapter must retain each supplied assumption. |
| [Z80DisAssembler](https://github.com/sarnau/Z80DisAssembler) | Small command-line Z80 disassembler; repository metadata does not report a license. | Z80 candidate with licensing and reproducibility review required. | Do not install or automate until license, revision, invocation, output determinism, and raw-input behavior are independently pinned. |
| [lvitals/z80dasm](https://github.com/lvitals/z80dasm) | Z80 disassembler repository, GPL-2.0 according to metadata. | Potential independent Z80 byte-to-instruction comparator. | Candidate only; distinguish it from the currently installed `z80dasm` binary and retain an exact source/revision if selected. |
| [REDasm](https://github.com/redasm-dev/redasm) | Official README declares mature x86/x86_64 and DOS MZ/COM support, an intermediate representation and analysis views, but no decompiler and no Z80 processor entry. | i8086-family supplemental analysis candidate, not a Z80 tool. | Source-inspected candidate only. Evaluate a headless, pinned i8086 invocation after the adapter core can model executable/load semantics; do not treat GUI features as batch workflow support. |

## Framework implications

The existing runner hard-codes radare2, one family disassembler, and optional
Ghidra command construction. A reusable adapter must instead record a tool
identifier, source/release pin, CPU compatibility declaration, executable
probe, command-template fields, explicit origin/load-model requirements,
standard-output and standard-error capture, expected output paths and hashes,
failure classification, and a commentary boundary. Every adapter must reject an
incompatible architecture before invocation. Detailed analysis commentary must
separate immutable bytes, decoded instructions, tool-derived hypotheses, and
separately evidenced behavior.

## Sources

1. [py8dis repository](https://github.com/ZornsLemma/py8dis)
2. [SkoolKit repository](https://github.com/skoolkid/skoolkit)
3. [z80dismblr repository](https://github.com/maziac/z80dismblr)
4. [Z80DisAssembler repository](https://github.com/sarnau/Z80DisAssembler)
5. [lvitals/z80dasm repository](https://github.com/lvitals/z80dasm)
6. [REDasm repository and README](https://github.com/redasm-dev/redasm)

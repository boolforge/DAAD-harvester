# DazzleStar License and Build Boundary — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Can the pinned DazzleStar Z80 disassembler source enter a controlled fixture-health path? |
| **Candidate** | [`durgadas311/dazzlestar`](https://github.com/durgadas311/dazzlestar), revision `8841d4fa48bfeabd52b090b8e785637b767dafa3` |
| **License result** | No source license notice was observed; `dz/LICENSE` exists but is zero bytes. |
| **Build result** | The disassembler Makefile references `zmac` to assemble target artifacts and does not expose a native host command-line disassembly build. |
| **Admission result** | `blocked_by_license_or_build`; `execution_eligible: false`. |

## Source boundary

The pinned README describes an interactive Z80 disassembler with code scanning,
explicit entry points, and CP/M-format support. That interface description does
not resolve its source licensing. The checkout contains no nonempty license text
or source-level license notice, and its packaged `dz/LICENSE` is empty.

The `disas/Makefile` invokes `zmac` to assemble CP/M-oriented target artifacts.
The Java-side Makefile builds user-interface jars, but neither file establishes a
reproducible native host command that can safely run a controlled Z80 fixture.
No fixture command was attempted because the license and interface boundary is
already unresolved.

> An interactive-tool README and a code-scanner feature description are not a
> license, a reproducible command contract, recovered source, or runtime proof.

## Retained-byte boundary

The candidate stays out of the adapter catalog and retained runner. A future
review would first need an actual source license and a reproducible host command;
only then could a controlled fixture, a platform memory model, Z80 origin/base
and entry or trace evidence, and cross-tool disagreement review be considered.

## References

1. [Pinned DazzleStar repository](https://github.com/durgadas311/dazzlestar/tree/8841d4fa48bfeabd52b090b8e785637b767dafa3)
2. [Pinned DazzleStar README](https://github.com/durgadas311/dazzlestar/blob/8841d4fa48bfeabd52b090b8e785637b767dafa3/README.md)
3. [Pinned disassembler Makefile](https://github.com/durgadas311/dazzlestar/blob/8841d4fa48bfeabd52b090b8e785637b767dafa3/disas/Makefile)

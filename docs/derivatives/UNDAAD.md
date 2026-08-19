# UnDAAD: Obsolete, Bounded Decompiler Evidence

| Header field | Value |
| --- | --- |
| **Question** | What use of UnDAAD is lawful and evidentially defensible in a preservation workflow? |
| **Evidence scope** | P0 public LGPL-3.0 repository, README, and project-maintainer warning. |
| **Status** | source-backed |
| **Implementation links** | [`../../daad_harvester/fingerprint.py`](../../daad_harvester/fingerprint.py), [`../versions/COMPATIBILITY_BOUNDARIES.md`](../versions/COMPATIBILITY_BOUNDARIES.md), [`../RESEARCH_METHODOLOGY.md`](../RESEARCH_METHODOLOGY.md) |
| **Non-claims** | UnDAAD output is not recovered original source, an authoritative DDB specification, or a general decompiler for modern DAAD releases. |

## Project role and maintainer boundary

UnDAAD is a public LGPL-3.0 PHP decompiler project for games made with DAAD. Its maintainers label it obsolete, say it may be useful for early Aventuras AD DOS files, and direct modern work toward unDRC instead.[1]

> “This decompiler is obsolete … [it] may be useful to decompile early Aventuras AD games, from the DOS files.” — UnDAAD README.[1]

## Permitted evidential use

UnDAAD can be retained as a **tool provenance item** and, where an operator lawfully runs it on a preserved input, as an auxiliary derived artifact. The original bytes, command/version, output checksum, warnings, and explicit scope qualification must accompany any such result.

| Workflow step | Permitted conclusion | Prohibited conclusion |
| --- | --- | --- |
| Identify an input matching its stated early DOS/Aventuras AD scope | Candidate for bounded auxiliary analysis. | Universally supported DAAD database. |
| Run a pinned tool copy on retained bytes | Reproducible UnDAAD-derived representation. | Recovered original authoring source. |
| Compare output with independently measured structure | Possible discrepancy signal. | Proof that tool output defines format semantics. |
| Observe failure or warning | Evidence of tool/input mismatch. | Evidence that the source artifact is invalid. |

## Preservation contract

Harvester does not invoke UnDAAD as a silent normalizer or a DDB validator. Any future integration must be opt-in, preserve source bytes, label output as tool-derived, pin the tool revision, and cite the maintainer’s obsolescence notice. This protects provenance and prevents a derivative reconstruction from being confused with original, unavailable interpreter or authoring code.

## References

[1]: https://github.com/Utodev/undaad "UnDAAD public repository and maintainer warning"

# lybrown/dis Controlled-Fixture Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does the pinned lybrown/dis Perl script reproducibly statically trace a controlled MOS 6502 raw fixture with explicit origin and entry arguments? |
| **Candidate** | [`lybrown/dis`](https://github.com/lybrown/dis), revision `b4954cc90f210a64a3c63e87101a9a8786cd0247` |
| **Observed license** | MIT, from pinned `LICENSE.md`. |
| **Health result** | Perl syntax check passed. Two controlled raw-fixture commands emitted byte-identical listings. |
| **Admission result** | `health_checked`; `execution_eligible: false`; MOS 6502 only. |

## Pinned interface and controlled result

The tracked `dis` file is a Perl script, not an opaque native executable. Its
pinned SHA-256 is `0d5d8d82b69c2998a86f66fe00482eb2ea4f65dc8d188a439a5521b1ddfe04f7`.
The README documents raw input type, explicit raw origin (`-o`), and code entry
points (`-c`). The repository-owned
[`run_lybrown_dis_fixture_health.py`](../../scripts/run_lybrown_dis_fixture_health.py)
requires that exact script hash, creates `ea 60` in a temporary directory, and
runs the raw command twice with origin and entry `0x0000`.

The fixture SHA-256 is `c45e396ba1d4efd0ae131ef11e13a3eafabc904f8deb603b394344652b68d8b7`.
Each run emitted the `nop` and `rts` listing with SHA-256
`c4b12d51590643ee4585cd33b5797b891b6da6f70b942165e3842006a36f579a`.
This is a narrow reproducibility observation for the recorded command, not a
general correctness finding for the candidate's static tracing or code/data
classification.

## CPU and retained-byte boundary

The candidate is recorded only for MOS 6502. Its README's C64 PRG handling and
address-oriented static-tracing controls do not demonstrate MOS 8501 support or
equivalence. The harness therefore emits an explicit MOS 8501 refusal. A C64
retained use would still require independently evidenced 6502 CPU profile,
origin, base, entry, and cross-tool disagreement evidence. Plus/4 material
requires an independently suitable MOS 8501 comparator rather than a silent
substitution.

> A static code/data split, label, branch path, or output assembly line from
> lybrown/dis is a tool hypothesis. It is not recovered source code, a validated
> DAAD interpreter load model, or runtime behavior.

## References

1. [Pinned lybrown/dis repository](https://github.com/lybrown/dis/tree/b4954cc90f210a64a3c63e87101a9a8786cd0247)
2. [Pinned lybrown/dis README](https://github.com/lybrown/dis/blob/b4954cc90f210a64a3c63e87101a9a8786cd0247/README.md)
3. [Pinned MIT license](https://github.com/lybrown/dis/blob/b4954cc90f210a64a3c63e87101a9a8786cd0247/LICENSE.md)

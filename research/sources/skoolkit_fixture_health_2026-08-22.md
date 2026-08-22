# SkoolKit Controlled-Fixture Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does pinned SkoolKit reproducibly render a controlled raw-Z80 fixture when the origin, start, and end are explicit? |
| **Candidate** | [`skoolkid/skoolkit`](https://github.com/skoolkid/skoolkit), revision `760eeaa012926b4220ea5a370a2bdf99ba098eb0` |
| **Observed license** | GNU GPL version 3, from pinned `COPYING`. |
| **Health result** | Two `sna2skool.py` raw-memory invocations produced byte-identical skool listings. |
| **Admission result** | `health_checked`; `execution_eligible: false`. |

## Controlled raw-memory result

The pinned `sna2skool.py --help` explicitly states that it accepts a binary raw
memory file and exposes origin (`-o`), start (`-s`), and end (`-e`) arguments.
Two commands converted the literal Z80 bytes `00 c9` using hexadecimal output,
origin `0`, start `0`, and end `2`. The fixture SHA-256 is
`4690c1ed14ac5dd2e529dc29c12bc4561caf27c025346c7e81b28597aeeaa533`; each
listing was 76 bytes with SHA-256
`bdd3e32adb74f2914165b080a240a909de53ad9b0df56db0a930e61ddd09c875`.
The listing rendered a routine containing `NOP` and `RET`.

## Upstream-suite boundary

The unmodified upstream test suite did not pass on the observed Python 3.12
host. Before building the optional C extension, C-simulator tests found no
`CSimulator`. After `python3 setup.py build_ext --inplace`, the focused C-simulator
module still contained failures that expected `AttributeError` but observed a
`SystemError`, and expected older keyword-argument message text. Those results
are recorded as host and extension-compatibility evidence; they do not negate the
successful pure-Python raw converter fixture and must not be hidden as a full
source-suite pass.

> The controlled listing proves only one command’s repeatable rendering for two
> synthetic bytes at a declared origin and start. It does not recover source,
> establish a Spectrum memory map, validate an interpreter entry point, or prove
> behavior.

## Retained-byte boundary

Before any retained Z80 material can be considered, the candidate needs a
platform-specific memory representation, CPU/origin/base/entry or trace evidence,
and a preserved cross-tool disagreement record. A snapshot, raw memory file,
and control file carry distinct assumptions. SkoolKit remains an
`external_candidate` outside the retained reverse-analysis runner.

## References

1. [Pinned SkoolKit repository](https://github.com/skoolkid/skoolkit/tree/760eeaa012926b4220ea5a370a2bdf99ba098eb0)
2. [Pinned SkoolKit README](https://github.com/skoolkid/skoolkit/blob/760eeaa012926b4220ea5a370a2bdf99ba098eb0/README.md)
3. [Pinned SkoolKit GPL text](https://github.com/skoolkid/skoolkit/blob/760eeaa012926b4220ea5a370a2bdf99ba098eb0/COPYING)

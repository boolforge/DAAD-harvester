# DOS i8086 Load-Model Sources — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which format and loader facts must be evidenced before a DOS i8086 static-analysis candidate can receive a retained-byte invocation? |
| **Scope** | DOS `.COM` and 16-bit MZ `.EXE` load models, not filename-derived classification, Windows PE, or runtime behavior. |
| **Status** | Source evidence gathered; no retained DAAD artifact has been classified or analyzed. |

## MZ evidence

The MZ signature is a header field, not a filename guarantee. The executable
header records file page information, relocation count and table offset, header
paragraph count, allocation bounds, initial `SS:SP`, initial `CS:IP`, and overlay
number. The load module begins after `header_paragraphs * 16`; relocation entries
target words within that module and require the chosen load segment to be added.
The loader then derives relocated `CS` and `SS`, sets `IP` and `SP`, and, under
DOS, sets `DS` and `ES` to the PSP segment. [1] [2]

| Required retained evidence | Why a tool default is insufficient |
| --- | --- |
| Raw header bytes and parse result | `MZ` plus extension cannot rule out an extended or malformed format. |
| File-size and page-field consistency | Determines whether the recorded module boundary is meaningful. |
| Header paragraph count and module hash | Binds the analysis input to the bytes that DOS would load. |
| Full relocation-table parse and bounds checks | Segment-reference words change with load segment. |
| `CS:IP`, `SS:SP`, allocation, and overlay fields | Defines entry and stack assumptions; overlays cannot be silently folded into a main image. |
| PSP and selected start-segment policy | Explains `DS`/`ES` and relocation values under a DOS loader. |

## COM boundary

COM admission cannot be inferred merely from an extension or a raw-base-zero
disassembly. The record must separately evidence the DOS program image origin,
the 256-byte PSP relationship, entry state, and any wrapper or container that
delivered the image. A candidate may decode bytes only after those facts are
captured; decoded instructions remain tool output, not recovered source.

## Negative cases

The admission contract must refuse an i8086 candidate when the header is absent
or malformed, relocation entries exceed the declared module, an overlay is not
accounted for, a target is an extended MZ-derived format, the COM/EXE container
is unknown, or `CS:IP`/origin/segment evidence is missing. A raw-base-zero
listing can remain a clearly labeled comparison output but cannot answer those
questions.

## References

1. [OSDev Wiki: MZ](https://wiki.osdev.org/MZ)
2. [Phobos: Notes on the format of DOS .EXE files](https://www.tavi.co.uk/phobos/exeformat.html)
3. [MS-DOS Encyclopedia: Program Segment Prefix structure](https://www.pcjs.org/documents/books/mspl13/msdos/encyclopedia/appendix-h/)

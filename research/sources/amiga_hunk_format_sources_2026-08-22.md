# Amiga Hunk Container Format Sources

| Source | Bounded use in this repository |
| --- | --- |
| [Amiga Development Wiki: Hunk file format](http://amiga-dev.wikidot.com/file-format:hunk) | `HUNK_HEADER` is the header block used for executable load files and precedes hunk allocation information. |
| [Just Solve: Amiga Hunk](http://justsolve.archiveteam.org/wiki/Amiga_Hunk) | A fixed header includes hunk-count and lengths before one or more hunk records. |
| [HunkInfo source repository](https://github.com/asllop/HunkInfo) | Classic Amiga Hunk is used by executable and other AmigaOS binary objects; container recognition alone does not determine a runtime entry or behavior. |

The retained Amiga profile parser may use these sources to validate bounded
big-endian Hunk record structure. They do not establish a particular retained
program's AmigaOS version, process state, library base, allocation address,
entry semantics, source code, or runtime behavior.

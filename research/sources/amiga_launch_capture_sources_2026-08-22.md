# Amiga Future Launch-Capture Source Record

## Purpose

This record supports only a future official Amiga Hunk loader and process-state
capture schema. It does not identify a DAAD interpreter, establish a loader
observation, recover source, qualify static analysis, or claim runtime behavior.

## Documented state categories

AmigaOS documentation describes a process as an Exec task with AmigaDOS process
data, including a segment-list array, stack size and base, current directory,
I/O streams, CLI state, arguments, and local environment.[1] It documents
segment lists as loader-produced structures whose concrete allocation and
addresses are runtime facts.[1] The DOS autodocs expose `LoadSeg`, segment-list
allocation, process creation, and command execution APIs as distinct loader and
process mechanisms.[2]

A future official observation must bind exact Hunk identity and loader context;
Kickstart and AmigaDOS identities; loader and relocation trace; snapshot and
machine configuration; allocated segment-list and segment-address mapping;
process and CLI context; CPU registers and stack; library/device state; and
bootstrap-medium evidence. The retained Hunk structural records do not supply
those observations.

## Non-substitution boundary

An Atari ST basepage, a generic 68000 default, a different Amiga title, or a
static Hunk relocation listing cannot satisfy this future schema. Capture fields
remain bound to an official profile and observed AmigaOS launch transition.

## References

[1]: https://wiki.amigaos.net/wiki/AmigaDOS_Data_Structures "AmigaDOS Data Structures"
[2]: https://wiki.amigaos.net/amiga/autodocs/dos.doc.txt "AmigaDOS dos.library autodocs"

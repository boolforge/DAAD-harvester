# Plus/4 Future Launch-Capture Source Record

## Purpose

This record supports only the design of a future official Plus/4 launcher and
banking capture schema. It is not an observed DAAD launch, an interpreter
identification, a qualified analysis, or a runtime claim.

## Documented state categories

The Commodore Plus/4 Programmer's Reference Guide identifies the platform and
its programming context.[1] The annotated 264-series memory map identifies the
7501 data-direction and I/O registers at `$0000` and `$0001`, a current-bank
location, a dedicated banking work area, and BASIC `SYS` register storage.[2]
The TED reference identifies the video and interrupt register range and the
upper-memory RAM/ROM paging controls at `$FF3E` and `$FF3F`.[3]

A future official observation must therefore bind exact wrapper and loader
identities; the machine model and ROM identities; a capture snapshot and
transition trace; 7501 register state; TED paging, configuration, and interrupt
state; upper-memory RAM/ROM selection; CPU registers and stack; RAM mapping;
and any bootstrap-medium evidence. The current retained PRG wrappers provide
none of those observations.

## Non-substitution boundary

The shared 6502-family instruction set, a C64 processor-port default, an
unrelated Plus/4 title, or a generic emulator state cannot satisfy this future
schema. Each future capture remains profile-specific and must document its
official loader transition.

## References

[1]: https://archive.org/details/Plus-4_Programmers_Reference_Guide "Programmer's Reference Guide for the Commodore Plus/4"
[2]: https://www.floodgap.com/retrobits/ckb/secret/264memory.txt "Annotated Commodore 264/Plus/4 memory map"
[3]: https://plus4world.powweb.com/plus4encyclopedia/500024 "TED Registers"

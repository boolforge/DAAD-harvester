# DOS MZ Future Launch-Capture Source Record

## Purpose

This record supports only a future official DOS MZ loader and entry-state
capture schema. It does not establish a retained-program runtime launch,
qualified analysis, recovered source, or behavioral equivalence.

## Documented state categories

The MZ header specifies the load module, minimum and maximum allocation,
relative CS:IP and SS:SP, and relocation table. A DOS loader allocates memory,
builds a 256-byte PSP, copies and relocates the module, and then establishes
segment and stack registers before transferring control.[1] [2]

A future official observation must bind exact MZ and loader context; DOS and
boot-medium identities; loader/relocation transition; PSP and memory-allocation
mapping; actual load segment; environment, command-tail, FCB, handle, and DTA
state; 8086 registers and stack; and snapshot/machine configuration. Relative
header fields alone do not provide those actual launch observations.

## Non-substitution boundary

A generic DOSBox default, a different DOS title, an arbitrary segment origin,
or a raw-base-zero listing cannot satisfy this future schema. Every observation
must remain bound to an official retained MZ profile and documented launch.

## References

[1]: https://www.tavi.co.uk/phobos/exeformat.html "Notes on the format of DOS .EXE files"
[2]: https://wiki.osdev.org/MZ "MZ"

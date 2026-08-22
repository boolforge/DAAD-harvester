# REDasm Headless Reassessment — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does the pinned REDasm source now provide a reproducible noninteractive i8086 analysis or decompilation command? |
| **GUI source revision** | [`redasm-dev/redasm`](https://github.com/redasm-dev/redasm) `113245ef02090602978e461fcb7031b75da448d6` |
| **Result** | No standalone batch command was evidenced. The pinned repository identifies itself as GUI-only; engine functionality is split into a separate core repository. |
| **Decompilation status** | The pinned FAQ says that a decompiler is not yet available. |
| **Admission result** | Still unconfigured and non-executable for retained DAAD bytes. |

## Multi-repository boundary

The GUI README states that REDasm is split across repositories and directs builds
through the `redasm-dev/workspace` project. Its pinned FAQ identifies the GUI
repository as historical, says the engine lives in `redasm-dev/core`, and says a
Python plugin API is on the roadmap while extensions are written in C. It also
states that decompilation is not yet available.

The inspected workspace revision `7ee60fe5c6d5fe9a6ab98f057de3e09a225ba4b6`
requires CMake, C17/C++17, Qt 6.8 for the GUI, and component fetching through
`Setup.cmake`. It declares separate version overrides for core, GUI, loaders,
processors, commands, analyzers, and the knowledge base. Its documented build
and tests describe the full project and GUI dependencies, not a pinned standalone
headless analyzer command.

> GUI file-loading support, a library-oriented engine statement, or future
> scripting plans do not establish a deterministic headless invocation,
> recovered source, DOS load model, or runtime behavior.

## Required next evidence

A promotion attempt must first fix exact revisions for every required component,
build them reproducibly, identify a documented noninteractive command, run it
only on a controlled fixture, and capture deterministic output and failure data.
Any i8086 retained use would still require an independently evidenced DOS COM/MZ
segment, origin, entry, and cross-tool disagreement record.

## References

1. [Pinned REDasm GUI README](https://github.com/redasm-dev/redasm/blob/113245ef02090602978e461fcb7031b75da448d6/README.md)
2. [REDasm workspace README](https://github.com/redasm-dev/workspace)
3. [REDasm core repository](https://github.com/redasm-dev/core)

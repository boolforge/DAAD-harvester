# Reverse-Engineering Corpus Index

**Purpose:** This directory owns provenance-first analysis of interpreter and derivative artifacts. It distinguishes immutable originals, publicly released source, reproducible disassembly, tool-derived decompilation, and human analytical notes.

| Module | Single responsibility | Status |
| --- | --- | --- |
| [Authorization and handling](AUTHORIZATION_AND_HANDLING.md) | Per-artifact authorization, acquisition, retention, and publication gate. | Implementation contract |
| [Artifact classification](ARTIFACT_CLASSIFICATION.md) | Original/source/derived artifact classes and non-equivalence rules. | Implementation contract |
| [Architecture workflows](ARCHITECTURE_WORKFLOWS.md) | Reproducible analysis workflow per processor family. | Implementation contract |
| [Interpreter inventory](INTERPRETER_INVENTORY.md) | Per-binary/source/derivative provenance and analysis state. | Measured inventory |
| [Cross-tool verification](CROSS_TOOL_VERIFICATION.md) | Agreement/disagreement protocol for disassembly and decompiler outputs. | Implementation contract |

> **No derived source fiction.** Decompiler output is a tool-generated representation. It may support a hypothesis when tied to a checksum, load model, tool version, command, and independent verification, but it is never labelled “recovered original source code.”

The manifest field contract belongs in [the schema module](../schemas/REVERSE_ENGINEERING_MANIFEST.md); the global research boundary remains [the research methodology](../RESEARCH_METHODOLOGY.md).

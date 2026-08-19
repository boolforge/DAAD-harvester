# Executable, ROM, and Snapshot Evidence

| Header field | Value |
| --- | --- |
| **Question** | How are executable, ROM, and snapshot artifacts structurally identified and preserved without executing or treating them as implicit archive containers? |
| **Evidence scope** | P1 Harvester native inspection/tests; P0 public media references where format-specific behavior is cited. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/unpack.py`](../../daad_harvester/unpack.py), [`../../tests/test_media_inspection.py`](../../tests/test_media_inspection.py) |
| **Non-claims** | A valid MZ header, ROM signature, snapshot extension, or embedded string does not prove that the program is DAAD, safely runnable, or an extractable file container. |

## Structural-only categories

| Category | Scanner evidence | Preservation result |
| --- | --- | --- |
| DOS COM | Flat executable candidate based on context/extension. | Immutable artifact, hash, and candidate classification; never execute. |
| DOS MZ EXE | `MZ` identity with header-size/file-size arithmetic checks. | Header evidence including validated/rejected arithmetic. |
| MSX ROM | Header/layout marker and known header fields where present. | ROM evidence; unresolved mapper/banking remains explicit. |
| ZX/CPC snapshots | Extension/signature/memory-map structural inspection. | Snapshot evidence with recognized layout, not a reconstructed source tree. |
| Runtime binary | Filename plus SHA-256 profile protocol. | Exact/strong/candidate runtime identity independent of execution. |

## Why there is no execution path

Preservation scanning must be safe and reproducible. Harvester does not execute DOS programs, ROMs, snapshots, or retro binaries to identify them. It records immutable bytes, header facts, hashes, embedded bounded evidence where defined, and bundle neighbors. Emulation or public-derivative testing is a separate, opt-in research activity that cannot overwrite the original artifact record.

## Relationship to DDB and runtime identity

Executable analysis may identify an MZ header or a profile candidate. DDB analysis may independently validate data structure. Only the [interpreter identity protocol](../interpreters/IDENTITY_PROTOCOL.md) upgrades an exact binary claim; only [DDB generations](../versions/DDB_GENERATIONS.md) provides a structural DDB claim.

## References

[1]: [`media_inspection.py`](../../daad_harvester/media_inspection.py) structural scanner implementation
[2]: [Interpreter identity protocol](../interpreters/IDENTITY_PROTOCOL.md); [DDB generations](../versions/DDB_GENERATIONS.md)

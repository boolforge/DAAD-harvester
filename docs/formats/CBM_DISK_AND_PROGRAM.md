# Commodore Disk and Program Media

| Header field | Value |
| --- | --- |
| **Question** | How are CBM tape/disk/program containers separated into extractable file-oriented media and protected/low-level evidence? |
| **Evidence scope** | P0 VICE format reference; P1 Harvester T64/P00/PRG/G64/CBM-TAP inspection and extraction tests. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/unpack.py`](../../daad_harvester/unpack.py), [`../../tests/test_platform_media.py`](../../tests/test_platform_media.py) |
| **Non-claims** | Shared Commodore media does not collapse C64 and Plus/4 target identity, and G64/TAP recognition does not fabricate file members. |

## Family separation

| Family | Structural role | Harvester decision |
| --- | --- | --- |
| T64 | Tape-image directory with member offsets/lengths. | Validate entries and bounded spans; extract valid members. |
| P00 | Program wrapper with an embedded original-name/load context. | Validate wrapper and expose PRG payload with wrapper provenance. |
| PRG | Program bytes/load-address context. | Preserve as program evidence; inspect recursively only when an outer contract applies. |
| D64/D71 | Sector image selected by expected size and native unpacker path. | Traverse only through the validated disk rules; retain image identity with every output. |
| G64/G71 | Low-level GCR track representation. | Recognize/record track evidence; no filesystem reconstruction unless a validated GCR decoder succeeds. |
| CBM TAP | Pulse timing stream. | Recognize/record pulse evidence; no generic file extraction. |

## Extensionless C64 BASIC SYS launchers

A filename is not required to recognize the narrow retained launcher profile. Native inspection accepts only a C64 BASIC program with load address `0x0801`, a tokenized `SYS` line, an ASCII decimal target, a consistent next-line pointer, and the terminal BASIC null link. It records the resulting `c64-basic-sys-prg` medium evidence as C64 platform evidence only; it does **not** assert that the program contains a DAAD DDB or identify an interpreter.

The retained `JABATO P.1` and `JABATO P.2` D64 members both satisfy this contract and invoke `SYS 2061`. Their related DDB evidence is retained separately as runtime-derived recovery evidence, so a browser or TUI must not present the launcher byte itself as a DDB or as an interpreter-correlated binary. A malformed non-decimal `SYS` target is a pinned rejection case.

## Recognition, bounds, and integrity

VICE distinguishes program wrappers, tape images, sector images, and GCR media. That distinction is preservation-critical: a low-level GCR/pulse object may contain protection or nonstandard encoding that a filesystem parser cannot faithfully represent.[1]

T64 extraction validates directory entry offsets and ranges against the container. P00 extraction keeps both wrapper metadata and underlying program payload. G64/G71 and CBM TAP are dispatched to structural inspection and retained with parser status rather than passed into unrelated Spectrum or filesystem logic.[2]

## Canonical-target rule

`c64` and `plus4` are separate canonical targets. The report uses runtime profile, DDB target evidence, media identifiers, and bundle provenance together; a `.prg`, `.p00`, or Commodore disk image is not enough to select either target. See the [C64 dossier](../platforms/COMMODORE_64.md) and [Plus/4 dossier](../platforms/COMMODORE_PLUS4.md).

## Release gate

Any expansion of D64/D71 geometry support, G64 GCR decoding, or CBM tape reconstruction requires valid, malformed, truncated, protection-oriented, and provenance fixtures. A successful file-oriented extraction must never erase the original image or low-level track/pulse evidence.

## References

[1]: https://vice-emu.sourceforge.io/vice_17.html "VICE emulator file-format reference"
[2]: [`platform_media.py`](../../daad_harvester/platform_media.py) and [`media_inspection.py`](../../daad_harvester/media_inspection.py) in Harvester

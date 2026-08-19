# Atari Protected Media: STX/Pasti and IPF

| Header field | Value |
| --- | --- |
| **Question** | How are Atari protected-media formats recognized and retained without turning partial structural metadata into fictitious filesystem recovery? |
| **Evidence scope** | P0/P3 STX and IPF preservation references; P1 Harvester scanner tests. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../daad_harvester/unpack.py`](../../daad_harvester/unpack.py), [`../../tests/test_media_inspection.py`](../../tests/test_media_inspection.py) |
| **Non-claims** | STX/IPF recognition does not imply sector reconstruction, FAT extraction, executable identity, or protection removal. |

## Evidence-only contract

STX/Pasti is a protected-floppy representation. The retained reference identifies the `RSY` signature and describes the format’s preservation role, while directing detailed format treatment to linked technical documentation.[1] IPF is likewise a flux/protection-oriented preservation family rather than a generic directory container.[2]

| Input | Recognition | Output | Forbidden shortcut |
| --- | --- | --- | --- |
| STX | `RSY\0` signature and bounded header/track metadata. | `recognized_evidence` with signature, structural fields, and original hash. | Invent a FAT directory from arbitrary track data. |
| IPF | `CAPS`/IPF-oriented structural identity where scanner supports it. | `recognized_evidence` with media status and metadata. | Flatten protection/flux metadata into a lossless sector image without a validated decoder. |
| ST/MSA contrast | FAT/decoded MSA path is handled separately. | File extraction only after validated decompression/FAT traversal. | Treat every Atari disk extension as protected or every protected image as FAT. |

## Preservation rationale

Protection-relevant timing, weak-bit, track, and encoding information can be the decisive archaeological evidence. Retaining it in structured media evidence is a completed preservation act even when generic member extraction is correctly declined.

## References

[1]: http://justsolve.archiveteam.org/wiki/STX "STX preservation reference"
[2]: http://fileformats.archiveteam.org/wiki/IPF "IPF format registry"

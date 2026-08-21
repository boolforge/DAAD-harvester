# R4 MSX Companion Resources — Source Inventory Notes

## Scope and evidence boundary

This note records source-discovery observations for the active R4 MSX
companion-resource investigation. It is not a format specification and does
not promote an MDG decoder, a launcher load model, or compatibility with a
modern interpreter.

## Inspected sources

| Source | Revision or access point | Direct observation | Permitted use in this investigation |
| --- | --- | --- | --- |
| `nataliapc/msx2daad` | `afdd6d21406107bd2fcb969cbf2f06f234717ecf` | Its bundled historical manual states: “Use DSM to make a file for MSX (which will be called `PARTx.MDG`).” The modern MSX2DAAD source itself has no `DAAD.MDG` reference and instead loads a configurable DDB/font/optional image model. | Independent naming/history evidence only. It does not establish the R4 `DAAD.MDG` byte grammar. |
| `daad-adventure-writer/daad` | `4a7e745235a12af5b397902dbd9214bc930c7680` | `Interpreters/MSX/DAAD.MDG` is exactly 2,105 bytes and byte-identical to retained R4 `DAAD.MDG`. Its `xREADME.TXT` calls it an empty graphics database with the standard character set. `LOADMSX1.COM` and `LOADMSX2.COM` are 565-byte related loaders naming `PART1.DDB` and `PART2.DDB`, respectively. | Exact canonical-template and related-loader evidence. It does not establish a generic MDG grammar or the R4 launcher’s complete runtime behavior. |

## Immediate implications

The classic official repository resolves the R4 sample-identity question:
retained R4 `DAAD.MDG` and its `Interpreters/MSX/DAAD.MDG` sample have the
same 2,105-byte length and SHA-256
`c588b0e7cbdbd3a591085cd233d471c7a37fed85a88085ced8a560a42a759f06`.
The later public build script’s 2,300-byte minimum split geometry is therefore
a different profile/generation and cannot be borrowed for the R4 file.

The modern MSX2DAAD implementation must remain a separately pinned comparison
target. Its lack of `DAAD.MDG` loading logic is negative evidence against
using it as an R4 decoder oracle, not evidence that R4 MDG was unused.

## Sources

1. [MSX2DAAD repository](https://github.com/nataliapc/msx2daad), inspected at commit `afdd6d21406107bd2fcb969cbf2f06f234717ecf`.
2. [Classic DAAD repository](https://github.com/daad-adventure-writer/daad), accessed 2026-08-21.

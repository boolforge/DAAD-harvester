# Architecture-Static Controlled-Fixture Observations — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Do the configured architecture-static commands emit repeatable controlled-fixture listings, and can every emitted byte be treated as a deterministic health artifact? |
| **Evidence scope** | Two runs over literal temporary fixtures using `z80dasm 1.1.6`, `da65 V2.18`, GNU `m68k-linux-gnu-objdump 2.42`, and `ndisasm 2.16.01`. No retained DAAD input was opened. |
| **Result** | The Z80, 68000, and i8086 commands produced byte-identical relative-path listings. da65 changed only its generated timestamp across runs; after removing its `Created` and `Input file` comment lines, its controlled 6502 body was identical. |
| **Admission effect** | None. These observations are host-tool health findings for future automation, not a retained-byte origin, entry, load model, source-recovery, function-boundary, or runtime claim. |

The literal fixtures were Z80 `00 c9`, MOS 6502/8501 `ea 60`, 68000
`4e 71 4e 75`, and i8086 `90 c3`. The commands used the corresponding entries
from `toolchain.json`: `z80dasm -a -g 0`, `da65`, GNU objdump in binary 68000
mode with VMA zero, and `ndisasm -b 16 -o 0`.

| Executable | Observed path | SHA-256 |
| --- | --- | --- |
| z80dasm | `/usr/bin/z80dasm` | `f6b5bcfbccdda8608679d266f20556753b13bcb2386c610c0934ec3e5ff48e0c` |
| da65 | `/usr/bin/da65` | `6b24a8fb310b739f60fb56dba5c7c69c84c119005094378bf642640ba4b72ef0` |
| GNU m68k objdump | `/usr/bin/m68k-linux-gnu-objdump` | `240d1acf1e8f1e3a09498300e8ca4f23076df5f3f7c16af48d534efcc03feded` |
| ndisasm | `/usr/bin/ndisasm` | `6a85a9d1c8f05c8528895e091ed6b9c5b92b726a66ab0bf263199619663e4dc6` |

| Tool and fixture | Raw-listing observation | Hash-bound result |
| --- | --- | --- |
| z80dasm, `00 c9` | Relative-path output was byte-identical across two runs. | `5962336ab58752559b28862a5f5f7169cdb8cf7f7f0f3d233b6bb210be191ca3` |
| da65, `ea 60` | The `Created` timestamp differs between runs. Raw-output hashes therefore cannot represent reproducibility. | Normalized body hash: `7492468387495b52b20a9ca7015c1445fd9697e4a201d325d83f005e13696001` |
| GNU m68k objdump, `4e 71 4e 75` | Relative-path output was byte-identical across two runs. | `cbfc52a5dd6dff445d6e0881ae323a31ccc3972cfcf15304cd2df552a5cef594` |
| ndisasm, `90 c3` | Relative-path output was byte-identical across two runs. | `fc3911ab8e093fe81c57e480c575c5eeeadc8be54028a0d29ea7e57c24d3dbf4` |

> A future architecture-static health runner must keep all fixtures temporary,
> preserve raw tool output for provenance, and either record da65's timestamp
> variation explicitly or compare a documented normalized view. It must not
> overwrite legacy raw-analysis records or present normalized text as recovered
> source or runtime evidence.

## References

1. [Pinned architecture-static command definitions](../../reverse_engineering/workflows/toolchain.json)

# Independent `c64tapedecode` Comparison — Jabato Side A

> **Evidence class:** P2 independent implementation comparison. The retained source and generated output corroborate the native KERNAL-packet extractor only where their bytes agree; they do not replace original TAP bytes, the VICE runtime trace, or the active later-loader recovery work.

| Field | Value |
| --- | --- |
| Public source | `https://github.com/lunderhage/c64tapedecode.git` |
| Retained revision | `e37919fb7107babc590772994fe3e5814a697df4` |
| License statement retained in source | GNU GPL v2 or later |
| Retained source mirror | `reverse_engineering/public_implementations/c64tapedecode/source/` |
| Input | Original source-248 Side A C64 raw TAP |
| Invocation | `c64tapedecode -T -vv < Jabato_Side_A.tap` |
| Output | `jabato_side_a_jabato_1.p00` (317 bytes) |
| Output SHA-256 | `26d2b41eecb1b05a12e463ab1152ecb582c9b55a07761b404772917c8c9f1042` |

## Verified comparison result

The independent implementation identifies a 202-byte PRG header named `JABATO 1`, with load address `$029F` and exclusive end `$03C0`, then decodes its repeated 299-byte data packet. Its generated P00 wraps the 289-byte PRG payload with the standard 26-byte P00 wrapper and 2-byte C64 load address.

The native Harvester raw-TAP extractor retains the full first-copy 299-byte KERNAL packet. Removing its 9-byte KERNAL packet prefix yields 289 bytes. Removing the independent P00 wrapper and load address yields the same 289 bytes. Both normalized payloads have SHA-256 `bb002e977409838a8ecb78cfdbf9d12f52087ea01a6a65705d971d0eecda4ddf` and compare byte-for-byte equal.

| Native retained member | Native packet layout | Independent output layout | Normalized result |
| --- | --- | --- | --- |
| `depth2_e414a9cd_c64tap_kernal_packet_002.bin` | 9-byte KERNAL framing prefix + 289-byte loader + checksum | 26-byte P00 wrapper + 2-byte load address + 289-byte loader | **Byte-identical 289-byte loader payload** |

## Boundary

The independent program decodes the same early KERNAL-compatible header and loader packets as the native implementation and produces no later game database file from this Side A run. It therefore corroborates the early physical extraction, but it does **not** recover the verified 24,899-byte Part 1 DDB, model the later custom/adaptive stream, establish Part 2, or explain the ASS D64 scene packaging. Those remain active evidence-driven implementation loops.

## Retained files

| File | Purpose |
| --- | --- |
| `provenance.txt` | Repository URL and exact source revision. |
| `jabato_side_a_decoder.stderr` | Complete independent-decoder diagnostic trace. |
| `jabato_side_a_jabato_1.p00` | Generated P00 output, retained separately from source and native output. |

[1]: https://github.com/lunderhage/c64tapedecode "lunderhage/c64tapedecode public source repository"

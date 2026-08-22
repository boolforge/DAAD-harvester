# Official R4 `DAAD.FNT` Evidence Inventory

| Audit field | Value |
| --- | --- |
| **Scope** | The two 896-byte `DAAD.FNT` descendants materialized from official R4 source 250. |
| **Question** | Can either retained file be identified as a complete, natively decodable SINTAC or DAAD font profile? |
| **Status** | **No generic decoder promoted.** The populated member is a validated AMSDOS container and exact official CPC loader-font byte identity. The all-`E5` member is an exact R4 byte profile with no promoted font, erased-file, or runtime semantics. Neither member is compatible with the independently documented FNT3 profile. |

## Retained bytes

| Retained path | Size | SHA-256 | Measured structure | Current boundary |
| --- | ---: | --- | --- | --- |
| `preservation_corpus/extracted/depth2_f0f7416a_DAAD.FNT` | 896 | `87a077d1d65c2c1a3fc64c03fd2c3f25431d2c6a7fc36ebf23256b3aa9bf4f07` | Exact `daad-r4-source250-all-e5-byte-profile`: every byte is `E5`. | The profile records only exact byte identity, fill byte, and repeated-byte count. No font, erased-file, CP/M allocation, target, or runtime semantics are promoted from its filename or fill value alone. |
| `preservation_corpus/extracted/depth2_dcd3ab68_DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Valid AMSDOS binary header: type `0x02`, load address `0x9378`, 768-byte logical/real/stored payload, and matching checksum. Exact byte identity with the official classic CPC loader font is recorded in the CPC FNT dossier.[3] A pinned official changelog states that `DAAD.FNT` is the standard CPC font used by the CPC tape loader.[4] | Native recognition is limited to AMSDOS container validation, exact CPC loader-font identity, and the documented CPC package role. Glyph mapping, proportional-width semantics, rendering, and runtime load success remain unproven. |

The two byte sequences must remain separate artifacts. Equal filename and equal
length do not establish equivalent content, platform, source package, or
runtime behavior. The all-`E5` profile additionally requires both its exact
896-byte length and retained SHA-256; an equal-size mutation remains an
unrecognized FNT profile.

## Independent comparison evidence

ADP’s current font tool accepts the modern SINTAC profiles only when the file
is exactly 6,672 bytes and begins `JSJ SINTAC FNT3\0`; the same tool also
recognizes the corresponding FNT4 header family.[1] PCDAAD publishes an
independent 6,672-byte `DAAD.FNT` sample with that FNT3 signature and describes
SINTAC fonts as proportional; it uses the 8-pixel-high glyph set while ignoring
the 16-pixel-high set.[2] The retained 896-byte populated candidate is neither
byte-identical to that sample nor size/signature-compatible with the FNT3
acceptance predicate. It is instead an exact match to an official classic CPC
loader-font byte stream and validates as an AMSDOS binary container using the
independently retained DRC header-writer field contract.[3]

> The independently documented FNT3 behavior proves a **different modern
> profile**, not the grammar of either retained R4 896-byte file.

Current ADP target initializers attempt `.FNT` before `.CH0` or `.CHR` on
Atari ST, Amiga, DOS, and SDL paths.[1] This establishes that filename-based
FNT loading is part of a later cross-target fallback convention. It does not
identify the R4 source-250 896-byte candidate’s target, date, font geometry,
or load success.

## Required closure path

The canonical CPC member now has bounded container validation, but its payload
still requires independent loader/writer evidence before a renderer may claim
glyph geometry or character mapping. The all-`E5` member requires a separate
origin/profile evidence loop. The next work must establish font height(s),
glyph count, bit/plane packing, proportional-width data, character encoding,
and target rendering behavior with corruption controls and real artifacts. A
future font atlas is prohibited until those properties are natively verified.

## References

[1]: [Pinned ADP font tool and runtime font-loading source](https://github.com/jlcebrian/ADP/)
[2]: [PCDAAD README and published FNT3 sample](https://github.com/Utodev/PCDAAD)
[3]: [CPC FNT dossier and retained DRC AMSDOS header writer](../../../docs/formats/CPC_DAAD_FNT.md)
[4]: [Pinned official DAAD changelog CPC FNT evidence](../../../research/sources/daad_official_fnt_cpc_evidence.json)

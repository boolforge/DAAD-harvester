# CPC `DAAD.FNT` Provenance Record

| Header field | Value |
| --- | --- |
| **Question** | What can be asserted about the retained 896-byte `DAAD.FNT` file without conflating it with other `.FNT` families? |
| **Evidence scope** | P1 official DAAD changelog; P2 official public-source bytes and retained corpus bytes. |
| **Status** | Primary-source byte identity and bounded AMSDOS container validation are established for one retained artifact. No glyph decoder, renderer, or native generator is promoted. |
| **Primary revision** | `daad-adventure-writer/daad` revision `4a7e745235a12af5b397902dbd9214bc930c7680`. |

## Primary-source equality

The official DAAD changelog identifies `DAAD.FNT` as the standard CPC font used by the CPC tape loader.[1] At the recorded public revision, both `Deprecated/TAPMAST/DAAD.FNT` and `Interpreters/CPC/DAAD.FNT` are 896 bytes and have SHA-256 `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a`. The retained `depth1_dcd3ab68_DAAD.FNT` artifact has the same size and digest, establishing exact byte identity with both official copies.

The official CPC release readme independently describes `DAAD.FNT` as the standard CPC font “used by the loader only.” The 994-byte tokenized BASIC `Deprecated/TAPMAST/DLPART1.BAS` contains the literal filename `DAAD.FNT`, which establishes its packaging linkage without requiring an unsupported reconstruction of BASIC-token semantics. The retained byte stream now validates as a documented AMSDOS binary container: type `0x02`, load address `0x9378`, logical and real payload lengths of 768 bytes, a 768-byte stored payload after the 128-byte header, and a matching little-endian header checksum. These fields follow the retained public DRC AMSDOS-header writer contract.[2]

| Record | Size | SHA-256 | Evidence result |
| --- | ---: | --- | --- |
| Official `Deprecated/TAPMAST/DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Official source byte. |
| Official `Interpreters/CPC/DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Exact match to the TAPMAST copy. |
| Corpus `depth1_dcd3ab68_DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Exact match to both official copies. |
| Corpus `depth2_f0f7416a_DAAD.FNT` | 896 | `87a077d1d65c2c1a3fc64c03fd2c3f25431d2c6a7fc36ebf23256b3aa9bf4f07` | Different byte pattern; not classified as the official standard CPC font. |

## **Non-claims**

The matching 896-byte artifact is identified as the official CPC tape-loader font byte stream with a validated AMSDOS container, but this record does **not** claim glyph/pixel layout, character mapping, semantic rendering behavior, compatibility with other CPC loaders, equivalence to legacy 2,176-byte `.CHR` containers, equivalence to SINTAC FNT3/FNT4, or a native font generator. Those require independent format documentation, native byte-level validation, and retained behavior evidence.

## References

[1]: https://github.com/daad-adventure-writer/daad/blob/master/CHANGELOG.md “Official DAAD changelog: `DAAD.FNT` CPC tape-loader entry”
[2]: [Retained DRC AMSDOS header writer](../../reverse_engineering/public_sources/daad-ready-public-source-material/TOOLS/DRC/amsdosheader.php)

# CPC `DAAD.FNT` Provenance Record

| Header field | Value |
| --- | --- |
| **Question** | What can be asserted about the retained 896-byte `DAAD.FNT` file without conflating it with other `.FNT` families? |
| **Evidence scope** | P1 official DAAD changelog; P2 official public-source bytes and retained corpus bytes. |
| **Status** | Primary-source byte identity established for one retained artifact. No byte grammar, parser, renderer, or native generator is promoted. |
| **Primary revision** | `daad-adventure-writer/daad` revision `4a7e745235a12af5b397902dbd9214bc930c7680`. |

## Primary-source equality

The official DAAD changelog identifies `DAAD.FNT` as the standard CPC font used by the CPC tape loader.[1] At the recorded public revision, both `Deprecated/TAPMAST/DAAD.FNT` and `Interpreters/CPC/DAAD.FNT` are 896 bytes and have SHA-256 `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a`. The retained `depth1_dcd3ab68_DAAD.FNT` artifact has the same size and digest, establishing exact byte identity with both official copies.

| Record | Size | SHA-256 | Evidence result |
| --- | ---: | --- | --- |
| Official `Deprecated/TAPMAST/DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Official source byte. |
| Official `Interpreters/CPC/DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Exact match to the TAPMAST copy. |
| Corpus `depth1_dcd3ab68_DAAD.FNT` | 896 | `fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a` | Exact match to both official copies. |
| Corpus `depth2_f0f7416a_DAAD.FNT` | 896 | `87a077d1d65c2c1a3fc64c03fd2c3f25431d2c6a7fc36ebf23256b3aa9bf4f07` | Different byte pattern; not classified as the official standard CPC font. |

## **Non-claims**

The matching 896-byte artifact is identified as the official CPC tape-loader font byte stream, but this record does **not** claim a decoded header grammar, glyph/pixel layout, semantic rendering behavior, compatibility with other CPC loaders, equivalence to legacy 2,176-byte `.CHR` containers, equivalence to SINTAC FNT3/FNT4, or a native format generator. Those require independent format documentation, native byte-level validation, and retained behavior evidence.

## References

[1]: https://github.com/daad-adventure-writer/daad/blob/master/CHANGELOG.md “Official DAAD changelog: `DAAD.FNT` CPC tape-loader entry”

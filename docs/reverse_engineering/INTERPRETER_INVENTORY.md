# Interpreter Reverse-Engineering Inventory

| Header field | Value |
| --- | --- |
| **Question** | Which authorized interpreter/source artifacts have a reproducible reverse-engineering record in this repository? |
| **Evidence scope** | P0 authorization/license/source record; P1 immutable artifact hash and tool-run records. |
| **Status** | measured inventory; exact-profile originals and public derivative-source mirrors retained |
| **Implementation links** | [`../schemas/REVERSE_ENGINEERING_MANIFEST.md`](../schemas/REVERSE_ENGINEERING_MANIFEST.md), [`../interpreters/OFFICIAL_PROFILE_LEDGER.md`](../interpreters/OFFICIAL_PROFILE_LEDGER.md), [`AUTHORIZATION_AND_HANDLING.md`](AUTHORIZATION_AND_HANDLING.md) |
| **Non-claims** | The existing official-profile hash ledger proves only profiled binary identity; it does not mean the repository has authorization to commit every corresponding original binary or derived source artifact. |

## Inventory rule

Every artifact row must identify one exact byte/source input and its authorization state before tool execution. The inventory does not use placeholder binaries, guessed decompilation, or unverified mirrors. Until a row reaches an authorization state permitting retention, the repository tracks only source/provenance metadata and the analysis plan.

| Inventory state | Meaning | Repository content permitted now |
| --- | --- | --- |
| `planned` | A profile/source candidate is known, but authorization/acquisition record is not complete. | Documentation and manifest template only. |
| `manifest_only` | Source/authorization evidence may be incomplete or redistribution-restricted. | Metadata, hashes, and reproducibility recipe; no original bytes. |
| `authorized_retained` | Required authorization and source/hash records permit retention. | Immutable original plus linked derived records, within stated scope. |
| `analyzed_verified` | Independent tool and behavior checks have been recorded. | Qualified findings, disassembly/decompilation labelled as derived. |

## Measured inventory

The documented-authorization record permitted retention of **42 exact-hash official interpreter profiles** from the pinned public DAAD distribution revision `4a7e745235a12af5b397902dbd9214bc930c7680`. The immutable bytes live in [`../../reverse_engineering/artifacts/original/`](../../reverse_engineering/artifacts/original/) and every row, source path, authorization reference, size, and SHA-256 is held in [`official_interpreters.json`](../../reverse_engineering/manifests/official_interpreters.json). This is a profile-anchor corpus, not a claim that every historical interpreter version is yet represented.

| Canonical platform | Retained exact profiles |
| --- | ---: |
| ZX Spectrum | 2 |
| Amstrad CPC | 2 |
| Commodore 64 | 2 |
| Commodore Plus/4 | 2 |
| MSX | 2 |
| Amstrad PCW | 2 |
| Atari ST | 4 |
| Amiga | 4 |
| IBM PC/DOS | 22 |
| **Total** | **42** |

Six public source workspaces were mirrored separately under [`../../reverse_engineering/public_sources/`](../../reverse_engineering/public_sources/), with revision and license-scope metadata in [`public_sources.json`](../../reverse_engineering/manifests/public_sources.json). They contain DRC, MSX2DAAD, Maluva, PCDAAD, UnDAAD, and DAAD Ready public material. The relevant ADP implementation is retained separately and in full—including source, test/game material, and 20 published release assets—under [`../../reverse_engineering/public_implementations/adp/`](../../reverse_engineering/public_implementations/adp/), with [`adp_implementation.json`](../../reverse_engineering/manifests/adp_implementation.json) and [`adp_verification.json`](../../reverse_engineering/manifests/adp_verification.json) providing per-file and test-run evidence. The official DAAD distribution itself did **not** provide original interpreter source code.

## Third-party comparison search

The initial public web/GitHub discovery record is retained in [`third_party_comparisons.json`](../../reverse_engineering/manifests/third_party_comparisons.json). It found public independent implementations and ordinary DAAD project references, but no external disassembly/decompilation whose stated input was an exact SHA-256 match for a retained official profile. Consequently, no third-party decompilation is presently accepted as evidence; the candidate record remains useful for future re-checking.

## References

[1]: [Authorization and handling gate](AUTHORIZATION_AND_HANDLING.md)
[2]: [Official interpreter profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[3]: [Reverse-engineering manifest schema](../schemas/REVERSE_ENGINEERING_MANIFEST.md)
[4]: [Authorized original inventory manifest](../../reverse_engineering/manifests/official_interpreters.json)
[5]: [Public source mirror manifest](../../reverse_engineering/manifests/public_sources.json)
[6]: [Third-party comparison discovery manifest](../../reverse_engineering/manifests/third_party_comparisons.json)

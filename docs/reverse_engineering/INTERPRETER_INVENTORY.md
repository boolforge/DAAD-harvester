# Interpreter Reverse-Engineering Inventory

| Header field | Value |
| --- | --- |
| **Question** | Which authorized interpreter/source artifacts have a reproducible reverse-engineering record in this repository? |
| **Evidence scope** | P0 authorization/license/source record; P1 immutable artifact hash and tool-run records. |
| **Status** | index; authorization-gated inventory initially contains no newly stored original binary blobs |
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

## Current baseline

The [official profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md) provides hash anchors for all nine canonical target families. Those anchors are the starting index for future per-binary manifests; they are not copied into this inventory as stored originals until authorization and acquisition fields are complete.

## References

[1]: [Authorization and handling gate](AUTHORIZATION_AND_HANDLING.md)
[2]: [Official interpreter profile ledger](../interpreters/OFFICIAL_PROFILE_LEDGER.md)
[3]: [Reverse-engineering manifest schema](../schemas/REVERSE_ENGINEERING_MANIFEST.md)

# Reverse-Engineering Manifest Schema

| Header field | Value |
| --- | --- |
| **Question** | What machine-readable fields make a reverse-engineering artifact reproducible, attributable, and safely publishable? |
| **Evidence scope** | P0 authorization/license/source records; P1 acquisition and tool-execution measurements. |
| **Status** | implementation contract |
| **Implementation links** | [`../reverse_engineering/AUTHORIZATION_AND_HANDLING.md`](../reverse_engineering/AUTHORIZATION_AND_HANDLING.md), [`../reverse_engineering/ARTIFACT_CLASSIFICATION.md`](../reverse_engineering/ARTIFACT_CLASSIFICATION.md) |
| **Non-claims** | A complete manifest does not establish the legal validity of a permission or correctness of a tool-derived interpretation; it makes both auditable. |

## Required root fields

| Field | Type | Meaning |
| --- | --- | --- |
| `artifact_id` | string | Stable repository identifier; never derived only from a filename. |
| `artifact_class` | enum | One canonical class from the classification module. |
| `platform` | enum | Canonical DAAD target or `derivative`/`cross_platform` as justified. |
| `architecture` | enum | `z80`, `mos6502`, `mos8501`, `m68000`, `i8086`, or evidence-qualified alternative. |
| `sha256` | string | SHA-256 of the exact described byte/source artifact. |
| `origin` | object | Source URL, retrieved timestamp, observed name/path, acquisition notes. |
| `authorization` | object | State, evidence URL/path, scope, issuer/source, decision date, redistribution result. |
| `storage` | object | Repository path or explicitly absent/restricted state. |
| `analysis` | array | Tool-derived child records with input/output hashes and reproducibility fields. |

## Derived-analysis record

| Field | Meaning |
| --- | --- |
| `analysis_id` | Unique, hash-qualified tool run identifier. |
| `kind` | `disassembly`, `decompilation`, `symbol_recovery`, `control_flow`, or `verification`. |
| `derived_from_sha256` | Exact parent original/source hash. |
| `tool` | Tool name, version, distribution/source URL, and plugin/processor module where applicable. |
| `load_model` | Base/load address, entry points, memory map, endian assumptions, bank/overlay state. |
| `command` | Exact reproducible invocation/configuration reference; no credentials. |
| `output_sha256` | Hash of derived output. |
| `verification` | Independent tools/checks, agreement/disagreement statement, confidence, and evidence links. |
| `publication_status` | Whether output is publishable, restricted, or manifest-only under the parent authorization. |

## JSON shape

```json
{
  "artifact_id": "zx-ds48ie-d599b14576cb",
  "artifact_class": "original_binary",
  "platform": "zx",
  "architecture": "z80",
  "sha256": "d599b14576cb46f72b34b106f6ad1079cdf0d346ed9ac44e89db7dbd0c0eb3d6",
  "origin": {"url": "https://example.invalid/source", "retrieved_at": "YYYY-MM-DD"},
  "authorization": {"state": "user_claimed_permission", "redistribution": "not_published_pending_record"},
  "storage": {"status": "manifest_only"},
  "analysis": []
}
```

The URL above is deliberately non-operative and is not an artifact source. It demonstrates required field shape only.

## References

[1]: [Authorization and handling gate](../reverse_engineering/AUTHORIZATION_AND_HANDLING.md)
[2]: [Artifact classification](../reverse_engineering/ARTIFACT_CLASSIFICATION.md)

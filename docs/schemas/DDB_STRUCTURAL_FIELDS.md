# DDB Structural Validation Fields

| Header field | Value |
| --- | --- |
| **Question** | Which measured fields constitute Harvester’s target-aware DDB validation result, and which conclusions remain outside that result? |
| **Evidence scope** | P0 public DRC/MSX2DAAD-compatible implementation contracts; P1 parser output and fixtures. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/daad_parser.py`](../../daad_harvester/daad_parser.py), [`../../daad_harvester/fingerprint.py`](../../daad_harvester/fingerprint.py), [`../../tests/test_fingerprint.py`](../../tests/test_fingerprint.py) |
| **Non-claims** | Validation identifies a bounded DDB layout; it does not identify a title, author, product release, original runtime binary, or complete bytecode semantics. |

## Top-level result contract

`parse_ddb()` returns a positive result only after target-aware header, file-length, pointer, process-entry, and bytecode-terminator checks succeed. Failure returns a reason and empty details rather than a partial positive identification.[1]

| Field | Positive-result meaning | Negative-result behavior |
| --- | --- | --- |
| `is_daad` | `true` only after complete structural validation. | `false`; not a statement that bytes are non-DAAD in every possible undocumented form. |
| `confidence` / `confidence_label` | `1.0` / `verified` for parser-contract success. | `0.0` / `unverified`. |
| `version` | Human label such as `DAAD DDB v2` or `v3`. | `null`. |
| `ddb_format` | `daad-vN` for DRC layout or `daad-vN-legacy` for compact layout. | `null`. |
| `platform`, `language` | Decoded target/language fields in measured header. | `unknown`. |
| `reason` | Structural success or failure rationale. | Specific rejection/validation reason. |
| `details` | Full explainable field object listed below. | Empty object. |

## `details` object

| Key | Measured content | Validation role |
| --- | --- | --- |
| `structural_validation` | Literal `verified` for a positive parse. | Declares parser-contract result, not historical provenance. |
| `header` | Serialized `DDBHeader` fields. | Makes target/version/address/count/pointer decisions auditable. |
| `container_wrapper` | `raw`, validated +3DOS wrapper, or Commodore PRG wrapper with load address. | Separates outer representation from DDB payload. |
| `process_validation` | Process table offset, process offsets, parsed-entry count, and terminated-stream count. | Demonstrates bounded process/bytecode validation. |
| `payload_offset` | Offset of the validated DDB in artifact bytes. | Preserves wrapper/embedded location. |
| `payload_size` | Validated payload length. | Supports range/integrity review. |
| `embedded_offset` | Added by the fingerprinter when it scans a valid embedded candidate. | Distinguishes raw DDB from embedded DDB evidence. |
| `interpreter_matches` | Candidate runtime profile observations in the artifact’s immediate bundle. | Correlation only; see [identity protocol](../interpreters/IDENTITY_PROTOCOL.md). |

## Serialized header fields

| Field | Semantics | Bound/non-claim |
| --- | --- | --- |
| `major_version` | Measured DDB major layout value. | Only values accepted by parser contract; not authoring release. |
| `machine_id`, `platform` | Target machine nibble mapped under parser contract. | Does not identify an actual machine or executable binary. |
| `base_address`, `endianness` | Target interpretation used for pointer arithmetic. | DRC-compatible/legacy parser behavior, not universal platform file order. |
| `language`, `submachine` | Header-derived language/control/subtarget evidence. | Language bit/control field not a publication/language provenance proof. |
| `object_count`, `location_count`, `message_count`, `system_message_count`, `process_count` | Declared counts. | Valid only together with pointer/table bounds. |
| `pointers` | Parsed section/vector addresses. | A pointer alone does not establish section semantic completeness. |
| `file_length`, `header_size`, `layout` | Measured payload relation and validated layout family. | Not whole-container length if a wrapper/embedded offset exists. |

## Validation flow

The standalone diagram is [`../diagrams/DDB_VALIDATION_FLOW.mmd`](../diagrams/DDB_VALIDATION_FLOW.mmd). The parser rejects explicit non-DAAD engine/archive classes early, considers raw and validated wrapper offsets, applies DRC and compact legacy contracts separately, and requires at least one nonempty, terminated condact stream.[1]

## References

[1]: [`daad_parser.py`](../../daad_harvester/daad_parser.py) "Harvester target-aware DDB parser contract"
[2]: [DDB generations](../versions/DDB_GENERATIONS.md)

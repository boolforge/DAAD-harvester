# DDB Decompiler and Recompiler Round-Trip Contract

| Header field | Value |
| --- | --- |
| **Question** | How must a native DAAD DDB decompiler and recompiler progress from exact retained bytes to a justified byte-identical output claim? |
| **Evidence scope** | P0 native parser/recompiler and deterministic tests; P1 source-level compiler/runtime evidence; P2 retained original database bytes; P3 derived disassembly/decompilation evidence; P4 emulator observations where applicable. |
| **Status** | Implementation contract. The repository has structural DDB validation but does not yet provide a complete decompiler or recompiler. |
| **Implementation links** | `daad_harvester/daad_parser.py`, `tests/ddb_fixtures.py`, `tests/test_inspect_ddb_candidates.py`, [DDB generations](../versions/DDB_GENERATIONS.md), and [ADP toolchain analysis](../implementations/ADP_TOOLCHAIN_ANALYSIS.md). |

## Profile is the unit of completion

No DDB is described as generically “decompiled” or “recompiled.” Each result is bound to an explicit **profile tuple**: source SHA-256, parent/container/member lineage, wrapper state, major version, header layout, machine ID, submachine, byte order, base-address model, language, compiler/runtime evidence, and optional extension dialect. A change in any tuple member creates a distinct comparison record.

| Profile property | Required retained evidence | Recompiler consequence |
| --- | --- | --- |
| Original byte stream | Complete digest suite and immutable source path/byte range. | The byte-comparison oracle is the exact retained input, not a similarly named game or an external compile. |
| Header and wrapper | Native structural record for raw, Commodore, Plus3DOS, and any later profile-specific wrapper. | Emit the declared wrapper only when its field/checksum grammar is supported. |
| Section pointers and tables | Bounded decoded offsets, counts, table ownership, and range checks. | Recompute all writable pointers from the selected profile rather than copying incidental host addresses. |
| Bytecode and dialect | Construct-by-construct semantic ledger, including operand grammar and termination rule. | Serialize every accepted construct deterministically in the original order and representation. |
| Runtime/extension state | Pinned interpreter/source/disassembly or measured runtime record when relevant. | Do not infer an unsupported extension solely from a shared header. |

## Lossless intermediate representation

The native intermediate representation must retain both typed semantics and the original byte ordering. It therefore contains a byte-range ledger for every header field, table entry, text/token record, process entry, CondAct stream, resource pointer, alignment span, externally supplied payload, and wrapper field. Each node records its source range, profile predicate, decoded value where known, and the serializer rule that owns its output range.

An **opaque byte node** may preserve an as-yet-undecoded range during investigation, but it cannot be used to promote semantic decompilation support. The capability ledger must name its exact source range, profile, blocking grammar, and minimal reproducer. A profile becomes semantically complete only when no opaque node remains in a preservation-critical DDB section.

> A byte-identical opaque pass-through is an evidence-preserving scaffold, not a completed decompiler. It must never hide an unknown CondAct, text encoding, pointer form, extension, or resource rule.

## Deterministic round-trip procedure

The following procedure is mandatory for every supported profile. It uses repository-native code as the primary oracle and treats third-party compiler output as supplementary comparison evidence.

| Step | Deterministic input/output | Required assertion | Failure disposition |
| --- | --- | --- | --- |
| 1. Ingest | Exact retained bytes and lineage record. | Digest, wrapper, and profile tuple are recorded before parsing. | Reject ambiguous provenance or retain a source-level ambiguity record. |
| 2. Parse | Profile-selected bytes. | Every claimed structure is bounded; all unsupported ranges enter the capability ledger. | Preserve the exact byte range and a minimal reproducer. |
| 3. Decompile | Typed lossless IR. | IR nodes cover every original byte exactly once, excluding a declared wrapper handled separately. | Reject overlap, gap, or undocumented normalization. |
| 4. Recompile | IR plus explicit profile tuple. | No wall-clock, locale, filesystem metadata, unordered map traversal, random state, or external compiler result affects bytes. | Add deterministic input controls and regression coverage. |
| 5. Compare | Original and recompiled bytes. | Equal length and equality at every byte; complete digest suite matches. | Report first/last differing byte, contiguous ranges, node ownership, and profile context. |
| 6. Cross-check | Pinned ADP/DRC/runtime evidence where applicable. | Agreement or a retained, explained difference. | Keep the result non-promoted until the conflict is resolved. |
| 7. Publish | Regenerated evidence record. | Report, TUI, web, package, test, and CI surface status/checksums/boundaries. | Fail the appropriate promotion gate when required data is absent. |

## Capability ledger and blocker closure

The decompiler ledger is append-only with respect to observed input structures. Each row has a stable profile ID, source digest, byte start/end, structure class, semantic status, native parser/recompiler status, evidence links, regression fixture, and next concrete experiment. No artifact may disappear into a generic “unknown” aggregate.

| Ledger status | Meaning | Required next state |
| --- | --- | --- |
| `observed_unclassified` | Retained bytes are present but no format rule is established. | Source/specification/release investigation plus a minimal fixture. |
| `structurally_bounded` | Exact range and safe boundary are known; semantic grammar is incomplete. | Decode the grammar and add corruption regressions. |
| `semantically_decoded` | IR represents the construct but has no recompile proof. | Add profile-specific deterministic serialization and byte comparison. |
| `round_trip_verified` | The exact profile recompiled byte-identically in repository-native code. | Add independent source/runtime corroboration before compatibility promotion. |
| `runtime_correlated` | A versioned runtime observation agrees with the profile claim. | Maintain regression and regenerate public evidence. |

## Source and implementation cross-checks

The modern DDB header/pointer sequence must be compared with the public DRC compiler source and the pinned ADP DDB writer, while the historical/derivative layouts require their own source and retained-byte profiles. The public DRC source records target-aware header emission, pointer patching, and a Plus3 external-message size exception; the pinned ADP writer exposes a separate restoration/serialization path and explicitly declines certain PAWS 128K layouts.[1] [2] Neither implementation substitutes for the retained source-byte oracle.

The current Harvester parser validates target-aware modern and compact historical header layouts, wrappers, pointer ranges, process entries, and CondAct termination. That structural coverage is the required base layer, not a claim that operand semantics or source-level reconstruction are complete.[3]

## Deterministic automation and publication

Before the first DDB profile can be promoted, the repository must add a native round-trip command to the primary workflow. Its committed fixture list must regenerate every profile’s IR, recompile exact bytes, write a machine-readable comparison record, and verify its expected digests from a clean clone. Any emulator, ADP, DRC, or external-tool run is optional corroboration and must be separately capability-declared; it cannot become an unstated primary prerequisite.

The public report, Pages application, and TUI must show the profile tuple, original/recompiled complete digests, byte-comparison status, capability-ledger state, source/runtime evidence links, and any unresolved byte ranges. A successful structural parser result must remain visibly distinct from `round_trip_verified`.

## **Non-claims**

This contract does not claim a complete DDB grammar, a working native recompiler, byte-identical output for any retained game, source reconstruction, correct execution, emulator equivalence, or ScummVM readiness. It also does not permit a shared header, an ADP/DRC compile, an opaque pass-through, or a partial CondAct decode to be represented as complete DAAD decompilation.

## References

[1]: [ADP toolchain analysis](../implementations/ADP_TOOLCHAIN_ANALYSIS.md) “Pinned ADP DDB writer, compiler path, and round-trip boundary”

[2]: https://github.com/daad-adventure-writer/DRC/blob/e7bb170ef94e7b4965c0719b497638cec7aeaca9/src/drb.php “Public DRC target-aware DDB serialization and pointer patching”

[3]: [DDB structural fields](../schemas/DDB_STRUCTURAL_FIELDS.md) “Harvester’s current target-aware header and bounded structural model”

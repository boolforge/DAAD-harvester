# Legacy DDB Section-Map Crosswalk

| Header field | Value |
| --- | --- |
| **Question** | Which compact legacy DDB header words own the unresolved byte ranges reported by the native lossless IR? |
| **Evidence scope** | P0 native IR ledger and retained byte ranges; P1 pinned ADP loader and DDB map implementation. |
| **Status** | Source-backed section ownership, XOR-text records, and odd-byte message-table alignment; individual section-payload grammars remain pending. |
| **Implementation links** | [`../../daad_harvester/ddb_ir.py`](../../daad_harvester/ddb_ir.py), [`../../daad_harvester/daad_parser.py`](../../daad_harvester/daad_parser.py), and [`DDB_DECOMPILER_ROUND_TRIP.md`](DDB_DECOMPILER_ROUND_TRIP.md). |

## Pointer ownership

For the compact legacy layouts currently measured in the retained corpus, the native IR converts each nonzero target-endian header word through the selected profile base address, sorts the resulting source offsets, and splits opaque ranges at every source-backed section start. Therefore each pending range has a concrete owner such as `legacy_vocabulary_payload_pending_grammar`, rather than a generic unknown span.

| Header offset | V1 | V2 | ADP loader/table ownership | Current IR status |
| --- | --- | --- | --- | --- |
| `0x08` | Token block pointer | Token block pointer | Token block | Bounded; token compression grammar pending. |
| `0x0A` | Process table pointer | Process table pointer | Process table | Typed source-backed pointer words and resolved offsets; process-entry grammar is separately decoded. |
| `0x0C` | Object names pointer | Object names pointer | Object names table | Typed pointers and XOR-terminated text-record boundaries; token expansion remains separate. |
| `0x0E` | Location descriptions pointer | Location descriptions pointer | Location descriptions table | Typed pointers and XOR-terminated text-record boundaries; token expansion remains separate. |
| `0x10` | Messages pointer | Messages pointer | Messages table | Typed pointers and XOR-terminated text-record boundaries; token expansion remains separate. |
| `0x12` | System messages pointer | System messages pointer | System messages table | Typed pointers and XOR-terminated text-record boundaries; token expansion remains separate. |
| `0x14` | Connections pointer | Connections pointer | Connections table | Typed pointer words plus verb/destination byte-pair lists terminated by raw `0xFF`. |
| `0x16` | Vocabulary pointer | Vocabulary pointer | Vocabulary | Typed seven-byte records: five XOR-decoded characters, raw index/type, and raw `0x00` terminator. |
| `0x18` | Object locations pointer | Object locations pointer | Object locations table | Typed one-byte scalar entries. |
| `0x1A` | Object words pointer | Object words pointer | Object words table | Typed two-byte noun/adjective scalar pairs. The loader’s one-byte-per-object check is an acceptance minimum, not the full writer/dump record width. |
| `0x1C` | Object attributes pointer | Object attributes pointer | Object attributes table | Typed one-byte scalar entries. |
| `0x1E` | Declared size | Extended object-attributes pointer | Extended object attributes table in V2 | Typed V2 target-endian two-byte scalar entries. |
| `0x20` | External-data pointer | Declared size | External data field | V1 typed target-endian field when it precedes all mapped sections; zero denotes absence and in-payload target resolution remains bounded. |
| `0x22` | — | External-data pointer | External data field | V2 typed target-endian field when it precedes all mapped sections; zero denotes absence and in-payload target resolution remains bounded. |

## Evidence interpretation

Pinned ADP reads the first eleven pointers at `0x08`–`0x1C` in the table order above, validates their count-dependent minimum spans, translates stored addresses with `DDB_DecodeStoredOffset`, and then stores typed in-memory section pointers.[1] Its V2 loader additionally validates the extended object-attribute pointer at `0x1E` with a `numObjects * 2` minimum span.[1] The ADP DDB tool independently prints the same field sequence and builds a sorted memory map from these section pointers.[2] ADP’s compiler writes each vocabulary word as five XOR-encoded bytes followed by raw index and type bytes; its dump path independently walks seven-byte entries to a raw zero terminator.[3] [4] Its connection serializer independently emits verb/destination byte pairs, a raw `0xFF` terminator per location list, one raw alignment zero when the complete connection payload ends on an odd boundary, and then the target-endian location pointer table.[5] The retained DOS V2 `BLANK.DDB` follows that exact connection condition: `ConnectionListNode(0x08C0, 0x08C3)` is followed by `AlignmentPaddingNode(0x08C3, 0x08C4, 0x00)` and `connections_table` at `0x08C4`; changing that byte to nonzero leaves it opaque under the native negative regression. The same compiler writes one primary attribute byte per object, emits a raw zero when that table ends at an odd offset, then emits V2 two-byte extended attributes.[6] Retained DOS V2 `BLANK.DDB` and `SPANISH.DDB` independently pin this exact condition at `0x08CD` and `0x078B`, respectively; nonzero mutations remain opaque under the native negative regressions. The same compiler’s `AppendMessageTable()` writes each XOR-text payload, inserts one raw zero byte when that payload ends on an odd byte boundary, and only then writes the target-endian two-byte offset table.[7] The retained Amiga V2 `PART1.DDB` follows that exact condition at four independently pointer-bounded boundaries: `0x080B` before system messages, `0x088B` before messages, `0x089D` before object names, and `0x099F` before location descriptions. The native IR types each byte only when all of these source-backed predicates match; any other gap remains explicit in the opaque ledger. The object-word serializer independently emits a noun and adjective byte for every object; the parser therefore treats the loader’s smaller validation span as a minimum acceptance condition rather than the semantic table width.[8] ADP defines V1/V2 external-data field offsets and reads a nonzero pointer only where it fits before the first section; an out-of-database target is explicitly nonfatal rather than inferred as local data.[9]

> A section owner establishes a safe byte-boundary and a concrete next decoder target. It does **not** establish the payload’s complete syntax, text encoding, authoring origin, interpreter compatibility, or semantic decompilation.

## **Non-claims**

This crosswalk does not claim that any pending legacy section grammar is complete. It does not permit byte-identical pass-through, a structurally bounded section, an ADP memory-map label, or an opaque-range owner to be presented as semantic decoding, source reconstruction, runtime equivalence, or ScummVM readiness.

## References

[1]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/ddb.cpp “Pinned ADP compact DDB loader: target-endian pointer reads, bounds validation, stored-offset decoding, and V2 extended object attributes”

[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/tool_ddb.cpp “Pinned ADP DDB memory map and legacy header field crosswalk”

[3]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `AppendVocabularyWord`: seven-byte legacy vocabulary serialization”

[4]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/ddb_dump.cpp “Pinned ADP `/VOC` dump: seven-byte vocabulary stride, XOR text, raw index/type, and zero terminator”

[5]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `AppendConnections`: verb/destination pairs, `0xFF` list terminator, alignment, and pointer table”

[6]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `AppendMessageTable`: XOR-text payload alignment and target-endian offset-table serialization”

[7]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `AppendMessageTable`: XOR-text payload alignment and target-endian offset-table serialization”

[8]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `AppendObjectWords`: noun/adjective pair serialization per object”

[9]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/ddb.cpp “Pinned ADP V1/V2 external-data field offsets and bounded external-pointer handling”

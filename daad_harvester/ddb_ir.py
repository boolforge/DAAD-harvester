"""Lossless, profile-scoped intermediate representation for verified DDB bytes.

Design boundary: this initial IR owns every input byte exactly once and routes
CondAct streams through the native grammar.  It intentionally preserves as
opaque any header-adjacent or section bytes whose complete grammar has not yet
been implemented.  Such preservation enables deterministic investigation and
byte comparison; it is never a semantic-completeness claim.
"""

from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from typing import Any, Callable, TypeAlias

from daad_harvester.daad_parser import DAADBytecodeParser
from daad_harvester.ddb_grammar import (
    CondActStreamItem,
    DDBProfile,
    OpaqueCondActNode,
    decode_condact_stream,
    encode_condact_stream,
)


@dataclass(frozen=True, slots=True)
class DDBNode:
    """One top-level source range owned by exactly one lossless IR node."""

    byte_start: int
    byte_end: int
    profile_predicate: DDBProfile
    raw_bytes: bytes

    def __post_init__(self) -> None:
        if self.byte_start < 0 or self.byte_end < self.byte_start:
            raise ValueError("invalid DDB node byte range")
        if len(self.raw_bytes) != self.byte_end - self.byte_start:
            raise ValueError("DDB node raw bytes do not match its source range")


@dataclass(frozen=True, slots=True)
class WrapperNode(DDBNode):
    """A profile-declared outer wrapper preserved apart from DDB payload bytes."""

    wrapper_format: str


@dataclass(frozen=True, slots=True)
class HeaderNode(DDBNode):
    """The fixed initial DDB preamble, before target-endian pointer fields."""

    decoded_fields: tuple[tuple[str, Any], ...]


@dataclass(frozen=True, slots=True)
class PointerTableNode(DDBNode):
    """Target-endian header pointer/count continuation bytes and decoded words."""

    pointers: tuple[int, ...]
    file_length: int


@dataclass(frozen=True, slots=True)
class HeaderExtensionNode(DDBNode):
    """A versioned compact-header external-data field before the first section."""

    external_pointer: int
    resolved_offset: int | None
    is_absent: bool


@dataclass(frozen=True, slots=True)
class ProcessPointerTableNode(DDBNode):
    """A decoded process-table word sequence with stored and source offsets."""

    stored_pointers: tuple[int, ...]
    resolved_offsets: tuple[int, ...]


@dataclass(frozen=True, slots=True)
class OffsetTableNode(DDBNode):
    """A source-backed count-indexed table of stored and resolved DDB offsets."""

    table_kind: str
    stored_pointers: tuple[int, ...]
    resolved_offsets: tuple[int, ...]


@dataclass(frozen=True, slots=True)
class VocabularyNode(DDBNode):
    """A legacy seven-byte vocabulary record or its raw block terminator."""

    decoded_word: bytes
    word_index: int | None
    word_type: int | None
    is_terminator: bool


@dataclass(frozen=True, slots=True)
class ObjectTableNode(DDBNode):
    """A fixed-width legacy object table with source-decoded scalar entries."""

    table_kind: str
    entry_width: int
    values: tuple[int, ...]


@dataclass(frozen=True, slots=True)
class ConnectionListNode(DDBNode):
    """A legacy location connection list of verb/destination pairs and `0xFF`."""

    table_references: tuple[str, ...]
    pairs: tuple[tuple[int, int], ...]


@dataclass(frozen=True, slots=True)
class TextNode(DDBNode):
    """A XOR-encoded text record with its decoded terminator and table references."""

    table_references: tuple[str, ...]
    decoded_bytes: bytes
    decoded_terminator: int


@dataclass(frozen=True, slots=True)
class TokenNode(DDBNode):
    """A bounded non-PAWS token-block marker, record, or early sentinel."""

    token_index: int | None
    decoded_bytes: bytes
    node_kind: str


@dataclass(frozen=True, slots=True)
class AlignmentPaddingNode(DDBNode):
    """A raw zero byte aligning a legacy XOR-text payload's word-offset table."""

    alignment: int
    following_table_kind: str


@dataclass(frozen=True, slots=True)
class CondActStreamNode(DDBNode):
    """A terminated executable stream decoded by the selected native grammar."""

    items: tuple[CondActStreamItem, ...]
    referenced_by_entries: tuple[int, ...]


@dataclass(frozen=True, slots=True)
class ProcessEntryNode(DDBNode):
    """A verb/noun/stream-pointer record or its one-byte process-list terminator."""

    process_index: int
    verb: int | None
    noun: int | None
    condact_offset: int | None
    is_terminator: bool


@dataclass(frozen=True, slots=True)
class OpaqueNode(DDBNode):
    """Bounded byte range without a complete native semantic grammar yet."""

    structure_hint: str


TopLevelDDBNode: TypeAlias = (
    WrapperNode
    | HeaderNode
    | PointerTableNode
    | HeaderExtensionNode
    | ProcessPointerTableNode
    | OffsetTableNode
    | VocabularyNode
    | ObjectTableNode
    | ConnectionListNode
    | TextNode
    | TokenNode
    | AlignmentPaddingNode
    | CondActStreamNode
    | ProcessEntryNode
    | OpaqueNode
)


LEGACY_SECTION_NAMES: tuple[str, ...] = (
    "token_block",
    "process_table",
    "object_names_table",
    "location_descriptions_table",
    "messages_table",
    "system_messages_table",
    "connections_table",
    "vocabulary",
    "object_locations_table",
    "object_words_table",
    "object_attributes_table",
    "extended_object_attributes_table",
)


LEGACY_OFFSET_TABLES: tuple[tuple[str, int, str], ...] = (
    ("object_names_table", 2, "object_count"),
    ("location_descriptions_table", 3, "location_count"),
    ("messages_table", 4, "message_count"),
    ("system_messages_table", 5, "system_message_count"),
    ("connections_table", 6, "location_count"),
)

LEGACY_TEXT_TABLE_KINDS: tuple[str, ...] = (
    "object_names_table",
    "location_descriptions_table",
    "messages_table",
    "system_messages_table",
)


@dataclass(frozen=True, slots=True)
class DDBIR:
    """Complete source-byte ownership and profile identity for one DDB input."""

    profile: DDBProfile
    source_sha256: str
    source_size: int
    nodes: tuple[TopLevelDDBNode, ...]

    def validate_byte_ledger(self) -> None:
        """Require full, ordered, non-overlapping source coverage at byte precision."""

        expected_start = 0
        for node in self.nodes:
            if node.byte_start != expected_start:
                raise ValueError(
                    f"DDB byte ledger gap or overlap at {expected_start:#x}; "
                    f"next node begins at {node.byte_start:#x}"
                )
            expected_start = node.byte_end
        if expected_start != self.source_size:
            raise ValueError(
                f"DDB byte ledger ends at {expected_start:#x}, "
                f"not source size {self.source_size:#x}"
            )

    def opaque_ranges(self) -> tuple[tuple[int, int, str], ...]:
        """Return all unresolved ranges, including opaque CondActs within streams."""

        ranges: list[tuple[int, int, str]] = []
        for node in self.nodes:
            if isinstance(node, OpaqueNode):
                ranges.append((node.byte_start, node.byte_end, node.structure_hint))
            elif isinstance(node, CondActStreamNode):
                for item in node.items:
                    if isinstance(item, OpaqueCondActNode):
                        ranges.append((item.byte_start, item.byte_end, item.reason))
        return tuple(ranges)

    @property
    def is_semantically_complete(self) -> bool:
        """Whether no unresolved range remains anywhere in the current IR."""

        return not self.opaque_ranges()


class DDBProfileMismatch(ValueError):
    """Raised when verified header/wrapper facts differ from the selected profile."""


def _filename_for_profile(profile: DDBProfile) -> str:
    if profile.wrapper == "commodore-prg":
        return "profile.prg"
    if profile.wrapper == "raw":
        return "profile.ddb"
    return "profile.bin"


def _payload_offset_for_wrapper(wrapper: str, result: dict[str, Any]) -> int:
    measured = result["details"]["payload_offset"]
    if wrapper == "raw" and measured != 0:
        raise DDBProfileMismatch("raw profile resolved to a non-raw payload offset")
    return measured


def _assert_profile_matches(profile: DDBProfile, result: dict[str, Any]) -> None:
    header = result["details"]["header"]
    actual = {
        "layout": header["layout"],
        "major_version": header["major_version"],
        "machine_id": header["machine_id"],
        "platform": header["platform"],
        "endianness": header["endianness"],
        "base_address": header["base_address"],
        "wrapper": result["details"]["container_wrapper"]["format"],
    }
    expected = {
        "layout": profile.layout,
        "major_version": profile.major_version,
        "machine_id": profile.machine_id,
        "platform": profile.platform,
        "endianness": profile.endianness,
        "base_address": profile.base_address,
        "wrapper": profile.wrapper,
    }
    mismatches = {
        field: (expected[field], actual[field])
        for field in expected
        if expected[field] != actual[field]
    }
    if mismatches:
        raise DDBProfileMismatch(f"DDB header/profile mismatch: {mismatches!r}")


def _pointer_to_offset(address: int, base_address: int) -> int:
    if address < base_address:
        raise ValueError("DDB pointer falls below its profile base address")
    return address - base_address


def _read_word(data: bytes, offset: int, endianness: str) -> int:
    part = data[offset:offset + 2]
    if len(part) != 2:
        raise ValueError("truncated target-endian DDB word")
    return int.from_bytes(part, endianness)


def _process_entry_nodes(
    data: bytes,
    *,
    payload_offset: int,
    payload_size: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> tuple[
    list[ProcessEntryNode],
    dict[int, list[int]],
    tuple[int, int],
    tuple[int, ...],
    tuple[int, ...],
]:
    """Parse bounded process records without claiming unimplemented table grammar."""

    base_address = header["base_address"]
    endianness = header["endianness"]
    process_count = header["process_count"]
    process_table_relative = _pointer_to_offset(header["pointers"][1], base_address)
    process_table_start = payload_offset + process_table_relative
    process_table_end = process_table_start + process_count * 2
    payload_end = payload_offset + payload_size
    if process_table_relative < header["header_size"] or process_table_end > payload_end:
        raise ValueError("verified DDB process table is outside its payload")
    entries: list[ProcessEntryNode] = []
    stream_references: dict[int, list[int]] = {}
    seen_process_offsets: set[int] = set()
    stored_process_pointers: list[int] = []
    resolved_process_offsets: list[int] = []
    for process_index in range(process_count):
        process_address = _read_word(data, process_table_start + process_index * 2, endianness)
        process_relative = _pointer_to_offset(process_address, base_address)
        process_start = payload_offset + process_relative
        if process_relative < header["header_size"] or process_start >= payload_end:
            raise ValueError("verified DDB process pointer is outside its payload")
        stored_process_pointers.append(process_address)
        resolved_process_offsets.append(process_start)
        if process_start in seen_process_offsets:
            continue
        seen_process_offsets.add(process_start)
        entry_offset = process_start
        while entry_offset < payload_end:
            if data[entry_offset] == 0:
                entries.append(
                    ProcessEntryNode(
                        entry_offset,
                        entry_offset + 1,
                        profile,
                        data[entry_offset:entry_offset + 1],
                        process_index,
                        None,
                        None,
                        None,
                        True,
                    )
                )
                break
            if entry_offset + 4 > payload_end:
                raise ValueError("truncated verified DDB process entry")
            condact_address = _read_word(data, entry_offset + 2, endianness)
            condact_relative = _pointer_to_offset(condact_address, base_address)
            condact_offset = payload_offset + condact_relative
            if condact_relative < header["header_size"] or condact_offset >= payload_end:
                raise ValueError("verified DDB CondAct pointer is outside its payload")
            entries.append(
                ProcessEntryNode(
                    entry_offset,
                    entry_offset + 4,
                    profile,
                    data[entry_offset:entry_offset + 4],
                    process_index,
                    data[entry_offset],
                    data[entry_offset + 1],
                    condact_offset,
                    False,
                )
            )
            stream_references.setdefault(condact_offset, []).append(entry_offset)
            entry_offset += 4
        else:
            raise ValueError("unterminated verified DDB process-entry list")
    return (
        entries,
        stream_references,
        (process_table_start, process_table_end),
        tuple(stored_process_pointers),
        tuple(resolved_process_offsets),
    )


def _stream_nodes(
    data: bytes,
    *,
    stream_references: dict[int, list[int]],
    profile: DDBProfile,
    payload_end: int,
) -> list[CondActStreamNode]:
    streams: list[CondActStreamNode] = []
    for stream_start, references in sorted(stream_references.items()):
        items = decode_condact_stream(data, stream_start, profile, end=payload_end)
        if not items or items[-1].byte_end <= stream_start:
            raise ValueError("verified DDB CondAct stream did not retain a byte range")
        stream_end = items[-1].byte_end
        if not any(item.__class__.__name__ == "StreamTerminatorNode" for item in items):
            raise ValueError("verified DDB CondAct stream lacks a grammar terminator")
        streams.append(
            CondActStreamNode(
                stream_start,
                stream_end,
                profile,
                data[stream_start:stream_end],
                tuple(items),
                tuple(references),
            )
        )
    return streams


def _offset_table_nodes(
    data: bytes,
    *,
    payload_offset: int,
    payload_size: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> list[OffsetTableNode]:
    """Decode ADP-validated legacy count-indexed pointer tables losslessly."""

    nodes: list[OffsetTableNode] = []
    base_address = header["base_address"]
    payload_end = payload_offset + payload_size
    for table_kind, pointer_index, count_field in LEGACY_OFFSET_TABLES:
        table_address = header["pointers"][pointer_index]
        count = header[count_field]
        if not table_address or count == 0:
            continue
        table_start = payload_offset + _pointer_to_offset(table_address, base_address)
        table_end = table_start + count * 2
        if table_start < payload_offset + header["header_size"] or table_end > payload_end:
            raise ValueError(f"verified DDB {table_kind} is outside its payload")
        stored_pointers = tuple(
            _read_word(data, table_start + index * 2, header["endianness"])
            for index in range(count)
        )
        resolved_offsets = tuple(
            payload_offset + _pointer_to_offset(pointer, base_address)
            for pointer in stored_pointers
        )
        if any(
            offset < payload_offset + header["header_size"] or offset >= payload_end
            for offset in resolved_offsets
        ):
            raise ValueError(f"verified DDB {table_kind} contains an out-of-range pointer")
        nodes.append(
            OffsetTableNode(
                table_start,
                table_end,
                profile,
                data[table_start:table_end],
                table_kind,
                stored_pointers,
                resolved_offsets,
            )
        )
    return nodes


def _vocabulary_nodes(
    data: bytes,
    *,
    payload_offset: int,
    payload_end: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> list[VocabularyNode]:
    """Decode ADP's compact legacy vocabulary record and terminator grammar."""

    vocabulary_address = header["pointers"][7]
    vocabulary_start = payload_offset + _pointer_to_offset(vocabulary_address, header["base_address"])
    if vocabulary_start < payload_offset + header["header_size"] or vocabulary_start >= payload_end:
        raise ValueError("verified DDB vocabulary is outside its payload")
    nodes: list[VocabularyNode] = []
    position = vocabulary_start
    while position < payload_end:
        if data[position] == 0:
            nodes.append(
                VocabularyNode(
                    position,
                    position + 1,
                    profile,
                    data[position:position + 1],
                    b"",
                    None,
                    None,
                    True,
                )
            )
            return nodes
        if position + 7 > payload_end:
            raise ValueError("truncated verified DDB vocabulary record")
        raw = data[position:position + 7]
        nodes.append(
            VocabularyNode(
                position,
                position + 7,
                profile,
                raw,
                bytes((byte ^ 0xFF) & 0x7F for byte in raw[:5]),
                raw[5],
                raw[6],
                False,
            )
        )
        position += 7
    raise ValueError("verified DDB vocabulary lacks its raw 0x00 terminator")


def _token_nodes(
    data: bytes,
    *,
    payload_offset: int,
    payload_end: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> list[TokenNode]:
    """Decode ADP's bounded non-PAWS token records without over-scanning text."""

    token_address = header["pointers"][0]
    if not token_address or profile.grammar_dialect == "paws":
        return []
    start = payload_offset + _pointer_to_offset(token_address, header["base_address"])
    if start < payload_offset + header["header_size"] or start >= payload_end:
        raise ValueError("verified DDB token block is outside its payload")
    nodes = [
        TokenNode(start, start + 1, profile, data[start:start + 1], None, b"", "block_marker")
    ]
    position = start + 1
    for token_index in range(0x80, 0x100):
        if position >= payload_end:
            raise ValueError("verified DDB token block exceeds its payload")
        if data[position] == 0:
            nodes.append(
                TokenNode(
                    position,
                    position + 1,
                    profile,
                    data[position:position + 1],
                    None,
                    b"",
                    "early_block_sentinel",
                )
            )
            return nodes
        token_start = position
        while position < payload_end and (data[position] & 0x80) == 0 and data[position] != 0:
            position += 1
        if position >= payload_end or data[position] == 0:
            raise ValueError("verified DDB token record lacks a high-bit terminator")
        position += 1
        raw = data[token_start:position]
        nodes.append(
            TokenNode(
                token_start,
                position,
                profile,
                raw,
                token_index,
                bytes((*raw[:-1], raw[-1] & 0x7F)),
                "token_record",
            )
        )
    return nodes


def _object_table_nodes(
    data: bytes,
    *,
    payload_offset: int,
    payload_size: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> list[ObjectTableNode]:
    """Decode source-backed fixed-width location and attribute object tables."""

    object_count = header["object_count"]
    payload_end = payload_offset + payload_size
    table_specs = [
        ("object_locations_table", 8, 1),
        ("object_words_table", 9, 2),
        ("object_attributes_table", 10, 1),
    ]
    if header["major_version"] >= 2:
        table_specs.append(("extended_object_attributes_table", 11, 2))
    nodes: list[ObjectTableNode] = []
    for table_kind, pointer_index, entry_width in table_specs:
        table_address = header["pointers"][pointer_index]
        if not table_address:
            continue
        table_start = payload_offset + _pointer_to_offset(table_address, header["base_address"])
        table_end = table_start + object_count * entry_width
        if table_start < payload_offset + header["header_size"] or table_end > payload_end:
            raise ValueError(f"verified DDB {table_kind} is outside its payload")
        values = tuple(
            int.from_bytes(
                data[table_start + index * entry_width:table_start + (index + 1) * entry_width],
                header["endianness"],
            )
            for index in range(object_count)
        )
        nodes.append(
            ObjectTableNode(
                table_start,
                table_end,
                profile,
                data[table_start:table_end],
                table_kind,
                entry_width,
                values,
            )
        )
    return nodes


def _connection_list_nodes(
    data: bytes,
    *,
    offset_tables: list[OffsetTableNode],
    payload_end: int,
    profile: DDBProfile,
) -> list[ConnectionListNode]:
    """Decode ADP's verb/destination pairs ending in a raw `0xFF` byte."""

    references: dict[int, list[str]] = {}
    for table in offset_tables:
        if table.table_kind != "connections_table":
            continue
        for index, offset in enumerate(table.resolved_offsets):
            references.setdefault(offset, []).append(f"connections_table[{index}]")
    nodes: list[ConnectionListNode] = []
    for start, table_references in sorted(references.items()):
        position = start
        pairs: list[tuple[int, int]] = []
        while position < payload_end and data[position] != 0xFF:
            if position + 2 > payload_end:
                raise ValueError("truncated verified DDB connection pair")
            pairs.append((data[position], data[position + 1]))
            position += 2
        if position >= payload_end:
            raise ValueError("verified DDB connection list lacks its 0xFF terminator")
        byte_end = position + 1
        nodes.append(
            ConnectionListNode(
                start,
                byte_end,
                profile,
                data[start:byte_end],
                tuple(table_references),
                tuple(pairs),
            )
        )
    return nodes


def _text_nodes(
    data: bytes,
    *,
    offset_tables: list[OffsetTableNode],
    payload_end: int,
    profile: DDBProfile,
) -> list[TextNode]:
    """Decode ADP's XOR text-record boundary grammar without token expansion."""

    references: dict[int, list[str]] = {}
    for table in offset_tables:
        if table.table_kind not in LEGACY_TEXT_TABLE_KINDS:
            continue
        for index, offset in enumerate(table.resolved_offsets):
            references.setdefault(offset, []).append(f"{table.table_kind}[{index}]")
    terminator = 0x1F if profile.grammar_dialect == "paws" else 0x0A
    nodes: list[TextNode] = []
    for start, table_references in sorted(references.items()):
        end = start
        while end < payload_end and (data[end] ^ 0xFF) != terminator:
            end += 1
        if end >= payload_end:
            raise ValueError("verified DDB text record lacks an XOR-decoded terminator")
        byte_end = end + 1
        decoded_bytes = bytes(byte ^ 0xFF for byte in data[start:end])
        nodes.append(
            TextNode(
                start,
                byte_end,
                profile,
                data[start:byte_end],
                tuple(table_references),
                decoded_bytes,
                terminator,
            )
        )
    return nodes


def _message_table_alignment_nodes(
    data: bytes,
    *,
    offset_tables: list[OffsetTableNode],
    text_nodes: list[TextNode],
    profile: DDBProfile,
) -> list[AlignmentPaddingNode]:
    """Decode ADP's odd-byte XOR-text payload padding before its word table.

    `AppendMessageTable()` emits a raw zero only when the just-written message
    payload has odd length, then emits its target-endian two-byte offset table.
    The condition is retained here exactly: a known text table must begin one
    byte after its final referenced text record, that final record must end at
    an odd source offset, and the intervening byte must be zero.  Any other
    gap remains visible through the opaque byte ledger.
    """

    nodes: list[AlignmentPaddingNode] = []
    for table in offset_tables:
        if table.table_kind not in LEGACY_TEXT_TABLE_KINDS:
            continue
        table_references = f"{table.table_kind}["
        table_text_nodes = [
            node
            for node in text_nodes
            if any(reference.startswith(table_references) for reference in node.table_references)
        ]
        if not table_text_nodes:
            continue
        payload_end = max(node.byte_end for node in table_text_nodes)
        if (
            payload_end & 1
            and table.byte_start == payload_end + 1
            and data[payload_end:table.byte_start] == b"\x00"
        ):
            nodes.append(
                AlignmentPaddingNode(
                    payload_end,
                    table.byte_start,
                    profile,
                    data[payload_end:table.byte_start],
                    2,
                    table.table_kind,
                )
            )
    return nodes


def _fill_opaque_ranges(
    data: bytes,
    profile: DDBProfile,
    known_nodes: list[TopLevelDDBNode],
    opaque_hint: Callable[[int], str],
    opaque_boundaries: tuple[int, ...] = (),
) -> tuple[TopLevelDDBNode, ...]:
    """Fill every unowned gap with an explicit opaque node and validate ledger order."""

    ordered = sorted(known_nodes, key=lambda node: (node.byte_start, node.byte_end))
    boundaries = tuple(sorted({boundary for boundary in opaque_boundaries if 0 < boundary < len(data)}))
    nodes: list[TopLevelDDBNode] = []
    position = 0
    for node in ordered:
        if node.byte_start < position:
            raise ValueError(
                f"overlapping DDB structures at {node.byte_start:#x} before {position:#x}"
            )
        for boundary in boundaries:
            if position < boundary < node.byte_start:
                nodes.append(
                    OpaqueNode(
                        position,
                        boundary,
                        profile,
                        data[position:boundary],
                        opaque_hint(position),
                    )
                )
                position = boundary
        if position < node.byte_start:
            nodes.append(
                OpaqueNode(
                    position,
                    node.byte_start,
                    profile,
                    data[position:node.byte_start],
                    opaque_hint(position),
                )
            )
        nodes.append(node)
        position = node.byte_end
    for boundary in boundaries:
        if position < boundary < len(data):
            nodes.append(
                OpaqueNode(
                    position,
                    boundary,
                    profile,
                    data[position:boundary],
                    opaque_hint(position),
                )
            )
            position = boundary
    if position < len(data):
        nodes.append(
            OpaqueNode(
                position,
                len(data),
                profile,
                data[position:],
                opaque_hint(position),
            )
        )
    return tuple(nodes)


def _legacy_opaque_hint(
    header: dict[str, Any], payload_offset: int, position: int
) -> str:
    """Name an unresolved range by its ADP-mapped legacy pointer owner."""

    section_starts = sorted(
        (
            payload_offset + _pointer_to_offset(pointer, header["base_address"]),
            LEGACY_SECTION_NAMES[index],
        )
        for index, pointer in enumerate(header["pointers"])
        if pointer and index < len(LEGACY_SECTION_NAMES)
    )
    if not section_starts or position < section_starts[0][0]:
        return "legacy_header_extension_pending_grammar"
    owner = section_starts[0][1]
    for section_start, section_name in section_starts:
        if section_start > position:
            break
        owner = section_name
    return f"legacy_{owner}_payload_pending_grammar"


def _legacy_section_boundaries(header: dict[str, Any], payload_offset: int) -> tuple[int, ...]:
    """Return source-backed legacy pointer starts for opaque ownership splitting."""

    return tuple(
        payload_offset + _pointer_to_offset(pointer, header["base_address"])
        for pointer in header["pointers"]
        if pointer
    )


def _header_extension_node(
    data: bytes,
    *,
    payload_offset: int,
    payload_end: int,
    header: dict[str, Any],
    profile: DDBProfile,
) -> HeaderExtensionNode | None:
    """Decode ADP's V1/V2 external-data field when it precedes all sections."""

    field_offset = 32 if header["major_version"] == 1 else 34
    field_start = payload_offset + field_offset
    field_end = field_start + 2
    section_offsets = [
        payload_offset + _pointer_to_offset(pointer, header["base_address"])
        for pointer in header["pointers"]
        if pointer
    ]
    if field_end > payload_end or not section_offsets or field_end > min(section_offsets):
        return None
    pointer = _read_word(data, field_start, header["endianness"])
    resolved_offset: int | None = None
    if pointer:
        candidate = payload_offset + _pointer_to_offset(pointer, header["base_address"])
        if field_end <= candidate < payload_end:
            resolved_offset = candidate
    return HeaderExtensionNode(
        field_start,
        field_end,
        profile,
        data[field_start:field_end],
        pointer,
        resolved_offset,
        pointer == 0,
    )


def decompile_ddb(data: bytes, profile: DDBProfile) -> DDBIR:
    """Decompile a parser-verified DDB into a complete byte-owned native IR."""

    parser = DAADBytecodeParser()
    result = parser.parse_ddb(data, _filename_for_profile(profile))
    if not result["is_daad"]:
        raise ValueError(f"DDB did not validate before decompilation: {result['reason']}")
    _assert_profile_matches(profile, result)
    details = result["details"]
    header = details["header"]
    payload_offset = _payload_offset_for_wrapper(profile.wrapper, result)
    payload_size = details["payload_size"]
    payload_end = payload_offset + payload_size
    header_size = header["header_size"]
    if payload_offset + header_size > payload_end:
        raise ValueError("verified DDB header exceeds its payload")
    known_nodes: list[TopLevelDDBNode] = []
    if payload_offset:
        known_nodes.append(
            WrapperNode(
                0,
                payload_offset,
                profile,
                data[:payload_offset],
                profile.wrapper,
            )
        )
    known_nodes.extend(
        (
            HeaderNode(
                payload_offset,
                payload_offset + 8,
                profile,
                data[payload_offset:payload_offset + 8],
                tuple(sorted(header.items())),
            ),
            PointerTableNode(
                payload_offset + 8,
                payload_offset + header_size,
                profile,
                data[payload_offset + 8:payload_offset + header_size],
                tuple(header["pointers"]),
                header["file_length"],
            ),
        )
    )
    if profile.layout == "legacy":
        known_nodes.extend(
            _token_nodes(
                data,
                payload_offset=payload_offset,
                payload_end=payload_end,
                header=header,
                profile=profile,
            )
        )
        header_extension = _header_extension_node(
            data,
            payload_offset=payload_offset,
            payload_end=payload_end,
            header=header,
            profile=profile,
        )
        if header_extension is not None:
            known_nodes.append(header_extension)
    (
        entries,
        stream_references,
        process_table_range,
        stored_process_pointers,
        resolved_process_offsets,
    ) = _process_entry_nodes(
        data,
        payload_offset=payload_offset,
        payload_size=payload_size,
        header=header,
        profile=profile,
    )
    known_nodes.append(
        ProcessPointerTableNode(
            process_table_range[0],
            process_table_range[1],
            profile,
            data[process_table_range[0]:process_table_range[1]],
            stored_process_pointers,
            resolved_process_offsets,
        )
    )
    offset_tables: list[OffsetTableNode] = []
    if profile.layout == "legacy":
        known_nodes.extend(
            _vocabulary_nodes(
                data,
                payload_offset=payload_offset,
                payload_end=payload_end,
                header=header,
                profile=profile,
            )
        )
        known_nodes.extend(
            _object_table_nodes(
                data,
                payload_offset=payload_offset,
                payload_size=payload_size,
                header=header,
                profile=profile,
            )
        )
        offset_tables = _offset_table_nodes(
            data,
            payload_offset=payload_offset,
            payload_size=payload_size,
            header=header,
            profile=profile,
        )
        known_nodes.extend(offset_tables)
        known_nodes.extend(
            _connection_list_nodes(
                data,
                offset_tables=offset_tables,
                payload_end=payload_end,
                profile=profile,
            )
        )
        text_nodes = _text_nodes(
            data,
            offset_tables=offset_tables,
            payload_end=payload_end,
            profile=profile,
        )
        known_nodes.extend(text_nodes)
        known_nodes.extend(
            _message_table_alignment_nodes(
                data,
                offset_tables=offset_tables,
                text_nodes=text_nodes,
                profile=profile,
            )
        )
    known_nodes.extend(entries)
    known_nodes.extend(
        _stream_nodes(
            data,
            stream_references=stream_references,
            profile=profile,
            payload_end=payload_end,
        )
    )
    ir = DDBIR(
        profile,
        sha256(data).hexdigest(),
        len(data),
        _fill_opaque_ranges(
            data,
            profile,
            known_nodes,
            (
                lambda position: _legacy_opaque_hint(header, payload_offset, position)
                if profile.layout == "legacy"
                else "unimplemented_drc_section_or_alignment"
            ),
            (
                _legacy_section_boundaries(header, payload_offset)
                if profile.layout == "legacy"
                else ()
            ),
        ),
    )
    ir.validate_byte_ledger()
    return ir


def recompile_ddb(ir: DDBIR, profile: DDBProfile) -> bytes:
    """Recompile a lossless IR deterministically without an external compiler."""

    if ir.profile != profile:
        raise DDBProfileMismatch("recompile profile differs from the decompiled IR profile")
    ir.validate_byte_ledger()
    output = bytearray()
    for node in ir.nodes:
        if isinstance(node, CondActStreamNode):
            output.extend(encode_condact_stream(node.items, profile))
        else:
            output.extend(node.raw_bytes)
    if len(output) != ir.source_size:
        raise ValueError("recompiled DDB length differs from the source byte ledger")
    return bytes(output)

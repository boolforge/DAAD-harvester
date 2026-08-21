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
from typing import Any, Literal, TypeAlias

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
class TextNode(DDBNode):
    """Reserved typed node for a source-backed DDB text record grammar."""

    text_encoding: str | None = None


@dataclass(frozen=True, slots=True)
class TokenNode(DDBNode):
    """Reserved typed node for a source-backed compressed-token grammar."""

    token_value: int | None = None


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
    | TextNode
    | TokenNode
    | CondActStreamNode
    | ProcessEntryNode
    | OpaqueNode
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
) -> tuple[list[ProcessEntryNode], dict[int, list[int]], tuple[int, int]]:
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
    for process_index in range(process_count):
        process_address = _read_word(data, process_table_start + process_index * 2, endianness)
        process_relative = _pointer_to_offset(process_address, base_address)
        process_start = payload_offset + process_relative
        if process_relative < header["header_size"] or process_start >= payload_end:
            raise ValueError("verified DDB process pointer is outside its payload")
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
    return entries, stream_references, (process_table_start, process_table_end)


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


def _fill_opaque_ranges(
    data: bytes,
    profile: DDBProfile,
    known_nodes: list[TopLevelDDBNode],
) -> tuple[TopLevelDDBNode, ...]:
    """Fill every unowned gap with an explicit opaque node and validate ledger order."""

    ordered = sorted(known_nodes, key=lambda node: (node.byte_start, node.byte_end))
    nodes: list[TopLevelDDBNode] = []
    position = 0
    for node in ordered:
        if node.byte_start < position:
            raise ValueError(
                f"overlapping DDB structures at {node.byte_start:#x} before {position:#x}"
            )
        if position < node.byte_start:
            nodes.append(
                OpaqueNode(
                    position,
                    node.byte_start,
                    profile,
                    data[position:node.byte_start],
                    "unimplemented_section_or_alignment",
                )
            )
        nodes.append(node)
        position = node.byte_end
    if position < len(data):
        nodes.append(
            OpaqueNode(
                position,
                len(data),
                profile,
                data[position:],
                "unimplemented_section_or_alignment",
            )
        )
    return tuple(nodes)


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
    entries, stream_references, process_table_range = _process_entry_nodes(
        data,
        payload_offset=payload_offset,
        payload_size=payload_size,
        header=header,
        profile=profile,
    )
    known_nodes.append(
        OpaqueNode(
            process_table_range[0],
            process_table_range[1],
            profile,
            data[process_table_range[0]:process_table_range[1]],
            "process_pointer_table_structure_pending",
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
        _fill_opaque_ranges(data, profile, known_nodes),
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

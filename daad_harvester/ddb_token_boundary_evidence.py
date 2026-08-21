"""Deterministic evidence for a rejected retained legacy token-boundary probe.

This module preserves an implementation defect discovered while testing an
unaccepted candidate rule from the pinned ADP non-PAWS token scan. The original
probe continued beyond ADP's documented maximum token index of 255 and reported
an overlap at index 256. The evidence proves that the apparent conflict lay
outside the candidate rule and must not be recorded as a profile blocker.
"""

from __future__ import annotations

from hashlib import sha256
from pathlib import Path
from typing import Any, Final

from daad_harvester.daad_parser import DAADBytecodeParser


REPOSITORY_ROOT: Final = Path(__file__).resolve().parents[1]
SOURCE_PATH: Final = "preservation_corpus/extracted/depth1_98397784_BLANK.DDB"
SOURCE_SHA256: Final = "8f45acdfe4813996cb3895dd66d2d9e6f0685acfc94c1ec35ed3eeb626cdad84"
TEXT_TABLES: Final = (
    ("object_names_table", 2, "object_count"),
    ("location_descriptions_table", 3, "location_count"),
    ("messages_table", 4, "message_count"),
    ("system_messages_table", 5, "system_message_count"),
)


def _read_word(data: bytes, offset: int, endianness: str) -> int:
    return int.from_bytes(data[offset:offset + 2], endianness)


def _text_references(data: bytes, header: dict[str, Any]) -> list[dict[str, Any]]:
    """Return independently resolved text starts from legacy offset tables."""

    references: list[dict[str, Any]] = []
    base_address = header["base_address"]
    for table_kind, pointer_index, count_field in TEXT_TABLES:
        table_start = header["pointers"][pointer_index] - base_address
        for index in range(header[count_field]):
            stored_pointer = _read_word(data, table_start + index * 2, header["endianness"])
            references.append(
                {
                    "table": table_kind,
                    "index": index,
                    "stored_pointer": stored_pointer,
                    "source_offset": stored_pointer - base_address,
                }
            )
    return sorted(references, key=lambda item: (item["source_offset"], item["table"], item["index"]))


def retained_token_boundary_blocker_evidence() -> dict[str, Any]:
    """Reproduce the rejected unbounded probe and ADP's bounded scan result."""

    path = REPOSITORY_ROOT / SOURCE_PATH
    data = path.read_bytes()
    if sha256(data).hexdigest() != SOURCE_SHA256:
        raise AssertionError("retained token-boundary source digest changed")
    result = DAADBytecodeParser().parse_ddb(data, path.name)
    if not result["is_daad"]:
        raise AssertionError(f"retained token-boundary source did not validate: {result['reason']}")
    header = result["details"]["header"]
    token_start = header["pointers"][0] - header["base_address"]
    text_references = _text_references(data, header)
    references_by_offset: dict[int, list[dict[str, Any]]] = {}
    for reference in text_references:
        references_by_offset.setdefault(reference["source_offset"], []).append(reference)

    def scan(*, maximum_index: int | None) -> dict[str, Any] | None:
        position = token_start + 1
        token_index = 0x80
        while position < len(data) and (maximum_index is None or token_index <= maximum_index):
            record_start = position
            while position < len(data) and (data[position] & 0x80) == 0 and data[position] != 0:
                position += 1
            if position >= len(data) or data[position] == 0:
                return None
            position += 1
            conflicts = [
                reference
                for offset, entries in references_by_offset.items()
                if record_start <= offset < position
                for reference in entries
            ]
            if conflicts:
                return {
                    "candidate_token_index": token_index,
                    "candidate_token_byte_start": record_start,
                    "candidate_token_byte_end": position,
                    "candidate_token_raw_hex": data[record_start:position].hex(),
                    "text_references": conflicts,
                }
            token_index += 1
        return None

    unbounded_overlap = scan(maximum_index=None)
    bounded_overlap = scan(maximum_index=0xFF)
    if unbounded_overlap is None or unbounded_overlap["candidate_token_index"] != 0x100:
        raise AssertionError("rejected unbounded token probe did not reproduce its index-256 overlap")
    if bounded_overlap is not None:
        raise AssertionError("ADP-bounded token scan unexpectedly overlaps a text reference")
    return {
        "schema_version": 1,
        "status": "rejected_probe_defect_closed",
        "profile": {
            "layout": header["layout"],
            "major_version": header["major_version"],
            "machine_id": header["machine_id"],
            "platform": header["platform"],
            "endianness": header["endianness"],
            "base_address": header["base_address"],
            "wrapper": result["details"]["container_wrapper"]["format"],
        },
        "source_path": SOURCE_PATH,
        "source_sha256": SOURCE_SHA256,
        "candidate_rule": "adp_non_paws_tokens_plus_one_high_bit_termination_zero_sentinel_index_0x80_through_0xff",
        "token_block_start": token_start,
        "unbounded_probe_overlap": unbounded_overlap,
        "adp_bounded_scan_overlap": bounded_overlap,
        "correction": "The index-256 overlap is outside ADP's n <= 255 loop and was caused by the rejected probe omitting that bound.",
    }

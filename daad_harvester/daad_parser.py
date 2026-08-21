"""Structural DAAD DDB recognition.

Recognition is based on actual DAAD interpreter/database contracts, not on
filenames or incidental text. A verified candidate must pass target-aware
header, length, offset, process-table, entry-reference, and bytecode-boundary
validation. The modern DRC layout and the compact historical V1/V2 layout
implemented by the open-source MSX2DAAD interpreter are validated separately;
runtime identity is handled through binary profiles.
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any, Dict, Optional, Tuple


MACHINE_IDS = {
    0x0: ("dos", 0x0000, "big"),
    0x1: ("zx", 0x8400, "big"),
    0x2: ("c64", 0x3880, "big"),
    0x3: ("cpc", 0x2880, "big"),
    0x4: ("msx", 0x0100, "big"),
    0x5: ("atarist", 0x0000, "little"),
    0x6: ("amiga", 0x0000, "little"),
    0x7: ("pcw", 0x0100, "big"),
    0xE: ("plus4", 0x7080, "big"),
    0xF: ("msx", 0x0000, "big"),  # MSX2 / MSX2DAAD subtarget
}

HEADER_SIZE = 60
HEADER_POINTER_COUNT = 13
LEGACY_HEADER_SIZE = 34
LEGACY_POINTER_COUNT = 13
LEGACY_V1_HEADER_SIZE = 32
LEGACY_V1_SECTION_POINTER_COUNT = 11
MAX_EMBEDDED_SCAN = 524_288
MAX_PROCESS_ENTRIES = 256
MAX_BYTECODE_LENGTH = 1024


@dataclass(frozen=True)
class DDBHeader:
    """A decoded DRC-compatible DAAD DDB header."""

    major_version: int
    machine_id: int
    platform: str
    base_address: int
    endianness: str
    language: str
    submachine: int
    object_count: int
    location_count: int
    message_count: int
    system_message_count: int
    process_count: int
    pointers: tuple[int, ...]
    file_length: int
    header_size: int = HEADER_SIZE
    layout: str = "drc"

    @property
    def expected_size(self) -> int:
        return self.file_length - self.base_address


class DAADBytecodeParser:
    """Validate DDB structure and discover embedded target-specific databases."""

    def is_explicit_rejection(self, data: bytes, filename: str) -> Tuple[bool, str]:
        """Reject known non-DAAD types before structural parsing."""

        extension = Path(filename).suffix.casefold()
        rejected_extensions = {
            ".php", ".html", ".htm", ".xml", ".json", ".css", ".js", ".py",
            ".cpp", ".h", ".c", ".txt", ".md", ".rpy", ".rpyc", ".nes",
            ".sfc", ".smc", ".z64", ".v64", ".n64", ".gba", ".gbc", ".gb",
            ".nds", ".3ds", ".iso", ".cue", ".mp3", ".mp4", ".wav", ".flac",
            ".ogg", ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".avi", ".mkv",
        }
        if extension in rejected_extensions:
            return True, f"explicit_non_daad_extension_{extension.lstrip('.')}"
        initial = data[:4096].lower()
        if extension in {".data", ".rpyc"} or b"renpy" in initial or data.startswith(b"RPYC"):
            return True, "renpy_engine_payload"
        if any(marker in initial for marker in (b"<?php", b"<!doctype html", b"<html", b"<head", b"</body>")):
            return True, "html_php_content"
        if data.startswith((b"PK\x03\x04", b"7z\xbc\xaf\x27\x1c", b"Rar!", b"\x1f\x8b")):
            return True, "raw_archive_header"
        if any(marker in data[:1024] for marker in (b"The Quill", b"QUILL", b"PAWS")):
            return True, "quill_paws_engine"
        if b"SWAN System" in data[:1024] or b"Graphic Adventure Creator" in data:
            return True, "other_authoring_engine"
        return False, ""

    @staticmethod
    def _read_word(data: bytes, offset: int, endianness: str) -> int:
        part = data[offset:offset + 2]
        if len(part) != 2:
            raise ValueError("truncated word")
        return int.from_bytes(part, endianness)

    @staticmethod
    def _plus3dos_wrapper(data: bytes) -> Optional[Tuple[int, Dict[str, Any]]]:
        if len(data) < 128 or not data.startswith(b"PLUS3DOS\x1a"):
            return None
        if sum(data[:127]) & 0xFF != data[127]:
            return None
        declared_total = int.from_bytes(data[11:15], "little")
        declared_payload = int.from_bytes(data[16:18], "little")
        if declared_total != len(data) or declared_payload != len(data) - 128:
            return None
        return 128, {
            "format": "plus3dos",
            "load_address": int.from_bytes(data[18:20], "little"),
            "header_valid": True,
        }

    @staticmethod
    def _candidate_offsets(data: bytes, filename: str) -> list[Tuple[int, Dict[str, Any]]]:
        """Return verified wrapper offsets plus the raw candidate fallback."""

        candidates: list[Tuple[int, Dict[str, Any]]] = [(0, {"format": "raw"})]
        plus3 = DAADBytecodeParser._plus3dos_wrapper(data)
        if plus3 is not None:
            candidates.insert(0, plus3)
        if Path(filename).suffix.casefold() in {".prg", ".p00"} and len(data) >= 2:
            candidates.insert(0, (2, {
                "format": "commodore-prg",
                "load_address": int.from_bytes(data[:2], "little"),
            }))
        return candidates

    @staticmethod
    def _pointer_index(address: int, header: DDBHeader) -> Optional[int]:
        if address == 0:
            return None
        if address < header.base_address:
            return None
        index = address - header.base_address
        return index

    def _parse_header(self, data: bytes, offset: int) -> Optional[DDBHeader]:
        if offset < 0 or len(data) - offset < HEADER_SIZE:
            return None
        major = data[offset]
        machine_language = data[offset + 1]
        machine_id = machine_language >> 4
        target = MACHINE_IDS.get(machine_id)
        if major not in {2, 3} or target is None:
            return None
        platform, base_address, endianness = target
        pointers = tuple(
            self._read_word(data, offset + 8 + (index * 2), endianness)
            for index in range(HEADER_POINTER_COUNT)
        )
        file_length = pointers[12]
        return DDBHeader(
            major_version=major,
            machine_id=machine_id,
            platform=platform,
            base_address=base_address,
            endianness=endianness,
            language="es" if machine_language & 0x01 else "en",
            submachine=data[offset + 2],
            object_count=data[offset + 3],
            location_count=data[offset + 4],
            message_count=data[offset + 5],
            system_message_count=data[offset + 6],
            process_count=data[offset + 7],
            pointers=pointers,
            file_length=file_length,
        )

    def _parse_legacy_header(self, data: bytes, offset: int) -> Optional[DDBHeader]:
        """Parse the compact V1/V2 DDB header used by historical interpreters.

        MSX2DAAD's `DDB_Header` declares this 34-byte structure: version,
        target/language, literal 0x5F control marker, five counts, twelve
        section offsets, and a file-length word. Public derivative layouts use
        file-relative values, while retained historical native images can keep
        the same fields as target-memory addresses. Both forms are accepted
        only when their complete bounded range validates structurally.
        """
        if offset < 0 or len(data) - offset < LEGACY_V1_HEADER_SIZE:
            return None
        major = data[offset]
        machine_language = data[offset + 1]
        machine_id = machine_language >> 4
        target = MACHINE_IDS.get(machine_id)
        if major not in {1, 2} or target is None or data[offset + 2] != 0x5F:
            return None
        platform, target_base, _ = target
        # MSX2DAAD documents little-endian offsets for its V2 target.  68000
        # historical targets store 16-bit values in Motorola order; the other
        # original 8-bit and DOS targets are little-endian.
        endianness = "big" if platform in {"atarist", "amiga"} else "little"
        # Version 1 predates the extra object-attributes field.  It therefore
        # has eleven section pointers and stores file length at $001E.  V2
        # has twelve section pointers and stores file length at $0020.  Do not
        # parse V1 vocabulary bytes at $0020 onward as phantom header pointers.
        if major == 1:
            header_size = LEGACY_V1_HEADER_SIZE
            pointer_count = LEGACY_V1_SECTION_POINTER_COUNT
        else:
            header_size = LEGACY_HEADER_SIZE
            pointer_count = LEGACY_POINTER_COUNT - 1
        if len(data) - offset < header_size:
            return None
        pointers = tuple(
            self._read_word(data, offset + 8 + (index * 2), endianness)
            for index in range(pointer_count)
        )
        file_length = self._read_word(data, offset + 8 + (pointer_count * 2), endianness)
        available_size = len(data) - offset
        absolute_size = file_length - target_base
        # Historical native DDBs may retain machine addresses. Prefer that
        # model only when its declared end, after target-base subtraction, is a
        # complete header-sized range inside this candidate. Relative layouts
        # (including MSX2DAAD) retain base zero.
        base_address = (
            target_base
            if target_base
            and absolute_size >= header_size
            and absolute_size <= available_size
            else 0
        )
        return DDBHeader(
            major_version=major,
            machine_id=machine_id,
            platform=platform,
            base_address=base_address,
            endianness=endianness,
            language="es" if machine_language & 0x01 else "en",
            submachine=data[offset + 2],
            object_count=data[offset + 3],
            location_count=data[offset + 4],
            message_count=data[offset + 5],
            system_message_count=data[offset + 6],
            process_count=data[offset + 7],
            pointers=pointers,
            file_length=file_length,
            header_size=header_size,
            layout="legacy",
        )

    def _validate_process_entries(
        self,
        data: bytes,
        offset: int,
        header: DDBHeader,
        payload_size: int,
    ) -> Dict[str, Any]:
        """Validate DRC process pointers, entry references, and terminators.

        DRC writes a table of one address per process.  Each process address
        leads to 4-byte verb/noun/condact-address entries terminated by zero;
        each referenced condact stream must be bounded and end in DAAD's
        `0xFF` end-of-entry marker.  This tests executable layout without
        pretending undocumented opcode operands are fully disassembled.
        """

        process_table_address = header.pointers[1]
        process_table = self._pointer_index(process_table_address, header)
        if process_table is None:
            return {"valid": False, "reason": "missing_process_table"}
        if header.process_count == 0 or header.process_count > 64:
            return {"valid": False, "reason": "invalid_process_count"}
        if process_table < header.header_size or process_table + (header.process_count * 2) > payload_size:
            return {"valid": False, "reason": "process_table_out_of_bounds"}

        process_offsets = [
            self._pointer_index(
                self._read_word(data, offset + process_table + (index * 2), header.endianness),
                header,
            )
            for index in range(header.process_count)
        ]
        if any(item is None or item < header.header_size or item >= payload_size for item in process_offsets):
            return {"valid": False, "reason": "process_entry_pointer_out_of_bounds"}

        referenced_streams = 0
        terminated_streams = 0
        parsed_entries = 0
        for process_offset in process_offsets[: min(header.process_count, 8)]:
            assert process_offset is not None
            entry_position = process_offset
            for _ in range(MAX_PROCESS_ENTRIES):
                if entry_position >= payload_size:
                    return {"valid": False, "reason": "process_entry_out_of_bounds"}
                if data[offset + entry_position] == 0:
                    break
                if entry_position + 4 > payload_size:
                    return {"valid": False, "reason": "truncated_process_entry"}
                condact_address = self._read_word(data, offset + entry_position + 2, header.endianness)
                condact_offset = self._pointer_index(condact_address, header)
                if condact_offset is None or condact_offset < header.header_size or condact_offset >= payload_size:
                    return {"valid": False, "reason": "condact_pointer_out_of_bounds"}
                end = min(payload_size, condact_offset + MAX_BYTECODE_LENGTH)
                stream = data[offset + condact_offset:offset + end]
                referenced_streams += 1
                terminator = stream.find(b"\xff")
                if terminator < 0:
                    return {"valid": False, "reason": "unterminated_condact_stream"}
                # A one-byte stream is legal only if it contains an actual
                # terminator; reject all-padding regions that happen to be zero.
                if stream[:terminator] == b"":
                    return {"valid": False, "reason": "empty_condact_stream"}
                terminated_streams += 1
                parsed_entries += 1
                entry_position += 4
            else:
                return {"valid": False, "reason": "process_entry_limit_exceeded"}

        if referenced_streams == 0 or terminated_streams != referenced_streams:
            return {"valid": False, "reason": "no_valid_condact_streams"}
        return {
            "valid": True,
            "process_table_offset": process_table,
            "process_offsets": process_offsets,
            "parsed_entries": parsed_entries,
            "terminated_streams": terminated_streams,
        }

    def _validate_at(
        self,
        data: bytes,
        offset: int,
        wrapper: Dict[str, Any],
        *,
        allow_trailing: bool = False,
        legacy: bool = False,
    ) -> Optional[Dict[str, Any]]:
        header = self._parse_legacy_header(data, offset) if legacy else self._parse_header(data, offset)
        if header is None:
            return None
        available_size = len(data) - offset
        expected_size = header.expected_size
        if expected_size < header.header_size or expected_size > available_size:
            return None
        if not allow_trailing and expected_size != available_size:
            padding = available_size - expected_size
            padded_end = ((expected_size + 127) // 128) * 128
            padding_bytes = data[offset + expected_size:offset + available_size]
            # CP/M stores the final logical record in a complete 128-byte
            # physical record. Accept only the exact rounded boundary with
            # zero-filled padding; arbitrary appended bytes remain invalid.
            if not (
                legacy
                and 0 < padding < 128
                and available_size == padded_end
                and padding_bytes == b"\x00" * padding
            ):
                return None
        payload_size = expected_size
        if not legacy and header.submachine != 95 and header.machine_id != 0xF:
            return None

        pointer_offsets = [self._pointer_index(pointer, header) for pointer in header.pointers[:12]]
        required = (1, 7)  # process table and vocabulary
        if any(pointer_offsets[index] is None for index in required):
            return None
        concrete_offsets = [item for item in pointer_offsets if item is not None]
        if any(item < header.header_size or item >= payload_size for item in concrete_offsets):
            return None
        # DRC emits the process-pointer table after all normal sections. The
        # older interpreter does not document that ordering, so it is enforced
        # only for the modern layout.
        if not legacy and pointer_offsets[1] != max(concrete_offsets):
            return None

        process = self._validate_process_entries(data, offset, header, payload_size)
        if not process["valid"]:
            return None
        return {
            "header": header,
            "wrapper": wrapper,
            "process": process,
            "payload_size": payload_size,
        }

    def parse_ddb(self, data: bytes, filename: str = "") -> Dict[str, Any]:
        """Return an explainable, target-aware DDB structural analysis."""

        rejected, reason = self.is_explicit_rejection(data, filename)
        if rejected:
            return self._failure(reason)
        for offset, wrapper in self._candidate_offsets(data, filename):
            validated = self._validate_at(data, offset, wrapper)
            if validated is None:
                validated = self._validate_at(data, offset, wrapper, legacy=True)
            if validated is None:
                continue
            header: DDBHeader = validated["header"]
            format_name = f"daad-v{header.major_version}" if header.layout == "drc" else f"daad-v{header.major_version}-legacy"
            details = {
                "structural_validation": "verified",
                "header": asdict(header),
                "container_wrapper": validated["wrapper"],
                "process_validation": validated["process"],
                "payload_offset": offset,
                "payload_size": validated["payload_size"],
            }
            return {
                "is_daad": True,
                "confidence": 1.0,
                "confidence_label": "verified",
                "version": f"DAAD DDB v{header.major_version}",
                "ddb_format": format_name,
                "ddb_major_version": header.major_version,
                "ddb_encoding": None,
                "platform": header.platform,
                "language": header.language,
                "reason": f"verified_structural_{header.layout}_ddb",
                "details": details,
            }
        return self._failure("no_valid_target_aware_ddb_structure")

    @staticmethod
    def _failure(reason: str) -> Dict[str, Any]:
        return {
            "is_daad": False,
            "confidence": 0.0,
            "confidence_label": "unverified",
            "version": None,
            "ddb_format": None,
            "ddb_major_version": None,
            "ddb_encoding": None,
            "platform": "unknown",
            "language": "unknown",
            "reason": reason,
            "details": {},
        }

    def find_embedded_ddb(self, data: bytes) -> Optional[Tuple[int, bytes]]:
        """Find a structurally valid embedded DDB without quadratic slicing."""

        limit = min(len(data) - HEADER_SIZE, MAX_EMBEDDED_SCAN)
        for offset in range(max(0, limit + 1)):
            if data[offset] not in {1, 2, 3}:
                continue
            if (data[offset + 1] >> 4) not in MACHINE_IDS:
                continue
            validated = self._validate_at(
                data, offset, {"format": "embedded"}, allow_trailing=True
            )
            if validated is None:
                validated = self._validate_at(
                    data, offset, {"format": "embedded"}, allow_trailing=True, legacy=True
                )
            if validated is None:
                continue
            size = validated["payload_size"]
            return offset, data[offset:offset + size]
        return None

    # Compatibility helpers retained for callers of the older parser API.
    def validate_process_table(self, data: bytes) -> Tuple[bool, int, list[int], list[str]]:
        analysis = self.parse_ddb(data, "candidate.ddb")
        if not analysis["is_daad"]:
            return False, 0, [], []
        process = analysis["details"]["process_validation"]
        return True, int(process["parsed_entries"]), list(process["process_offsets"]), []

    def disassemble_process_bytecode(self, data: bytes, offset: int, max_bytes: int = 512) -> Tuple[bool, int, list[str]]:
        stream = data[offset:offset + max_bytes]
        terminator = stream.find(b"\xff")
        if terminator <= 0:
            return False, 0, []
        return True, terminator, [f"RAW_CONDACTS[{terminator}]", "END"]

    def detect_platform(self, data: bytes, filename: str) -> str:
        return self.parse_ddb(data, filename)["platform"]


# Public alias retained for existing integrations.
DAADParser = DAADBytecodeParser

"""Native platform-media parsers used by :mod:`daad_harvester.unpack`.

The functions here are deliberately bounded and read-only.  They preserve
members as bytes for the recursive unpacker rather than mounting media or
executing emulators.  Corrupt images return an empty list instead of guessing.
"""

from __future__ import annotations

import gzip
import re
from dataclasses import dataclass
from typing import Iterable, List, Optional, Tuple

from daad_harvester.dms import DmsDecodeError, decompress_dms as _decompress_dms


Member = Tuple[str, bytes]
_MSX_CAS_HEADER = b"\x1f\xa6\xde\xba\xcc\x13\x7d\x74"


@dataclass(frozen=True)
class TzxBlock:
    """A fully bounded TZX v1.20 block, retaining control-flow evidence."""

    index: int
    block_id: int
    kind: str
    offset: int
    body: bytes
    data: Optional[bytes] = None
    relative_targets: Tuple[int, ...] = ()


def _clean_name(value: bytes, fallback: str) -> str:
    name = value.replace(b"\xa0", b" ").decode("ascii", errors="ignore").strip(" \x00")
    name = re.sub(r"[^A-Za-z0-9._ -]+", "_", name).strip(" .")
    return name or fallback


def extract_spectrum_blocks(blocks: Iterable[bytes], prefix: str = "block") -> List[Member]:
    """Associate ZX tape header/data blocks into named raw payload members."""

    extracted: List[Member] = []
    pending_header: Optional[Tuple[str, str]] = None
    for index, block in enumerate(blocks):
        if len(block) == 19 and block[0] == 0x00:
            header_type = block[1]
            extension = {0: "bas", 1: "num", 2: "chr", 3: "bin"}.get(header_type, "dat")
            pending_header = (_clean_name(block[2:12], f"{prefix}_{index}"), extension)
        elif pending_header and len(block) >= 2 and block[0] == 0xFF:
            name, extension = pending_header
            # TAP/TZX blocks contain flag and checksum around payload.
            extracted.append((f"{name}.{extension}", block[1:-1]))
            pending_header = None
        elif block:
            extracted.append((f"{prefix}_{index}.bin", block))
    return extracted


def parse_tzx_blocks(data: bytes) -> Optional[List[TzxBlock]]:
    """Parse every standardized TZX v1.20/CDT block without desynchronization.

    The scanner preserves data and relative control-flow targets as evidence. It
    deliberately does not execute loops, jumps, calls, or selections: recursive
    unpacking should inspect a tape once rather than replay arbitrary control
    graphs or duplicate preservation payloads.
    """

    if len(data) < 10 or not data.startswith(b"ZXTape!\x1a"):
        return None
    pos = 10
    blocks: List[TzxBlock] = []

    def take(start: int, size: int) -> Optional[bytes]:
        if size < 0 or start + size > len(data):
            return None
        return data[start:start + size]

    def u24(start: int) -> Optional[int]:
        raw = take(start, 3)
        return int.from_bytes(raw, "little") if raw is not None else None

    def u32(start: int) -> Optional[int]:
        raw = take(start, 4)
        return int.from_bytes(raw, "little") if raw is not None else None

    while pos < len(data):
        start = pos
        block_id = data[pos]
        pos += 1
        body: Optional[bytes] = None
        payload: Optional[bytes] = None
        kind = ""
        targets: Tuple[int, ...] = ()
        if block_id == 0x10:  # standard speed data
            header = take(pos, 4)
            if header is None:
                return None
            size = int.from_bytes(header[2:4], "little")
            body = take(pos, 4 + size)
            payload = body[4:] if body is not None else None
            kind = "standard_data"
        elif block_id == 0x11:  # turbo data
            header = take(pos, 18)
            if header is None:
                return None
            size = int.from_bytes(header[15:18], "little")
            body = take(pos, 18 + size)
            payload = body[18:] if body is not None else None
            kind = "turbo_data"
        elif block_id == 0x12:
            body, kind = take(pos, 4), "pure_tone"
        elif block_id == 0x13:
            count = take(pos, 1)
            body = take(pos, 1 + (count[0] * 2)) if count is not None else None
            kind = "pulse_sequence"
        elif block_id == 0x14:  # pure data
            header = take(pos, 10)
            if header is None:
                return None
            size = int.from_bytes(header[7:10], "little")
            body = take(pos, 10 + size)
            payload = body[10:] if body is not None else None
            kind = "pure_data"
        elif block_id == 0x15:
            header = take(pos, 8)
            if header is None:
                return None
            size = int.from_bytes(header[5:8], "little")
            body, kind = take(pos, 8 + size), "direct_recording"
        elif block_id in {0x18, 0x19}:
            size = u32(pos)
            body = take(pos, 4 + size) if size is not None else None
            kind = "csw_recording" if block_id == 0x18 else "generalized_data"
        elif block_id == 0x20:
            body, kind = take(pos, 2), "pause_or_stop"
        elif block_id == 0x21:
            count = take(pos, 1)
            body = take(pos, 1 + count[0]) if count is not None else None
            kind = "group_start"
        elif block_id == 0x22:
            body, kind = b"", "group_end"
        elif block_id == 0x23:
            body, kind = take(pos, 2), "jump"
            if body is not None:
                targets = (int.from_bytes(body, "little", signed=True),)
        elif block_id == 0x24:
            body, kind = take(pos, 2), "loop_start"
        elif block_id == 0x25:
            body, kind = b"", "loop_end"
        elif block_id == 0x26:
            count_raw = take(pos, 2)
            count = int.from_bytes(count_raw, "little") if count_raw is not None else None
            body = take(pos, 2 + (count * 2)) if count is not None else None
            kind = "call_sequence"
            if body is not None:
                targets = tuple(int.from_bytes(body[index:index + 2], "little", signed=True) for index in range(2, len(body), 2))
        elif block_id == 0x27:
            body, kind = b"", "return"
        elif block_id == 0x28:
            size_raw = take(pos, 2)
            size = int.from_bytes(size_raw, "little") if size_raw is not None else None
            body, kind = (take(pos, 2 + size) if size is not None else None), "select"
        elif block_id in {0x2A, 0x2B}:
            size = u32(pos)
            body = take(pos, 4 + size) if size is not None else None
            kind = "stop_48k" if block_id == 0x2A else "set_signal_level"
            if block_id == 0x2A and body is not None and size != 0:
                return None
            if block_id == 0x2B and body is not None and (size != 1 or body[-1] not in {0, 1}):
                return None
        elif block_id == 0x30:
            count = take(pos, 1)
            body = take(pos, 1 + count[0]) if count is not None else None
            kind = "text_description"
        elif block_id == 0x31:
            header = take(pos, 2)
            body = take(pos, 2 + header[1]) if header is not None else None
            kind = "message"
        elif block_id == 0x32:
            size_raw = take(pos, 2)
            size = int.from_bytes(size_raw, "little") if size_raw is not None else None
            body, kind = (take(pos, 2 + size) if size is not None else None), "archive_info"
        elif block_id == 0x33:
            count = take(pos, 1)
            body = take(pos, 1 + (count[0] * 3)) if count is not None else None
            kind = "hardware_info"
        elif block_id == 0x35:
            header = take(pos, 20)
            if header is None:
                return None
            size = int.from_bytes(header[16:20], "little")
            body, kind = take(pos, 20 + size), "custom_info"
        elif block_id == 0x5A:
            body, kind = take(pos, 9), "glue"
            if body is not None and not body.startswith(b"XTape!\x1a"):
                return None
        else:
            return None
        if body is None:
            return None
        blocks.append(TzxBlock(len(blocks), block_id, kind, start, body, payload, targets))
        pos += len(body)

    total = len(blocks)
    for block in blocks:
        if any(not 0 <= block.index + target < total for target in block.relative_targets):
            return None
    return blocks


def extract_tzx(data: bytes) -> List[Member]:
    """Extract validated Spectrum-compatible payloads from a TZX or CPC CDT tape."""

    parsed = parse_tzx_blocks(data)
    if parsed is None:
        return []
    return extract_spectrum_blocks((block.data for block in parsed if block.data is not None), prefix="tzx")


def extract_t64(data: bytes) -> List[Member]:
    """Extract Commodore T64 tape entries using their documented directory offsets."""

    if len(data) < 64 or b"c64 tape image" not in data[:40].lower():
        return []
    used_entries = int.from_bytes(data[36:38], "little")
    max_entries = int.from_bytes(data[34:36], "little")
    count = min(used_entries or max_entries, max_entries, 512)
    entries = []
    for index in range(count):
        offset = 64 + (index * 32)
        entry = data[offset:offset + 32]
        if len(entry) != 32 or entry[0] == 0:
            continue
        start = int.from_bytes(entry[2:4], "little")
        end = int.from_bytes(entry[4:6], "little")
        data_offset = int.from_bytes(entry[8:12], "little")
        if not (0 < data_offset < len(data) and end >= start):
            continue
        length = end - start
        if length <= 0:
            continue
        payload = data[data_offset:data_offset + length]
        if len(payload) != length:
            continue
        name = _clean_name(entry[16:32], f"t64_{index:03d}")
        entries.append((f"{name}.prg", start.to_bytes(2, "little") + payload))
    return entries


def extract_p00(data: bytes) -> List[Member]:
    """Unwrap a validated P00 program image without losing its PRG load bytes."""

    if len(data) <= 26 or data[:8] != b"C64File\x00":
        return []
    name = _clean_name(data[8:25], "p00_program")
    payload = data[26:]
    if len(payload) < 2:
        return []
    return [(f"{name}.prg", payload)]


def _fat12_next(table: bytes, cluster: int) -> Optional[int]:
    index = cluster + (cluster // 2)
    if index + 1 >= len(table):
        return None
    pair = table[index] | (table[index + 1] << 8)
    return (pair >> 4) & 0x0FFF if cluster & 1 else pair & 0x0FFF


def _fat_lfn_name(parts: List[bytes]) -> str:
    """Return a validated VFAT long filename, or an empty value for fallback."""

    raw = b"".join(parts)
    characters = []
    for index in range(0, len(raw), 2):
        unit = raw[index:index + 2]
        if len(unit) != 2 or unit == b"\x00\x00":
            break
        if unit == b"\xff\xff":
            continue
        characters.append(unit)
    try:
        value = b"".join(characters).decode("utf-16le")
    except UnicodeDecodeError:
        return ""
    return _clean_name(value.encode("utf-8", "ignore"), "")


def _fat_lfn_checksum(short_name: bytes) -> int:
    checksum = 0
    for value in short_name:
        checksum = ((checksum & 1) << 7) + (checksum >> 1) + value
        checksum &= 0xFF
    return checksum


def extract_fat(data: bytes, *, require_type: Optional[str] = None) -> List[Member]:
    """Extract a complete bounded FAT12/FAT16 directory tree.

    The parser validates the BPB-derived geometry and FAT variant, walks files
    and directories only through bounded, cycle-free cluster chains, and handles
    conventional 8.3 plus validated long filename records. FAT32 is deliberately
    not conflated with these floppy-era media families and is rejected here.
    """

    if len(data) < 512 or data[510:512] != b"\x55\xaa":
        return []
    bytes_per_sector = int.from_bytes(data[11:13], "little")
    sectors_per_cluster = data[13]
    reserved = int.from_bytes(data[14:16], "little")
    fat_count = data[16]
    root_entries = int.from_bytes(data[17:19], "little")
    total_sectors = int.from_bytes(data[19:21], "little") or int.from_bytes(data[32:36], "little")
    sectors_per_fat = int.from_bytes(data[22:24], "little")
    if (
        bytes_per_sector not in {128, 256, 512, 1024}
        or not sectors_per_cluster
        or not reserved
        or not fat_count
        or not root_entries
        or not sectors_per_fat
        or not total_sectors
    ):
        return []
    image_size = total_sectors * bytes_per_sector
    if image_size > len(data):
        return []
    root_sector_count = (root_entries * 32 + bytes_per_sector - 1) // bytes_per_sector
    fat_start = reserved * bytes_per_sector
    fat_size = sectors_per_fat * bytes_per_sector
    root_start = (reserved + fat_count * sectors_per_fat) * bytes_per_sector
    data_start_sector = reserved + fat_count * sectors_per_fat + root_sector_count
    data_sector_count = total_sectors - data_start_sector
    if data_sector_count <= 0 or fat_start + fat_size > len(data) or root_start + root_entries * 32 > len(data):
        return []
    cluster_count = data_sector_count // sectors_per_cluster
    fat_type = "fat12" if cluster_count < 4085 else "fat16" if cluster_count < 65525 else "fat32"
    if fat_type == "fat32" or (require_type and fat_type != require_type):
        return []
    fat = data[fat_start:fat_start + fat_size]
    members: List[Member] = []
    max_cluster = cluster_count + 1
    directory_clusters: set[int] = set()

    def next_cluster(cluster: int) -> Optional[int]:
        if fat_type == "fat12":
            return _fat12_next(fat, cluster)
        offset = cluster * 2
        return int.from_bytes(fat[offset:offset + 2], "little") if offset + 2 <= len(fat) else None

    def chain_payload(first_cluster: int) -> Optional[bytes]:
        if not 2 <= first_cluster <= max_cluster:
            return None
        seen: set[int] = set()
        payload = bytearray()
        cluster = first_cluster
        eof = 0xFF8 if fat_type == "fat12" else 0xFFF8
        bad = 0xFF7 if fat_type == "fat12" else 0xFFF7
        while True:
            if cluster in seen or not 2 <= cluster <= max_cluster:
                return None
            seen.add(cluster)
            sector = data_start_sector + ((cluster - 2) * sectors_per_cluster)
            start = sector * bytes_per_sector
            length = sectors_per_cluster * bytes_per_sector
            if start + length > image_size:
                return None
            payload.extend(data[start:start + length])
            following = next_cluster(cluster)
            if following is None or following == bad:
                return None
            if following >= eof:
                return bytes(payload)
            cluster = following

    def walk_directory(entries: bytes, prefix: str) -> None:
        lfn_records: List[Tuple[int, int, bytes]] = []
        for entry_offset in range(0, len(entries) - 31, 32):
            entry = entries[entry_offset:entry_offset + 32]
            if entry[0] == 0x00:
                return
            if entry[0] == 0xE5:
                lfn_records.clear()
                continue
            attributes = entry[11]
            if attributes == 0x0F:
                ordinal = entry[0]
                sequence = ordinal & 0x1F
                if entry[12] != 0 or entry[26:28] != b"\x00\x00" or sequence == 0:
                    lfn_records.clear()
                    continue
                fragment = entry[1:11] + entry[14:26] + entry[28:32]
                if ordinal & 0x40:
                    lfn_records = [(sequence, entry[13], fragment)]
                elif not lfn_records or sequence != lfn_records[-1][0] - 1 or entry[13] != lfn_records[-1][1]:
                    lfn_records.clear()
                else:
                    lfn_records.append((sequence, entry[13], fragment))
                continue
            lfn_parts = [record[2] for record in reversed(lfn_records)]
            sequence_valid = bool(lfn_records) and lfn_records[-1][0] == 1 and all(
                lfn_records[index][0] == lfn_records[0][0] - index for index in range(len(lfn_records))
            )
            checksum_valid = sequence_valid and lfn_records[0][1] == _fat_lfn_checksum(entry[:11])
            name = _fat_lfn_name(lfn_parts) if checksum_valid else ""
            name = name or _clean_name(entry[0:8], "file")
            lfn_records.clear()
            extension = _clean_name(entry[8:11], "")
            short_name = f"{name}.{extension}" if extension and not name.casefold().endswith(f".{extension.casefold()}") else name
            if attributes & 0x08:  # volume label
                continue
            cluster = int.from_bytes(entry[26:28], "little")
            path = f"{prefix}/{short_name}" if prefix else short_name
            if attributes & 0x10:
                if short_name in {".", ".."} or cluster in directory_clusters:
                    continue
                directory = chain_payload(cluster)
                if directory is None:
                    continue
                directory_clusters.add(cluster)
                walk_directory(directory, path)
                continue
            file_size = int.from_bytes(entry[28:32], "little")
            if file_size == 0:
                members.append((path, b""))
                continue
            payload = chain_payload(cluster)
            if payload is not None and len(payload) >= file_size:
                members.append((path, payload[:file_size]))

    walk_directory(data[root_start:root_start + root_entries * 32], "")
    return members


def extract_fat12(data: bytes) -> List[Member]:
    """Extract a bounded FAT12 filesystem; compatibility wrapper for callers."""

    return extract_fat(data, require_type="fat12")


def extract_fat16(data: bytes) -> List[Member]:
    """Extract a bounded FAT16 filesystem, including subdirectories and LFNs."""

    return extract_fat(data, require_type="fat16")


def decompress_msa(data: bytes) -> Optional[bytes]:
    """Decode an Atari ST MSA sector stream with bounded RLE expansion."""

    if len(data) < 10 or data[:2] != b"\x0e\x0f":
        return None
    sectors = int.from_bytes(data[2:4], "big")
    sides = int.from_bytes(data[4:6], "big")
    first_track = int.from_bytes(data[6:8], "big")
    last_track = int.from_bytes(data[8:10], "big")
    if not (1 <= sectors <= 64 and sides <= 1 and first_track <= last_track <= 255):
        return None
    track_size = sectors * 512
    track_count = (last_track - first_track + 1) * (sides + 1)
    pos = 10
    output = bytearray()
    for _ in range(track_count):
        if pos + 2 > len(data):
            return None
        encoded_size = int.from_bytes(data[pos:pos + 2], "big")
        pos += 2
        if pos + encoded_size > len(data):
            return None
        source = data[pos:pos + encoded_size]
        pos += encoded_size
        if encoded_size == track_size:
            output.extend(source)
            continue
        decoded = bytearray()
        cursor = 0
        while cursor < len(source) and len(decoded) < track_size:
            value = source[cursor]
            cursor += 1
            if value != 0xE5:
                decoded.append(value)
                continue
            if cursor + 3 > len(source):
                return None
            repeated = source[cursor]
            count = int.from_bytes(source[cursor + 1:cursor + 3], "big")
            cursor += 3
            if count == 0 or len(decoded) + count > track_size:
                return None
            decoded.extend(bytes((repeated,)) * count)
        if len(decoded) != track_size:
            return None
        output.extend(decoded)
    return bytes(output)


def extract_msx_cas(data: bytes) -> List[Member]:
    """Split MSX CAS records into raw payloads without inventing a filesystem."""

    offsets = []
    position = 0
    while True:
        found = data.find(_MSX_CAS_HEADER, position)
        if found < 0:
            break
        offsets.append(found)
        position = found + len(_MSX_CAS_HEADER)
    if not offsets:
        return []
    members = []
    for index, start in enumerate(offsets):
        end = offsets[index + 1] if index + 1 < len(offsets) else len(data)
        body = data[start + len(_MSX_CAS_HEADER):end]
        # CAS headers often carry an ASCII filename after a 10-byte record
        # descriptor. Keep evidence intact while sanitizing only the output name.
        name = _clean_name(body[:10], f"cas_{index:03d}")
        members.append((f"{name}.casbin", body))
    return members


def decompress_adz(data: bytes) -> Optional[bytes]:
    """Return a gzip-compressed ADZ image only when decompression is bounded and valid."""

    if not data.startswith(b"\x1f\x8b"):
        return None
    try:
        expanded = gzip.decompress(data)
    except (OSError, EOFError):
        return None
    if len(expanded) % 512 or len(expanded) > 16 * 1024 * 1024:
        return None
    return expanded


def decompress_dms(data: bytes) -> Optional[bytes]:
    """Decode a DMS archive to an ADF only when all tracks validate completely."""

    try:
        expanded = _decompress_dms(data)
    except DmsDecodeError:
        return None
    if len(expanded) % 512 or len(expanded) > 32 * 1024 * 1024:
        return None
    return expanded


def _be32(block: bytes, word_index: int, *, signed: bool = False) -> int:
    start = word_index * 4
    return int.from_bytes(block[start:start + 4], "big", signed=signed)


def _adf_block(data: bytes, number: int) -> Optional[bytes]:
    start = number * 512
    if number <= 0 or start + 512 > len(data):
        return None
    return data[start:start + 512]


def _adf_name(block: bytes) -> str:
    position = (128 - 20) * 4
    length = block[position]
    if length > 30:
        return ""
    return _clean_name(block[position + 1:position + 1 + length], "")


def extract_adf(data: bytes) -> List[Member]:
    """Extract files from a standard Amiga OFS/FFS ADF image.

    The parser walks root/directory hash chains, validates header types and
    self-keys, prevents pointer cycles, and reads OFS linked blocks or FFS
    reverse header block lists, including validated file-extension chains.
    """

    if len(data) < 512 * 4 or len(data) % 512 or not data.startswith(b"DOS"):
        return []
    block_count = len(data) // 512
    root_number = int.from_bytes(data[8:12], "big") or (block_count // 2)
    root = _adf_block(data, root_number)
    if root is None or _be32(root, 0) != 2 or _be32(root, 127, signed=True) != 1:
        return []
    is_ffs = bool(data[3] & 0x01)
    members: List[Member] = []
    visited_headers: set[int] = set()

    def read_file(number: int, block: bytes, path: str) -> None:
        # FileHeaderBlock::ByteSize is word 81. Word 80 is the reserved
        # HighSeq field; treating it as a size silently discarded valid OFS
        # files from real images whose HighSeq is zero.
        byte_size = _be32(block, 81)
        if byte_size < 0 or byte_size > len(data):
            return
        header_chain = [block]
        if is_ffs:
            extension = _be32(block, 126)
            extension_seen = {number}
            while extension:
                if extension in extension_seen:
                    return
                extension_seen.add(extension)
                extension_block = _adf_block(data, extension)
                if (
                    extension_block is None
                    or _be32(extension_block, 0) != 2
                    or _be32(extension_block, 1) != extension
                    or _be32(extension_block, 127, signed=True) != -3
                ):
                    return
                header_chain.append(extension_block)
                extension = _be32(extension_block, 126)
            pointers = [
                _be32(header, index)
                for header in header_chain
                for index in range(77, 5, -1)
            ]
            payload = bytearray()
            data_seen = set()
            for pointer in pointers:
                if pointer == 0:
                    continue
                if pointer in data_seen:
                    return
                data_seen.add(pointer)
                data_block = _adf_block(data, pointer)
                if data_block is None:
                    return
                payload.extend(data_block)
                if len(payload) >= byte_size:
                    break
            if len(payload) < byte_size:
                return
            members.append((path, bytes(payload[:byte_size])))
            return
        payload = bytearray()
        chain_seen = set()
        for header in header_chain:
            pointer = _be32(header, 4)
            while pointer and pointer not in chain_seen and len(payload) < byte_size:
                chain_seen.add(pointer)
                data_block = _adf_block(data, pointer)
                if data_block is None or _be32(data_block, 0) != 8:
                    return
                chunk_size = _be32(data_block, 3)
                if chunk_size < 0 or chunk_size > 488:
                    return
                payload.extend(data_block[24:24 + chunk_size])
                pointer = _be32(data_block, 4)
        if len(payload) >= byte_size:
            members.append((path, bytes(payload[:byte_size])))

    def walk_directory(number: int, prefix: str, expected_secondary: int) -> None:
        directory = _adf_block(data, number)
        if directory is None or _be32(directory, 0) != 2 or _be32(directory, 127, signed=True) != expected_secondary:
            return
        for index in range(6, 78):
            entry_number = _be32(directory, index)
            chain_seen = set()
            while entry_number and entry_number not in chain_seen and entry_number not in visited_headers:
                chain_seen.add(entry_number)
                visited_headers.add(entry_number)
                entry = _adf_block(data, entry_number)
                if entry is None or _be32(entry, 0) != 2 or _be32(entry, 1) != entry_number:
                    break
                name = _adf_name(entry)
                secondary = _be32(entry, 127, signed=True)
                path = f"{prefix}/{name}" if prefix and name else name
                if secondary == -3 and name:
                    read_file(entry_number, entry, path)
                elif secondary == 2 and name:
                    walk_directory(entry_number, path, 2)
                entry_number = _be32(entry, 124)

    walk_directory(root_number, "", 1)
    return members

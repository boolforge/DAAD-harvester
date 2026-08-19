"""Native platform-media parsers used by :mod:`daad_harvester.unpack`.

The functions here are deliberately bounded and read-only.  They preserve
members as bytes for the recursive unpacker rather than mounting media or
executing emulators.  Corrupt images return an empty list instead of guessing.
"""

from __future__ import annotations

import gzip
import re
from typing import Iterable, List, Optional, Tuple

from daad_harvester.dms import DmsDecodeError, decompress_dms as _decompress_dms


Member = Tuple[str, bytes]
_MSX_CAS_HEADER = b"\x1f\xa6\xde\xba\xcc\x13\x7d\x74"


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


def extract_tzx(data: bytes) -> List[Member]:
    """Extract standard/turbo/pure-data blocks from a TZX or CPC CDT tape."""

    if len(data) < 10 or not data.startswith(b"ZXTape!\x1a"):
        return []
    pos = 10
    blocks: List[bytes] = []
    while pos < len(data):
        block_id = data[pos]
        pos += 1
        try:
            if block_id == 0x10:  # standard speed data
                size = int.from_bytes(data[pos + 2:pos + 4], "little")
                pos += 4
                block = data[pos:pos + size]
                if len(block) != size:
                    return []
                blocks.append(block)
                pos += size
            elif block_id == 0x11:  # turbo data
                size = int.from_bytes(data[pos + 15:pos + 18], "little")
                pos += 18
                block = data[pos:pos + size]
                if len(block) != size:
                    return []
                blocks.append(block)
                pos += size
            elif block_id == 0x14:  # pure data
                size = int.from_bytes(data[pos + 7:pos + 10], "little")
                pos += 10
                block = data[pos:pos + size]
                if len(block) != size:
                    return []
                blocks.append(block)
                pos += size
            elif block_id == 0x15:  # direct recording
                size = int.from_bytes(data[pos + 5:pos + 8], "little")
                pos += 8 + size
            elif block_id == 0x12:
                pos += 4
            elif block_id == 0x13:
                if pos >= len(data):
                    return []
                pos += 1 + (data[pos] * 2)
            elif block_id == 0x20:
                pos += 2
            elif block_id == 0x21:
                if pos >= len(data):
                    return []
                pos += 1 + data[pos]
            elif block_id == 0x22:
                pass
            elif block_id == 0x30:
                if pos >= len(data):
                    return []
                pos += 1 + data[pos]
            elif block_id == 0x31:
                if pos + 1 >= len(data):
                    return []
                pos += 2 + data[pos + 1]
            elif block_id == 0x32:
                size = int.from_bytes(data[pos:pos + 2], "little")
                pos += 2 + size
            elif block_id == 0x33:
                if pos >= len(data):
                    return []
                pos += 1 + (data[pos] * 3)
            elif block_id == 0x35:
                size = int.from_bytes(data[pos + 16:pos + 20], "little")
                pos += 20 + size
            elif block_id == 0x5A:
                pos += 9
            else:
                # Unknown TZX blocks have format-specific lengths. Stopping is
                # safer than desynchronizing and emitting invented payloads.
                break
            if pos > len(data):
                return []
        except (IndexError, ValueError):
            return []
    return extract_spectrum_blocks(blocks, prefix="tzx")


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


def extract_fat12(data: bytes) -> List[Member]:
    """Extract root-directory files from a standard FAT12 floppy image.

    This covers MSX-DOS, Atari ST, and IBM PC media.  It intentionally follows
    only valid root entries and cluster chains, rejecting cycles and malformed
    BPBs rather than treating a random sector stream as a filesystem.
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
    if fat_start + fat_size > len(data) or root_start + root_entries * 32 > len(data):
        return []
    fat = data[fat_start:fat_start + fat_size]
    members: List[Member] = []
    for entry_offset in range(root_start, root_start + root_entries * 32, 32):
        entry = data[entry_offset:entry_offset + 32]
        if len(entry) < 32 or entry[0] in {0x00, 0xE5}:
            continue
        attributes = entry[11]
        if attributes & 0x18 or attributes == 0x0F:  # volume label, directory, or VFAT LFN
            continue
        name = _clean_name(entry[0:8], "file")
        extension = _clean_name(entry[8:11], "")
        filename = f"{name}.{extension}" if extension else name
        cluster = int.from_bytes(entry[26:28], "little")
        file_size = int.from_bytes(entry[28:32], "little")
        if file_size == 0:
            members.append((filename, b""))
            continue
        if cluster < 2:
            continue
        clusters_seen = set()
        payload = bytearray()
        while 2 <= cluster < 0xFF8 and cluster not in clusters_seen:
            clusters_seen.add(cluster)
            sector = data_start_sector + ((cluster - 2) * sectors_per_cluster)
            start = sector * bytes_per_sector
            length = sectors_per_cluster * bytes_per_sector
            if start + length > len(data):
                payload = bytearray()
                break
            payload.extend(data[start:start + length])
            next_cluster = _fat12_next(fat, cluster)
            if next_cluster is None:
                payload = bytearray()
                break
            cluster = next_cluster
        if len(payload) >= file_size:
            members.append((filename, bytes(payload[:file_size])))
    return members


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
    reverse header block lists. Unsupported extension-heavy files are skipped
    conservatively instead of emitting corrupt bytes.
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
        byte_size = _be32(block, 80)
        if byte_size < 0 or byte_size > len(data):
            return
        extension = _be32(block, 126)
        if extension:  # extensions need a full continuation list; do not truncate silently.
            return
        if is_ffs:
            pointers = [_be32(block, index) for index in range(77, 5, -1)]
            payload = bytearray()
            for pointer in pointers:
                if pointer == 0:
                    continue
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
        pointer = _be32(block, 4)
        payload = bytearray()
        chain_seen = set()
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

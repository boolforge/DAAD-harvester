"""Structural inspection for native retro-computing preservation media.

The unpacker uses this module before it attempts member extraction.  Its job is
not to guess that a payload is a DAAD game: it validates the outer medium,
reports the evidence required to reproduce that decision, and records when a
medium is valid but intentionally non-file-oriented (for example a pulse tape
or low-level protected track dump).
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
from hashlib import sha256
from pathlib import Path
from typing import Any, Dict

from daad_harvester.adf_generation import adf_boot_checksum, adf_normal_checksum
from daad_harvester.chr_generation import validate_daad_chr
from daad_harvester.dms import crc16_arc
from daad_harvester.platform_media import is_msx_dos_fat12_boot_sector, parse_tzx_blocks


@dataclass(frozen=True)
class MediaInspection:
    """A bounded, serializable outer-media parsing result."""

    parser: str
    status: str
    validation: str
    evidence: Dict[str, Any]

    def as_dict(self) -> Dict[str, Any]:
        return asdict(self)


def _result(
    parser: str,
    status: str,
    validation: str,
    **evidence: Any,
) -> MediaInspection:
    return MediaInspection(parser, status, validation, evidence)


def _inspect_cbm_tap(data: bytes) -> MediaInspection:
    if len(data) < 20:
        return _result("cbm-tap-v1-v2", "rejected", "truncated_header", size=len(data))
    signature = data[:12]
    if signature not in {b"C64-TAPE-RAW", b"C16-TAPE-RAW"}:
        return _result("cbm-tap-v1-v2", "rejected", "signature_mismatch")
    version = data[12]
    platform_code = data[13]
    declared_size = int.from_bytes(data[16:20], "little")
    actual_size = len(data) - 20
    if version not in {0, 1, 2}:
        return _result(
            "cbm-tap-v1-v2", "recognized_evidence", "unknown_version",
            version=version, platform_code=platform_code,
            declared_size=declared_size, actual_size=actual_size,
        )
    if declared_size != actual_size:
        return _result(
            "cbm-tap-v1-v2", "rejected", "declared_length_mismatch",
            version=version, platform_code=platform_code,
            declared_size=declared_size, actual_size=actual_size,
        )
    expected_platform = 2 if signature.startswith(b"C16") else 0
    platform_valid = platform_code == expected_platform or version == 0
    return _result(
        "cbm-tap-v1-v2",
        "recognized_evidence",
        "valid_pulse_stream" if platform_valid else "platform_header_mismatch",
        version=version,
        platform_code=platform_code,
        video_standard=data[14],
        declared_size=declared_size,
        pulse_bytes=actual_size,
    )


def _inspect_g64(data: bytes) -> MediaInspection:
    if len(data) < 12:
        return _result("cbm-g64", "rejected", "truncated_header", size=len(data))
    signature = data[:8]
    if signature not in {b"GCR-1541", b"GCR-1571"}:
        return _result("cbm-g64", "rejected", "signature_mismatch")
    version = data[8]
    track_count = data[9]
    track_size = int.from_bytes(data[10:12], "little")
    table_end = 12 + (track_count * 8)
    if version != 0 or not (1 <= track_count <= 168) or track_size < 256 or table_end > len(data):
        return _result(
            "cbm-g64", "rejected", "invalid_header_or_tables",
            version=version, track_count=track_count, track_size=track_size,
        )
    valid_tracks = 0
    invalid_tracks = 0
    for index in range(track_count):
        offset = int.from_bytes(data[12 + index * 4:16 + index * 4], "little")
        if not offset:
            continue
        if offset + 2 > len(data):
            invalid_tracks += 1
            continue
        stored_size = int.from_bytes(data[offset:offset + 2], "little")
        if not (1 <= stored_size <= track_size and offset + 2 + stored_size <= len(data)):
            invalid_tracks += 1
            continue
        valid_tracks += 1
    status = "recognized_evidence" if not invalid_tracks else "partial"
    validation = "valid_gcr_track_index" if not invalid_tracks else "invalid_gcr_track_offsets"
    return _result(
        "cbm-g64", status, validation, version=version, track_count=track_count,
        track_size=track_size, indexed_tracks=valid_tracks, invalid_tracks=invalid_tracks,
        disk_family="1571" if signature == b"GCR-1571" else "1541",
    )


def _inspect_p00(data: bytes) -> MediaInspection:
    if len(data) < 26:
        return _result("cbm-p00", "rejected", "truncated_header", size=len(data))
    if data[:8] != b"C64File\x00":
        return _result("cbm-p00", "rejected", "signature_mismatch")
    name = data[8:25].replace(b"\xa0", b" ").rstrip(b" \x00").decode("latin-1", "replace")
    return _result("cbm-p00", "recognized_evidence", "valid_wrapper", name=name, payload_size=len(data) - 26)


def _inspect_c64_basic_sys_prg(data: bytes) -> MediaInspection:
    """Recognize a strict C64 BASIC SYS launcher without trusting a filename.

    This profile is deliberately narrower than a generic PRG claim: it requires
    the canonical BASIC load address, one tokenized SYS line, an ASCII decimal
    target, a line terminator, and the terminal null link. It identifies a C64
    program medium only; it does not establish DAAD content or an interpreter.
    """

    if len(data) < 15:
        return _result("c64-basic-sys-prg", "rejected", "truncated_basic_sys_stub", size=len(data))
    load_address = int.from_bytes(data[0:2], "little")
    if load_address != 0x0801:
        return _result("c64-basic-sys-prg", "rejected", "unexpected_basic_load_address", load_address=load_address)
    next_line = int.from_bytes(data[2:4], "little")
    line_number = int.from_bytes(data[4:6], "little")
    if data[6] != 0x9E:
        return _result("c64-basic-sys-prg", "rejected", "missing_basic_sys_token", token=data[6])
    terminator = data.find(b"\x00", 7, min(len(data), 14))
    if terminator < 8:
        return _result("c64-basic-sys-prg", "rejected", "missing_or_empty_sys_target")
    target_bytes = data[7:terminator]
    if not target_bytes.isdigit():
        return _result("c64-basic-sys-prg", "rejected", "non_decimal_sys_target")
    sys_target = int(target_bytes)
    terminal_link = terminator + 3
    if terminal_link > len(data) or data[terminator + 1:terminal_link] != b"\x00\x00":
        return _result("c64-basic-sys-prg", "rejected", "missing_terminal_basic_link")
    if next_line != load_address + (terminator - 2 + 1):
        return _result(
            "c64-basic-sys-prg", "rejected", "inconsistent_basic_next_line_pointer",
            load_address=load_address, next_line=next_line,
        )
    if not 0 <= sys_target <= 0xFFFF:
        return _result("c64-basic-sys-prg", "rejected", "sys_target_out_of_range", sys_target=sys_target)
    return _result(
        "c64-basic-sys-prg", "recognized_evidence", "validated_c64_basic_sys_launcher",
        load_address=load_address,
        basic_line_number=line_number,
        sys_target=sys_target,
        basic_program_end_offset=terminal_link,
        machine_code_offset=terminal_link,
    )


def _inspect_tzx(data: bytes) -> MediaInspection:
    if len(data) < 10 or not data.startswith(b"ZXTape!\x1a"):
        return _result("tzx-cdt", "rejected", "signature_mismatch")
    major, minor = data[8], data[9]
    if major != 1:
        return _result("tzx-cdt", "recognized_evidence", "unknown_major_version", major=major, minor=minor)
    blocks = parse_tzx_blocks(data)
    if blocks is None:
        return _result("tzx-cdt", "rejected", "invalid_or_truncated_block_stream", major=major, minor=minor)
    data_blocks = [block for block in blocks if block.data is not None]
    control_blocks = [block for block in blocks if block.relative_targets]
    return _result(
        "tzx-cdt",
        "recognized_evidence",
        "validated_tzx_v1_block_stream",
        major=major,
        minor=minor,
        block_count=len(blocks),
        data_block_count=len(data_blocks),
        control_block_count=len(control_blocks),
        block_types=sorted({block.kind for block in blocks}),
    )


def _inspect_cpc_dsk(data: bytes) -> MediaInspection:
    """Validate standard or extended CPC DSK record boundaries before extraction."""

    standard = data.startswith(b"MV - CPCEMU Disk-File")
    extended = data.startswith(b"EXTENDED CPC DSK File")
    if len(data) < 0x100 or not (standard or extended):
        return _result("cpc-dsk", "rejected", "truncated_or_missing_dsk_signature")
    tracks, sides = data[0x30], data[0x31]
    total_tracks = tracks * sides
    if not tracks or not sides or total_tracks > 204:
        return _result("cpc-dsk", "rejected", "invalid_track_geometry", tracks=tracks, sides=sides)
    fixed_size = int.from_bytes(data[0x32:0x34], "little")
    track_sizes = data[0x34:0x34 + total_tracks] if extended else ()
    if not extended and fixed_size < 0x100:
        return _result("cpc-dsk", "rejected", "invalid_fixed_track_size", fixed_size=fixed_size)
    pos = 0x100
    present_tracks = 0
    sectors = 0
    track_layouts: list[tuple[tuple[int, ...], tuple[int, ...]]] = []
    for index in range(total_tracks):
        track_size = track_sizes[index] * 256 if extended else fixed_size
        if not track_size:
            continue
        if track_size < 0x100 or pos + track_size > len(data):
            return _result("cpc-dsk", "rejected", "truncated_track_record", parsed_tracks=present_tracks)
        header = data[pos:pos + 0x100]
        if not header.startswith(b"Track-Info"):
            return _result("cpc-dsk", "rejected", "missing_track_info_header", parsed_tracks=present_tracks)
        sector_count = header[0x15]
        if 0x18 + sector_count * 8 > 0x100:
            return _result("cpc-dsk", "rejected", "invalid_sector_descriptor_table", parsed_tracks=present_tracks)
        consumed = 0
        sector_ids: list[int] = []
        sector_sizes: list[int] = []
        for sector in range(sector_count):
            descriptor = header[0x18 + sector * 8:0x20 + sector * 8]
            sector_size = int.from_bytes(descriptor[6:8], "little")
            if not sector_size:
                code = descriptor[3]
                if code > 7:
                    return _result("cpc-dsk", "rejected", "invalid_sector_size_code", parsed_tracks=present_tracks)
                sector_size = 128 << code
            consumed += sector_size
            sector_ids.append(descriptor[2])
            sector_sizes.append(sector_size)
        if 0x100 + consumed > track_size:
            return _result("cpc-dsk", "rejected", "sector_payload_exceeds_track", parsed_tracks=present_tracks)
        present_tracks += 1
        sectors += sector_count
        track_layouts.append((tuple(sector_ids), tuple(sector_sizes)))
        pos += track_size
    if pos != len(data):
        return _result("cpc-dsk", "rejected", "trailing_or_missing_track_data", parsed_tracks=present_tracks, trailing=len(data) - pos)
    standard_track_count = tracks == 40 and sides == 1 and present_tracks == 40
    system_ids = tuple(range(0x41, 0x4A))
    data_ids = tuple(range(0xC1, 0xCA))
    standard_sizes = (512,) * 9
    if standard_track_count and all(ids == system_ids and sizes == standard_sizes for ids, sizes in track_layouts):
        cpm_profile = "cpc_system"
    elif standard_track_count and all(ids == data_ids and sizes == standard_sizes for ids, sizes in track_layouts):
        cpm_profile = "cpc_data"
    else:
        cpm_profile = "nonstandard_mixed_geometry"
    return _result(
        "cpc-dsk", "recognized_evidence", "validated_cpc_dsk_track_stream",
        dsk_variant="extended" if extended else "standard",
        tracks=tracks,
        sides=sides,
        present_tracks=present_tracks,
        sector_count=sectors,
        cpm_directory_profile=cpm_profile,
        cpm_directory_extraction_eligible=cpm_profile in {"cpc_system", "cpc_data"},
        observed_track_layouts=sorted(
            {
                f"ids={','.join(f'{value:02X}' for value in ids)};sizes={','.join(map(str, sizes))}"
                for ids, sizes in track_layouts
            }
        ),
    )


def _inspect_msa(data: bytes) -> MediaInspection:
    if len(data) < 10 or data[:2] != b"\x0e\x0f":
        return _result("atari-msa", "rejected", "signature_mismatch")
    sectors = int.from_bytes(data[2:4], "big")
    sides = int.from_bytes(data[4:6], "big")
    first_track = int.from_bytes(data[6:8], "big")
    last_track = int.from_bytes(data[8:10], "big")
    valid = 1 <= sectors <= 64 and sides <= 1 and first_track <= last_track <= 255
    return _result(
        "atari-msa", "recognized_evidence" if valid else "rejected",
        "valid_geometry" if valid else "invalid_geometry", sectors=sectors,
        sides=sides, first_track=first_track, last_track=last_track,
    )


def _inspect_adf(data: bytes) -> MediaInspection:
    if len(data) < 2048 or len(data) % 512 or not data.startswith(b"DOS"):
        return _result("amiga-adf", "rejected", "invalid_boot_block")
    if data[3] not in {0, 1, 2, 3}:
        return _result("amiga-adf", "rejected", "unsupported_dos_type", dos_type=data[:4].decode("latin-1", "replace"))
    boot = data[:1024]
    if int.from_bytes(boot[4:8], "big") != adf_boot_checksum(boot):
        return _result("amiga-adf", "rejected", "boot_checksum_mismatch", dos_type=data[:4].decode("latin-1", "replace"))
    block_count = len(data) // 512
    root_block = int.from_bytes(data[8:12], "big")
    if not 2 <= root_block < block_count:
        return _result("amiga-adf", "rejected", "root_block_out_of_range", root_block=root_block, blocks=block_count)
    root_start = root_block * 512
    root = data[root_start:root_start + 512]
    if int.from_bytes(root[:4], "big") != 2 or int.from_bytes(root[508:512], "big", signed=True) != 1:
        return _result("amiga-adf", "rejected", "invalid_root_block_type", root_block=root_block)
    if int.from_bytes(root[20:24], "big") != adf_normal_checksum(root, 20):
        return _result("amiga-adf", "rejected", "root_checksum_mismatch", root_block=root_block)
    bitmap_block = int.from_bytes(root[79 * 4:80 * 4], "big")
    if not 2 <= bitmap_block < block_count:
        return _result("amiga-adf", "rejected", "bitmap_block_out_of_range", root_block=root_block, bitmap_block=bitmap_block)
    bitmap = data[bitmap_block * 512:(bitmap_block + 1) * 512]
    if int.from_bytes(bitmap[:4], "big") != adf_normal_checksum(bitmap, 0):
        return _result("amiga-adf", "rejected", "bitmap_checksum_mismatch", root_block=root_block, bitmap_block=bitmap_block)
    return _result(
        "amiga-adf", "recognized_evidence", "validated_adf_ofs_ffs_structure",
        dos_type=data[:4].decode("latin-1", "replace"),
        filesystem="ffs" if data[3] & 0x01 else "ofs",
        blocks=block_count,
        root_block=root_block,
        bitmap_block=bitmap_block,
        root_hash_table_entries=int.from_bytes(root[12:16], "big"),
    )


def _inspect_dms(data: bytes) -> MediaInspection:
    if len(data) < 56 or not data.startswith(b"DMS!"):
        return _result("amiga-dms", "rejected", "signature_or_header_mismatch", size=len(data))
    stored_crc = int.from_bytes(data[54:56], "big")
    calculated_crc = crc16_arc(data[4:54])
    if stored_crc != calculated_crc:
        return _result(
            "amiga-dms", "rejected", "archive_header_crc_mismatch",
            stored_crc=stored_crc, calculated_crc=calculated_crc, archive_size=len(data),
        )
    general_info = int.from_bytes(data[10:12], "big")
    return _result(
        "amiga-dms", "recognized_evidence", "validated_archive_header",
        header_size=56,
        archive_size=len(data),
        creator_version=int.from_bytes(data[46:48], "big"),
        first_track=int.from_bytes(data[16:18], "big"),
        last_track=int.from_bytes(data[18:20], "big"),
        disk_type=int.from_bytes(data[50:52], "big"),
        default_mode=int.from_bytes(data[52:54], "big"),
        encrypted=bool(general_info & 0x0002),
        banner=bool(general_info & 0x0008),
        file_id=bool(general_info & 0x0100),
    )


def _inspect_fat(data: bytes) -> MediaInspection:
    is_msx_dos = is_msx_dos_fat12_boot_sector(data)
    if len(data) < 512 or (data[510:512] != b"\x55\xaa" and not is_msx_dos):
        return _result("fat12-fat16", "rejected", "invalid_boot_signature")
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
        return _result("fat12-fat16", "rejected", "invalid_bpb")
    root_sectors = (root_entries * 32 + bytes_per_sector - 1) // bytes_per_sector
    data_start = reserved + fat_count * sectors_per_fat + root_sectors
    data_sectors = total_sectors - data_start
    image_size = total_sectors * bytes_per_sector
    if data_sectors <= 0 or image_size > len(data):
        return _result("fat12-fat16", "rejected", "declared_geometry_out_of_range")
    cluster_count = data_sectors // sectors_per_cluster
    if cluster_count >= 65525:
        return _result("fat12-fat16", "recognized_evidence", "fat32_or_later_not_routed", cluster_count=cluster_count)
    fat_variant = "fat12" if cluster_count < 4085 else "fat16"
    return _result(
        "fat12-fat16", "recognized_evidence",
        "validated_msx_dos_fat12_geometry" if is_msx_dos else "validated_fat_geometry",
        fat_variant=fat_variant,
        boot_convention="msx-dos-eb-fe-90" if is_msx_dos else "ibm-pc-55-aa",
        bytes_per_sector=bytes_per_sector,
        sectors_per_cluster=sectors_per_cluster,
        total_sectors=total_sectors,
        cluster_count=cluster_count,
    )


def _inspect_mz(data: bytes) -> MediaInspection:
    if len(data) < 28 or data[:2] not in {b"MZ", b"ZM"}:
        return _result("dos-mz", "rejected", "truncated_or_missing_mz_signature")
    bytes_last_page = int.from_bytes(data[2:4], "little")
    pages = int.from_bytes(data[4:6], "little")
    relocation_count = int.from_bytes(data[6:8], "little")
    header_paragraphs = int.from_bytes(data[8:10], "little")
    relocation_offset = int.from_bytes(data[24:26], "little")
    if not pages or bytes_last_page > 512:
        return _result("dos-mz", "rejected", "invalid_page_fields")
    declared_size = pages * 512 - (512 - bytes_last_page if bytes_last_page else 0)
    header_size = header_paragraphs * 16
    relocation_end = relocation_offset + relocation_count * 4
    if declared_size < header_size or declared_size > len(data) or relocation_end > header_size:
        return _result(
            "dos-mz", "rejected", "invalid_header_bounds",
            declared_size=declared_size, header_size=header_size, relocation_end=relocation_end,
        )
    return _result(
        "dos-mz", "recognized_evidence", "validated_mz_header",
        declared_size=declared_size,
        header_size=header_size,
        relocation_count=relocation_count,
        relocation_offset=relocation_offset,
    )


def _inspect_stx(data: bytes) -> MediaInspection:
    """Validate Pasti/STX record boundaries and preserve protection signals."""

    if len(data) < 16 or data[:4] != b"RSY\x00":
        return _result("atari-stx", "rejected", "truncated_or_missing_rsy_signature")
    version = int.from_bytes(data[4:6], "little")
    creator = int.from_bytes(data[6:8], "little")
    declared_tracks = data[10]
    if not declared_tracks:
        return _result("atari-stx", "rejected", "zero_track_count", version=version, creator=creator)
    pos = 16
    tracks = 0
    protected_tracks = 0
    fuzzy_tracks = 0
    timing_or_status_tracks = 0
    while tracks < declared_tracks:
        if pos + 16 > len(data):
            return _result("atari-stx", "rejected", "truncated_track_header", parsed_tracks=tracks)
        track_size = int.from_bytes(data[pos:pos + 4], "little")
        fuzzy_size = int.from_bytes(data[pos + 4:pos + 8], "little")
        sector_count = int.from_bytes(data[pos + 8:pos + 10], "little")
        flags = int.from_bytes(data[pos + 10:pos + 12], "little")
        image_size = int.from_bytes(data[pos + 12:pos + 14], "little")
        if track_size < 16 or pos + track_size > len(data):
            return _result("atari-stx", "rejected", "invalid_track_length", parsed_tracks=tracks, track_size=track_size)
        header_size = 16 + (sector_count * 16 if flags & 0x0001 else 0)
        if header_size + fuzzy_size > track_size or image_size > track_size - header_size - fuzzy_size:
            return _result("atari-stx", "rejected", "inconsistent_track_descriptors", parsed_tracks=tracks)
        if flags & 0x0001:
            protected_tracks += 1
        if fuzzy_size:
            fuzzy_tracks += 1
        if flags & 0x00C0:
            timing_or_status_tracks += 1
        if flags & 0x0001:
            sector_start = pos + 16
            statuses = [data[sector_start + sector * 16 + 14] for sector in range(sector_count)]
            if any(status & 0x98 for status in statuses):
                timing_or_status_tracks += 1
        pos += track_size
        tracks += 1
    if pos != len(data):
        return _result("atari-stx", "rejected", "trailing_or_missing_track_records", parsed_tracks=tracks, trailing=len(data) - pos)
    return _result(
        "atari-stx", "recognized_evidence", "validated_pasti_track_records",
        version=version,
        creator=creator,
        track_count=tracks,
        protected_tracks=protected_tracks,
        fuzzy_tracks=fuzzy_tracks,
        timing_or_status_tracks=timing_or_status_tracks,
    )


def _inspect_ipf(data: bytes) -> MediaInspection:
    """Recognize the initial SPS CAPS record while preserving IPF as opaque media."""

    if len(data) < 12 or data[:4] != b"CAPS":
        return _result("sps-ipf", "rejected", "truncated_or_missing_caps_record")
    record_size = int.from_bytes(data[4:8], "big")
    if record_size != 12:
        return _result("sps-ipf", "rejected", "invalid_caps_record_size", record_size=record_size)
    return _result("sps-ipf", "recognized_evidence", "validated_initial_caps_record", record_size=record_size, archive_size=len(data))


def _inspect_msx_rom(data: bytes) -> MediaInspection:
    """Capture MSX cartridge-header and banking evidence without mapper guessing."""

    if not data:
        return _result("msx-rom", "rejected", "empty_rom_image")
    header_offset = next((offset for offset in (0, 0x4000) if len(data) >= offset + 16 and data[offset:offset + 2] == b"AB"), None)
    if header_offset is None:
        return _result(
            "msx-rom", "recognized_evidence", "raw_rom_without_standard_ab_header",
            rom_size=len(data), size_multiple_8k=len(data) % 0x2000 == 0,
            mapper_assessment="unidentified",
        )
    vectors = {
        name: int.from_bytes(data[header_offset + position:header_offset + position + 2], "little")
        for name, position in (("init", 2), ("statement", 4), ("device", 6), ("text", 8))
    }
    nonzero_vectors = {name: value for name, value in vectors.items() if value}
    if len(data) <= 0x8000:
        mapper_assessment = "linear_cartridge_size"
    else:
        mapper_assessment = "banked_size_requires_mapper_identification"
    return _result(
        "msx-rom", "recognized_evidence", "validated_msx_ab_cartridge_header",
        rom_size=len(data),
        header_offset=header_offset,
        header_address=0x4000 if header_offset == 0 else 0x8000,
        size_multiple_8k=len(data) % 0x2000 == 0,
        mapper_assessment=mapper_assessment,
        entry_vectors=nonzero_vectors,
    )


_MSX_R4_CANONICAL_MDG_SIZE = 2105
_MSX_R4_CANONICAL_MDG_SHA256 = "c588b0e7cbdbd3a591085cd233d471c7a37fed85a88085ced8a560a42a759f06"
_CPC_DAAD_LOADER_FNT_SIZE = 896
_CPC_DAAD_LOADER_FNT_SHA256 = "fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a"
_R4_SOURCE250_ALL_E5_FNT_SIZE = 896
_R4_SOURCE250_ALL_E5_FNT_SHA256 = "87a077d1d65c2c1a3fc64c03fd2c3f25431d2c6a7fc36ebf23256b3aa9bf4f07"


def _inspect_msx_r4_mdg(data: bytes) -> MediaInspection:
    """Recognize only the independently corroborated canonical R4 MDG template.

    The retained R4 member is byte-identical to the classic official empty
    graphics database with standard character set. That proves one immutable
    template identity, not the complete grammar of arbitrary MSX MDG files.
    Nonmatching members remain explicit unrecognized-profile evidence.
    """

    digest = sha256(data).hexdigest()
    if len(data) != _MSX_R4_CANONICAL_MDG_SIZE:
        return _result(
            "daad-msx-mdg", "recognized_evidence", "unrecognized_mdg_size_profile",
            size=len(data), sha256=digest,
            canonical_size=_MSX_R4_CANONICAL_MDG_SIZE,
        )
    if digest != _MSX_R4_CANONICAL_MDG_SHA256:
        return _result(
            "daad-msx-mdg", "recognized_evidence", "unrecognized_same_size_mdg_profile",
            size=len(data), sha256=digest,
            canonical_sha256=_MSX_R4_CANONICAL_MDG_SHA256,
        )
    return _result(
        "daad-msx-mdg", "recognized_evidence", "validated_r4_canonical_empty_graphics_template",
        profile_id="daad-msx-r4-canonical-empty-graphics-template",
        size=len(data),
        sha256=digest,
        template_identity="exact_official_classic_mdx_template_match",
        documented_role="empty_graphics_database_with_standard_charset",
        grammar_boundary="exact_template_only_no_generic_mdg_decoder",
    )


def _inspect_daad_fnt(data: bytes) -> MediaInspection:
    """Inspect only demonstrated AMSDOS and exact CPC loader-font FNT evidence.

    `.FNT` is not a single DAAD format. The known modern SINTAC FNT3 family
    and the retained 896-byte CPC loader font have incompatible layouts. This
    routine validates the documented AMSDOS header where present and promotes
    a CPC font role only for the exact public-source-correlated byte identity.
    """

    digest = sha256(data).hexdigest()
    unknown = _result(
        "daad-fnt", "recognized_evidence", "unrecognized_fnt_profile",
        size=len(data), sha256=digest,
        profile_boundary="no_generic_fnt_or_sintac_font_decoder",
    )
    if len(data) == _R4_SOURCE250_ALL_E5_FNT_SIZE and digest == _R4_SOURCE250_ALL_E5_FNT_SHA256:
        return _result(
            "daad-fnt", "recognized_evidence", "identified_r4_source250_all_e5_byte_profile",
            size=len(data),
            sha256=digest,
            profile_id="daad-r4-source250-all-e5-byte-profile",
            fill_byte=0xE5,
            repeated_byte_count=len(data),
            profile_boundary="exact_byte_identity_only_no_font_erasure_or_runtime_semantics",
        )
    if len(data) < 128 or data[0x12] != 0x02:
        return unknown

    logical_size = int.from_bytes(data[0x18:0x1A], "little")
    real_size = int.from_bytes(data[0x40:0x43], "little")
    stored_size = len(data) - 128
    stored_checksum = int.from_bytes(data[0x43:0x45], "little")
    computed_checksum = sum(data[:0x43]) & 0xFFFF
    header_name = data[1:16].decode("ascii", errors="replace").rstrip("\x00")
    header_evidence = {
        "size": len(data),
        "sha256": digest,
        "header_name_raw": header_name,
        "binary_type": data[0x12],
        "load_address": int.from_bytes(data[0x15:0x17], "little"),
        "entry_address": int.from_bytes(data[0x1A:0x1C], "little"),
        "logical_payload_size": logical_size,
        "real_payload_size": real_size,
        "stored_payload_size": stored_size,
        "stored_header_checksum": stored_checksum,
        "computed_header_checksum": computed_checksum,
    }
    if stored_checksum != computed_checksum:
        return _result(
            "amsdos-binary", "rejected", "amsdos_header_checksum_mismatch",
            **header_evidence,
        )
    if logical_size != stored_size or real_size != stored_size:
        return _result(
            "amsdos-binary", "rejected", "amsdos_declared_size_mismatch",
            **header_evidence,
        )
    if digest == _CPC_DAAD_LOADER_FNT_SHA256:
        return _result(
            "daad-cpc-loader-fnt", "recognized_evidence", "validated_amsdos_cpc_loader_font_container",
            **header_evidence,
            profile_id="daad-cpc-standard-tape-loader-font",
            primary_source_identity="exact_classic_daad_cpc_fnt_match",
            role_boundary="container_and_loader_font_identity_only_no_glyph_decoder",
        )
    return _result(
        "amsdos-binary", "recognized_evidence", "validated_amsdos_binary_header_noncanonical_fnt",
        **header_evidence,
        profile_boundary="valid_amsdos_container_not_a_validated_daad_font_profile",
    )


_MSX_R4_LAUNCHER_PREFIX = b"\xf3\x21\x0f\x01\x11\x00\x81\x01"
_MSX_R4_LAUNCHER_SIZE = 559
_MSX_R4_LAUNCHER_FILE_TABLE = b"FILES   BINDAAD    MDGPART1   DDBDAAD    Z80LOADPIC SC2"


def _inspect_msx_r4_launcher_com(data: bytes) -> MediaInspection | None:
    """Recognize the measured R4 raw-COM launcher structure without execution.

    This checks the R4 entry bytes, observed filename table, and three FCB
    service-call sequences. It identifies a bounded file-oriented launcher
    profile, not successful execution or a complete MSX-DOS COM grammar.
    """

    if not data.startswith(_MSX_R4_LAUNCHER_PREFIX):
        return None
    if len(data) != _MSX_R4_LAUNCHER_SIZE:
        return _result(
            "daad-msx-r4-launcher-com", "rejected", "unexpected_r4_launcher_size",
            size=len(data), expected_size=_MSX_R4_LAUNCHER_SIZE,
        )
    file_table_offset = data.find(_MSX_R4_LAUNCHER_FILE_TABLE)
    if file_table_offset < 0:
        return _result(
            "daad-msx-r4-launcher-com", "rejected", "missing_r4_launcher_file_table",
            size=len(data),
        )
    expected_calls = (
        (b"\x0e\x0f\x11\x5c\x00\xcd\x05\x00", "fcb_open", 0x0F),
        (b"\x0e\x1a\xcd\x05\x00", "fcb_close", 0x1A),
        (b"\x0e\x27\x11\x5c\x00\xcd\x05\x00", "fcb_random_block", 0x27),
    )
    calls: list[dict[str, int | str]] = []
    for pattern, operation, service in expected_calls:
        offset = data.find(pattern)
        if offset < 0:
            return _result(
                "daad-msx-r4-launcher-com", "rejected", "missing_r4_launcher_fcb_service",
                operation=operation, service=service,
            )
        calls.append({"operation": operation, "service": service, "file_offset": offset, "fcb_address": 0x005C})
    return _result(
        "daad-msx-r4-launcher-com", "recognized_evidence", "validated_r4_file_oriented_launcher_structure",
        size=len(data),
        conventional_com_load_address=0x0100,
        file_table_offset=file_table_offset,
        referenced_files=("DAAD.MDG", "PART1.DDB", "DAAD.Z80", "LOADPIC.SC2"),
        fcb_calls=calls,
        execution_boundary="static_structure_only_no_runtime_execution_or_complete_com_grammar",
    )


def _inspect_daad_chr(data: bytes) -> MediaInspection:
    """Validate the known fixed-size legacy character-set container boundary."""

    try:
        evidence = validate_daad_chr(data)
    except (TypeError, ValueError) as exc:
        return _result("daad-legacy-chr", "rejected", "invalid_chr_container_size", error=str(exc), size=len(data))
    return _result("daad-legacy-chr", "recognized_evidence", "validated_legacy_chr_container", **evidence)


def _inspect_legacy_dat_v2(data: bytes) -> MediaInspection:
    """Validate the bounded V2 table grammar without decoding image payloads."""

    table_offset = 0x000A
    entry_size = 48
    entry_count = 256
    payload_floor = table_offset + entry_size * entry_count
    if len(data) < payload_floor:
        return _result("daad-legacy-dat-v2", "rejected", "truncated_v2_entry_table", size=len(data), minimum_size=payload_floor)
    if data[:2] == b"\x03\x00":
        byte_order = "big"
    elif data[:2] == b"\xff\xff":
        byte_order = "little"
    else:
        return _result("daad-legacy-dat-v2", "rejected", "missing_v2_signature", size=len(data))
    declared_size = int.from_bytes(data[6:10], byte_order)
    image_entries = 0
    audio_entries = 0
    populated_entries = 0
    buffered_entries = 0
    fixed_entries = 0
    for index in range(entry_count):
        offset = table_offset + index * entry_size
        entry = data[offset:offset + entry_size]
        member_offset = int.from_bytes(entry[0:4], byte_order)
        flags = int.from_bytes(entry[4:6], byte_order)
        if member_offset == 0:
            continue
        if member_offset < payload_floor or member_offset >= len(data):
            return _result(
                "daad-legacy-dat-v2", "rejected", "entry_offset_out_of_bounds",
                byte_order=byte_order, entry_index=index, member_offset=member_offset,
                payload_floor=payload_floor, file_size=len(data),
            )
        populated_entries += 1
        if flags & 0x0010:
            audio_entries += 1
        else:
            image_entries += 1
        if flags & 0x0002:
            buffered_entries += 1
        if not flags & 0x0001:
            fixed_entries += 1
    return _result(
        "daad-legacy-dat-v2", "recognized_evidence", "validated_v2_header_and_entry_offsets",
        byte_order=byte_order, declared_size=declared_size, declared_size_matches_file=declared_size == len(data),
        entry_table_offset=table_offset, entry_table_bytes=entry_size * entry_count,
        payload_floor=payload_floor, populated_entries=populated_entries, image_entries=image_entries,
        audio_entries=audio_entries, buffered_entries=buffered_entries, fixed_entries=fixed_entries,
        payload_boundary="offsets_only_no_length_or_codec_validation",
    )


def _decode_pcw_byte_stream(data: bytes, expected_size: int) -> bytes:
    """Decode ADP's bounded PCW byte stream to its exact monochrome size."""

    if len(data) < 5:
        raise ValueError("truncated_compressed_stream_header")
    token_count = data[0]
    if token_count > 4:
        raise ValueError("compressed_stream_token_count_out_of_bounds")
    tokens = data[1:5]
    position = 5
    output = bytearray()
    while position < len(data) and len(output) < expected_size:
        value = data[position]
        position += 1
        repeat = 1
        if value in tokens[:token_count]:
            if position >= len(data):
                raise ValueError("truncated_compressed_stream_repeat")
            repeat = data[position]
            position += 1
        if len(output) + repeat > expected_size:
            raise ValueError("compressed_stream_output_overflow")
        output.extend([value] * repeat)
    if len(output) != expected_size or position != len(data):
        raise ValueError("compressed_stream_length_mismatch")
    return bytes(output)


def _rearrange_pcw_decoded_to_stored(data: bytes, width: int, height: int) -> bytes:
    """Restore ADP's PCW interleaved monochrome storage layout."""

    row_bytes = (width + 7) >> 3
    expected_size = row_bytes * height
    if len(data) != expected_size or height & 1:
        raise ValueError("invalid_pcw_decoded_geometry")
    output = bytearray(expected_size)
    for pair in range(height // 2):
        source_top = pair * row_bytes * 2
        source_bottom = source_top + row_bytes * 2 - 1
        destination_base = (pair >> 2) * width + (pair & 3) * 2
        for x_byte in range(row_bytes):
            destination = destination_base + (x_byte << 3)
            if destination + 1 >= expected_size:
                raise ValueError("pcw_stored_layout_destination_out_of_bounds")
            output[destination] = data[source_top + x_byte]
            output[destination + 1] = data[source_bottom - x_byte]
    return bytes(output)


def _expand_pcw_stored_to_packed(data: bytes, width: int, height: int) -> bytes:
    """Expand PCW 1-bit stored rows into deterministic four-bit packed pixels."""

    row_bytes = (width + 7) >> 3
    expected_size = row_bytes * height
    if len(data) != expected_size:
        raise ValueError("pcw_stored_layout_size_mismatch")
    output = bytearray((width * height + 1) >> 1)
    for y in range(height):
        row_start = y * ((width + 1) >> 1)
        base = (y >> 3) * width + (y & 7)
        for x_byte in range(row_bytes):
            value = data[base + (x_byte << 3)]
            destination = row_start + x_byte * 4
            output[destination] = (0xF0 if value & 0x80 else 0) | (0x0F if value & 0x40 else 0)
            output[destination + 1] = (0xF0 if value & 0x20 else 0) | (0x0F if value & 0x10 else 0)
            output[destination + 2] = (0xF0 if value & 0x08 else 0) | (0x0F if value & 0x04 else 0)
            output[destination + 3] = (0xF0 if value & 0x02 else 0) | (0x0F if value & 0x01 else 0)
    return bytes(output)


def decode_pcw_dat_image_resource(data: bytes, resource: dict[str, Any]) -> bytes:
    """Decode one validated PCW DAT image resource to four-bit packed pixels."""

    if resource.get("audio"):
        raise ValueError("audio_resource_has_no_pixel_decoder")
    width = int(resource["width"])
    height = int(resource["height"])
    payload_offset = int(resource["payload_offset"])
    payload_end = int(resource["payload_end"])
    if not (0 < width <= 1024 and 0 < height <= 1024 and 0 <= payload_offset <= payload_end <= len(data)):
        raise ValueError("invalid_pcw_resource_decoder_bounds")
    mono_size = ((width + 7) >> 3) * height
    payload = data[payload_offset:payload_end]
    if resource.get("compressed"):
        stored = _rearrange_pcw_decoded_to_stored(_decode_pcw_byte_stream(payload, mono_size), width, height)
    else:
        if len(payload) < mono_size:
            raise ValueError("truncated_uncompressed_pcw_resource")
        stored = payload[:mono_size]
    return _expand_pcw_stored_to_packed(stored, width, height)


def _inspect_pcw_dat_v1(data: bytes) -> MediaInspection:
    """Validate the documented PCW V1 DAT directory without decoding pictures.

    ADP's shared DMG reader accepts this profile only when the little-endian
    header declares machine zero, high-resolution mode four, and a bounded
    picture count. It then reads the fixed 256-entry, ten-byte directory at
    offset six; payload offsets must start after the complete directory. This
    validator records those cross-file resource references but intentionally
    does not claim a PIC payload codec or rendering grammar.
    """

    directory_offset = 6
    entry_count = 256
    entry_size = 10
    directory_size = entry_count * entry_size
    payload_floor = directory_offset + directory_size
    if len(data) < payload_floor:
        return _result(
            "daad-pcw-dat-v1", "rejected", "truncated_fixed_directory",
            file_size=len(data), minimum_size=payload_floor,
        )
    machine = int.from_bytes(data[0:2], "little")
    screen_mode = int.from_bytes(data[2:4], "little")
    picture_count = int.from_bytes(data[4:6], "little")
    if machine != 0 or screen_mode != 4 or picture_count > entry_count:
        return _result(
            "daad-pcw-dat-v1", "rejected", "invalid_pcw_v1_header",
            machine=machine, screen_mode=screen_mode, picture_count=picture_count,
        )

    entries: list[dict[str, int | bool]] = []
    for index in range(entry_count):
        position = directory_offset + index * entry_size
        entry = data[position:position + entry_size]
        offset = int.from_bytes(entry[0:4], "little")
        flags = int.from_bytes(entry[4:6], "little")
        if offset == 0:
            continue
        if offset < payload_floor or offset >= len(data):
            return _result(
                "daad-pcw-dat-v1", "rejected", "resource_offset_out_of_bounds",
                entry_index=index, resource_offset=offset, payload_floor=payload_floor,
                file_size=len(data),
            )
        if offset + 6 > len(data):
            return _result(
                "daad-pcw-dat-v1", "rejected", "truncated_resource_header",
                entry_index=index, resource_offset=offset, file_size=len(data),
            )
        width_word = int.from_bytes(data[offset:offset + 2], "little")
        height_word = int.from_bytes(data[offset + 2:offset + 4], "little")
        payload_length = int.from_bytes(data[offset + 4:offset + 6], "little")
        width = width_word & 0x7FFF
        height = height_word & 0x7FFF
        compressed = bool(width_word & 0x8000)
        audio = bool(height_word & 0x8000)
        payload_end = offset + 6 + payload_length
        if payload_end > len(data):
            return _result(
                "daad-pcw-dat-v1", "rejected", "resource_payload_out_of_bounds",
                entry_index=index, resource_offset=offset, payload_length=payload_length,
                file_size=len(data),
            )
        if not audio and (width == 0 or height == 0 or payload_length == 0):
            return _result(
                "daad-pcw-dat-v1", "rejected", "invalid_image_resource_header",
                entry_index=index, width=width, height=height, payload_length=payload_length,
            )
        if not audio and (width > 1024 or height > 1024):
            return _result(
                "daad-pcw-dat-v1", "rejected", "image_resource_dimensions_out_of_bounds",
                entry_index=index, width=width, height=height,
            )
        decoded_entry: dict[str, int | bool | str] = {
                "index": index,
                "offset": offset,
                "flags": flags,
                "x": int.from_bytes(entry[6:8], "little", signed=True),
                "y": int.from_bytes(entry[8:10], "little", signed=True),
                "buffered": bool(flags & 0x0002),
                "fixed": not bool(flags & 0x0001),
                "width": width,
                "height": height,
                "payload_length": payload_length,
                "payload_offset": offset + 6,
                "payload_end": payload_end,
                "compressed": compressed,
                "audio": audio,
            }
        if not audio:
            try:
                pixels = decode_pcw_dat_image_resource(data, decoded_entry)
            except ValueError as exc:
                return _result(
                    "daad-pcw-dat-v1", "rejected", "resource_pixel_decode_failed",
                    entry_index=index, reason=str(exc),
                )
            decoded_entry["packed_pixel_bytes"] = len(pixels)
            decoded_entry["pixel_encoding"] = "pcw_1bit_to_4bit_packed"
        entries.append(decoded_entry)
    if picture_count != len(entries):
        return _result(
            "daad-pcw-dat-v1", "rejected", "picture_count_directory_mismatch",
            picture_count=picture_count, populated_entries=len(entries),
        )
    return _result(
        "daad-pcw-dat-v1", "recognized_evidence", "validated_pcw_v1_resource_directory",
        machine=machine,
        screen_mode=screen_mode,
        picture_count=picture_count,
        directory_offset=directory_offset,
        directory_entry_count=entry_count,
        directory_entry_size=entry_size,
        payload_floor=payload_floor,
        resources=entries,
        resource_payload_codec="validated_pcw_byte_stream_and_monochrome_layout",
    )


def _inspect_snapshot(extension: str, data: bytes) -> MediaInspection:
    # Snapshot formats are machine-state evidence, not raw executable members.
    known_size = len(data) in {49179, 131103, 147487}
    return _result(
        f"snapshot-{extension[1:]}", "recognized_evidence",
        "snapshot_requires_memory_map_reconstruction" if known_size else "snapshot_extension_only",
        size=len(data), extension=extension,
    )


def inspect_native_media(filename: str, data: bytes) -> MediaInspection:
    """Inspect a single artifact without executing, mounting, or guessing members."""

    extension = Path(filename).suffix.casefold()
    if data.startswith((b"C64-TAPE-RAW", b"C16-TAPE-RAW")):
        return _inspect_cbm_tap(data)
    if data.startswith((b"GCR-1541", b"GCR-1571")):
        return _inspect_g64(data)
    if data.startswith(b"C64File\x00"):
        return _inspect_p00(data)
    if len(data) >= 2 and data[:2] == b"\x01\x08":
        return _inspect_c64_basic_sys_prg(data)
    if data.startswith(b"ZXTape!\x1a"):
        return _inspect_tzx(data)
    if data.startswith((b"EXTENDED CPC DSK", b"MV - CPCEMU")):
        return _inspect_cpc_dsk(data)
    if data.startswith(b"\x0e\x0f"):
        return _inspect_msa(data)
    if data.startswith(b"DOS") and len(data) % 512 == 0:
        return _inspect_adf(data)
    if data.startswith(b"DMS!") or extension == ".dms":
        return _inspect_dms(data)
    if data.startswith(b"RSY\x00") or extension == ".stx":
        return _inspect_stx(data)
    if data.startswith(b"CAPS") or extension == ".ipf":
        return _inspect_ipf(data)
    if extension == ".rom":
        return _inspect_msx_rom(data)
    if extension == ".mdg":
        return _inspect_msx_r4_mdg(data)
    if extension == ".fnt":
        return _inspect_daad_fnt(data)
    if extension in {".ch0", ".chr"}:
        return _inspect_daad_chr(data)
    if extension == ".dat" and data[:4] == b"\x00\x00\x04\x00":
        return _inspect_pcw_dat_v1(data)
    if extension == ".dat" and data[:2] in {b"\x03\x00", b"\xff\xff"}:
        return _inspect_legacy_dat_v2(data)
    if len(data) >= 512 and (
        data[510:512] == b"\x55\xaa" or is_msx_dos_fat12_boot_sector(data)
    ):
        return _inspect_fat(data)
    if data.startswith((b"MZ", b"ZM")) or extension == ".exe":
        return _inspect_mz(data)
    if extension in {".sna", ".z80"}:
        return _inspect_snapshot(extension, data)
    if extension == ".com":
        launcher = _inspect_msx_r4_launcher_com(data)
        if launcher is not None:
            return launcher
    if extension in {".rom", ".com", ".exe", ".prg"}:
        return _result("opaque-program-image", "recognized_evidence", "preserved_for_fingerprint", extension=extension, size=len(data))
    return _result("none", "unrecognized", "no_native_media_signature", extension=extension, size=len(data))

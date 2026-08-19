"""Byte-exact DMS framing and integrity regressions for native decoding."""

import pytest

from daad_harvester.dms import DmsDecodeError, checksum16, crc16_arc, decompress_dms
from daad_harvester.platform_media import decompress_dms as safe_decompress_dms


def _header(*, encrypted: bool = False) -> bytearray:
    header = bytearray(56)
    header[:4] = b"DMS!"
    header[10:12] = (2 if encrypted else 0).to_bytes(2, "big")
    header[16:18] = (0).to_bytes(2, "big")
    header[18:20] = (79).to_bytes(2, "big")
    header[25:28] = (4096).to_bytes(3, "big")
    header[54:56] = crc16_arc(header[4:54]).to_bytes(2, "big")
    return header


def _track(
    number: int,
    payload: bytes,
    *,
    mode: int = 0,
    packed: bytes | None = None,
    intermediate_length: int | None = None,
) -> bytes:
    packed = payload if packed is None else packed
    header = bytearray(20)
    header[:2] = b"TR"
    header[2:4] = number.to_bytes(2, "big")
    header[6:8] = len(packed).to_bytes(2, "big")
    header[8:10] = (len(payload) if intermediate_length is None else intermediate_length).to_bytes(2, "big")
    header[10:12] = len(payload).to_bytes(2, "big")
    header[13] = mode
    header[14:16] = checksum16(payload).to_bytes(2, "big")
    header[16:18] = crc16_arc(packed).to_bytes(2, "big")
    header[18:20] = crc16_arc(header[:18]).to_bytes(2, "big")
    return bytes(header) + packed


def test_dms_crc16_uses_reference_arc_check_value() -> None:
    assert crc16_arc(b"123456789") == 0xBB3D


def test_dms_decodes_valid_stored_track_exactly() -> None:
    payload = bytes(range(256)) * 9  # 2304 bytes, a real data-track-sized record
    archive = bytes(_header()) + _track(0, payload)
    assert decompress_dms(archive) == payload


def test_dms_decodes_simple_rle_track_exactly() -> None:
    payload = b"A" * 2305
    packed = b"\x90\xffA" + len(payload).to_bytes(2, "big")
    archive = bytes(_header()) + _track(1, payload, mode=1, packed=packed)
    assert decompress_dms(archive) == payload


def test_dms_decodes_quick_stage_then_simple_rle_exactly() -> None:
    payload = b"Q" * 2305
    stage_one = b"\x90\xffQ" + len(payload).to_bytes(2, "big")
    bit_string = "".join(f"1{byte:08b}" for byte in stage_one)
    packed = int(bit_string.ljust((len(bit_string) + 7) // 8 * 8, "0"), 2).to_bytes(
        (len(bit_string) + 7) // 8, "big"
    )
    archive = bytes(_header()) + _track(
        2, payload, mode=2, packed=packed, intermediate_length=len(stage_one)
    )
    assert decompress_dms(archive) == payload


def test_dms_rejects_corrupt_header_track_and_unpacked_checksums() -> None:
    payload = b"B" * 2305
    archive = bytearray(bytes(_header()) + _track(2, payload))
    archive[54] ^= 1
    with pytest.raises(DmsDecodeError, match="archive_header_crc_mismatch"):
        decompress_dms(bytes(archive))

    archive = bytearray(bytes(_header()) + _track(2, payload))
    archive[-1] ^= 1
    with pytest.raises(DmsDecodeError, match="track_data_crc_mismatch"):
        decompress_dms(bytes(archive))

    archive = bytearray(bytes(_header()) + _track(2, payload))
    archive[56 + 14] ^= 1
    archive[56 + 18:56 + 20] = crc16_arc(archive[56:56 + 18]).to_bytes(2, "big")
    with pytest.raises(DmsDecodeError, match="unpacked_track_checksum_mismatch"):
        decompress_dms(bytes(archive))


def test_dms_encrypted_and_advanced_modes_remain_explicit_failures() -> None:
    payload = b"C" * 2305
    with pytest.raises(DmsDecodeError, match="encrypted_archive"):
        decompress_dms(bytes(_header(encrypted=True)) + _track(3, payload))
    with pytest.raises(DmsDecodeError, match="unsupported_dms_mode_6"):
        decompress_dms(bytes(_header()) + _track(3, payload, mode=6))


def test_safe_dms_wrapper_returns_none_without_partial_output() -> None:
    payload = b"D" * 2305
    advanced = bytes(_header()) + _track(4, payload, mode=2)
    assert safe_decompress_dms(advanced) is None

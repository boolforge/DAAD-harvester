"""Byte-exact DMS framing and integrity regressions for native decoding."""

import pytest

from daad_harvester.dms import (
    DmsDecodeError,
    _DeepDecoder,
    _DmsDecodeState,
    _MediumDecoder,
    checksum16,
    crc16_arc,
    decompress_dms,
)
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
    flags: int = 0,
) -> bytes:
    packed = payload if packed is None else packed
    header = bytearray(20)
    header[:2] = b"TR"
    header[2:4] = number.to_bytes(2, "big")
    header[6:8] = len(packed).to_bytes(2, "big")
    header[8:10] = (len(payload) if intermediate_length is None else intermediate_length).to_bytes(2, "big")
    header[10:12] = len(payload).to_bytes(2, "big")
    header[12] = flags
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


def test_dms_decodes_medium_stage_then_simple_rle_exactly() -> None:
    payload = b"M" * 2305
    stage_one = b"\x90\xffM" + len(payload).to_bytes(2, "big")
    bit_string = "".join(f"1{byte:08b}" for byte in stage_one)
    packed = int(bit_string.ljust((len(bit_string) + 7) // 8 * 8, "0"), 2).to_bytes(
        (len(bit_string) + 7) // 8, "big"
    )
    archive = bytes(_header()) + _track(
        3, payload, mode=3, packed=packed, intermediate_length=len(stage_one)
    )
    assert decompress_dms(archive) == payload


def test_medium_match_path_uses_static_distance_tables_and_window() -> None:
    bits = "".join(f"1{byte:08b}" for byte in b"ABC")
    # MEDIUM match: flag 0; prefix 0 => 3-byte match, then two 3-bit zero fields
    # => distance 0, which copies the previous byte (C) three times.
    bits += "0" + "00000000" + "000" + "000"
    packed = int(bits.ljust((len(bits) + 7) // 8 * 8, "0"), 2).to_bytes((len(bits) + 7) // 8, "big")
    assert _MediumDecoder(_DmsDecodeState()).decode(packed, 6) == b"ABCCCC"


def test_dms_decodes_deep_stage_then_simple_rle_exactly() -> None:
    payload = b"E" * 2305
    stage_one = b"\x90\xffE" + len(payload).to_bytes(2, "big")
    state = _DmsDecodeState()
    decoder = _DeepDecoder(state)
    decoder._init_tree()
    bits = ""
    for byte in stage_one:
        node = byte + 627  # DEEP_T; leaves are symbolic index + DEEP_T.
        code = []
        while state.deep_parent[node] != 0:
            parent = state.deep_parent[node]
            code.append("0" if state.deep_son[parent] == node else "1")
            node = parent
        # The final parent-table relation points at the synthetic leaf marker
        # (symbol + DEEP_T), not a Huffman branch; it is never serialized.
        bits += "".join(reversed(code))[:-1]
        decoder._update(byte)
    packed = int(bits.ljust((len(bits) + 7) // 8 * 8, "0"), 2).to_bytes((len(bits) + 7) // 8, "big")
    archive = bytes(_header()) + _track(
        4, payload, mode=4, packed=packed, intermediate_length=len(stage_one)
    )
    assert decompress_dms(archive) == payload


@pytest.mark.parametrize("mode", [5, 6])
def test_dms_decodes_heavy_rebuild_tracks_with_both_dictionary_sizes(mode: int) -> None:
    payload = b"H" * 2305
    # HEAVY tree records with count=0 create constant symbol tables. The C tree
    # is fixed at literal 'H'; the P tree is irrelevant because no match occurs.
    bits = f"{0:09b}{ord('H'):09b}{0:05b}{0:05b}"
    packed = int(bits.ljust(32, "0"), 2).to_bytes(4, "big")
    archive = bytes(_header()) + _track(
        mode,
        payload,
        mode=mode,
        packed=packed,
        intermediate_length=len(payload),
        flags=0x02,
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


def test_dms_encrypted_and_uninitialized_heavy_streams_remain_explicit_failures() -> None:
    payload = b"C" * 2305
    with pytest.raises(DmsDecodeError, match="encrypted_archive"):
        decompress_dms(bytes(_header(encrypted=True)) + _track(3, payload))
    with pytest.raises(DmsDecodeError, match="heavy_tree_state_missing"):
        decompress_dms(bytes(_header()) + _track(3, payload, mode=6))


def test_safe_dms_wrapper_returns_none_without_partial_output() -> None:
    payload = b"D" * 2305
    advanced = bytes(_header()) + _track(4, payload, mode=6)
    assert safe_decompress_dms(advanced) is None

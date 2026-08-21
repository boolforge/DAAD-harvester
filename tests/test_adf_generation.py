"""Regression tests for deterministic bounded Amiga ADF/OFS generation."""

from __future__ import annotations

import hashlib

import pytest

from daad_harvester.adf_generation import (
    ADF_DD_BYTE_LENGTH,
    ADF_ROOT_BLOCK,
    AmigaTimestamp,
    build_blank_adf_ofs,
    validate_blank_adf_ofs,
)
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.platform_media import extract_adf


def test_blank_adf_ofs_is_deterministic_and_structurally_valid() -> None:
    first = build_blank_adf_ofs()
    second = build_blank_adf_ofs()

    assert first == second
    assert len(first) == ADF_DD_BYTE_LENGTH
    assert first[:4] == b"DOS\x00"
    assert int.from_bytes(first[8:12], "big") == ADF_ROOT_BLOCK
    assert hashlib.sha256(first).hexdigest() == hashlib.sha256(second).hexdigest()
    assert validate_blank_adf_ofs(first)["filesystem_claim"] == "empty_ofs_filesystem_no_members"
    inspection = inspect_native_media("blank.adf", first)
    assert inspection.parser == "amiga-adf"
    assert inspection.validation == "validated_adf_ofs_ffs_structure"
    assert extract_adf(first) == []


def test_blank_adf_ofs_uses_explicit_name_and_timestamp() -> None:
    timestamp = AmigaTimestamp(days=17, minutes=123, ticks=250)
    image = build_blank_adf_ofs(volume_name="DAAD ARCHIVE", timestamp=timestamp)

    evidence = validate_blank_adf_ofs(image, volume_name="DAAD ARCHIVE", timestamp=timestamp)
    assert evidence["volume_name"] == "DAAD ARCHIVE"
    assert evidence["timestamp"] == {"days": 17, "minutes": 123, "ticks": 250}
    with pytest.raises(ValueError, match="root timestamp"):
        validate_blank_adf_ofs(image, volume_name="DAAD ARCHIVE")


def test_blank_adf_ofs_rejects_invalid_inputs_and_corruption() -> None:
    with pytest.raises(ValueError, match="1 through 30"):
        build_blank_adf_ofs(volume_name="")
    with pytest.raises(ValueError, match="Latin-1"):
        build_blank_adf_ofs(volume_name="DAAD €")
    with pytest.raises(ValueError, match="timestamp.days"):
        build_blank_adf_ofs(timestamp=AmigaTimestamp(days=-1))

    corrupted_boot = bytearray(build_blank_adf_ofs())
    corrupted_boot[4] ^= 0x80
    with pytest.raises(ValueError, match="boot checksum"):
        validate_blank_adf_ofs(bytes(corrupted_boot))
    corrupted_root = bytearray(build_blank_adf_ofs())
    corrupted_root[ADF_ROOT_BLOCK * 512 + 20] ^= 0x80
    with pytest.raises(ValueError, match="root checksum"):
        validate_blank_adf_ofs(bytes(corrupted_root))
    corrupted_bitmap = bytearray(build_blank_adf_ofs())
    corrupted_bitmap[(ADF_ROOT_BLOCK + 1) * 512] ^= 0x80
    with pytest.raises(ValueError, match="bitmap checksum"):
        validate_blank_adf_ofs(bytes(corrupted_bitmap))
    inspection = inspect_native_media("corrupted.adf", bytes(corrupted_bitmap))
    assert inspection.status == "rejected"
    assert inspection.validation == "bitmap_checksum_mismatch"

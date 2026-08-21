"""Bounded legacy DAT V2 header/table inspection regressions."""

from __future__ import annotations

from pathlib import Path

from daad_harvester.media_inspection import inspect_native_media


ROOT = Path(__file__).resolve().parents[1]


def _v2_fixture(*, byte_order: str = "big", member_offset: int = 0) -> bytes:
    table_size = 0x300A
    data = bytearray(table_size + (4 if member_offset else 0))
    data[:2] = b"\x03\x00" if byte_order == "big" else b"\xff\xff"
    data[6:10] = len(data).to_bytes(4, byte_order)
    if member_offset:
        data[10:14] = member_offset.to_bytes(4, byte_order)
        data[14:16] = (0x0003).to_bytes(2, byte_order)
    return bytes(data)


def test_legacy_dat_v2_inspector_validates_empty_big_endian_table() -> None:
    result = inspect_native_media("part1.dat", _v2_fixture())
    assert result.status == "recognized_evidence"
    assert result.validation == "validated_v2_header_and_entry_offsets"
    assert result.evidence["byte_order"] == "big"
    assert result.evidence["populated_entries"] == 0


def test_legacy_dat_v2_inspector_accepts_little_endian_offset_record() -> None:
    result = inspect_native_media("part1.dat", _v2_fixture(byte_order="little", member_offset=0x300A))
    assert result.status == "recognized_evidence"
    assert result.evidence["byte_order"] == "little"
    assert result.evidence["image_entries"] == 1
    assert result.evidence["buffered_entries"] == 1


def test_legacy_dat_v2_inspector_rejects_bad_table_and_member_bounds() -> None:
    short = inspect_native_media("short.dat", b"\x03\x00" + b"\x00" * 8)
    assert short.status == "rejected"
    assert short.validation == "truncated_v2_entry_table"
    bad = inspect_native_media("bad.dat", _v2_fixture(member_offset=0x4000))
    assert bad.status == "rejected"
    assert bad.validation == "entry_offset_out_of_bounds"


def test_retained_populated_legacy_dat_v2_reports_structural_evidence() -> None:
    artifact = ROOT / "preservation_corpus/extracted/depth1_83f16a8c_PART1.DAT"
    result = inspect_native_media(artifact.name, artifact.read_bytes())

    assert result.status == "recognized_evidence"
    assert result.validation == "validated_v2_header_and_entry_offsets"
    assert result.evidence["byte_order"] == "big"
    assert result.evidence["declared_size"] == 283_318
    assert result.evidence["populated_entries"] == 145
    assert result.evidence["image_entries"] == 145
    assert result.evidence["payload_boundary"] == "offsets_only_no_length_or_codec_validation"

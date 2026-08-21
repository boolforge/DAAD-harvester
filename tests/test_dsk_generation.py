"""Regression tests for deterministic native Extended DSK generation."""

from __future__ import annotations

import hashlib
from pathlib import Path

import pytest

from daad_harvester.db import Database
from daad_harvester.dsk_generation import (
    ExtendedDskSector,
    ExtendedDskTrack,
    build_blank_cpc_system_dsk,
    build_extended_dsk,
)
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.unpack import Unpacker


def _cpm_data_track() -> ExtendedDskTrack:
    sectors = [bytearray(512) for _ in range(9)]
    directory = bytearray(32)
    directory[0] = 0
    directory[1:9] = b"GAME    "
    directory[9:12] = b"BIN"
    directory[15] = 8
    directory[16] = 2
    sectors[0][:32] = directory
    sectors[4][:1024] = b"DAAD" + b"\x7f" * 1020
    return ExtendedDskTrack(
        track=0,
        side=0,
        sectors=tuple(
            ExtendedDskSector(sector_id=0xC1 + index, size_code=2, data=bytes(payload))
            for index, payload in enumerate(sectors)
        ),
    )


def test_blank_cpc_system_generation_is_deterministic_and_structurally_valid() -> None:
    first = build_blank_cpc_system_dsk()
    second = build_blank_cpc_system_dsk()

    assert first == second
    assert hashlib.sha256(first).hexdigest() == hashlib.sha256(second).hexdigest()
    result = inspect_native_media("blank-cpc-system.dsk", first)
    assert result.validation == "validated_cpc_dsk_track_stream"
    assert result.evidence["dsk_variant"] == "extended"
    assert result.evidence["tracks"] == 40
    assert result.evidence["sides"] == 1
    assert result.evidence["cpm_directory_profile"] == "cpc_system"
    assert result.evidence["cpm_directory_extraction_eligible"] is True


def test_generated_explicit_cpm_track_round_trips_through_native_unpacker(tmp_path: Path) -> None:
    dsk = build_extended_dsk(tracks=1, sides=1, track_records=(_cpm_data_track(),))
    result = inspect_native_media("generated.dsk", dsk)
    assert result.validation == "validated_cpc_dsk_track_stream"

    unpacker = Unpacker(Database(tmp_path / "state.db"), extract_dir=tmp_path / "extracted")
    assert unpacker.unpack_dsk(dsk) == [("GAME.BIN", b"DAAD" + b"\x7f" * 1020)]


def test_generation_requires_canonical_track_order_and_explicit_geometry() -> None:
    sector = ExtendedDskSector(sector_id=1, size_code=2, data=b"\x00" * 512)
    misplaced = ExtendedDskTrack(track=1, side=0, sectors=(sector,))

    with pytest.raises(ValueError, match="canonical"):
        build_extended_dsk(tracks=1, sides=1, track_records=(misplaced,))
    with pytest.raises(ValueError, match="tracks × sides"):
        build_extended_dsk(tracks=1, sides=1, track_records=())

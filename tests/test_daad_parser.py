"""Tests for target-aware, structurally validated DAAD DDB recognition."""

from __future__ import annotations

import time

import pytest

from daad_harvester.daad_parser import DAADBytecodeParser
from tests.ddb_fixtures import make_ddb, wrap_commodore, wrap_plus3dos


@pytest.mark.parametrize("platform", ("zx", "cpc", "c64", "plus4", "msx", "pcw", "atarist", "amiga", "dos"))
@pytest.mark.parametrize("major", (2, 3))
def test_drc_header_verifies_every_official_daad_target(platform: str, major: int) -> None:
    parser = DAADBytecodeParser()
    result = parser.parse_ddb(make_ddb(platform, major=major), "candidate.ddb")

    assert result["is_daad"] is True
    assert result["confidence"] == 1.0
    assert result["confidence_label"] == "verified"
    assert result["platform"] == platform
    assert result["ddb_format"] == f"daad-v{major}"
    assert result["ddb_major_version"] == major
    assert result["details"]["structural_validation"] == "verified"
    assert result["details"]["header"]["platform"] == platform
    assert result["details"]["process_validation"]["terminated_streams"] == 1


def test_structural_parser_recognizes_spanish_language_bit() -> None:
    result = DAADBytecodeParser().parse_ddb(make_ddb("cpc", spanish=True), "juego.ddb")
    assert result["is_daad"] is True
    assert result["language"] == "es"


@pytest.mark.parametrize("platform", ("c64", "plus4"))
def test_structural_parser_unwraps_commodore_prg(platform: str) -> None:
    result = DAADBytecodeParser().parse_ddb(wrap_commodore(make_ddb(platform), platform), "game.prg")
    assert result["is_daad"] is True
    assert result["platform"] == platform
    assert result["details"]["container_wrapper"]["format"] == "commodore-prg"


def test_structural_parser_unwraps_checked_plus3dos_header() -> None:
    result = DAADBytecodeParser().parse_ddb(wrap_plus3dos(make_ddb("zx")), "game.ddb")
    assert result["is_daad"] is True
    assert result["platform"] == "zx"
    assert result["details"]["container_wrapper"]["format"] == "plus3dos"


def test_rejects_plus3dos_with_invalid_checksum() -> None:
    payload = bytearray(wrap_plus3dos(make_ddb("zx")))
    payload[127] ^= 0xFF
    result = DAADBytecodeParser().parse_ddb(bytes(payload), "game.ddb")
    assert result["is_daad"] is False


@pytest.mark.parametrize("mutation", ("bad_size", "bad_process_pointer", "unterminated_stream", "bad_machine"))
def test_structural_parser_rejects_corrupt_header_invariants(mutation: str) -> None:
    payload = bytearray(make_ddb("cpc"))
    if mutation == "bad_size":
        payload[32:34] = (0xFFFF).to_bytes(2, "big")
    elif mutation == "bad_process_pointer":
        payload[10:12] = (0x1000).to_bytes(2, "big")
    elif mutation == "unterminated_stream":
        payload[62] = 0
    else:
        payload[1] = 0x90

    result = DAADBytecodeParser().parse_ddb(bytes(payload), "broken.ddb")
    assert result["is_daad"] is False
    assert result["reason"] == "no_valid_target_aware_ddb_structure"


def test_incidental_daad_strings_do_not_verify_a_payload() -> None:
    content = b"DAADREADY DAAD Aventuras AD " * 30
    result = DAADBytecodeParser().parse_ddb(content, "not-a-ddb.bin")
    assert result["is_daad"] is False
    assert result["confidence"] == 0.0


@pytest.mark.parametrize(
    ("filename", "data", "expected_reason"),
    [
        ("game.data", b"renpy_version_8_0" + b"DAAD" * 5, "renpy_engine_payload"),
        ("response.dat", b"<!DOCTYPE html><html>DAAD</html>", "html_php_content"),
        ("game.nes", b"NES\x1a" + b"\x00" * 100, "explicit_non_daad_extension_nes"),
        ("game.zip", b"PK\x03\x04" + b"\x00" * 100, "raw_archive_header"),
        ("paws.dat", b"PAWS Engine" + b"\x00" * 100, "quill_paws_engine"),
    ],
)
def test_explicit_non_daad_payloads_are_rejected(filename: str, data: bytes, expected_reason: str) -> None:
    result = DAADBytecodeParser().parse_ddb(data, filename)
    assert result["is_daad"] is False
    assert result["reason"] == expected_reason


def test_find_embedded_ddb_uses_structural_validation() -> None:
    parser = DAADBytecodeParser()
    container = b"\x00" * 63 + make_ddb("amiga", major=3) + b"ignored trailing bytes"
    found = parser.find_embedded_ddb(container)
    assert found is not None
    offset, extracted = found
    assert offset == 63
    result = parser.parse_ddb(extracted, "embedded.ddb")
    assert result["is_daad"] is True
    assert result["platform"] == "amiga"


def test_find_embedded_ddb_stays_fast_on_large_non_candidate_files() -> None:
    parser = DAADBytecodeParser()
    data = b"\x00" * 20_000_000
    start = time.monotonic()
    result = parser.find_embedded_ddb(data)
    elapsed = time.monotonic() - start
    assert result is None
    assert elapsed < 3.0

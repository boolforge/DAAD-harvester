"""Tests for target-aware, structurally validated DAAD DDB recognition."""

from __future__ import annotations

from pathlib import Path
import time

import pytest

from daad_harvester.daad_parser import DAADBytecodeParser
from tests.ddb_fixtures import make_ddb, make_legacy_ddb, wrap_commodore, wrap_plus3dos


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


@pytest.mark.parametrize("platform", ("zx", "cpc", "c64", "plus4", "msx", "pcw", "atarist", "amiga", "dos"))
def test_historical_v2_header_verifies_every_official_daad_target(platform: str) -> None:
    result = DAADBytecodeParser().parse_ddb(make_legacy_ddb(platform), "legacy.ddb")

    assert result["is_daad"] is True
    assert result["confidence"] == 1.0
    assert result["platform"] == platform
    assert result["ddb_format"] == "daad-v2-legacy"
    assert result["ddb_major_version"] == 2
    assert result["reason"] == "verified_structural_legacy_ddb"
    assert result["details"]["header"]["layout"] == "legacy"


def test_historical_zx_header_accepts_target_absolute_section_addresses() -> None:
    payload = bytearray(make_legacy_ddb("zx"))
    base = 0x8400
    for index in range(13):
        offset = 8 + index * 2
        relative = int.from_bytes(payload[offset:offset + 2], "little")
        if relative:
            payload[offset:offset + 2] = (base + relative).to_bytes(2, "little")
    payload[56:60] = bytes((1, 1)) + (base + 64).to_bytes(2, "little")
    payload[72:74] = (base + 56).to_bytes(2, "little")
    result = DAADBytecodeParser().parse_ddb(bytes(payload), "native_zx.ddb")
    assert result["is_daad"] is True
    assert result["platform"] == "zx"
    assert result["details"]["header"]["base_address"] == base


def test_historical_v1_database_is_distinguished_from_v2_without_toolchain_guess() -> None:
    result = DAADBytecodeParser().parse_ddb(make_legacy_ddb("zx", major=1, spanish=True), "original.ddb")

    assert result["is_daad"] is True
    assert result["ddb_format"] == "daad-v1-legacy"
    assert result["version"] == "DAAD DDB v1"
    assert result["platform"] == "zx"
    assert result["language"] == "es"


def test_retained_adp_jabato_c64_v1_fixture_validates_at_native_base() -> None:
    fixture = (
        Path(__file__).resolve().parents[1]
        / "reverse_engineering/public_implementations/adp/source/tests/games/jabato/c64/JABATO-C64 1.DDB"
    )
    payload = fixture.read_bytes()
    result = DAADBytecodeParser().parse_ddb(payload, fixture.name)

    assert result["is_daad"] is True
    assert result["ddb_format"] == "daad-v1-legacy"
    assert result["platform"] == "c64"
    assert result["language"] == "es"
    assert result["details"]["header"]["base_address"] == 0x3880
    assert result["details"]["header"]["header_size"] == 32
    assert result["details"]["payload_size"] == len(payload) == 24899


def test_historical_header_rejects_bad_marker_and_unterminated_condact_stream() -> None:
    bad_marker = bytearray(make_legacy_ddb("c64"))
    bad_marker[2] = 0
    unterminated = bytearray(make_legacy_ddb("c64"))
    unterminated[65] = 0

    parser = DAADBytecodeParser()
    assert parser.parse_ddb(bytes(bad_marker), "legacy.ddb")["is_daad"] is False
    assert parser.parse_ddb(bytes(unterminated), "legacy.ddb")["is_daad"] is False


def test_embedded_historical_ddb_is_recovered_at_exact_declared_size() -> None:
    payload = make_legacy_ddb("plus4")
    found = DAADBytecodeParser().find_embedded_ddb(b"LOADER" + payload + b"TRAILER")

    assert found == (6, payload)


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

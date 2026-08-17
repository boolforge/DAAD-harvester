"""Tests for DAADBytecodeParser & deep structural bytecode validation."""

import pytest
from daad_harvester.daad_parser import DAADBytecodeParser, DAADParser


def test_renpy_payload_rejection():
    parser = DAADBytecodeParser()

    # Case 1: File named .data containing renpy signature
    renpy_data = b"renpy_version_8_0_3_data_payload_1234567890" + b"DAAD" * 10
    res = parser.parse_ddb(renpy_data, "game.data")
    assert res["is_daad"] is False
    assert res["reason"] == "renpy_engine_payload"

    # Case 2: File containing RPYC header
    rpyc_data = b"RPYC\x00\x01\x02\x03some_renpy_compiled_script"
    res = parser.parse_ddb(rpyc_data, "script.dat")
    assert res["is_daad"] is False
    assert res["reason"] == "renpy_engine_payload"


def test_html_php_rejection():
    parser = DAADBytecodeParser()
    html_data = b"<!DOCTYPE html><html><head><title>404 Not Found</title></head><body>DAAD</body></html>"
    res = parser.parse_ddb(html_data, "response.dat")
    assert res["is_daad"] is False
    assert res["reason"] == "html_php_content"


def test_console_rom_and_media_rejection():
    parser = DAADBytecodeParser()

    rom_data = b"NES\x1a\x02\x01\x01\x00" + b"\x00" * 100
    res = parser.parse_ddb(rom_data, "game.nes")
    assert res["is_daad"] is False
    assert "explicit_non_daad_extension" in res["reason"]

    mp3_data = b"ID3\x03\x00\x00\x00" + b"\x00" * 100
    res = parser.parse_ddb(mp3_data, "song.mp3")
    assert res["is_daad"] is False
    assert "explicit_non_daad_extension" in res["reason"]


def test_find_embedded_ddb():
    parser = DAADBytecodeParser()

    # Create dummy container with padding and embedded DDB at offset 64
    header = bytearray(32)
    header[0], header[1] = 0x20, 0x00 # P0 = 32
    header[2], header[3] = 0x30, 0x00 # P1 = 48
    header[4], header[5] = 0x40, 0x00 # P2 = 64

    ddb_payload = bytearray(128)
    ddb_payload[:32] = header
    p0_bytes = bytes([0x01, 0x01, 0x01, 0x05, 0x09, 0x0A, 0x81, 0x02, 0xFE])
    ddb_payload[32:32 + len(p0_bytes)] = p0_bytes
    p1_bytes = bytes([0x00, 0x00, 0x0B, 0x01, 0x8C, 0x01, 0xFE])
    ddb_payload[48:48 + len(p1_bytes)] = p1_bytes

    container = b"\x00" * 64 + bytes(ddb_payload)
    found = parser.find_embedded_ddb(container)
    assert found is not None
    offset, extracted = found
    assert offset == 64


def test_bytecode_disassembly_valid_ddb():
    parser = DAADBytecodeParser()

    # Construct a valid minimal DAAD DDB byte stream with valid Process Table Pointers and DAAD Opcodes
    # Process 0 pointer = 0x0020 (32)
    # Process 1 pointer = 0x0030 (48)
    # Process 2 pointer = 0x0040 (64)
    header = bytearray(32)
    header[0], header[1] = 0x20, 0x00 # P0 = 32
    header[2], header[3] = 0x30, 0x00 # P1 = 48
    header[4], header[5] = 0x40, 0x00 # P2 = 64

    # Padding up to 32 bytes
    payload = bytearray(128)
    payload[:32] = header

    # At offset 32 (P0): Verb=1, Noun=1, COND:AT(1) [0x01, 0x05], COND:PRESENT(1) [0x09, 0x0A], ACT:GOTO(1) [0x81, 0x02], ACT:DONE [0xFE]
    p0_bytes = bytes([
        0x01, 0x01,       # Entry: Verb 1, Noun 1
        0x01, 0x05,       # COND: AT(5)
        0x09, 0x0A,       # COND: PRESENT(10)
        0x81, 0x02,       # ACT: GOTO(2)
        0xFE              # ACT: DONE
    ])
    payload[32:32 + len(p0_bytes)] = p0_bytes

    # At offset 48 (P1): Verb=0, Noun=0, COND:ZERO(1) [0x0B, 0x01], ACT:PRINT(1) [0x8C, 0x01], ACT:DONE [0xFE]
    p1_bytes = bytes([
        0x00, 0x00,       # Entry: Verb 0, Noun 0
        0x0B, 0x01,       # COND: ZERO(1)
        0x8C, 0x01,       # ACT: PRINT(1)
        0xFE              # ACT: DONE
    ])
    payload[48:48 + len(p1_bytes)] = p1_bytes

    # Append DAAD system strings and vocabulary
    payload.extend(b"Es muy oscuro No ves nada Llevas contigo DAADREADY")
    payload.extend(b"INVE MIRA COGE DEJA NORT SUR ESTE OEST")

    res = parser.parse_ddb(bytes(payload), "test_game.ddb")
    assert res["is_daad"] is True
    assert res["confidence"] >= 0.70
    assert res["details"]["bytecode_disassembly_valid"] is True

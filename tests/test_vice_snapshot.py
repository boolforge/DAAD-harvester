"""Deterministic VICE snapshot RAM extraction regressions."""

from __future__ import annotations

import pytest

from scripts.extract_vice_snapshot_ram import HEADER_SIZE, MAGIC, MODULE_HEADER_SIZE, extract_ram, parse_modules


def _module(name: str, payload: bytes, major: int = 0, minor: int = 0) -> bytes:
    header = name.encode("ascii").ljust(16, b"\0") + bytes((major, minor))
    return header + (MODULE_HEADER_SIZE + len(payload)).to_bytes(4, "little") + payload


def _snapshot(*modules: bytes) -> bytes:
    return MAGIC.ljust(19, b"\0") + b"\x01\x00" + b"C64".ljust(16, b"\0") + b"VICE Version\x1a".ljust(13, b"\0") + b"\x03\x07\x01\x00" + (0).to_bytes(4, "little") + b"".join(modules)


def test_extracts_exact_c64_ram_after_memory_configuration_bytes() -> None:
    ram = bytes(range(256)) * 256
    snapshot = _snapshot(_module("MAINCPU", b"cpu"), _module("C64MEM", b"\x2f\x36\x01\x01" + ram, 0, 0))
    assert len(snapshot[:HEADER_SIZE]) == HEADER_SIZE
    extracted, metadata = extract_ram(snapshot)
    assert extracted == ram
    assert metadata["configuration_bytes_hex"] == "2f360101"
    assert metadata["ram_size"] == 65536
    assert [module[0] for module in parse_modules(snapshot)] == ["MAINCPU", "C64MEM"]


def test_rejects_truncated_c64_memory_module() -> None:
    snapshot = _snapshot(_module("C64MEM", b"\0" * 12))
    with pytest.raises(ValueError, match="too short"):
        extract_ram(snapshot)

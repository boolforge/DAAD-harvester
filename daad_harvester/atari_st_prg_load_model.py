"""Validate retained Atari ST PRG header and relocation-stream boundaries."""

from __future__ import annotations

import hashlib
import json
import struct
from pathlib import Path
from typing import Any


class AtariStPrgLoadModelError(ValueError):
    """Raised when a retained Atari ST PRG container is malformed or altered."""


HEADER_SIZE = 28
PRG_MAGIC = 0x601A


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _long(data: bytes, offset: int) -> int:
    if offset + 4 > len(data):
        raise AtariStPrgLoadModelError("truncated PRG longword")
    return struct.unpack_from(">I", data, offset)[0]


def parse_atari_st_prg(data: bytes) -> dict[str, int]:
    """Validate Atari ST PRG segment arithmetic and bounded relocation encoding."""
    if len(data) < HEADER_SIZE or int.from_bytes(data[:2], "big") != PRG_MAGIC:
        raise AtariStPrgLoadModelError("missing Atari ST PRG magic")
    text_size, data_size, bss_size, symbol_size = (_long(data, 2), _long(data, 6), _long(data, 10), _long(data, 14))
    absflag = int.from_bytes(data[26:28], "big")
    load_size = text_size + data_size + symbol_size
    relocation_offset = HEADER_SIZE + load_size
    if relocation_offset > len(data):
        raise AtariStPrgLoadModelError("PRG declared segments exceed retained file")
    if absflag != 0:
        raise AtariStPrgLoadModelError("retained PRG absolute flag is not the expected relocatable form")
    if relocation_offset + 5 > len(data):
        raise AtariStPrgLoadModelError("truncated PRG relocation stream")
    first_offset = _long(data, relocation_offset)
    if first_offset >= text_size + data_size:
        raise AtariStPrgLoadModelError("first PRG relocation lies outside text/data image")
    current = first_offset
    cursor = relocation_offset + 4
    relocation_count = 1
    while True:
        delta = data[cursor]
        cursor += 1
        if delta == 0:
            break
        current += 254 if delta == 1 else delta
        if current >= text_size + data_size:
            raise AtariStPrgLoadModelError("PRG relocation delta exceeds text/data image")
        relocation_count += 1
    if cursor != len(data):
        raise AtariStPrgLoadModelError("PRG relocation stream has trailing bytes")
    return {"text_size": text_size, "data_size": data_size, "bss_size": bss_size, "symbol_size": symbol_size, "load_size": load_size, "first_relocation_offset": first_offset, "relocation_stream_size": cursor - relocation_offset, "relocation_count": relocation_count}


def validate_atari_st_prg_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate four Atari ST containers without enabling retained execution."""
    if contract.get("schema_version") != 1 or contract.get("admission_state") != "prg_segments_and_relocations_verified_runtime_unresolved":
        raise AtariStPrgLoadModelError("invalid PRG admission state")
    if contract.get("execution_eligible") is not False:
        raise AtariStPrgLoadModelError("PRG container facts must not enable execution")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 4:
        raise AtariStPrgLoadModelError("contract must contain exactly four Atari ST profiles")
    seen: set[str] = set()
    for profile in profiles:
        identifier = profile.get("artifact_id") if isinstance(profile, dict) else None
        if not isinstance(identifier, str) or identifier in seen:
            raise AtariStPrgLoadModelError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value, expected_hash = profile.get("input_path"), profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise AtariStPrgLoadModelError(f"{identifier}: unsafe input path")
        path = root / path_value
        if not isinstance(expected_hash, str) or not path.is_file() or _sha256(path) != expected_hash:
            raise AtariStPrgLoadModelError(f"{identifier}: retained Atari ST identity differs")
        fields = parse_atari_st_prg(path.read_bytes())
        for field in ("text_size", "data_size", "bss_size", "symbol_size", "load_size", "first_relocation_offset", "relocation_stream_size", "relocation_count"):
            if profile.get(field) != fields[field]:
                raise AtariStPrgLoadModelError(f"{identifier}: {field} differs from retained PRG")


def load_atari_st_prg_load_model(path: Path, root: Path) -> dict[str, Any]:
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise AtariStPrgLoadModelError("Atari ST PRG contract must be a JSON object")
    validate_atari_st_prg_load_model(contract, root)
    return contract

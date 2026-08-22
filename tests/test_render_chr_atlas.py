"""Regression coverage for the deterministic CHR atlas command."""

from __future__ import annotations

import importlib.util
import json
from pathlib import Path

import pytest

from daad_harvester.chr_generation import CHR_HEADER_SIZE, CHR_PAYLOAD_SIZE, build_daad_chr


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "render_chr_atlas.py"
SPEC = importlib.util.spec_from_file_location("render_chr_atlas", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


def _validated_chr() -> bytes:
    header = bytearray(CHR_HEADER_SIZE)
    header[9:12] = b"CHR"
    header[0x12] = 2
    header[0x41] = 8
    header[0x43:0x45] = (0x0224).to_bytes(2, "little")
    return build_daad_chr(header=bytes(header), glyph_bytes=b"\x80" * 8 + bytes(CHR_PAYLOAD_SIZE - 8))


def test_atlas_command_writes_reproducible_hash_pinned_outputs(tmp_path: Path) -> None:
    source = tmp_path / "fixture.chr"
    output = tmp_path / "atlas.png"
    metadata = tmp_path / "atlas.json"
    source.write_bytes(_validated_chr())

    first = MODULE.render(source, output, metadata, scale=2)
    first_output = output.read_bytes()
    first_metadata = metadata.read_bytes()
    second = MODULE.render(source, output, metadata, scale=2)

    assert first == second
    assert output.read_bytes() == first_output
    assert metadata.read_bytes() == first_metadata
    manifest = json.loads(first_metadata)
    assert manifest["source_sha256"] == MODULE.sha256(source.read_bytes())
    assert manifest["derived_sha256"] == MODULE.sha256(first_output)
    assert manifest["evidence"]["glyph_index_mapping"] == "byte_index_only_no_code_page_claim"
    assert "--scale 2" in manifest["regeneration_command"]
    assert MODULE.check(source, output, metadata, scale=2) is None

    output.write_bytes(b"stale atlas")
    with pytest.raises(ValueError, match="atlas output"):
        MODULE.check(source, output, metadata, scale=2)
    MODULE.render(source, output, metadata, scale=2)
    metadata.write_bytes(b"stale manifest")
    with pytest.raises(ValueError, match="atlas manifest"):
        MODULE.check(source, output, metadata, scale=2)


def test_atlas_command_rejects_unvalidated_chr_profile(tmp_path: Path) -> None:
    source = tmp_path / "opaque.chr"
    source.write_bytes(bytes(CHR_HEADER_SIZE + CHR_PAYLOAD_SIZE))

    with pytest.raises(ValueError, match="validated ADP legacy"):
        MODULE.render(source, tmp_path / "atlas.png", tmp_path / "atlas.json")

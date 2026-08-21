"""Retained-artifact byte-identical DDB decompile/recompile regressions."""

from __future__ import annotations

from hashlib import sha256
from pathlib import Path

from daad_harvester.ddb_grammar import DDBProfile
from daad_harvester.ddb_ir import decompile_ddb, recompile_ddb
from daad_harvester.unpack import compute_hashes


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
BLANK_DDB = (
    REPOSITORY_ROOT
    / "preservation_corpus/extracted/depth1_98397784_BLANK.DDB"
)
BLANK_DDB_SHA256 = "8f45acdfe4813996cb3895dd66d2d9e6f0685acfc94c1ec35ed3eeb626cdad84"
BLANK_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=2,
    machine_id=0,
    platform="dos",
    endianness="little",
    base_address=0,
    wrapper="raw",
)


def test_retained_legacy_v2_dos_blank_ddb_round_trips_byte_identically() -> None:
    original = BLANK_DDB.read_bytes()

    assert len(original) == 2652
    assert sha256(original).hexdigest() == BLANK_DDB_SHA256
    original_hashes = compute_hashes(original)
    assert len(original_hashes) == 17
    assert all(original_hashes.values())
    ir = decompile_ddb(original, BLANK_DDB_PROFILE)
    recompiled = recompile_ddb(ir, BLANK_DDB_PROFILE)

    assert ir.source_sha256 == BLANK_DDB_SHA256
    assert len(recompiled) == len(original)
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes

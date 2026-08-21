"""Deterministic evidence generation for retained native DDB round trips.

The current fixture set proves byte-identical repository-native recompilation
for explicitly named profiles.  Its ``semantic_status`` deliberately remains
separate from byte equality: opaque section ranges are surfaced as bounded
investigation work, never hidden by a successful preservation pass-through.
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any, Final

from daad_harvester.ddb_grammar import DDBProfile
from daad_harvester.ddb_ir import decompile_ddb, recompile_ddb
from daad_harvester.unpack import compute_hashes


REPOSITORY_ROOT: Final = Path(__file__).resolve().parents[1]


@dataclass(frozen=True, slots=True)
class RetainedDDBRoundTripFixture:
    """Exact retained bytes and profile fields for one native round-trip oracle."""

    profile_id: str
    source_path: str
    expected_size: int
    expected_sha256: str
    profile: DDBProfile


RETAINED_DDB_ROUND_TRIP_FIXTURES: Final = (
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v2-dos-little-raw-blank-r4",
        source_path="preservation_corpus/extracted/depth1_98397784_BLANK.DDB",
        expected_size=2652,
        expected_sha256="8f45acdfe4813996cb3895dd66d2d9e6f0685acfc94c1ec35ed3eeb626cdad84",
        profile=DDBProfile(
            layout="legacy",
            major_version=2,
            machine_id=0,
            platform="dos",
            endianness="little",
            base_address=0,
            wrapper="raw",
        ),
    ),
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v2-dos-little-raw-spanish",
        source_path="preservation_corpus/extracted/depth1_f14c8b04_SPANISH.DDB",
        expected_size=2326,
        expected_sha256="a147f2ad2f691930e886a0c1df1d8aa1de6683a20c369fb834244e917dbc8de1",
        profile=DDBProfile(
            layout="legacy",
            major_version=2,
            machine_id=0,
            platform="dos",
            endianness="little",
            base_address=0,
            wrapper="raw",
        ),
    ),
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v1-c64-little-0x3880-raw-jabato-ass-part1",
        source_path="preservation_corpus/derived/commodore_loader/jabato_ass_part1_post_mirar.ddb",
        expected_size=24899,
        expected_sha256="7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6",
        profile=DDBProfile(
            layout="legacy",
            major_version=1,
            machine_id=2,
            platform="c64",
            endianness="little",
            base_address=0x3880,
            wrapper="raw",
        ),
    ),
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v2-zx-little-0x8400-raw-chichen-embedded-code",
        source_path="preservation_corpus/extracted/depth3_25a67864_CODE__embedded_002400.ddb",
        expected_size=22194,
        expected_sha256="7d7b26973b9c36a6dca4e804e2c4dbfccda663985f6052080ac85151bb1386ab",
        profile=DDBProfile(
            layout="legacy",
            major_version=2,
            machine_id=1,
            platform="zx",
            endianness="little",
            base_address=0x8400,
            wrapper="raw",
        ),
    ),
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v2-amiga-big-raw-chichen-part1",
        source_path="preservation_corpus/extracted/depth2_92aef478_PART1.DDB",
        expected_size=2872,
        expected_sha256="13389079e2a3e06e7546e082e5e3d1e5d7658333efcac20a0992a2dc9396e133",
        profile=DDBProfile(
            layout="legacy",
            major_version=2,
            machine_id=6,
            platform="amiga",
            endianness="big",
            base_address=0,
            wrapper="raw",
        ),
    ),
    RetainedDDBRoundTripFixture(
        profile_id="legacy-v2-amiga-big-raw-chichen-part2",
        source_path="preservation_corpus/extracted/depth1_806a1c74_PART2.DDB",
        expected_size=43990,
        expected_sha256="efe5be7e82982365699cc78308d382d86262e6f2458b6ea8c09314aa49bcc414",
        profile=DDBProfile(
            layout="legacy",
            major_version=2,
            machine_id=6,
            platform="amiga",
            endianness="big",
            base_address=0,
            wrapper="raw",
        ),
    ),
)


def _first_difference(original: bytes, recompiled: bytes) -> int | None:
    """Return the first differing offset, including a deterministic length mismatch."""

    for offset, (left, right) in enumerate(zip(original, recompiled)):
        if left != right:
            return offset
    if len(original) != len(recompiled):
        return min(len(original), len(recompiled))
    return None


def retained_ddb_round_trip_evidence() -> dict[str, Any]:
    """Build exact native preservation evidence for every promoted fixture."""

    records: list[dict[str, Any]] = []
    for fixture in RETAINED_DDB_ROUND_TRIP_FIXTURES:
        path = REPOSITORY_ROOT / fixture.source_path
        original = path.read_bytes()
        original_hashes = compute_hashes(original)
        if len(original) != fixture.expected_size:
            raise AssertionError(
                f"{fixture.profile_id} size {len(original)} != {fixture.expected_size}"
            )
        if original_hashes["sha256"] != fixture.expected_sha256:
            raise AssertionError(
                f"{fixture.profile_id} SHA-256 {original_hashes['sha256']} "
                f"!= {fixture.expected_sha256}"
            )
        ir = decompile_ddb(original, fixture.profile)
        recompiled = recompile_ddb(ir, fixture.profile)
        recompiled_hashes = compute_hashes(recompiled)
        first_difference = _first_difference(original, recompiled)
        if first_difference is not None:
            raise AssertionError(
                f"{fixture.profile_id} native recompile differs at {first_difference:#x}"
            )
        opaque_ranges = [
            {"byte_start": start, "byte_end": end, "reason": reason}
            for start, end, reason in ir.opaque_ranges()
        ]
        records.append(
            {
                "profile_id": fixture.profile_id,
                "source_path": fixture.source_path,
                "source_size": len(original),
                "profile": asdict(fixture.profile),
                "source_digests": original_hashes,
                "recompiled_size": len(recompiled),
                "recompiled_digests": recompiled_hashes,
                "byte_comparison": {
                    "byte_identical": True,
                    "first_difference": None,
                },
                "semantic_status": (
                    "semantically_decoded"
                    if ir.is_semantically_complete
                    else "structurally_bounded"
                ),
                "opaque_ranges": opaque_ranges,
            }
        )
    return {
        "schema_version": 1,
        "fixture_count": len(records),
        "records": records,
    }

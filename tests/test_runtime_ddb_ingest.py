"""Real-artifact regression for emulator-RAM DDB materialization."""

from __future__ import annotations

import importlib.util
from pathlib import Path
import sys

from daad_harvester.db import Database


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/ingest_runtime_ddb.py"
SPEC = importlib.util.spec_from_file_location("ingest_runtime_ddb", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
INGEST = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = INGEST
SPEC.loader.exec_module(INGEST)


def test_retained_side_b_ram_part2_is_materialized_as_verified_artifact(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/jabato-side-b", "archive", initial_status="unpacked")
    assert source_id is not None
    ram = ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_b_tap_post_input_12.ram"
    expected = "ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69"

    result = INGEST.ingest(
        db,
        source_id=source_id,
        ram_path=ram,
        output_path=tmp_path / "part2.ddb",
        filename="jabato_side_b_runtime_part2.ddb",
        offset=0x3880,
        expected_sha256=expected,
    )

    artifact = db.get_all_artifacts()[0]
    assert result["sha256"] == expected
    assert result["size"] == 24680
    assert artifact.is_daad_payload is True
    assert artifact.ddb_format == "daad-v1-legacy"
    assert artifact.measured_platform == "c64"
    assert artifact.media_status == "runtime_recovered"
    assert (tmp_path / "part2.ddb").read_bytes() == (
        ROOT / "reverse_engineering/public_implementations/adp/source/tests/games/jabato/c64/JABATO-C64 2.DDB"
    ).read_bytes()

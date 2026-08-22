from __future__ import annotations

from pathlib import Path

import pytest

from daad_harvester.artifact_paths import resolve_retained_artifact_path


def test_resolve_retained_artifact_path_uses_existing_recorded_path(tmp_path: Path) -> None:
    retained = tmp_path / "outside.bin"
    retained.write_bytes(b"evidence")

    assert resolve_retained_artifact_path(str(retained), tmp_path) == retained


def test_resolve_retained_artifact_path_rebases_historical_checkout(tmp_path: Path) -> None:
    retained = tmp_path / "preservation_corpus" / "extracted" / "depth1_example.dsk"
    retained.parent.mkdir(parents=True)
    retained.write_bytes(b"evidence")

    resolved = resolve_retained_artifact_path(
        "/historical/checkout/preservation_corpus/extracted/depth1_example.dsk", tmp_path
    )

    assert resolved == retained.resolve()


def test_resolve_retained_artifact_path_rejects_non_corpus_or_missing_paths(tmp_path: Path) -> None:
    with pytest.raises(ValueError, match="lacks"):
        resolve_retained_artifact_path("/historical/checkout/unrelated.bin", tmp_path)
    with pytest.raises(ValueError, match="unavailable"):
        resolve_retained_artifact_path("/historical/checkout/preservation_corpus/extracted/missing.dsk", tmp_path)

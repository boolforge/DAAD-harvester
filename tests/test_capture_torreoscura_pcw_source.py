from __future__ import annotations

import pytest

from scripts.capture_torreoscura_pcw_source import PCW_ARCHIVE, PCW_TEXT, build_snapshot


def test_build_snapshot_records_exact_public_pcw_link() -> None:
    snapshot = build_snapshot(f'<a href="to_pcw.zip">{PCW_TEXT}</a>')

    assert snapshot["pcw_archive_url"] == PCW_ARCHIVE
    assert snapshot["pcw_link_text"] == PCW_TEXT


def test_build_snapshot_rejects_missing_or_shifted_public_pcw_link() -> None:
    with pytest.raises(ValueError, match="exactly one"):
        build_snapshot("<html></html>")
    with pytest.raises(ValueError, match="unexpected"):
        build_snapshot(f'<a href="other.zip">{PCW_TEXT}</a>')

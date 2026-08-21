"""Tests for interactive TUIDashboard components."""

import pytest
from unittest.mock import MagicMock
from daad_harvester.db import Database
from daad_harvester.tui import TUIDashboard


def test_tui_dashboard_navigation(tmp_path):
    db = Database(tmp_path / "test.db")
    tui = TUIDashboard(db)

    assert tui.active_tab == 0

    # Simulate pressing Tab key
    tui.handle_key_input("\t")
    assert tui.active_tab == 1

    # Simulate pressing Tab key again
    tui.handle_key_input("\t")
    assert tui.active_tab == 2

    # Simulate pressing Tab key again (wrap around)
    tui.handle_key_input("\t")
    assert tui.active_tab == 0


def test_tui_dashboard_search_filter(tmp_path):
    db = Database(tmp_path / "test.db")
    tui = TUIDashboard(db)

    # Trigger search mode
    tui.handle_key_input("/")
    assert tui.in_search_mode is True

    # Type query "jabato"
    for char in "jabato":
        tui.handle_key_input(char)

    assert tui.search_filter == "jabato"

    # Press Enter to exit search mode
    tui.handle_key_input("\n")
    assert tui.in_search_mode is False
    assert tui.search_filter == "jabato"


def test_tui_detail_view_open_close_and_render(tmp_path):
    """Enter opens the per-game detail modal (Tab 1 only); Enter/Esc closes it;
    it renders real forensic fields without crashing, including with 0 games."""
    from daad_harvester.models import ArtifactRecord

    db = Database(tmp_path / "test.db")
    src_id = db.add_source(url="https://example.com/game.zip", source_tier="archive", title="Src")
    db.add_artifact(ArtifactRecord(
        id=None, source_id=src_id, original_filename="jabato.ddb", extracted_path="/tmp/j.ddb",
        archive_depth=0, file_size=54321, md5_full="a" * 32, md5_5000="b" * 32, sha256="c" * 64,
        is_daad_payload=True, daad_version_guess="DAAD DDB", platform_hint="zx", title="El Jabato",
    ))
    tui = TUIDashboard(db)

    assert tui.detail_view is False
    tui.handle_key_input("\r")  # Enter on tab 0 opens it
    assert tui.detail_view is True
    tui.console.print(tui.render())  # must not raise

    # While open, other keys (e.g. Tab) are ignored -- only Enter/Esc close it
    tui.handle_key_input("\t")
    assert tui.active_tab == 0
    assert tui.detail_view is True

    tui.handle_key_input("\x1b")  # Escape closes it
    assert tui.detail_view is False

    # Empty DB: opening the modal with nothing selected must not crash
    empty_tui = TUIDashboard(Database(tmp_path / "empty.db"))
    empty_tui.handle_key_input("\r")
    assert empty_tui.detail_view is True
    empty_tui.console.print(empty_tui.render())

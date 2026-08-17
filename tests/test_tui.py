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

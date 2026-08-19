"""Tests for interactive TUIDashboard components."""

from hashlib import md5, sha256
from io import StringIO
from pathlib import Path

import pytest
from unittest.mock import MagicMock
from rich.console import Console
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.tui import TUIDashboard
from tests.ddb_fixtures import make_ddb


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


def test_tui_cycles_theme_and_opens_selected_artifact_inspector(tmp_path: Path):
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/adventure", "fixture")
    payload = make_ddb("zx")
    path = tmp_path / "adventure.ddb"
    path.write_bytes(payload)
    artifact = ArtifactRecord(
        id=None, source_id=source_id, original_filename="ADVENTURE.DDB", extracted_path=str(path), archive_depth=1,
        file_size=len(payload), md5_full=md5(payload).hexdigest(), md5_5000=md5(payload).hexdigest(), sha256=sha256(payload).hexdigest(),
        is_daad_payload=True, measured_platform="zx", ddb_format="daad-v3", fingerprint_confidence="verified",
    )
    db.add_artifact(artifact)
    dashboard = TUIDashboard(db)
    original_theme = dashboard.theme[0]
    dashboard.handle_key_input("h")
    assert dashboard.theme[0] != original_theme
    dashboard.handle_key_input("\n")
    assert dashboard.show_detail is True
    output = StringIO()
    dashboard.console = Console(file=output, force_terminal=False, width=120)
    dashboard.console.print(dashboard.render())
    assert "ARTIFACT INSPECTOR" in output.getvalue()
    assert "ADVENTURE.DDB" in output.getvalue()

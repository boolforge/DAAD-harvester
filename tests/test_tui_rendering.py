"""Real rendering tests for TUIDashboard.

These exercise the actual Rich rendering path (render() -> Console.print()),
unlike test_tui.py, which only drives handle_key_input() in isolation and
never touches Rich's markup parser at all. That is exactly how the original
`rich.errors.MarkupError` crash (an unescaped "[/]" key hint in the footer)
and the related bracket-in-title crash risk shipped to main with a fully
green test suite: the tests never exercised the code path that broke in
real usage.
"""

from pathlib import Path

from rich.console import Console

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.tui import TUIDashboard


def _render(dash: TUIDashboard, tabs=(0, 1, 2), width: int = 140) -> str:
    """Renders the given tabs through a real Console and returns plain text."""
    console = Console(record=True, width=width, force_terminal=True)
    for tab in tabs:
        dash.active_tab = tab
        console.print(dash.render())
    return console.export_text()


def test_render_empty_db_all_tabs_no_crash(tmp_path):
    db = Database(tmp_path / "test.db")
    dash = TUIDashboard(db)
    # Must not raise rich.errors.MarkupError (or anything else).
    _render(dash)


def test_render_footer_hints_are_literal_not_swallowed(tmp_path):
    """Regression test for the exact crash: '[/]' must render as literal
    text, not be parsed as Rich's bare close-tag instruction (which closed
    the preceding [bold yellow] span early and left the following explicit
    [/bold yellow] with nothing to close)."""
    db = Database(tmp_path / "test.db")
    dash = TUIDashboard(db)
    text = _render(dash, tabs=(0,))
    for hint in ("[Tab]", "[Up/Down]", "[/]", "[C]", "[P]"):
        assert hint in text, f"key hint {hint!r} missing/mangled in rendered footer"


def test_render_with_bracketed_game_title_no_crash(tmp_path):
    """Real archive filenames/titles routinely carry bracketed platform/year/
    region tags, e.g. 'Game [1988] (ZX Spectrum) [Cracked].zip'. These must
    never be misinterpreted as Rich markup tags."""
    db = Database(tmp_path / "test.db")
    src_id = db.add_source("http://example.com/juego.zip", "archive")
    art = ArtifactRecord(
        id=None,
        source_id=src_id,
        original_filename="La Aventura Original [1988] (ZX) [Cracked].zip",
        extracted_path="/tmp/x.ddb",
        archive_depth=1,
        file_size=47104,
        md5_full="a" * 32,
        md5_5000="b" * 32,
        sha256="c" * 64,
        is_daad_payload=True,
        title="La Aventura Original [1988] [Cracked]",
        platform_hint="zx",
    )
    db.add_artifact(art)

    dash = TUIDashboard(db)
    text = _render(dash, tabs=(0,))

    assert "La Aventura Original" in text
    assert "1988" in text
    assert "Cracked" in text


def test_render_with_bracketed_source_title_no_crash(tmp_path):
    db = Database(tmp_path / "test.db")
    db.add_source(
        "http://example.com/x.zip",
        "archive",
        title="Coleccion DAAD Juegos [ZX+CPC] (1988-1992)",
    )
    dash = TUIDashboard(db)
    text = _render(dash, tabs=(1,))
    assert "ZX+CPC" in text
    assert "1988-1992" in text


def test_render_with_bracketed_search_filter_no_crash(tmp_path):
    """A user typing '[' while filtering must not crash the dashboard."""
    db = Database(tmp_path / "test.db")
    dash = TUIDashboard(db)
    dash.in_search_mode = True
    for ch in "aventura [1988]":
        dash.handle_key_input(ch)
    assert dash.search_filter == "aventura [1988]"

    text = _render(dash, tabs=(0, 1))
    assert "aventura [1988]" in text


def test_render_survives_many_update_cycles(tmp_path):
    """Simulates run_live_tui_async's update_loop calling render() repeatedly
    (~4x/second in production) while the user switches tabs and toggles
    pause -- the actual conditions the original crash occurred under."""
    db = Database(tmp_path / "test.db")
    db.add_source("http://example.com/a.zip", "archive", title="Fuente A [x]")
    dash = TUIDashboard(db)
    console = Console(record=True, width=120, force_terminal=True)
    for i in range(15):
        dash.handle_key_input("\t")
        if i % 4 == 0:
            dash.handle_key_input("p")
        console.print(dash.render())


def test_render_priority_queue_exposes_catalog_and_cpc_priority(tmp_path):
    db = Database(tmp_path / "test.db")
    db.add_source(
        "https://example.com/chichen.dsk",
        "archive",
        title="Chichén Itzá",
        platform="cpc",
        known_game_id="chichen_itza",
        acquisition_priority=1200,
    )
    dash = TUIDashboard(db)
    text = _render(dash, tabs=(1, 2))

    assert "Priority Acquisition" in text
    assert "chichen_itza" in text
    assert "1200" in text
    assert "Priority CPC Candidates" in text

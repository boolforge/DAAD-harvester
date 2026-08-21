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


def _render(dash: TUIDashboard, tabs=(0, 1, 2, 3, 4, 5, 6), width: int = 140) -> str:
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


def test_render_priority_queue_exposes_catalog_and_platform_neutral_priority(tmp_path):
    db = Database(tmp_path / "test.db")
    db.add_source(
        "https://example.com/chichen.dsk",
        "archive",
        title="Chichén Itzá",
        platform="cpc",
        known_game_id="chichen_itza",
        acquisition_priority=1000,
    )
    dash = TUIDashboard(db)
    text = _render(dash, tabs=(1, 5))

    assert "Priority Acquisition" in text
    assert "chichen_itza" in text
    assert "1000" in text
    assert "Evidence-Prioritized Candidates" in text


def test_render_game_port_and_detection_handoff_with_real_lineage(tmp_path):
    db = Database(tmp_path / "test.db")
    source_id = db.add_source(
        "https://example.com/chichen.dsk",
        "archive",
        title="Chichén Itzá",
        platform="cpc",
        known_game_id="chichen_itza",
    )
    artifact = ArtifactRecord(
        id=None,
        source_id=source_id,
        original_filename="CHICHEN.DDB",
        extracted_path=str(tmp_path / "CHICHEN.DDB"),
        archive_depth=1,
        file_size=24576,
        md5_full="a" * 32,
        md5_5000="b" * 32,
        sha256="c" * 64,
        is_daad_payload=True,
        measured_platform="cpc",
        ddb_format="daad-v2",
    )
    db.add_artifact(artifact)
    db.add_artifact(
        ArtifactRecord(
            id=None,
            source_id=source_id,
            original_filename="CHICHEN.DSK",
            extracted_path=str(tmp_path / "CHICHEN.DSK"),
            archive_depth=0,
            file_size=184320,
            md5_full="d" * 32,
            md5_5000="e" * 32,
            sha256="f" * 64,
            container_format="cpc-dsk",
            media_parser="cpc_dsk",
            media_validation="recognized",
        )
    )
    dash = TUIDashboard(db)
    dash.search_filter = "chichen"

    text = _render(dash, tabs=(2, 4), width=180)

    assert "GAME & PORT EXPLORER" in text
    assert "Chichén Itzá" in text
    assert "Catalog platforms" in text
    assert "Measured artifact platforms" in text
    assert "CHICHEN.DDB" in text
    assert "CHICHEN.DSK" in text
    assert "structurally validated DDB payload" in text
    assert "retained technical-medium container" in text
    assert "… 1 more retained artifacts" not in text
    assert "c" * 16 in text
    assert "SCUMMVM DETECTION HANDOFF" in text
    assert "Detection metadata only" in text


def test_render_native_generator_tab_exposes_complete_checksum_and_boundary(tmp_path):
    dash = TUIDashboard(Database(tmp_path / "test.db"))

    text = _render(dash, tabs=(3,), width=180)

    assert "NATIVE FORMAT GENERATOR EVIDENCE" in text
    assert "1 of 3" in text
    assert "extended-dsk-blank-cpc-system-v1" in text
    assert "validated_cpc_dsk_track_stream" in text
    assert "17 complete digests recorded" in text

    dash.selected_index = 11
    checksum_text = _render(dash, tabs=(3,), width=180)

    assert "Integrity window" in checksum_text
    assert "BLAKE2B" in checksum_text
    assert "XXH128" in checksum_text

    dash.selected_index = 18
    adf_text = _render(dash, tabs=(3,), width=180)
    assert "2 of 3" in adf_text
    assert "adf-ofs-blank-standard-dd-v1" in adf_text
    assert "empty_ofs_filesystem_no_members" in adf_text

    dash.selected_index = 36
    tzx_text = _render(dash, tabs=(3,), width=180)
    assert "3 of 3" in tzx_text
    assert "tzx-standard-data-synthetic-pair-v1" in tzx_text
    assert "generated_extraction_verified" in tzx_text

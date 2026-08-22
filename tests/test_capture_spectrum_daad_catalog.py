from __future__ import annotations

import json

import pytest

from scripts.capture_spectrum_daad_catalog import (
    DEFAULT_RAW,
    _read_raw_snapshot,
    build_snapshot,
    parse_relationship_catalog,
)


def test_committed_spectrum_relationship_snapshot_is_structurally_captured() -> None:
    raw_html = _read_raw_snapshot(DEFAULT_RAW)
    snapshot = build_snapshot(raw_html)

    assert snapshot["record_count"] == 42
    assert snapshot["relationship_label"] == "Programs authored (or executed) with this title"
    assert snapshot["records"][0] == {
        "catalog_entry_url": "https://spectrumcomputing.co.uk/entry/42613/ZX-Spectrum/13_Rue_del_Percebe_El_Nacimiento_de_la_Leyenda",
        "catalog_release_id": "42613",
        "catalog_platform_path": "ZX-Spectrum",
        "displayed_publisher": "Manuel Mart\u00ednez Pe\u00f1a",
        "displayed_title": "13 Rue del Percebe: El Nacimiento de la Leyenda",
        "displayed_year": 2023,
        "language": None,
        "relationship_state": "catalog_relationship_only",
    }
    assert next(record for record in snapshot["records"] if record["displayed_title"] == "La Celda")["displayed_year"] is None
    assert all(record["language"] is None for record in snapshot["records"])


def test_snapshot_json_is_deterministic() -> None:
    first = build_snapshot(_read_raw_snapshot(DEFAULT_RAW))
    second = build_snapshot(_read_raw_snapshot(DEFAULT_RAW))

    assert json.dumps(first, indent=2, sort_keys=True) == json.dumps(second, indent=2, sort_keys=True)


def test_parser_rejects_absent_relationship_panel() -> None:
    with pytest.raises(ValueError, match="relationship panel is missing"):
        parse_relationship_catalog("<html><body><main>no relationships</main></body></html>")


def test_parser_rejects_row_without_a_title_link() -> None:
    malformed = """
        <div id="collapse_authored">
          <div class="row zxdb_stripes">
            <div>title</div><div><a href="list?label_id=1">publisher</a></div><div>2024</div><div></div>
          </div>
        </div>
    """
    with pytest.raises(ValueError, match="lacks title or publisher link"):
        parse_relationship_catalog(malformed)

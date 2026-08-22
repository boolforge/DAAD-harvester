from __future__ import annotations

import pytest

from scripts.capture_official_daad_fnt_cpc_evidence import build_snapshot, parse_changelog


CHANGELOG = """# Changelog

## DAAD R3

in DAAD\\TAPMAST\\

* DLPART1.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART1
* DLPART2.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART2
* DAAD.FNT: the DAAD standard CPC font (this file is used by the CPC tape loader)
"""


def test_official_changelog_extracts_only_documented_cpc_fnt_role() -> None:
    claim = parse_changelog(CHANGELOG)

    assert claim == {
        "release_section": "DAAD R3",
        "documented_path": r"DAAD\TAPMAST\DAAD.FNT",
        "exact_statement": "DAAD.FNT: the DAAD standard CPC font (this file is used by the CPC tape loader)",
        "cpc_loader_context": [
            "DLPART1.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART1",
            "DLPART2.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART2",
        ],
    }
    snapshot = build_snapshot(CHANGELOG)
    assert snapshot["source_revision"] == "4a7e745235a12af5b397902dbd9214bc930c7680"
    assert "does not establish" in str(snapshot["boundary"])


def test_official_changelog_rejects_fnt_statement_without_loader_context() -> None:
    with pytest.raises(ValueError, match="CPC tape-loader context"):
        parse_changelog("""## DAAD R3\n\n* DAAD.FNT: the DAAD standard CPC font (this file is used by the CPC tape loader)\n""")

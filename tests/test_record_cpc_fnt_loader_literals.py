from __future__ import annotations

import pytest

from scripts.record_cpc_fnt_loader_literals import LITERAL, literal_offsets


def test_literal_offsets_returns_each_observed_loader_token_occurrence() -> None:
    assert literal_offsets(b'prefix "!DAAD.FNT", middle "!DAAD.FNT", suffix') == [9, 29]


def test_literal_offsets_rejects_nearby_but_nonmatching_filename() -> None:
    assert literal_offsets(b'DAAD.FON "!DAAD.FNTX",') == []
    assert literal_offsets(b"DAAD.FNT") == []
    assert LITERAL == b"DAAD.FNT"

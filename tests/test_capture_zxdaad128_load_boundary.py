from __future__ import annotations

import pytest

from scripts.capture_zxdaad128_load_boundary import AD0_SENTENCE, OTHER_BANKS_SENTENCE, build_snapshot


def test_build_snapshot_records_documented_modern_load_boundary() -> None:
    snapshot = build_snapshot(f"{AD0_SENTENCE}\n{OTHER_BANKS_SENTENCE}")

    assert snapshot["documented_load_assumptions"] == {
        "ad0_bank": 0,
        "ad0_load_address": "0x6000",
        "ad0_entry_address": "0x6002",
        "other_bank_load_address": "0xC000",
    }
    assert "does not establish Spectrum Next support" in snapshot["non_claims"][2]


def test_build_snapshot_rejects_missing_load_assumption() -> None:
    with pytest.raises(ValueError, match="lacks an expected load-assumption statement"):
        build_snapshot(AD0_SENTENCE)

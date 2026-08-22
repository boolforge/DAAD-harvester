from __future__ import annotations

import pytest

from scripts.capture_py8dis_capability_boundary import CAPABILITY_SENTENCE, build_snapshot


def test_build_snapshot_records_explicit_non_z80_boundary() -> None:
    snapshot = build_snapshot(CAPABILITY_SENTENCE)

    assert snapshot["documented_cpu_support"] == ["6502", "65C02", "8080"]
    assert snapshot["z80_capability"] == "not included in the retained README's explicit current CPU-support statement"
    assert "does not install, execute, configure, or validate py8dis" in snapshot["non_claims"][0]


def test_build_snapshot_rejects_missing_explicit_cpu_statement() -> None:
    with pytest.raises(ValueError, match="lacks the expected CPU-capability statement"):
        build_snapshot("py8dis documentation changed")

from __future__ import annotations

import pytest

from scripts.capture_redasm_capability_boundary import (
    DOCUMENTED_PROCESSORS,
    NEXT_SECTION,
    PROCESSOR_HEADING,
    PROCESSOR_TABLE_MARKERS,
    build_snapshot,
)


def _readme(*, processor_table: str | None = None) -> str:
    table = processor_table or "\n".join(PROCESSOR_TABLE_MARKERS)
    return f"Introduction\n{PROCESSOR_HEADING}\n{table}\n{NEXT_SECTION}\n"


def test_build_snapshot_records_the_explicit_processor_table_boundary() -> None:
    snapshot = build_snapshot(_readme())

    assert snapshot["documented_processors"] == DOCUMENTED_PROCESSORS
    assert "Z80 is not listed in the retained README processor table." in snapshot["documented_boundaries"]
    assert "It does not claim that redasm lacks a possible Z80 plugin or configuration outside the retained processor table." in snapshot["non_claims"]


def test_build_snapshot_rejects_missing_processor_table_marker() -> None:
    with pytest.raises(ValueError, match="lacks expected processor-table markers"):
        build_snapshot(_readme(processor_table=PROCESSOR_TABLE_MARKERS[0]))


def test_build_snapshot_rejects_a_processor_table_that_lists_z80() -> None:
    with pytest.raises(ValueError, match="does not retain the expected non-Z80 processor table"):
        build_snapshot(_readme(processor_table="\n".join((*PROCESSOR_TABLE_MARKERS, "| **Z80** | test | **A** |"))))

import pytest

from scripts.run_parallel_workflow import GATE_GROUPS, run_parallel


def test_gate_groups_are_named_and_nonempty() -> None:
    assert set(GATE_GROUPS) == {"evidence", "publication", "analysis"}
    assert all(GATE_GROUPS[group] for group in GATE_GROUPS)
    names = [gate.name for gates in GATE_GROUPS.values() for gate in gates]
    assert len(names) == len(set(names))


def test_unknown_group_is_rejected() -> None:
    with pytest.raises(ValueError, match="unknown gate groups"):
        run_parallel(groups=["missing"], workers=1)


def test_worker_count_is_clamped_and_group_runs() -> None:
    assert run_parallel(groups=["publication"], workers=999) == 0

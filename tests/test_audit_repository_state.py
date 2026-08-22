from __future__ import annotations

from scripts.audit_repository_state import _markdown_report, _todo_baseline_status, collect_audit


def test_repository_audit_collects_committed_inventory_deterministically() -> None:
    first = collect_audit()
    second = collect_audit()

    assert first == second
    assert first["schema_version"] == 1
    assert first["metrics"]["backlog"]["unchecked_items"] == 155
    assert first["metrics"]["acquisition"] == {
        "queued": 37,
        "discovery_required": 42,
        "blocked": 0,
    }
    assert first["metrics"]["corpus"]["artifacts"] == 1015
    assert first["metrics"]["corpus"]["sources"] == 265
    assert first["metrics"]["regeneration"] == {
        "entries": 17,
        "inputs": 40,
        "outputs": 26,
    }
    references = first["audit"]["command_execution_references"]
    assert len(references) == 12
    assert {reference["class"] for reference in references} == {
        "acquisition_only_runtime",
        "declared_host_dependency",
        "external_independent_validator",
        "repository_native_orchestration",
    }
    assert all(reference["boundary"] for reference in references)


def test_repository_audit_marks_filename_test_matching_as_a_review_prompt() -> None:
    data = collect_audit()
    report = _markdown_report(data)

    assert "not proof of missing coverage" in report
    assert "does not establish universal catalog completeness" in report
    assert "Recent bounded deliveries established PCW same-disk companion co-residency" in report
    assert "The next atomic delivery should implement the PCW child" not in report
    assert data["audit"]["limitations"] == [
        "Static analysis does not establish format, release, or runtime semantics.",
        "Filename-level test matching is a review prompt, not test coverage measurement.",
        "Identical AST bodies require semantic review before deduplication.",
    ]


def test_todo_baseline_is_reported_without_interpreting_it_as_current_results() -> None:
    assert _todo_baseline_status("no release assertion") == {
        "declared_test_count": None,
        "status": "not_found",
    }
    assert _todo_baseline_status(
        "latest local deterministic release gate reports **319 passing tests**"
    ) == {
        "declared_test_count": 319,
        "status": "historical_baseline_requires_release-gate_refresh",
    }

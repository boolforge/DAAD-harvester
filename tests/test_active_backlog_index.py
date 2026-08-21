from scripts.build_active_backlog_index import build_index


def test_build_index_is_deterministic_and_preserves_sections() -> None:
    sample = "# A\n- [ ] First parser task\n## B\n- [x] Done\n- [ ] Second report task\n"
    first = build_index(sample)
    second = build_index(sample)

    assert first == second
    assert first["unchecked_item_count"] == 2
    assert first["items"][0]["section"] == "A"
    assert first["items"][1]["section"] == "B"
    assert [item["id"] for item in first["items"]] == ["todo-0002", "todo-0005"]
    assert first["items"][0]["required_real_artifact_regression"] is False
    assert first["items"][1]["regeneration_report_impact"] == "report/TUI/web regeneration and accessibility checks"


def test_broad_requirement_is_not_promoted_by_child_wording() -> None:
    index = build_index("## Gate\n- [ ] Complete universal corpus audit with every retained artifact\n")
    item = index["items"][0]

    assert item["atomic_delivery_boundary"] == "broad gate; split into independently evidenced child deliveries"
    assert item["required_real_artifact_regression"] is True

from types import SimpleNamespace

from daad_harvester.report_export import StaticReportExporter
from daad_harvester.tui import TUIDashboard


def test_report_labels_c64_sys_launcher_as_non_ddb() -> None:
    presentation = StaticReportExporter._artifact_presentation({"media_parser": "c64-basic-sys-prg"})

    assert presentation["role"] == "C64 BASIC SYS launcher"
    assert presentation["status"] == "validated C64 program medium; not a DDB"
    assert "runtime-derived DDB" in (presentation["boundary"] or "")
    assert presentation["runtime_ddb_link"] is None


def test_tui_labels_c64_sys_launcher_as_non_ddb() -> None:
    artifact = SimpleNamespace(
        original_filename="JABATO P.1",
        is_daad_payload=False,
        media_parser="c64-basic-sys-prg",
    )

    assert TUIDashboard._resource_role(artifact) == "C64 BASIC SYS launcher (not a DDB)"
    boundary = TUIDashboard._resource_boundary(artifact)
    assert "not a DDB" in boundary
    assert "separate linked evidence record" in boundary

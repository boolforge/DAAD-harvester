from __future__ import annotations

import json
from pathlib import Path

import pytest

from daad_harvester import analyzer_adapters


ROOT = Path(__file__).resolve().parents[1]
CATALOG_PATH = ROOT / "reverse_engineering" / "workflows" / "analyzer_adapters.json"
TOOLCHAIN_PATH = ROOT / "reverse_engineering" / "workflows" / "toolchain.json"


def _catalog() -> dict:
    return json.loads(CATALOG_PATH.read_text(encoding="utf-8"))


def _toolchain() -> dict:
    return json.loads(TOOLCHAIN_PATH.read_text(encoding="utf-8"))


def test_repository_catalog_covers_each_configured_toolchain_architecture_redundantly() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())

    for architecture in _toolchain()["architectures"]:
        adapters = analyzer_adapters.adapters_for_architecture(catalog, architecture)
        assert [adapter["role"] for adapter in adapters] == [
            "control_flow_analysis",
            "static_disassembly",
            "structured_analysis",
        ]
        assert all(adapter["state"] == analyzer_adapters.CONFIGURED for adapter in adapters)


def test_candidates_are_cataloged_but_never_selected_for_configured_execution() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())

    candidates = analyzer_adapters.adapters_for_architecture(
        catalog, "z80", state=analyzer_adapters.CANDIDATE
    )

    assert {adapter["adapter_id"] for adapter in candidates} == {
        "skoolkit-z80-candidate-v1",
        "z80dismblr-candidate-v1",
    }
    assert all(adapter["runner"] == "external_candidate" for adapter in candidates)
    assert all("raw retained bytes" in adapter["commentary_boundary"] or "raw-base-zero" in adapter["commentary_boundary"] for adapter in candidates)


def test_pinned_py8dis_candidate_is_limited_to_unconfigured_mos6502_research() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    py8dis = next(adapter for adapter in catalog["adapters"] if adapter["adapter_id"] == "py8dis-mos6502-candidate-v1")

    assert py8dis["state"] == analyzer_adapters.CANDIDATE
    assert py8dis["architectures"] == ["mos6502"]
    assert py8dis["tool"]["pin"] == "2a6046356e20e93c4a2d484bc04bd5d74d66254e"
    assert py8dis["runner"] == "external_candidate"
    assert "origin" in py8dis["load_model_compatibility"][0]


def test_pinned_z80dismblr_candidate_is_limited_to_unconfigured_z80_research() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    z80dismblr = next(adapter for adapter in catalog["adapters"] if adapter["adapter_id"] == "z80dismblr-candidate-v1")

    assert z80dismblr["state"] == analyzer_adapters.CANDIDATE
    assert z80dismblr["architectures"] == ["z80"]
    assert z80dismblr["tool"]["pin"] == "2ff52822f0d706f9f39762e079f300f45cfd451d"
    assert z80dismblr["runner"] == "external_candidate"
    assert "start_or_trace" in z80dismblr["load_model_compatibility"][0]


def test_pinned_redasm_candidate_is_limited_to_unconfigured_i8086_research() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    redasm = next(adapter for adapter in catalog["adapters"] if adapter["adapter_id"] == "redasm-i8086-candidate-v1")

    assert redasm["state"] == analyzer_adapters.CANDIDATE
    assert redasm["architectures"] == ["i8086"]
    assert redasm["tool"]["pin"] == "113245ef02090602978e461fcb7031b75da448d6"
    assert redasm["runner"] == "external_candidate"
    assert "headless_cli" in redasm["load_model_compatibility"][0]


def test_catalog_rejects_configured_adapter_with_incompatible_load_model() -> None:
    catalog = _catalog()
    catalog["adapters"][0]["load_model_compatibility"] = ["requires_validated_model"]

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="incompatible load model"):
        analyzer_adapters.validate_catalog(catalog, _toolchain())


def test_catalog_rejects_candidate_that_claims_to_be_executable() -> None:
    catalog = _catalog()
    candidate = next(adapter for adapter in catalog["adapters"] if adapter["state"] == "candidate")
    candidate["runner"] = "radare2_static"

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="external_candidate"):
        analyzer_adapters.validate_catalog(catalog, _toolchain())


def test_commentary_template_preserves_all_evidence_layers() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    template = analyzer_adapters.commentary_template(
        analyzer_adapters.adapters_for_architecture(catalog, "i8086")[0]
    )

    assert tuple(template) == analyzer_adapters.COMMENTARY_LAYERS
    assert "Tool-derived" in template["tool_hypotheses"]
    assert "separately" in template["evidenced_behavior"]

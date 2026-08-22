from __future__ import annotations

import json
from pathlib import Path

import pytest

from daad_harvester import analyzer_adapters


ROOT = Path(__file__).resolve().parents[1]
CATALOG_PATH = ROOT / "reverse_engineering" / "workflows" / "analyzer_adapters.json"
TOOLCHAIN_PATH = ROOT / "reverse_engineering" / "workflows" / "toolchain.json"
CANDIDATE_MATRIX_PATH = ROOT / "reverse_engineering" / "workflows" / "analyzer_candidate_matrix.json"
GHIDRA_HEALTH_PATH = ROOT / "reverse_engineering" / "workflows" / "ghidra_headless_health.json"
DOS_I8086_ADMISSION_PATH = ROOT / "reverse_engineering" / "workflows" / "dos_i8086_load_model_admission.json"


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


def test_pinned_capstone_candidate_is_limited_to_unconfigured_m68000_and_i8086_research() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    capstone = next(adapter for adapter in catalog["adapters"] if adapter["adapter_id"] == "capstone-m68k-x86-candidate-v1")

    assert capstone["state"] == analyzer_adapters.CANDIDATE
    assert capstone["architectures"] == ["m68000", "i8086"]
    assert capstone["tool"]["pin"] == "3a8d30a66726fd31990fa584f62fd30dcd9f9b50"
    assert capstone["runner"] == "external_candidate"
    assert "origin_entry" in capstone["load_model_compatibility"][0]


def test_pinned_lybrown_candidate_is_limited_to_unconfigured_mos6502_research() -> None:
    catalog = analyzer_adapters.load_catalog(CATALOG_PATH, _toolchain())
    lybrown = next(adapter for adapter in catalog["adapters"] if adapter["adapter_id"] == "lybrown-dis-mos6502-candidate-v1")

    assert lybrown["state"] == analyzer_adapters.CANDIDATE
    assert lybrown["architectures"] == ["mos6502"]
    assert lybrown["runner"] == "external_candidate"
    assert "MOS 8501" in lybrown["commentary_boundary"]


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


def test_candidate_matrix_preserves_non_executable_architecture_scoped_admission() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)

    assert {candidate["candidate_id"] for candidate in matrix["candidates"]} >= {
        "py8dis-mos6502-v1",
        "z80dismblr-z80-v1",
        "skoolkit-z80-v1",
        "oxore-m68k-disasm-v1",
        "capstone-m68k-x86-v1",
        "lybrown-dis-mos6502-v1",
        "redasm-i8086-v1",
    }
    assert all(candidate["execution_eligible"] is False for candidate in matrix["candidates"])
    assert {architecture for candidate in matrix["candidates"] for architecture in candidate["architectures"]} >= {
        "z80", "mos6502", "m68000", "i8086"
    }


def test_health_checked_m68k_candidate_remains_non_executable_pending_platform_evidence() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)
    oxore = next(candidate for candidate in matrix["candidates"] if candidate["candidate_id"] == "oxore-m68k-disasm-v1")

    assert oxore["admission_state"] == "health_checked"
    assert oxore["architectures"] == ["m68000"]
    assert oxore["source"]["revision"] == "bb6d83981bbb53de352061b793c8215e45af895a"
    assert oxore["execution_eligible"] is False
    assert any("Amiga or Atari ST origin" in blocker for blocker in oxore["blockers"])
    assert "controlled" in oxore["non_claim"]


def test_health_checked_skoolkit_candidate_remains_non_executable_pending_z80_memory_evidence() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)
    skoolkit = next(candidate for candidate in matrix["candidates"] if candidate["candidate_id"] == "skoolkit-z80-v1")

    assert skoolkit["admission_state"] == "health_checked"
    assert skoolkit["architectures"] == ["z80"]
    assert skoolkit["execution_eligible"] is False
    assert "GPL-3.0" in skoolkit["source"]["license_status"]
    assert any("memory map" in blocker for blocker in skoolkit["blockers"])


def test_candidate_matrix_rejects_an_unconfigured_executable_candidate() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)
    matrix["candidates"][0]["execution_eligible"] = True

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="must not be execution eligible"):
        analyzer_adapters.validate_candidate_matrix(matrix)


def test_i8086_candidate_records_user_authorized_health_recipe_without_becoming_executable() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)
    candidate = next(candidate for candidate in matrix["candidates"] if candidate["candidate_id"] == "jhelland-8086-disassembler-v1")

    assert candidate["admission_state"] == "health_checked"
    assert candidate["execution_eligible"] is False
    assert "confirmed by the user" in candidate["source"]["license_status"]
    assert not any("license" in blocker for blocker in candidate["blockers"])
    assert any("health recipe" in blocker for blocker in candidate["blockers"])


def test_dazzlestar_candidate_records_empty_license_and_toolchain_blocks_without_becoming_executable() -> None:
    matrix = analyzer_adapters.load_candidate_matrix(CANDIDATE_MATRIX_PATH)
    candidate = next(candidate for candidate in matrix["candidates"] if candidate["candidate_id"] == "dazzlestar-z80-v1")

    assert candidate["admission_state"] == "blocked_by_license_or_build"
    assert candidate["execution_eligible"] is False
    assert "empty" in candidate["source"]["license_status"]
    assert any("zmac" in blocker for blocker in candidate["blockers"])


def test_dos_i8086_admission_contract_preserves_fail_closed_com_and_mz_evidence() -> None:
    contract = analyzer_adapters.load_dos_i8086_load_model_admission(DOS_I8086_ADMISSION_PATH)

    assert contract["states"][-1] == "admissible_for_candidate_comparison"
    assert "psp_relationship" in contract["com_required_evidence"]
    assert "relocation_table_bounds" in contract["mz_required_evidence"]
    assert "raw_base_zero_only" in contract["fail_closed_conditions"]


def test_dos_i8086_admission_contract_rejects_missing_required_fail_closed_condition() -> None:
    contract = analyzer_adapters.load_dos_i8086_load_model_admission(DOS_I8086_ADMISSION_PATH)
    contract["fail_closed_conditions"].remove("unknown_container")

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="contract field differs: fail_closed_conditions"):
        analyzer_adapters.validate_dos_i8086_load_model_admission(contract)


def test_ghidra_headless_health_covers_each_configured_architecture_without_authorizing_retained_inputs() -> None:
    health = analyzer_adapters.load_ghidra_headless_health(GHIDRA_HEALTH_PATH, _toolchain())

    assert health["tool"]["version"] == "12.1.3"
    assert {architecture for profile in health["processor_profiles"] for architecture in profile["architectures"]} == set(_toolchain()["architectures"])
    assert all(profile["repeat_exports_byte_identical"] is True for profile in health["processor_profiles"])
    assert all(host["status"] != "health_checked" for host in health["host_profiles"] if host["platform"].startswith("Windows"))
    assert "not recovered source" in health["non_claim"]


def test_ghidra_headless_health_rejects_a_processor_language_that_drifted_from_the_toolchain() -> None:
    health = analyzer_adapters.load_ghidra_headless_health(GHIDRA_HEALTH_PATH, _toolchain())
    health["processor_profiles"][0]["ghidra_language"] = "wrong:LE:16:default"

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="language does not match toolchain"):
        analyzer_adapters.validate_ghidra_headless_health(health, _toolchain())


def test_ghidra_headless_health_rejects_a_fixture_hash_mismatch() -> None:
    health = analyzer_adapters.load_ghidra_headless_health(GHIDRA_HEALTH_PATH, _toolchain())
    health["processor_profiles"][0]["fixture_sha256"] = "0" * 64

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="fixture SHA-256"):
        analyzer_adapters.validate_ghidra_headless_health(health, _toolchain())


def test_ghidra_headless_health_rejects_uncontrolled_fixture_name_or_repeat_count() -> None:
    health = analyzer_adapters.load_ghidra_headless_health(GHIDRA_HEALTH_PATH, _toolchain())
    health["processor_profiles"][0]["fixture_filename"] = "../retained.bin"

    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="controlled relative fixture name"):
        analyzer_adapters.validate_ghidra_headless_health(health, _toolchain())

    health = analyzer_adapters.load_ghidra_headless_health(GHIDRA_HEALTH_PATH, _toolchain())
    health["processor_profiles"][0]["repeat_run_count"] = 1
    with pytest.raises(analyzer_adapters.AdapterCatalogError, match="exactly two repeated runs"):
        analyzer_adapters.validate_ghidra_headless_health(health, _toolchain())

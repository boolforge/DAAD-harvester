"""Regression coverage for the lossless profile-scoped DDB intermediate representation."""

from __future__ import annotations

import pytest

from daad_harvester.ddb_grammar import DDBProfile
from daad_harvester.ddb_ir import (
    CondActStreamNode,
    DDBProfileMismatch,
    OpaqueNode,
    ProcessEntryNode,
    ProcessPointerTableNode,
    WrapperNode,
    decompile_ddb,
    recompile_ddb,
)
from tests.ddb_fixtures import make_legacy_ddb, wrap_commodore


def legacy_profile(
    platform: str = "dos", *, major_version: int = 2, wrapper: str = "raw"
) -> DDBProfile:
    machine_id = {"dos": 0, "c64": 2}[platform]
    base_address = 0x3880 if platform == "c64" else 0
    return DDBProfile(
        layout="legacy",
        major_version=major_version,
        machine_id=machine_id,
        platform=platform,
        endianness="little",
        base_address=base_address,
        wrapper=wrapper,
    )


def test_legacy_ddb_decompiles_to_a_complete_non_overlapping_byte_ledger() -> None:
    original = make_legacy_ddb("dos")
    ir = decompile_ddb(original, legacy_profile())

    ir.validate_byte_ledger()
    assert ir.source_size == len(original)
    assert ir.nodes[0].byte_start == 0
    assert ir.nodes[-1].byte_end == len(original)
    assert any(isinstance(node, ProcessEntryNode) for node in ir.nodes)
    assert any(isinstance(node, ProcessPointerTableNode) for node in ir.nodes)
    assert any(isinstance(node, CondActStreamNode) for node in ir.nodes)
    assert any(isinstance(node, OpaqueNode) for node in ir.nodes)
    assert ir.is_semantically_complete is False
    assert all(
        node.structure_hint != "unimplemented_section_or_alignment"
        for node in ir.nodes
        if isinstance(node, OpaqueNode)
    )
    assert any(
        node.structure_hint == "legacy_vocabulary_payload_pending_grammar"
        for node in ir.nodes
        if isinstance(node, OpaqueNode)
    )
    assert all(
        node.structure_hint != "process_pointer_table_structure_pending"
        for node in ir.nodes
        if isinstance(node, OpaqueNode)
    )
    assert recompile_ddb(ir, legacy_profile()) == original


def test_opaque_condact_ranges_remain_visible_inside_a_lossless_stream() -> None:
    original = bytearray(make_legacy_ddb("dos", major=1))
    original[64:66] = b"\x6d\xff"

    ir = decompile_ddb(bytes(original), legacy_profile(major_version=1))

    assert (64, 65, "unknown_opcode_6d") in ir.opaque_ranges()
    assert recompile_ddb(ir, legacy_profile(major_version=1)) == bytes(original)


def test_profile_and_measured_wrapper_must_agree_before_decompilation() -> None:
    original = make_legacy_ddb("dos")
    with pytest.raises(DDBProfileMismatch, match="platform"):
        decompile_ddb(original, legacy_profile(platform="c64"))


def test_commodore_wrapper_is_owned_separately_and_round_trips() -> None:
    original = wrap_commodore(make_legacy_ddb("c64"), "c64")
    selected_profile = legacy_profile("c64", wrapper="commodore-prg")
    # This deterministic fixture models the compact file-relative historical
    # header; its PRG load address is a wrapper fact, not its DDB pointer base.
    selected_profile = DDBProfile(
        layout=selected_profile.layout,
        major_version=selected_profile.major_version,
        machine_id=selected_profile.machine_id,
        platform=selected_profile.platform,
        endianness=selected_profile.endianness,
        base_address=0,
        wrapper=selected_profile.wrapper,
    )

    ir = decompile_ddb(original, selected_profile)

    assert isinstance(ir.nodes[0], WrapperNode)
    assert ir.nodes[0].raw_bytes == original[:2]
    assert recompile_ddb(ir, selected_profile) == original


def test_recompile_rejects_a_different_profile_even_when_bytes_would_match() -> None:
    ir = decompile_ddb(make_legacy_ddb("dos"), legacy_profile())
    with pytest.raises(DDBProfileMismatch, match="differs"):
        recompile_ddb(ir, legacy_profile(major_version=1))

"""Retained-artifact byte-identical DDB decompile/recompile regressions."""

from __future__ import annotations

from hashlib import sha256
from pathlib import Path

import pytest

from daad_harvester.ddb_grammar import DDBProfile
from daad_harvester.ddb_ir import (
    AlignmentPaddingNode,
    OffsetTableNode,
    AlignmentPaddingNode,
    ConnectionListNode,
    ControlSectionNode,
    ExternalVectorTableNode,
    HeaderExtensionNode,
    ObjectTableNode,
    ProcessCodeAlignmentNode,
    ProcessEntryNode,
    ProcessSectionMarkerNode,
    TokenNode,
    TextNode,
    VocabularyNode,
    decompile_ddb,
    recompile_ddb,
)
from daad_harvester.unpack import compute_hashes


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
BLANK_DDB = (
    REPOSITORY_ROOT
    / "preservation_corpus/extracted/depth1_98397784_BLANK.DDB"
)
BLANK_DDB_SHA256 = "8f45acdfe4813996cb3895dd66d2d9e6f0685acfc94c1ec35ed3eeb626cdad84"
BLANK_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=2,
    machine_id=0,
    platform="dos",
    endianness="little",
    base_address=0,
    wrapper="raw",
)
SPANISH_DOS_V2_DDB = REPOSITORY_ROOT / "preservation_corpus/extracted/depth1_f14c8b04_SPANISH.DDB"
SPANISH_DOS_V2_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=2,
    machine_id=0,
    platform="dos",
    endianness="little",
    base_address=0,
    wrapper="raw",
)
C64_V1_DDB = (
    REPOSITORY_ROOT
    / "preservation_corpus/derived/commodore_loader/jabato_ass_part1_post_mirar.ddb"
)
C64_V1_DDB_SHA256 = "7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6"
C64_V1_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=1,
    machine_id=2,
    platform="c64",
    endianness="little",
    base_address=0x3880,
    wrapper="raw",
)
ZX_V2_DDB = (
    REPOSITORY_ROOT
    / "preservation_corpus/extracted/depth3_25a67864_CODE__embedded_002400.ddb"
)
ZX_V2_DDB_SHA256 = "7d7b26973b9c36a6dca4e804e2c4dbfccda663985f6052080ac85151bb1386ab"
ZX_V2_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=2,
    machine_id=1,
    platform="zx",
    endianness="little",
    base_address=0x8400,
    wrapper="raw",
)
AMIGA_V2_DDB = REPOSITORY_ROOT / "preservation_corpus/extracted/depth2_92aef478_PART1.DDB"
AMIGA_V2_DDB_SHA256 = "13389079e2a3e06e7546e082e5e3d1e5d7658333efcac20a0992a2dc9396e133"
AMIGA_V2_DDB_PROFILE = DDBProfile(
    layout="legacy",
    major_version=2,
    machine_id=6,
    platform="amiga",
    endianness="big",
    base_address=0,
    wrapper="raw",
)


def test_retained_legacy_v2_dos_blank_ddb_round_trips_byte_identically() -> None:
    original = BLANK_DDB.read_bytes()

    assert len(original) == 2652
    assert sha256(original).hexdigest() == BLANK_DDB_SHA256
    original_hashes = compute_hashes(original)
    assert len(original_hashes) == 17
    assert all(original_hashes.values())
    ir = decompile_ddb(original, BLANK_DDB_PROFILE)
    recompiled = recompile_ddb(ir, BLANK_DDB_PROFILE)

    assert ir.source_sha256 == BLANK_DDB_SHA256
    assert {
        node.table_kind for node in ir.nodes if isinstance(node, OffsetTableNode)
    } == {
        "object_names_table",
        "location_descriptions_table",
        "messages_table",
        "system_messages_table",
        "connections_table",
    }
    assert {
        reference.split("[")[0]
        for node in ir.nodes
        if isinstance(node, TextNode)
        for reference in node.table_references
    } == {
        "object_names_table",
        "location_descriptions_table",
        "messages_table",
        "system_messages_table",
    }
    vocabulary_nodes = [node for node in ir.nodes if isinstance(node, VocabularyNode)]
    assert vocabulary_nodes[-1].is_terminator is True
    assert vocabulary_nodes[-1].raw_bytes == b"\x00"
    assert all(node.word_index is not None for node in vocabulary_nodes[:-1])
    header_extensions = [node for node in ir.nodes if isinstance(node, HeaderExtensionNode)]
    assert not header_extensions
    external_vector_tables = [
        node for node in ir.nodes if isinstance(node, ExternalVectorTableNode)
    ]
    assert len(external_vector_tables) == 1
    assert external_vector_tables[0].byte_start == 0x22
    assert external_vector_tables[0].byte_end == 0x3C
    assert external_vector_tables[0].stored_vectors == (0,) * 13
    assert external_vector_tables[0].primary_external_data_pointer == 0
    assert external_vector_tables[0].external_psg_table_pointer == 0
    mutated = bytearray(original)
    mutated[0x24] = 0x01
    mutated_ir = decompile_ddb(bytes(mutated), BLANK_DDB_PROFILE)
    mutated_vectors = [
        node for node in mutated_ir.nodes if isinstance(node, ExternalVectorTableNode)
    ]
    assert mutated_vectors[0].stored_vectors[1] == 1
    assert recompile_ddb(mutated_ir, BLANK_DDB_PROFILE) == bytes(mutated)
    token_nodes = [node for node in ir.nodes if isinstance(node, TokenNode)]
    assert token_nodes[0].node_kind == "block_marker"
    assert token_nodes[-1].token_index == 0xFF
    assert len([node for node in token_nodes if node.node_kind == "token_record"]) == 128
    assert {
        node.table_kind for node in ir.nodes if isinstance(node, ObjectTableNode)
    } == {
        "object_locations_table",
        "object_words_table",
        "object_attributes_table",
        "extended_object_attributes_table",
    }
    connection_nodes = [node for node in ir.nodes if isinstance(node, ConnectionListNode)]
    assert connection_nodes
    assert all(node.raw_bytes.endswith(b"\xff") for node in connection_nodes)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.following_table_kind)
        for node in ir.nodes
        if isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "connections_table"
    ] == [(0x08C3, 0x08C4, b"\x00", "connections_table")]
    mutated = bytearray(original)
    mutated[0x08C3] = 0x01
    mutated_ir = decompile_ddb(bytes(mutated), BLANK_DDB_PROFILE)
    assert not any(
        isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "connections_table"
        for node in mutated_ir.nodes
    )
    assert recompile_ddb(mutated_ir, BLANK_DDB_PROFILE) == bytes(mutated)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.following_table_kind)
        for node in ir.nodes
        if isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "extended_object_attributes_table"
    ] == [(0x08CD, 0x08CE, b"\x00", "extended_object_attributes_table")]
    mutated = bytearray(original)
    mutated[0x08CD] = 0x01
    mutated_ir = decompile_ddb(bytes(mutated), BLANK_DDB_PROFILE)
    assert not any(
        isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "extended_object_attributes_table"
        for node in mutated_ir.nodes
    )
    assert recompile_ddb(mutated_ir, BLANK_DDB_PROFILE) == bytes(mutated)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.marker_value, node.first_stream_offset)
        for node in ir.nodes
        if isinstance(node, ProcessSectionMarkerNode)
    ] == [(0x08D1, 0x08D2, b"\xff", 0xFF, 0x08D2)]
    mutated = bytearray(original)
    mutated[0x08D1] = 0xFE
    mutated_ir = decompile_ddb(bytes(mutated), BLANK_DDB_PROFILE)
    assert not any(isinstance(node, ProcessSectionMarkerNode) for node in mutated_ir.nodes)
    assert recompile_ddb(mutated_ir, BLANK_DDB_PROFILE) == bytes(mutated)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.alignment)
        for node in ir.nodes
        if isinstance(node, ProcessCodeAlignmentNode)
    ] == [
        (0x08F9, 0x08FA, b"\x00", 2),
        (0x0945, 0x0946, b"\x00", 2),
        (0x0971, 0x0972, b"\x00", 2),
        (0x0981, 0x0982, b"\x00", 2),
    ]
    process_terminators = [
        node for node in ir.nodes if isinstance(node, ProcessEntryNode) and node.is_terminator
    ]
    assert process_terminators
    assert all(node.raw_bytes == b"\x00\x00" for node in process_terminators)
    mutated = bytearray(original)
    mutated[0x0987] = 0x01
    with pytest.raises(ValueError, match="two-byte zero terminator"):
        decompile_ddb(bytes(mutated), BLANK_DDB_PROFILE)
    assert len(recompiled) == len(original)
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes


def test_retained_legacy_v2_spanish_dos_object_attribute_padding_is_bounded() -> None:
    original = SPANISH_DOS_V2_DDB.read_bytes()
    ir = decompile_ddb(original, SPANISH_DOS_V2_DDB_PROFILE)

    external_vector_tables = [
        node for node in ir.nodes if isinstance(node, ExternalVectorTableNode)
    ]
    assert [
        (node.byte_start, node.byte_end, node.stored_vectors)
        for node in external_vector_tables
    ] == [(0x22, 0x3C, (0,) * 13)]
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.following_table_kind)
        for node in ir.nodes
        if isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "extended_object_attributes_table"
    ] == [(0x078B, 0x078C, b"\x00", "extended_object_attributes_table")]
    mutated = bytearray(original)
    mutated[0x078B] = 0x01
    mutated_ir = decompile_ddb(bytes(mutated), SPANISH_DOS_V2_DDB_PROFILE)
    assert not any(
        isinstance(node, AlignmentPaddingNode)
        and node.following_table_kind == "extended_object_attributes_table"
        for node in mutated_ir.nodes
    )
    assert recompile_ddb(mutated_ir, SPANISH_DOS_V2_DDB_PROFILE) == bytes(mutated)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.marker_value, node.first_stream_offset)
        for node in ir.nodes
        if isinstance(node, ProcessSectionMarkerNode)
    ] == [(0x078F, 0x0790, b"\xff", 0xFF, 0x0790)]
    mutated = bytearray(original)
    mutated[0x078F] = 0xFE
    mutated_ir = decompile_ddb(bytes(mutated), SPANISH_DOS_V2_DDB_PROFILE)
    assert not any(isinstance(node, ProcessSectionMarkerNode) for node in mutated_ir.nodes)
    assert recompile_ddb(mutated_ir, SPANISH_DOS_V2_DDB_PROFILE) == bytes(mutated)
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes, node.alignment)
        for node in ir.nodes
        if isinstance(node, ProcessCodeAlignmentNode)
    ] == [
        (0x07B7, 0x07B8, b"\x00", 2),
        (0x0803, 0x0804, b"\x00", 2),
        (0x082F, 0x0830, b"\x00", 2),
        (0x083F, 0x0840, b"\x00", 2),
        (0x08F5, 0x08F6, b"\x00", 2),
    ]
    process_terminators = [
        node for node in ir.nodes if isinstance(node, ProcessEntryNode) and node.is_terminator
    ]
    assert process_terminators
    assert all(node.raw_bytes == b"\x00\x00" for node in process_terminators)
    mutated = bytearray(original)
    mutated[0x0845] = 0x01
    with pytest.raises(ValueError, match="two-byte zero terminator"):
        decompile_ddb(bytes(mutated), SPANISH_DOS_V2_DDB_PROFILE)


def test_retained_legacy_v1_c64_target_memory_ddb_round_trips_byte_identically() -> None:
    original = C64_V1_DDB.read_bytes()

    assert len(original) == 24899
    assert sha256(original).hexdigest() == C64_V1_DDB_SHA256
    original_hashes = compute_hashes(original)
    ir = decompile_ddb(original, C64_V1_DDB_PROFILE)
    recompiled = recompile_ddb(ir, C64_V1_DDB_PROFILE)

    assert ir.profile.base_address == 0x3880
    assert len(original_hashes) == 17
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes


def test_retained_legacy_v2_zx_target_memory_ddb_round_trips_byte_identically() -> None:
    original = ZX_V2_DDB.read_bytes()

    assert len(original) == 22194
    assert sha256(original).hexdigest() == ZX_V2_DDB_SHA256
    original_hashes = compute_hashes(original)
    ir = decompile_ddb(original, ZX_V2_DDB_PROFILE)
    recompiled = recompile_ddb(ir, ZX_V2_DDB_PROFILE)

    assert ir.profile.base_address == 0x8400
    assert len(original_hashes) == 17
    control_sections = [node for node in ir.nodes if isinstance(node, ControlSectionNode)]
    assert [
        (node.byte_start, node.byte_end, node.raw_bytes[:8], node.payload_kind)
        for node in control_sections
    ] == [(0x3C, 0x7A, b"\x00\x00\x00\x00\x00\x00\x00\x00", "documented_ctl_payload")]
    mutated = bytearray(original)
    mutated[0x44] ^= 0x01
    mutated_ir = decompile_ddb(bytes(mutated), ZX_V2_DDB_PROFILE)
    assert any(
        isinstance(node, ControlSectionNode) and node.raw_bytes[8] == original[0x44] ^ 0x01
        for node in mutated_ir.nodes
    )
    assert recompile_ddb(mutated_ir, ZX_V2_DDB_PROFILE) == bytes(mutated)
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes


def test_retained_legacy_v2_amiga_big_endian_ddb_round_trips_byte_identically() -> None:
    original = AMIGA_V2_DDB.read_bytes()

    assert len(original) == 2872
    assert sha256(original).hexdigest() == AMIGA_V2_DDB_SHA256
    original_hashes = compute_hashes(original)
    ir = decompile_ddb(original, AMIGA_V2_DDB_PROFILE)
    recompiled = recompile_ddb(ir, AMIGA_V2_DDB_PROFILE)

    assert len(original_hashes) == 17
    assert [
        (
            node.byte_start,
            node.byte_end,
            node.raw_bytes,
            node.alignment,
            node.following_table_kind,
        )
        for node in ir.nodes
        if isinstance(node, AlignmentPaddingNode)
    ] == [
        (0x080B, 0x080C, b"\x00", 2, "system_messages_table"),
        (0x088B, 0x088C, b"\x00", 2, "messages_table"),
        (0x089D, 0x089E, b"\x00", 2, "object_names_table"),
        (0x099F, 0x09A0, b"\x00", 2, "location_descriptions_table"),
        (0x09AD, 0x09AE, b"\x00", 2, "connections_table"),
    ]
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes

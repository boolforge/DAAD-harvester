"""Retained-artifact byte-identical DDB decompile/recompile regressions."""

from __future__ import annotations

from hashlib import sha256
from pathlib import Path

from daad_harvester.ddb_grammar import DDBProfile
from daad_harvester.ddb_ir import (
    OffsetTableNode,
    ObjectTableNode,
    ConnectionListNode,
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
    assert {
        node.table_kind for node in ir.nodes if isinstance(node, ObjectTableNode)
    } == {
        "object_locations_table",
        "object_attributes_table",
        "extended_object_attributes_table",
    }
    connection_nodes = [node for node in ir.nodes if isinstance(node, ConnectionListNode)]
    assert connection_nodes
    assert all(node.raw_bytes.endswith(b"\xff") for node in connection_nodes)
    assert len(recompiled) == len(original)
    assert recompiled == original
    assert compute_hashes(recompiled) == original_hashes


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

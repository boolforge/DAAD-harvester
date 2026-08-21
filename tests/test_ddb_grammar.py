"""Regression coverage for the profile-scoped native CondAct grammar."""

from __future__ import annotations

import pytest

from daad_harvester.ddb_grammar import (
    DDBProfile,
    OpaqueCondActNode,
    PAWS_OPCODE_TABLE,
    STREAM_TERMINATOR,
    StreamTerminatorNode,
    UnsupportedDDBGrammarProfile,
    V1_OPCODE_TABLE,
    V2_OPCODE_TABLE,
    decode_condact_stream,
    encode_condact_stream,
    opcode_table_for,
)


def profile(*, major_version: int = 2, dialect: str | None = None) -> DDBProfile:
    """Return a compact profile whose fields match the public grammar boundary."""

    return DDBProfile(
        layout="legacy",
        major_version=major_version,
        machine_id=0,
        platform="dos",
        endianness="little",
        base_address=0,
        wrapper="raw",
        extension_dialect=dialect,
    )


def test_v1_table_covers_every_defined_adp_opcode_and_rejects_remaining_slots() -> None:
    assert all(specification is not None for specification in V1_OPCODE_TABLE[:0x6D])
    assert all(specification is None for specification in V1_OPCODE_TABLE[0x6D:])
    assert V1_OPCODE_TABLE[0x13].name == "DESC"
    assert V1_OPCODE_TABLE[0x13].parameter_count == 0
    assert V1_OPCODE_TABLE[0x24].name == "TIMEOUT"
    assert V1_OPCODE_TABLE[0x65].name == "RESET"


def test_v2_table_covers_all_7_bit_opcodes_with_source_defined_arities() -> None:
    assert len(V2_OPCODE_TABLE) == 0x80
    assert all(specification is not None for specification in V2_OPCODE_TABLE)
    assert V2_OPCODE_TABLE[0x13].name == "DESC"
    assert V2_OPCODE_TABLE[0x13].parameter_count == 1
    assert V2_OPCODE_TABLE[0x24].name == "SYNONYM"
    assert V2_OPCODE_TABLE[0x7A].name == "INDIR"
    assert V2_OPCODE_TABLE[0x7F].name == "RESET"


def test_paws_table_preserves_its_own_defined_opcode_boundary_and_differences() -> None:
    assert all(specification is not None for specification in PAWS_OPCODE_TABLE[:0x6C])
    assert all(specification is None for specification in PAWS_OPCODE_TABLE[0x6C:])
    assert PAWS_OPCODE_TABLE[0x12].name == "INVEN"
    assert PAWS_OPCODE_TABLE[0x1C].name == "SCORE"
    assert PAWS_OPCODE_TABLE[0x4E].name == "CHARSET"
    assert PAWS_OPCODE_TABLE[0x52].name == "LINE"


@pytest.mark.parametrize(
    ("selected_profile", "table"),
    (
        (profile(major_version=1), V1_OPCODE_TABLE),
        (profile(major_version=2), V2_OPCODE_TABLE),
        (profile(major_version=1, dialect="paws"), PAWS_OPCODE_TABLE),
    ),
)
def test_every_source_defined_opcode_decodes_and_reencodes_at_its_declared_arity(
    selected_profile: DDBProfile,
    table: tuple[object | None, ...],
) -> None:
    for specification in table:
        if specification is None:
            continue
        parameters = tuple(range(1, specification.parameter_count + 1))
        original = bytes((specification.opcode, *parameters, STREAM_TERMINATOR))
        nodes = decode_condact_stream(original, 0, selected_profile)

        decoded = nodes[0]
        assert decoded.name == specification.name
        assert decoded.parameters == parameters
        assert encode_condact_stream(nodes, selected_profile) == original


def test_first_parameter_indirection_round_trips_without_losing_raw_opcode_bit() -> None:
    original = bytes((0x80 | 0x31, 0x12, 0x34, STREAM_TERMINATOR))
    nodes = decode_condact_stream(original, 0, profile())

    assert nodes[0].name == "PLUS"
    assert nodes[0].first_parameter_indirect is True
    assert nodes[0].parameters == (0x12, 0x34)
    assert isinstance(nodes[-1], StreamTerminatorNode)
    assert encode_condact_stream(nodes, profile()) == original


def test_indir_prefix_is_lowered_to_second_parameter_indirection_and_round_trips() -> None:
    # Public DRC evidence serializes LET 100 @200 as INDIR 200 / LET 100 0.
    original = bytes((0x7A, 0xC8, 0x33, 0x64, 0x00, STREAM_TERMINATOR))
    nodes = decode_condact_stream(original, 0, profile())

    assert len(nodes) == 2
    lowered = nodes[0]
    assert lowered.name == "LET"
    assert lowered.byte_start == 0
    assert lowered.byte_end == 5
    assert lowered.parameters == (0x64, 0x00)
    assert lowered.second_parameter_indirect is True
    assert lowered.second_indirection_parameter == 0xC8
    assert encode_condact_stream(nodes, profile()) == original


def test_unknown_and_truncated_bytes_remain_explicit_lossless_opaque_nodes() -> None:
    original = bytes((0x6D, 0x65))
    nodes = decode_condact_stream(original, 0, profile(major_version=1))

    assert [type(node) for node in nodes] == [OpaqueCondActNode, OpaqueCondActNode]
    assert nodes[0].raw_bytes == b"\x6d"
    assert nodes[0].reason == "unknown_opcode_6d"
    assert nodes[1].raw_bytes == b"\x65"
    assert nodes[1].reason == "truncated_parameters_reset"
    assert encode_condact_stream(nodes, profile(major_version=1)) == original


def test_unsupported_profile_never_falls_back_to_another_opcode_table() -> None:
    with pytest.raises(UnsupportedDDBGrammarProfile, match="v3"):
        opcode_table_for(profile(major_version=3))

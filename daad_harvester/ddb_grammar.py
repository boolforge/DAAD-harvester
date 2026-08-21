"""Profile-scoped, lossless DAAD CondAct stream grammar.

Design boundary: opcode names and operand arities are transcribed from the
pinned ADP ``include/ddb_condact_defs.h`` source.  The grammar is deliberately
profile-scoped: V1, V2, and PAWS use independently selected tables, while
unrepresented versions and unknown opcodes remain explicit rather than being
silently interpreted.  Every decoded node retains an absolute source range and
every opaque byte sequence round-trips unchanged.
"""

from __future__ import annotations

from dataclasses import dataclass, replace
from typing import Final, Literal, TypeAlias


PROFILE_DIALECTS: Final = frozenset({"v1", "v2", "paws"})
STREAM_TERMINATOR: Final = 0xFF
INDIR_NAME: Final = "INDIR"


@dataclass(frozen=True, slots=True)
class DDBProfile:
    """The execution-relevant DDB fields used to select a CondAct grammar."""

    layout: str
    major_version: int
    machine_id: int
    platform: str
    endianness: Literal["little", "big"]
    base_address: int
    wrapper: str = "raw"
    extension_dialect: str | None = None

    @property
    def grammar_dialect(self) -> str:
        """Return the explicit grammar dialect or raise for unimplemented ones."""

        if self.extension_dialect is not None:
            return self.extension_dialect.casefold()
        if self.major_version == 1:
            return "v1"
        if self.major_version == 2:
            return "v2"
        return f"v{self.major_version}"


@dataclass(frozen=True, slots=True)
class OpcodeSpec:
    """One profile-specific opcode name and its exact byte parameter arity."""

    opcode: int
    name: str
    parameter_count: int


@dataclass(frozen=True, slots=True)
class CondActNode:
    """A recognized CondAct, optionally lowered from a preceding INDIR prefix."""

    byte_start: int
    byte_end: int
    opcode: int
    name: str
    parameters: tuple[int, ...]
    first_parameter_indirect: bool = False
    second_parameter_indirect: bool = False
    second_indirection_parameter: int | None = None


@dataclass(frozen=True, slots=True)
class StreamTerminatorNode:
    """DAAD's one-byte end-of-entry marker, retained as an owned source byte."""

    byte_start: int
    byte_end: int
    raw_byte: int = STREAM_TERMINATOR


@dataclass(frozen=True, slots=True)
class OpaqueCondActNode:
    """A lossless byte range with an unresolved opcode or incomplete operand rule."""

    byte_start: int
    byte_end: int
    raw_bytes: bytes
    reason: str


CondActStreamItem: TypeAlias = CondActNode | StreamTerminatorNode | OpaqueCondActNode


class UnsupportedDDBGrammarProfile(ValueError):
    """Raised when a profile does not yet have a source-backed grammar table."""


def _make_table(specification: str) -> tuple[OpcodeSpec | None, ...]:
    """Build a fixed 128-opcode table from an ordered ADP source transcription."""

    entries: list[OpcodeSpec | None] = []
    for opcode, token in enumerate(specification.split()):
        name, parameter_count = token.rsplit("/", 1)
        entries.append(
            None
            if name == "INVALID"
            else OpcodeSpec(opcode, name, int(parameter_count))
        )
    if len(entries) > 0x80:
        raise ValueError("CondAct table exceeds the 7-bit opcode space")
    entries.extend([None] * (0x80 - len(entries)))
    return tuple(entries)


# Exact ordered transcription of ADP DDB_VERSION1_CONDACTS, omitting only its
# repeated terminal INVALID entries because _make_table supplies None for every
# undefined 7-bit opcode slot.
V1_OPCODE_TABLE: Final = _make_table(
    """
    AT/1 NOTAT/1 ATGT/1 ATLT/1 PRESENT/1 ABSENT/1 WORN/1 NOTWORN/1
    CARRIED/1 NOTCARR/1 CHANCE/1 ZERO/1 NOTZERO/1 EQ/2 GT/2 LT/2
    ADJECT1/1 ADVERB/1 SFX/2 DESC/0 QUIT/0 END/0 DONE/0 OK/0
    ANYKEY/0 SAVE/0 LOAD/0 TURNS/0 DISPLAY/1 CLS/0 DROPALL/0 AUTOG/0
    AUTOD/0 AUTOW/0 AUTOR/0 PAUSE/1 TIMEOUT/0 GOTO/1 MESSAGE/1 REMOVE/1
    GET/1 DROP/1 WEAR/1 DESTROY/1 CREATE/1 SWAP/2 PLACE/2 SET/1 CLEAR/1
    PLUS/2 MINUS/2 LET/2 NEWLINE/0 PRINT/1 SYSMESS/1 ISAT/2 COPYOF/2
    COPYOO/2 COPYFO/2 COPYFF/2 LISTOBJ/0 EXTERN/2 RAMSAVE/0 RAMLOAD/1
    BEEP/2 PAPER/1 INK/1 BORDER/1 PREP/1 NOUN2/1 ADJECT2/1 ADD/2 SUB/2
    PARSE/0 LISTAT/1 PROCESS/1 SAME/2 MES/1 WINDOW/1 NOTEQ/2 NOTSAME/2
    MODE/1 WINAT/2 TIME/2 PICTURE/1 DOALL/1 PROMPT/1 GRAPHIC/2 ISNOTAT/2
    WEIGH/2 PUTIN/2 TAKEOUT/2 NEWTEXT/0 ABILITY/2 WEIGHT/1 RANDOM/1 INPUT/2
    SAVEAT/0 BACKAT/0 PRINTAT/2 WHATO/0 RESET/1 PUTO/1 NOTDONE/0 AUTOP/1
    AUTOT/1 MOVE/1 WINSIZE/2 REDO/0
    """
)


# Exact ordered transcription of ADP DDB_VERSION2_CONDACTS.
V2_OPCODE_TABLE: Final = _make_table(
    """
    AT/1 NOTAT/1 ATGT/1 ATLT/1 PRESENT/1 ABSENT/1 WORN/1 NOTWORN/1
    CARRIED/1 NOTCARR/1 CHANCE/1 ZERO/1 NOTZERO/1 EQ/2 GT/2 LT/2
    ADJECT1/1 ADVERB/1 SFX/2 DESC/1 QUIT/0 END/0 DONE/0 OK/0
    ANYKEY/0 SAVE/1 LOAD/1 DPRINT/1 DISPLAY/1 CLS/0 DROPALL/0 AUTOG/0
    AUTOD/0 AUTOW/0 AUTOR/0 PAUSE/1 SYNONYM/2 GOTO/1 MESSAGE/1 REMOVE/1
    GET/1 DROP/1 WEAR/1 DESTROY/1 CREATE/1 SWAP/2 PLACE/2 SET/1 CLEAR/1
    PLUS/2 MINUS/2 LET/2 NEWLINE/0 PRINT/1 SYSMESS/1 ISAT/2 SETCO/1
    SPACE/0 HASAT/1 HASNAT/1 LISTOBJ/0 EXTERN/2 RAMSAVE/0 RAMLOAD/1
    BEEP/2 PAPER/1 INK/1 BORDER/1 PREP/1 NOUN2/1 ADJECT2/1 ADD/2 SUB/2
    PARSE/1 LISTAT/1 PROCESS/1 SAME/2 MES/1 WINDOW/1 NOTEQ/2 NOTSAME/2
    MODE/1 WINAT/2 TIME/2 PICTURE/1 DOALL/1 MOUSE/2 GFX/2 ISNOTAT/2
    WEIGH/2 PUTIN/2 TAKEOUT/2 NEWTEXT/0 ABILITY/2 WEIGHT/1 RANDOM/1 INPUT/2
    SAVEAT/0 BACKAT/0 PRINTAT/2 WHATO/0 CALL/1 PUTO/1 NOTDONE/0 AUTOP/1
    AUTOT/1 MOVE/1 WINSIZE/2 REDO/0 CENTRE/0 EXIT/1 INKEY/0 BIGGER/2
    SMALLER/2 ISDONE/0 ISNDONE/0 SKIP/1 RESTART/0 TAB/1 COPYOF/2 XMESSAGE/2
    COPYOO/2 INDIR/1 COPYFO/2 SETAT/2 COPYFF/2 COPYBF/2 RESET/0
    """
)


# Exact ordered transcription of ADP DDB_PAWS_CONDACTS. The public source
# defines 0x00 through 0x6B; the remaining slots intentionally stay None.
PAWS_OPCODE_TABLE: Final = _make_table(
    """
    AT/1 NOTAT/1 ATGT/1 ATLT/1 PRESENT/1 ABSENT/1 WORN/1 NOTWORN/1
    CARRIED/1 NOTCARR/1 CHANCE/1 ZERO/1 NOTZERO/1 EQ/2 GT/2 LT/2
    ADJECT1/1 ADVERB/1 INVEN/0 DESC/0 QUIT/0 END/0 DONE/0 OK/0
    ANYKEY/0 SAVE/0 LOAD/0 TURNS/0 SCORE/0 CLS/0 DROPALL/0 AUTOG/0
    AUTOD/0 AUTOW/0 AUTOR/0 PAUSE/1 TIMEOUT/0 GOTO/1 MESSAGE/1 REMOVE/1
    GET/1 DROP/1 WEAR/1 DESTROY/1 CREATE/1 SWAP/2 PLACE/2 SET/1 CLEAR/1
    PLUS/2 MINUS/2 LET/2 NEWLINE/0 PRINT/1 SYSMESS/1 ISAT/2 COPYOF/2
    COPYOO/2 COPYFO/2 COPYFF/2 LISTOBJ/0 EXTERN/1 RAMSAVE/0 RAMLOAD/1
    BEEP/2 PAPER/1 INK/1 BORDER/1 PREP/1 NOUN2/1 ADJECT2/1 ADD/2 SUB/2
    PARSE/0 LISTAT/1 PROCESS/1 SAME/2 MES/1 CHARSET/1 NOTEQ/2 NOTSAME/2
    MODE/2 LINE/1 TIME/2 PICTURE/1 DOALL/1 PROMPT/1 GRAPHIC/1 ISNOTAT/2
    WEIGH/2 PUTIN/2 TAKEOUT/2 NEWTEXT/0 ABILITY/2 WEIGHT/1 RANDOM/1 INPUT/1
    SAVEAT/0 BACKAT/0 PRINTAT/2 WHATO/0 RESET/1 PUTO/1 NOTDONE/0 AUTOP/1
    AUTOT/1 MOVE/1 PROTECT/0
    """
)


OPCODE_TABLES: Final = {
    "v1": V1_OPCODE_TABLE,
    "v2": V2_OPCODE_TABLE,
    "paws": PAWS_OPCODE_TABLE,
}


def opcode_table_for(profile: DDBProfile) -> tuple[OpcodeSpec | None, ...]:
    """Return the exact table selected by a profile, never a generic fallback."""

    dialect = profile.grammar_dialect
    try:
        return OPCODE_TABLES[dialect]
    except KeyError as error:
        raise UnsupportedDDBGrammarProfile(
            f"no source-backed CondAct grammar for profile dialect {dialect!r}"
        ) from error


def _decode_known_condact(
    data: bytes,
    position: int,
    limit: int,
    table: tuple[OpcodeSpec | None, ...],
) -> CondActNode | OpaqueCondActNode:
    raw_opcode = data[position]
    opcode = raw_opcode & 0x7F
    specification = table[opcode]
    if specification is None:
        return OpaqueCondActNode(
            position,
            position + 1,
            data[position:position + 1],
            f"unknown_opcode_{raw_opcode:02x}",
        )
    first_parameter_indirect = bool(raw_opcode & 0x80)
    if first_parameter_indirect and specification.parameter_count == 0:
        return OpaqueCondActNode(
            position,
            position + 1,
            data[position:position + 1],
            f"invalid_first_parameter_indirection_{specification.name.lower()}",
        )
    byte_end = position + 1 + specification.parameter_count
    if byte_end > limit:
        return OpaqueCondActNode(
            position,
            limit,
            data[position:limit],
            f"truncated_parameters_{specification.name.lower()}",
        )
    return CondActNode(
        position,
        byte_end,
        opcode,
        specification.name,
        tuple(data[position + 1:byte_end]),
        first_parameter_indirect=first_parameter_indirect,
    )


def decode_condact_stream(
    data: bytes,
    offset: int,
    profile: DDBProfile,
    *,
    end: int | None = None,
) -> list[CondActStreamItem]:
    """Decode one bounded stream while retaining source ranges and opaque bytes.

    The optional ``end`` is an exclusive absolute source boundary. It exists for
    callers that already own a containing section; the required three-argument
    API consumes through ``len(data)``. A terminator node ends decoding early.
    """

    if offset < 0 or offset > len(data):
        raise ValueError("CondAct stream offset is outside source bytes")
    limit = len(data) if end is None else end
    if limit < offset or limit > len(data):
        raise ValueError("CondAct stream end is outside source bytes")
    table = opcode_table_for(profile)
    nodes: list[CondActStreamItem] = []
    position = offset
    while position < limit:
        if data[position] == STREAM_TERMINATOR:
            nodes.append(StreamTerminatorNode(position, position + 1))
            break
        current = _decode_known_condact(data, position, limit, table)
        if isinstance(current, OpaqueCondActNode):
            nodes.append(current)
            position = current.byte_end
            continue
        if current.name == INDIR_NAME and not current.first_parameter_indirect:
            next_position = current.byte_end
            if next_position < limit and data[next_position] != STREAM_TERMINATOR:
                following = _decode_known_condact(data, next_position, limit, table)
                if (
                    isinstance(following, CondActNode)
                    and len(following.parameters) >= 2
                ):
                    nodes.append(
                        replace(
                            following,
                            byte_start=current.byte_start,
                            second_parameter_indirect=True,
                            second_indirection_parameter=current.parameters[0],
                        )
                    )
                    position = following.byte_end
                    continue
        nodes.append(current)
        position = current.byte_end
    return nodes


def _indirection_opcode(table: tuple[OpcodeSpec | None, ...]) -> int:
    for specification in table:
        if specification is not None and specification.name == INDIR_NAME:
            return specification.opcode
    raise UnsupportedDDBGrammarProfile(
        "profile has no source-backed INDIR opcode for second-parameter indirection"
    )


def encode_condact_stream(
    nodes: list[CondActStreamItem] | tuple[CondActStreamItem, ...],
    profile: DDBProfile,
) -> bytes:
    """Serialize decoded nodes deterministically without normalizing opaque bytes."""

    table = opcode_table_for(profile)
    output = bytearray()
    for node in nodes:
        if isinstance(node, OpaqueCondActNode):
            output.extend(node.raw_bytes)
            continue
        if isinstance(node, StreamTerminatorNode):
            if node.raw_byte != STREAM_TERMINATOR:
                raise ValueError("only the DAAD 0xFF stream terminator is encodable")
            output.append(STREAM_TERMINATOR)
            continue
        specification = table[node.opcode] if 0 <= node.opcode < 0x80 else None
        if specification is None:
            raise ValueError(f"unsupported CondAct opcode {node.opcode:#04x}")
        if specification.name != node.name:
            raise ValueError(
                f"opcode {node.opcode:#04x} is {specification.name}, not {node.name}"
            )
        if len(node.parameters) != specification.parameter_count:
            raise ValueError(
                f"{node.name} requires {specification.parameter_count} parameters, "
                f"not {len(node.parameters)}"
            )
        if node.first_parameter_indirect and specification.parameter_count == 0:
            raise ValueError(f"{node.name} cannot indirect a missing first parameter")
        if node.second_parameter_indirect:
            if specification.parameter_count < 2 or node.second_indirection_parameter is None:
                raise ValueError(
                    f"{node.name} cannot encode second-parameter indirection"
                )
            output.extend((_indirection_opcode(table), node.second_indirection_parameter))
        raw_opcode = node.opcode | (0x80 if node.first_parameter_indirect else 0)
        output.append(raw_opcode)
        output.extend(node.parameters)
    return bytes(output)

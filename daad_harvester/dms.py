"""Bounded native decoding primitives for Amiga DMS archives.

This module intentionally exposes a narrow, verifiable first-stage decoder:
the archive and every decoded track must pass CRC-16/ARC and additive checksum
validation. Stored and SIMPLE/RLE tracks are decoded in-process. Advanced DMS
compression modes are recognized by their real mode identifiers and rejected
with a specific exception until their independent oracle parity suite is added.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import List


HEADER_SIZE = 56
TRACK_HEADER_SIZE = 20
MAX_TRACK_SIZE = 32000
FILE_ID_TRACK = 80
BANNER_TRACK = 0xFFFF


class DmsDecodeError(ValueError):
    """A structurally invalid, encrypted, or not-yet-decodable DMS archive."""


@dataclass(frozen=True)
class DmsTrack:
    number: int
    packed_length: int
    intermediate_length: int
    unpacked_length: int
    flags: int
    mode: int
    checksum: int
    data_crc: int


def crc16_arc(data: bytes) -> int:
    """Return DMS's reflected CRC-16/ARC value (poly 0xA001, init zero)."""

    crc = 0
    for value in data:
        crc ^= value
        for _ in range(8):
            crc = (crc >> 1) ^ 0xA001 if crc & 1 else crc >> 1
    return crc & 0xFFFF


def checksum16(data: bytes) -> int:
    """Return DMS's wrapping byte-sum checksum for unpacked track data."""

    return sum(data) & 0xFFFF


def _be16(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset:offset + 2], "big")


def _rle_simple(data: bytes, expected_length: int) -> bytes:
    """Decode DMS SIMPLE RLE to exactly the caller-declared output size."""

    output = bytearray()
    pos = 0
    while len(output) < expected_length:
        if pos >= len(data):
            raise DmsDecodeError("simple_rle_truncated")
        value = data[pos]
        pos += 1
        if value != 0x90:
            output.append(value)
            continue
        if pos >= len(data):
            raise DmsDecodeError("simple_rle_escape_truncated")
        run = data[pos]
        pos += 1
        if run == 0:
            output.append(0x90)
            continue
        if pos >= len(data):
            raise DmsDecodeError("simple_rle_value_truncated")
        repeated = data[pos]
        pos += 1
        if run == 0xFF:
            if pos + 2 > len(data):
                raise DmsDecodeError("simple_rle_long_count_truncated")
            run = int.from_bytes(data[pos:pos + 2], "big")
            pos += 2
        if run == 0 or len(output) + run > expected_length:
            raise DmsDecodeError("simple_rle_output_overflow")
        output.extend(bytes((repeated,)) * run)
    return bytes(output)


class _BitReader:
    """DMS-compatible MSB-first reader with the historical zero-padded tail."""

    def __init__(self, data: bytes) -> None:
        self._data = data
        self._byte_pos = 0
        self._buffer = 0
        self._count = 0
        self._refill()

    def _refill(self) -> None:
        while self._count < 16:
            value = self._data[self._byte_pos] if self._byte_pos < len(self._data) else 0
            self._byte_pos += 1
            self._buffer = (self._buffer << 8) | value
            self._count += 8

    def read(self, bits: int) -> int:
        value = self.peek(bits)
        self.consume(bits)
        return value

    def peek(self, bits: int) -> int:
        return self._buffer >> (self._count - bits)

    def consume(self, bits: int) -> None:
        self._count -= bits
        self._buffer &= (1 << self._count) - 1
        self._refill()


_D_CODE = bytes(
    [0] * 32
    + [value for value in range(1, 4) for _ in range(16)]
    + [value for value in range(4, 12) for _ in range(8)]
    + [value for value in range(12, 24) for _ in range(4)]
    + [value for value in range(24, 40) for _ in range(2)]
    + list(range(48, 64))
)
_D_LEN = bytes([3] * 32 + [4] * 48 + [5] * 64 + [6] * 80 + [7] * 16 + [8] * 16)
_DEEP_N_CHAR = 314
_DEEP_T = _DEEP_N_CHAR * 2 - 1
_DEEP_ROOT = _DEEP_T - 1


class _DmsDecodeState:
    """The shared DMS LZ window and positions that may cross a track boundary."""

    def __init__(self) -> None:
        self.window = bytearray(0x4000)
        self.heavy_c_lengths = [0] * 510
        self.heavy_pt_lengths = [0] * 20
        self.heavy_c_table = [0] * 4096
        self.heavy_pt_table = [0] * 256
        self.heavy_left = [0] * (2 * 510 - 1)
        self.heavy_right = [0] * (2 * 510 - 1 + 9)
        self.heavy_trees_ready = False
        self.reset()

    def reset(self) -> None:
        self.window[:] = b"\x00" * len(self.window)
        self.quick_position = 251  # 256 - QUICK's maximum match length (5)
        self.medium_position = 0x3FBE  # 16K - MEDIUM's maximum match length (66)
        self.deep_position = 0x3FC4  # 16K - DEEP's maximum match length (60)
        self.deep_frequency = [0] * (_DEEP_T + 1)
        self.deep_parent = [0] * (_DEEP_T + _DEEP_N_CHAR)
        self.deep_son = [0] * _DEEP_T
        self.deep_needs_init = True
        self.heavy_position = 0
        self.heavy_last_match_length = 0


class _QuickDecoder:
    """DMS QUICK first-stage decoder, including state kept between flagged tracks."""

    def __init__(self, state: _DmsDecodeState) -> None:
        self.state = state

    def decode(self, packed: bytes, output_length: int) -> bytes:
        reader = _BitReader(packed)
        output = bytearray()
        while len(output) < output_length:
            if reader.read(1):
                value = reader.read(8)
                self.state.window[self.state.quick_position & 0xFF] = value
                self.state.quick_position = (self.state.quick_position + 1) & 0xFF
                output.append(value)
                continue
            length = reader.read(2) + 2
            distance = reader.read(8)
            if len(output) + length > output_length:
                raise DmsDecodeError("quick_output_overflow")
            source = (self.state.quick_position - distance - 1) & 0xFF
            for _ in range(length):
                value = self.state.window[source & 0xFF]
                self.state.window[self.state.quick_position & 0xFF] = value
                self.state.quick_position = (self.state.quick_position + 1) & 0xFF
                source = (source + 1) & 0xFF
                output.append(value)
        self.state.quick_position = (self.state.quick_position + 5) & 0xFF
        return bytes(output)


class _MediumDecoder:
    """DMS MEDIUM LZ first-stage decoder using the reference static tables."""

    def __init__(self, state: _DmsDecodeState) -> None:
        self.state = state

    def decode(self, packed: bytes, output_length: int) -> bytes:
        reader = _BitReader(packed)
        output = bytearray()
        while len(output) < output_length:
            if reader.read(1):
                value = reader.read(8)
                self.state.window[self.state.medium_position & 0x3FFF] = value
                self.state.medium_position = (self.state.medium_position + 1) & 0x3FFF
                output.append(value)
                continue
            prefix = reader.read(8) & 0xFF
            length = _D_CODE[prefix] + 3
            mid = ((prefix << _D_LEN[prefix]) | reader.read(_D_LEN[prefix])) & 0xFF
            low = ((mid << _D_LEN[mid]) | reader.read(_D_LEN[mid])) & 0xFF
            distance = (_D_CODE[mid] << 8) | low
            if len(output) + length > output_length:
                raise DmsDecodeError("medium_output_overflow")
            source = (self.state.medium_position - distance - 1) & 0x3FFF
            for _ in range(length):
                value = self.state.window[source & 0x3FFF]
                self.state.window[self.state.medium_position & 0x3FFF] = value
                self.state.medium_position = (self.state.medium_position + 1) & 0x3FFF
                source = (source + 1) & 0x3FFF
                output.append(value)
        self.state.medium_position = (self.state.medium_position + 66) & 0x3FFF
        return bytes(output)


class _DeepDecoder:
    """DMS DEEP adaptive-Huffman LZ decoder, including persistent tree state."""

    def __init__(self, state: _DmsDecodeState) -> None:
        self.state = state

    def _init_tree(self) -> None:
        state = self.state
        for index in range(_DEEP_N_CHAR):
            state.deep_frequency[index] = 1
            state.deep_son[index] = index + _DEEP_T
            state.deep_parent[index + _DEEP_T] = index
        low = 0
        high = _DEEP_N_CHAR
        while high <= _DEEP_ROOT:
            state.deep_frequency[high] = state.deep_frequency[low] + state.deep_frequency[low + 1]
            state.deep_son[high] = low
            state.deep_parent[low] = high
            state.deep_parent[low + 1] = high
            low += 2
            high += 1
        state.deep_frequency[_DEEP_T] = 0xFFFF
        state.deep_parent[_DEEP_ROOT] = 0
        state.deep_needs_init = False

    def _reconstruct(self) -> None:
        state = self.state
        leaf = 0
        for index in range(_DEEP_T):
            if state.deep_son[index] >= _DEEP_T:
                state.deep_frequency[leaf] = (state.deep_frequency[index] + 1) // 2
                state.deep_son[leaf] = state.deep_son[index]
                leaf += 1
        low = 0
        high = _DEEP_N_CHAR
        while high < _DEEP_T:
            frequency = state.deep_frequency[low] + state.deep_frequency[low + 1]
            state.deep_frequency[high] = frequency
            insertion = high - 1
            while frequency < state.deep_frequency[insertion]:
                insertion -= 1
            insertion += 1
            state.deep_frequency[insertion + 1:high + 1] = state.deep_frequency[insertion:high]
            state.deep_frequency[insertion] = frequency
            state.deep_son[insertion + 1:high + 1] = state.deep_son[insertion:high]
            state.deep_son[insertion] = low
            low += 2
            high += 1
        for index in range(_DEEP_T):
            child = state.deep_son[index]
            state.deep_parent[child] = index
            if child < _DEEP_T:
                state.deep_parent[child + 1] = index

    def _update(self, symbol: int) -> None:
        state = self.state
        if state.deep_frequency[_DEEP_ROOT] == 0x8000:
            self._reconstruct()
        current = state.deep_parent[symbol + _DEEP_T]
        while True:
            state.deep_frequency[current] += 1
            frequency = state.deep_frequency[current]
            swap = current + 1
            if frequency > state.deep_frequency[swap]:
                while True:
                    swap += 1
                    if frequency <= state.deep_frequency[swap]:
                        break
                swap -= 1
                state.deep_frequency[current], state.deep_frequency[swap] = (
                    state.deep_frequency[swap],
                    frequency,
                )
                left_child = state.deep_son[current]
                state.deep_parent[left_child] = swap
                if left_child < _DEEP_T:
                    state.deep_parent[left_child + 1] = swap
                right_child = state.deep_son[swap]
                state.deep_son[swap] = left_child
                state.deep_parent[right_child] = current
                if right_child < _DEEP_T:
                    state.deep_parent[right_child + 1] = current
                state.deep_son[current] = right_child
                current = swap
            current = state.deep_parent[current]
            if current == 0:
                return

    def _decode_char(self, reader: _BitReader) -> int:
        state = self.state
        node = state.deep_son[_DEEP_ROOT]
        while node < _DEEP_T:
            node = state.deep_son[node + reader.read(1)]
        symbol = node - _DEEP_T
        self._update(symbol)
        return symbol

    def decode(self, packed: bytes, output_length: int) -> bytes:
        state = self.state
        reader = _BitReader(packed)
        if state.deep_needs_init:
            self._init_tree()
        output = bytearray()
        while len(output) < output_length:
            code = self._decode_char(reader)
            if code < 256:
                state.window[state.deep_position & 0x3FFF] = code
                state.deep_position = (state.deep_position + 1) & 0x3FFF
                output.append(code)
                continue
            length = code - 253
            prefix = reader.read(8) & 0xFF
            distance = (_D_CODE[prefix] << 8) | ((prefix << _D_LEN[prefix]) | reader.read(_D_LEN[prefix])) & 0xFF
            if len(output) + length > output_length:
                raise DmsDecodeError("deep_output_overflow")
            source = (state.deep_position - distance - 1) & 0x3FFF
            for _ in range(length):
                value = state.window[source & 0x3FFF]
                state.window[state.deep_position & 0x3FFF] = value
                state.deep_position = (state.deep_position + 1) & 0x3FFF
                source = (source + 1) & 0x3FFF
                output.append(value)
        state.deep_position = (state.deep_position + 60) & 0x3FFF
        return bytes(output)


def _make_huffman_table(
    left: list[int],
    right: list[int],
    symbols: int,
    lengths: list[int],
    table_bits: int,
    table: list[int],
) -> None:
    """Build the exact LHA-style decode table used by DMS HEAVY streams."""

    table_size = 1 << table_bits
    table[:] = [0] * table_size
    available = symbols
    bit = table_size >> 1
    maximum_depth = table_bits + 1
    depth = 1
    length = 1
    code_index = -1
    codeword = 0

    def build() -> int:
        nonlocal available, bit, depth, length, code_index, codeword
        node = 0
        if length == depth:
            while True:
                code_index += 1
                if code_index >= symbols:
                    break
                if lengths[code_index] == length:
                    start = codeword
                    codeword += bit
                    if codeword > table_size:
                        raise DmsDecodeError("heavy_huffman_table_overflow")
                    table[start:codeword] = [code_index] * (codeword - start)
                    return code_index
            code_index = -1
            length += 1
            bit >>= 1
        depth += 1
        if depth < maximum_depth:
            build()
            build()
        elif depth > 32:
            raise DmsDecodeError("heavy_huffman_depth_exceeded")
        else:
            node = available
            available += 1
            if node >= 2 * symbols - 1:
                raise DmsDecodeError("heavy_huffman_tree_overflow")
            left_child = build()
            right_child = build()
            left[node] = left_child
            right[node] = right_child
            if codeword >= table_size:
                raise DmsDecodeError("heavy_huffman_incomplete")
            if depth == maximum_depth:
                table[codeword] = node
                codeword += 1
        depth -= 1
        return node

    build()
    build()
    if codeword != table_size:
        raise DmsDecodeError("heavy_huffman_invalid_code_lengths")


class _HeavyDecoder:
    """DMS HEAVY1/HEAVY2 LZH decoder with canonical-tree state persistence."""

    def __init__(self, state: _DmsDecodeState) -> None:
        self.state = state

    def _read_character_tree(self, reader: _BitReader) -> None:
        state = self.state
        count = reader.read(9)
        if count:
            if count > 510:
                raise DmsDecodeError("heavy_character_tree_count")
            for index in range(count):
                state.heavy_c_lengths[index] = reader.read(5)
            state.heavy_c_lengths[count:] = [0] * (510 - count)
            _make_huffman_table(
                state.heavy_left,
                state.heavy_right,
                510,
                state.heavy_c_lengths,
                12,
                state.heavy_c_table,
            )
            return
        symbol = reader.read(9)
        if symbol >= 510:
            raise DmsDecodeError("heavy_character_symbol")
        state.heavy_c_lengths[:] = [0] * 510
        state.heavy_c_table[:] = [symbol] * 4096

    def _read_position_tree(self, reader: _BitReader, position_codes: int) -> None:
        state = self.state
        count = reader.read(5)
        if count:
            if count > 20:
                raise DmsDecodeError("heavy_position_tree_count")
            for index in range(count):
                state.heavy_pt_lengths[index] = reader.read(4)
            state.heavy_pt_lengths[count:] = [0] * (20 - count)
            _make_huffman_table(
                state.heavy_left,
                state.heavy_right,
                position_codes,
                state.heavy_pt_lengths,
                8,
                state.heavy_pt_table,
            )
            return
        symbol = reader.read(5)
        if symbol >= position_codes:
            raise DmsDecodeError("heavy_position_symbol")
        state.heavy_pt_lengths[:] = [0] * 20
        state.heavy_pt_table[:] = [symbol] * 256

    def _decode_character(self, reader: _BitReader) -> int:
        state = self.state
        node = state.heavy_c_table[reader.peek(12) & 0xFFF]
        if node < 510:
            reader.consume(state.heavy_c_lengths[node])
            return node
        reader.consume(12)
        path = reader.peek(16)
        probe = 0x8000
        while node >= 510:
            node = state.heavy_right[node] if path & probe else state.heavy_left[node]
            probe >>= 1
        reader.consume(state.heavy_c_lengths[node] - 12)
        return node

    def _decode_position(self, reader: _BitReader, position_codes: int) -> int:
        state = self.state
        node = state.heavy_pt_table[reader.peek(8) & 0xFF]
        if node < position_codes:
            reader.consume(state.heavy_pt_lengths[node])
        else:
            reader.consume(8)
            path = reader.peek(16)
            probe = 0x8000
            while node >= position_codes:
                node = state.heavy_right[node] if path & probe else state.heavy_left[node]
                probe >>= 1
            reader.consume(state.heavy_pt_lengths[node] - 8)
        if node != position_codes - 1:
            if node:
                extra = node - 1
                node = reader.peek(extra) | (1 << extra)
                reader.consume(extra)
            state.heavy_last_match_length = node
        return state.heavy_last_match_length

    def decode(self, packed: bytes, output_length: int, *, big_dictionary: bool, rebuild: bool) -> bytes:
        state = self.state
        position_codes, mask = (15, 0x1FFF) if big_dictionary else (14, 0x0FFF)
        reader = _BitReader(packed)
        if rebuild:
            self._read_character_tree(reader)
            self._read_position_tree(reader, position_codes)
            state.heavy_trees_ready = True
        elif not state.heavy_trees_ready:
            raise DmsDecodeError("heavy_tree_state_missing")
        output = bytearray()
        while len(output) < output_length:
            code = self._decode_character(reader)
            if code < 256:
                state.window[state.heavy_position & mask] = code
                state.heavy_position = (state.heavy_position + 1) & mask
                output.append(code)
                continue
            length = code - 253
            distance = self._decode_position(reader, position_codes)
            if len(output) + length > output_length:
                raise DmsDecodeError("heavy_output_overflow")
            source = (state.heavy_position - distance - 1) & mask
            for _ in range(length):
                value = state.window[source & mask]
                state.window[state.heavy_position & mask] = value
                state.heavy_position = (state.heavy_position + 1) & mask
                source = (source + 1) & mask
                output.append(value)
        return bytes(output)


def _parse_track(header: bytes) -> DmsTrack:
    if len(header) != TRACK_HEADER_SIZE or header[:2] != b"TR":
        raise DmsDecodeError("track_signature_mismatch")
    if crc16_arc(header[:18]) != _be16(header, 18):
        raise DmsDecodeError("track_header_crc_mismatch")
    track = DmsTrack(
        number=_be16(header, 2),
        packed_length=_be16(header, 6),
        intermediate_length=_be16(header, 8),
        unpacked_length=_be16(header, 10),
        flags=header[12],
        mode=header[13],
        checksum=_be16(header, 14),
        data_crc=_be16(header, 16),
    )
    if max(track.packed_length, track.intermediate_length, track.unpacked_length) > MAX_TRACK_SIZE:
        raise DmsDecodeError("track_length_limit_exceeded")
    return track


def decompress_dms(data: bytes) -> bytes:
    """Decode an unencrypted DMS archive with stored/SIMPLE tracks to raw ADF.

    The function refuses advanced MEDIUM, DEEP, HEAVY1, and HEAVY2
    streams until the project has complete decoder-parity tests for those modes.
    That failure preserves a truthful DMS parser decision; it never returns a
    partial disk image as an ADF.
    """

    if len(data) < HEADER_SIZE or data[:4] != b"DMS!":
        raise DmsDecodeError("archive_signature_or_header_mismatch")
    if crc16_arc(data[4:54]) != _be16(data, 54):
        raise DmsDecodeError("archive_header_crc_mismatch")
    general_info = _be16(data, 10)
    if general_info & 0x0002:
        raise DmsDecodeError("encrypted_archive")
    pos = HEADER_SIZE
    output: List[bytes] = []
    state = _DmsDecodeState()
    quick = _QuickDecoder(state)
    medium = _MediumDecoder(state)
    deep = _DeepDecoder(state)
    heavy = _HeavyDecoder(state)
    while pos < len(data):
        if len(data) - pos < TRACK_HEADER_SIZE:
            raise DmsDecodeError("truncated_track_header")
        track = _parse_track(data[pos:pos + TRACK_HEADER_SIZE])
        pos += TRACK_HEADER_SIZE
        end = pos + track.packed_length
        if end > len(data):
            raise DmsDecodeError("truncated_track_data")
        packed = data[pos:end]
        pos = end
        if crc16_arc(packed) != track.data_crc:
            raise DmsDecodeError("track_data_crc_mismatch")
        if track.number in {FILE_ID_TRACK, BANNER_TRACK} or track.unpacked_length <= 2048:
            continue
        if track.mode == 0:
            if track.packed_length < track.unpacked_length:
                raise DmsDecodeError("stored_track_shorter_than_declared")
            decoded = packed[:track.unpacked_length]
        elif track.mode == 1:
            decoded = _rle_simple(packed, track.unpacked_length)
        elif track.mode == 2:
            stage_one = quick.decode(packed, track.intermediate_length)
            decoded = _rle_simple(stage_one, track.unpacked_length)
        elif track.mode == 3:
            stage_one = medium.decode(packed, track.intermediate_length)
            decoded = _rle_simple(stage_one, track.unpacked_length)
        elif track.mode == 4:
            stage_one = deep.decode(packed, track.intermediate_length)
            decoded = _rle_simple(stage_one, track.unpacked_length)
        elif track.mode in {5, 6}:
            stage_one = heavy.decode(
                packed,
                track.intermediate_length,
                big_dictionary=track.mode == 6,
                rebuild=bool(track.flags & 0x02),
            )
            if track.flags & 0x04:
                decoded = _rle_simple(stage_one, track.unpacked_length)
            elif len(stage_one) >= track.unpacked_length:
                decoded = stage_one[:track.unpacked_length]
            else:
                raise DmsDecodeError("heavy_stage_shorter_than_output")
        else:
            raise DmsDecodeError(f"unsupported_dms_mode_{track.mode}")
        if checksum16(decoded) != track.checksum:
            raise DmsDecodeError("unpacked_track_checksum_mismatch")
        output.append(decoded)
        if not track.flags & 0x01:
            state.reset()
    if not output:
        raise DmsDecodeError("no_decoded_data_tracks")
    return b"".join(output)

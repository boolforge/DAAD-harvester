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
        value = self._buffer >> (self._count - bits)
        self._count -= bits
        self._buffer &= (1 << self._count) - 1
        self._refill()
        return value


class _QuickDecoder:
    """DMS QUICK first-stage decoder, including state kept between flagged tracks."""

    def __init__(self) -> None:
        self.reset()

    def reset(self) -> None:
        self.window = bytearray(256)
        self.position = 251  # 256 - QUICK's maximum match length (5)

    def decode(self, packed: bytes, output_length: int) -> bytes:
        reader = _BitReader(packed)
        output = bytearray()
        while len(output) < output_length:
            if reader.read(1):
                value = reader.read(8)
                self.window[self.position & 0xFF] = value
                self.position = (self.position + 1) & 0xFF
                output.append(value)
                continue
            length = reader.read(2) + 2
            distance = reader.read(8)
            if len(output) + length > output_length:
                raise DmsDecodeError("quick_output_overflow")
            source = (self.position - distance - 1) & 0xFF
            for _ in range(length):
                value = self.window[source & 0xFF]
                self.window[self.position & 0xFF] = value
                self.position = (self.position + 1) & 0xFF
                source = (source + 1) & 0xFF
                output.append(value)
        self.position = (self.position + 5) & 0xFF
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
    quick = _QuickDecoder()
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
        else:
            raise DmsDecodeError(f"unsupported_dms_mode_{track.mode}")
        if checksum16(decoded) != track.checksum:
            raise DmsDecodeError("unpacked_track_checksum_mismatch")
        output.append(decoded)
        if not track.flags & 0x01:
            quick.reset()
    if not output:
        raise DmsDecodeError("no_decoded_data_tracks")
    return b"".join(output)

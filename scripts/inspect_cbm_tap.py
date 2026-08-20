#!/usr/bin/env python3
"""Inspect a Commodore raw-TAP pulse stream without executing its loader.

The TAP container represents physical pulse timing, not necessarily a sequence
of conventional ROM-loader files.  This utility therefore preserves the exact
stream framing and only offers bounded two-pulse decoding previews to aid
classification of turbo/custom loaders.  It never claims that a preview is a
verified program member.

The byte and overflow conventions follow the VICE raw-TAP file-format
specification: <https://vice-emu.sourceforge.io/vice_17.html>.
"""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator


SIGNATURES = {
    b"C64-TAPE-RAW": "c64",
    b"C16-TAPE-RAW": "plus4",
}

# Default bounds are the midpoint limits implied by the retained C64 KERNAL
# reader's short/medium/long decision path, rounded outward to accommodate the
# measured Side A timing clusters.  They are classification bounds only: the
# KERNAL's adaptive software-servo and error correction are not yet modeled.
ROM_SHORT_MEDIUM_BOUNDARY = 440
ROM_MEDIUM_LONG_BOUNDARY = 640
ROM_MAX_LONG = 840


@dataclass(frozen=True)
class Pulse:
    """One decoded timing event with byte offsets into the retained TAP file."""

    stream_offset: int
    encoded_size: int
    cycles: int | None
    kind: str


def parse_pulses(data: bytes) -> tuple[dict[str, int | str], list[Pulse]]:
    """Validate a TAP header and return pulse events without normalization."""
    if len(data) < 20:
        raise ValueError("truncated TAP header")
    signature = data[:12]
    if signature not in SIGNATURES:
        raise ValueError("not a supported Commodore raw-TAP signature")
    version = data[12]
    if version not in {0, 1, 2}:
        raise ValueError(f"unsupported TAP version {version}")
    declared_size = int.from_bytes(data[16:20], "little")
    stream = data[20:]
    if declared_size != len(stream):
        raise ValueError(
            f"declared pulse-stream size {declared_size} differs from actual {len(stream)}"
        )

    pulses: list[Pulse] = []
    index = 0
    while index < len(stream):
        raw = stream[index]
        stream_offset = index
        if raw:
            pulses.append(Pulse(stream_offset, 1, raw * 8, "quantized"))
            index += 1
            continue
        if version == 0:
            # V0 is an overflow marker, not an exact duration.  Keep the
            # lower bound rather than silently inventing a duration.
            pulses.append(Pulse(stream_offset, 1, None, "v0_overflow"))
            index += 1
            continue
        if index + 4 > len(stream):
            raise ValueError(f"truncated v{version} extended pulse at stream offset {stream_offset}")
        cycles = int.from_bytes(stream[index + 1:index + 4], "little")
        pulses.append(Pulse(stream_offset, 4, cycles, "exact_extended"))
        index += 4

    metadata: dict[str, int | str] = {
        "signature": signature.decode("ascii"),
        "platform": SIGNATURES[signature],
        "version": version,
        "platform_code": data[13],
        "video_standard": data[14],
        "declared_pulse_bytes": declared_size,
    }
    return metadata, pulses


def _runs(values: list[int]) -> list[dict[str, int]]:
    """Return the ten longest constant-byte runs in deterministic order."""
    if not values:
        return []
    found: list[dict[str, int]] = []
    start = 0
    for index in range(1, len(values) + 1):
        if index != len(values) and values[index] == values[start]:
            continue
        found.append({"byte": values[start], "start": start, "length": index - start})
        start = index
    return sorted(found, key=lambda item: (-item["length"], item["start"]))[:10]


def _transition_previews(values: list[int]) -> list[dict[str, object]]:
    """Show bounded data immediately following meaningful constant-byte runs."""
    if not values:
        return []
    qualifying_runs: list[tuple[int, int, int]] = []
    start = 0
    for index in range(1, len(values) + 1):
        if index != len(values) and values[index] == values[start]:
            continue
        if index - start >= 32:
            qualifying_runs.append((start, index - start, values[start]))
        start = index
    return [
        {
            "run_byte": byte,
            "run_start": run_start,
            "run_length": run_length,
            "following_64_bytes_hex": bytes(values[run_start + run_length:run_start + run_length + 64]).hex(),
        }
        for run_start, run_length, byte in qualifying_runs[:10]
    ]


def _decode_preview(pulses: list[Pulse], threshold_cycles: int, lsb_first: bool) -> dict[str, object]:
    """Decode regular two-pulse timings into a bounded byte preview.

    Extended/unknown timings terminate a partial byte rather than being forced
    into a data bit.  The result is explicitly an unverified timing-derived
    preview, suitable for sync-pattern comparison only.
    """
    decoded: list[int] = []
    current = 0
    bit_count = 0
    for pulse in pulses:
        if pulse.cycles is None:
            current = 0
            bit_count = 0
            continue
        bit = int(pulse.cycles > threshold_cycles)
        if lsb_first:
            current |= bit << bit_count
        else:
            current = (current << 1) | bit
        bit_count += 1
        if bit_count == 8:
            decoded.append(current)
            current = 0
            bit_count = 0
    return {
        "bit_order": "lsb_first" if lsb_first else "msb_first",
        "threshold_cycles": threshold_cycles,
        "decoded_byte_count": len(decoded),
        "first_64_bytes_hex": bytes(decoded[:64]).hex(),
        "longest_constant_byte_runs": _runs(decoded),
        "transition_previews": _transition_previews(decoded),
    }


def _physical_segments(pulses: list[Pulse], stream_size: int) -> list[dict[str, int]]:
    """Partition a stream on long documented V1 pause pulses only.

    A TAP pause is physical timing evidence, not proof of a logical file.  The
    threshold merely excludes short extended records used for other timing
    purposes, while recording every boundary-generating pulse verbatim.
    """
    boundaries = [
        pulse
        for pulse in pulses
        if pulse.kind == "exact_extended" and pulse.cycles is not None and pulse.cycles >= 100_000
    ]
    start = 0
    segments: list[dict[str, int]] = []
    for index, boundary in enumerate(boundaries):
        end = boundary.stream_offset + boundary.encoded_size
        segments.append(
            {
                "segment_index": index,
                "stream_start": start,
                "stream_end_exclusive": end,
                "stream_byte_count": end - start,
                "following_pause_cycles": boundary.cycles,
            }
        )
        start = end
    if start < stream_size:
        segments.append(
            {
                "segment_index": len(segments),
                "stream_start": start,
                "stream_end_exclusive": stream_size,
                "stream_byte_count": stream_size - start,
            }
        )
    return segments


def _segment_timing_profiles(pulses: list[Pulse]) -> list[dict[str, object]]:
    """Report dominant exact timings per long-pause-delimited physical segment."""
    segments: list[list[int]] = [[]]
    for pulse in pulses:
        if pulse.kind == "exact_extended" and pulse.cycles is not None and pulse.cycles >= 100_000:
            segments.append([])
            continue
        if pulse.cycles is not None:
            segments[-1].append(pulse.cycles)
    return [
        {
            "segment_index": index,
            "exact_pulse_count": len(values),
            "dominant_cycles": [
                {"cycles": cycles, "count": count, "tap_value": cycles // 8 if cycles % 8 == 0 else None}
                for cycles, count in sorted(Counter(values).items(), key=lambda item: (-item[1], item[0]))[:8]
            ],
        }
        for index, values in enumerate(segments)
    ]


def _loader_01b6_preview(
    pulses: list[Pulse], validation_ram: bytes | None
) -> dict[str, list[dict[str, object]]]:
    """Model the measured Side A loader's `ROR $FC` ten-pulse byte reads.

    The model is constrained by retained execution evidence: the loader writes
    `$01B6` to CIA timer A, performs ten calls to its pulse-read subroutine,
    and compares the resulting `$FC` value to `$16`.  Since the tape may
    include other encodings and physical pauses, this function exposes sync
    candidates for inspection rather than treating them as recovered files.
    """
    previews: list[dict[str, object]] = []
    frames: list[dict[str, object]] = []
    segments: list[list[Pulse]] = [[]]
    for pulse in pulses:
        if pulse.kind == "exact_extended" and pulse.cycles is not None and pulse.cycles >= 100_000:
            segments.append([])
            continue
        if pulse.cycles is not None:
            segments[-1].append(pulse)
    for segment_index, regular in enumerate(segments):
        for phase in range(10):
            value = 0x7F
            decoded: list[tuple[int, int]] = []
            index = phase
            while index + 10 <= len(regular):
                group = regular[index:index + 10]
                for pulse in group:
                    carry = int(pulse.cycles > 0x01B6)
                    value = ((carry << 7) | (value >> 1)) & 0xFF
                decoded.append((group[0].stream_offset, value))
                index += 10
            zero_run = 0
            for byte_index, (stream_offset, decoded_byte) in enumerate(decoded):
                if decoded_byte == 0:
                    zero_run += 1
                    continue
                if decoded_byte != 0x16 or zero_run == 0:
                    zero_run = 0
                    continue
                following = [value for _, value in decoded[byte_index + 1:]]
                candidate = {
                    "segment_index": segment_index,
                    "phase": phase,
                    "preceding_zero_byte_run": zero_run,
                    "sync_stream_offset": stream_offset,
                    "following_16_bytes_hex": bytes(following[:16]).hex(),
                }
                if len(previews) < 32:
                    previews.append(candidate)
                if len(following) >= 4:
                    # The code stores the four post-sync bytes in descending
                    # Y order at $AC-$AF, then uses ($AC),X and the KERNAL
                    # `incsal`/`cmpste` helpers: bytes 0-1 are the exclusive
                    # end pointer and bytes 2-3 are the start pointer.
                    end = following[0] | (following[1] << 8)
                    start = following[2] | (following[3] << 8)
                    expected_size = end - start
                    if 0 < expected_size and end <= 0x10000:
                        payload = bytes(following[4:4 + expected_size])
                        frame: dict[str, object] = {
                            "segment_index": segment_index,
                            "phase": phase,
                            "sync_stream_offset": stream_offset,
                            "start_address": start,
                            "end_address_exclusive": end,
                            "expected_payload_size": expected_size,
                            "available_payload_size": len(payload),
                            "complete_payload": len(payload) == expected_size,
                            "available_payload_sha256": hashlib.sha256(payload).hexdigest(),
                        }
                        if validation_ram is not None and len(payload) == expected_size:
                            runtime = validation_ram[start:end]
                            frame["runtime_byte_matches"] = sum(
                                left == right for left, right in zip(payload, runtime)
                            )
                            frame["runtime_exact_match"] = payload == runtime
                        if len(frames) < 64:
                            frames.append(frame)
                zero_run = 0
    return {"sync_candidates": previews, "plausible_frames": frames}


def _measured_loader_reference_matches(
    pulses: list[Pulse], reference: bytes | None
) -> list[dict[str, object]]:
    """Find exact reference prefixes under the measured ten-pulse ROR model.

    This is deliberately a location test, not a member extractor: a match only
    proves that the supplied byte prefix is present under a stated timing phase
    and polarity.  Header, checksum, and transfer-boundary semantics still
    require independent validation before any bytes are promoted.
    """
    if reference is None:
        return []
    prefix = reference[: min(64, len(reference))]
    if not prefix:
        return []
    segments: list[list[Pulse]] = [[]]
    for pulse in pulses:
        if pulse.kind == "exact_extended" and pulse.cycles is not None and pulse.cycles >= 100_000:
            segments.append([])
            continue
        if pulse.cycles is not None:
            segments[-1].append(pulse)
    matches: list[dict[str, object]] = []
    for segment_index, regular in enumerate(segments):
        for phase in range(10):
            for inverted in (False, True):
                value = 0x7F
                decoded: list[tuple[int, int]] = []
                index = phase
                while index + 10 <= len(regular):
                    group = regular[index:index + 10]
                    for pulse in group:
                        carry = int(pulse.cycles > 0x01B6) ^ int(inverted)
                        value = ((carry << 7) | (value >> 1)) & 0xFF
                    decoded.append((group[0].stream_offset, value))
                    index += 10
                values = bytes(value for _, value in decoded)
                found_at = values.find(prefix)
                if found_at >= 0:
                    matches.append(
                        {
                            "segment_index": segment_index,
                            "phase": phase,
                            "inverted_polarity": inverted,
                            "stream_offset": decoded[found_at][0],
                            "matched_prefix_size": len(prefix),
                            "reference_prefix_sha256": hashlib.sha256(prefix).hexdigest(),
                        }
                    )
    return matches


def _kernal_pulse_class(cycles: int) -> str:
    """Classify a regular TAP timing for the retained KERNAL read state machine."""
    if cycles <= ROM_SHORT_MEDIUM_BOUNDARY:
        return "short"
    if cycles <= ROM_MEDIUM_LONG_BOUNDARY:
        return "medium"
    if cycles <= ROM_MAX_LONG:
        return "long"
    return "invalid"


def _kernal_packet_summary(
    pulses: list[Pulse], reference: bytes | None
) -> dict[str, object]:
    """Boundedly model the ROM reader's leader, byte, and parity states.

    The state transitions mirror the independent retained C64 KERNAL source:
    twenty short leader pulses, a long byte-start pulse, then differing
    short/medium dipole pairs.  This deliberately omits the ROM software
    servo, duplicated-block retry, header interpretation, and checksum claim.
    It can therefore identify an exact known prefix but cannot yet materialize
    a verified TAP member by itself.
    """
    packet_summaries: list[dict[str, object]] = []
    matches: list[dict[str, object]] = []
    packet: list[tuple[int, int, bool]] = []
    state = "none"
    short_run = 0
    last_pulse = "invalid"
    bit_count = 0
    output_byte = 0
    packet_start: int | None = None

    def flush() -> None:
        nonlocal packet, packet_start
        if not packet:
            return
        values = bytes(value for _, value, _ in packet)
        parity_valid = sum(valid for _, _, valid in packet)
        packet_summaries.append(
            {
                "stream_start": packet_start,
                "stream_end": packet[-1][0],
                "byte_count": len(packet),
                "parity_valid_byte_count": parity_valid,
                "first_64_bytes_hex": values[:64].hex(),
                "sha256": hashlib.sha256(values).hexdigest(),
            }
        )
        if reference:
            prefix = reference[: min(64, len(reference))]
            found_at = values.find(prefix)
            if found_at >= 0:
                matches.append(
                    {
                        "stream_offset": packet[found_at][0],
                        "packet_byte_offset": found_at,
                        "packet_byte_count": len(packet),
                        "matched_prefix_size": len(prefix),
                        "reference_prefix_sha256": hashlib.sha256(prefix).hexdigest(),
                    }
                )
        packet = []
        packet_start = None

    for pulse in pulses:
        if pulse.cycles is None:
            flush()
            state = "none"
            short_run = 0
            last_pulse = "invalid"
            continue
        pulse_class = _kernal_pulse_class(pulse.cycles)
        if state == "none":
            short_run = short_run + 1 if pulse_class == "short" else 0
            if short_run >= 20:
                state = "leader"
        elif state == "leader":
            if pulse_class == "long":
                state = "data"
            elif pulse_class != "short":
                flush()
                state = "none"
                short_run = 0
        elif state == "data":
            if pulse_class == "short":
                flush()
                state = "leader"
                short_run = 1
            elif pulse_class == "medium":
                state = "bit_first"
                bit_count = 0
                output_byte = 0
                packet_start = pulse.stream_offset if packet_start is None else packet_start
            else:
                flush()
                state = "none"
                short_run = 0
        elif state == "bit_first":
            if pulse_class in {"short", "medium"}:
                state = "bit_second"
            else:
                flush()
                state = "none"
                short_run = 0
        else:  # bit_second
            if pulse_class in {"short", "medium"} and pulse_class != last_pulse:
                bit = int(pulse_class == "short")
                if bit_count < 8:
                    output_byte |= bit << bit_count
                    state = "bit_first"
                else:
                    expected_parity = 1 ^ (output_byte.bit_count() & 1)
                    packet.append((pulse.stream_offset, output_byte, bit == expected_parity))
                    state = "leader"
                bit_count += 1
            else:
                flush()
                state = "none"
                short_run = 0
        last_pulse = pulse_class
    flush()
    return {
        "timing_bounds": {
            "short_medium_boundary": ROM_SHORT_MEDIUM_BOUNDARY,
            "medium_long_boundary": ROM_MEDIUM_LONG_BOUNDARY,
            "max_long": ROM_MAX_LONG,
        },
        "packet_count": len(packet_summaries),
        "packets": packet_summaries[:64],
        "reference_prefix_matches": matches[:32],
    }


def inspect(
    path: Path,
    threshold_cycles: int | None,
    validation_ram: bytes | None = None,
    reference_ddb: bytes | None = None,
) -> dict[str, object]:
    """Return a JSON-serializable, bounded structural analysis for one TAP."""
    data = path.read_bytes()
    header, pulses = parse_pulses(data)
    exact = [pulse.cycles for pulse in pulses if pulse.cycles is not None]
    frequency = Counter(exact)
    common = sorted(frequency.items(), key=lambda item: (-item[1], item[0]))
    if threshold_cycles is None:
        if len(common) < 2:
            raise ValueError("insufficient exact pulse classes for a two-pulse preview")
        threshold_cycles = (common[0][0] + common[1][0]) // 2
    loader_model = _loader_01b6_preview(pulses, validation_ram)
    kernal_model = _kernal_packet_summary(pulses, reference_ddb)
    return {
        "path": str(path),
        "sha256": hashlib.sha256(data).hexdigest(),
        "file_size": len(data),
        "header": header,
        "pulse_event_count": len(pulses),
        "pulse_kinds": dict(sorted(Counter(pulse.kind for pulse in pulses).items())),
        "extended_pulse_events": [
            {
                "stream_offset": pulse.stream_offset,
                "encoded_size": pulse.encoded_size,
                "cycles": pulse.cycles,
            }
            for pulse in pulses
            if pulse.kind == "exact_extended"
        ][:64],
        "physical_pause_segments": _physical_segments(pulses, len(data) - 20),
        "segment_timing_profiles": _segment_timing_profiles(pulses),
        "measured_loader_01b6_sync_candidates": loader_model["sync_candidates"],
        "measured_loader_01b6_plausible_frames": loader_model["plausible_frames"],
        "measured_loader_reference_prefix_matches": _measured_loader_reference_matches(
            pulses, reference_ddb
        ),
        "kernal_compatible_decoder": kernal_model,
        "dominant_exact_pulse_cycles": [
            {"cycles": cycles, "count": count, "tap_value": cycles // 8 if cycles % 8 == 0 else None}
            for cycles, count in common[:16]
        ],
        "two_pulse_previews": [
            _decode_preview(pulses, threshold_cycles, lsb_first=False),
            _decode_preview(pulses, threshold_cycles, lsb_first=True),
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path", type=Path)
    parser.add_argument(
        "--threshold-cycles",
        type=int,
        help="Explicit strict-greater-than two-pulse threshold; defaults to the midpoint of the two dominant exact timing classes.",
    )
    parser.add_argument(
        "--validate-ram",
        type=Path,
        help="Optional 64 KiB C64 RAM image used only for exact candidate-frame byte comparison.",
    )
    parser.add_argument(
        "--reference-ddb",
        type=Path,
        help="Optional known DDB used only for an exact 64-byte prefix-location scan under the measured loader model.",
    )
    args = parser.parse_args()
    validation_ram = None if args.validate_ram is None else args.validate_ram.read_bytes()
    if validation_ram is not None and len(validation_ram) != 65536:
        parser.error("--validate-ram must contain exactly 65536 bytes")
    reference_ddb = None if args.reference_ddb is None else args.reference_ddb.read_bytes()
    print(
        json.dumps(
            inspect(args.path, args.threshold_cycles, validation_ram, reference_ddb),
            indent=2,
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

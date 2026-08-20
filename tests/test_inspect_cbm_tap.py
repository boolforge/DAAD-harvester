"""Regression coverage for bounded Commodore raw-TAP analysis."""

from __future__ import annotations

import importlib.util
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/inspect_cbm_tap.py"
SPEC = importlib.util.spec_from_file_location("inspect_cbm_tap", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
TAP = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = TAP
SPEC.loader.exec_module(TAP)


def _pulse_stream_for_byte(value: int) -> list[object]:
    """Build one ROM-style encoded byte with its odd parity dipole."""
    pulses = [TAP.Pulse(index, 1, 368, "quantized") for index in range(20)]
    next_offset = len(pulses)
    pulses.append(TAP.Pulse(next_offset, 1, 712, "quantized"))
    next_offset += 1
    pulses.append(TAP.Pulse(next_offset, 1, 592, "quantized"))
    next_offset += 1
    bits = [(value >> bit) & 1 for bit in range(8)]
    bits.append(1 ^ (value.bit_count() & 1))
    for bit in bits:
        first, second = ((592, 368) if bit else (368, 592))
        pulses.append(TAP.Pulse(next_offset, 1, first, "quantized"))
        pulses.append(TAP.Pulse(next_offset + 1, 1, second, "quantized"))
        next_offset += 2
    pulses.append(TAP.Pulse(next_offset, 1, None, "v0_overflow"))
    return pulses


def _loader_pulses_for_bytes(values: list[int]) -> list[object]:
    """Encode exact ten-pulse ROR states for the measured Side A loader."""
    pulses: list[object] = []
    state = 0x7F
    offset = 0
    for target in values:
        carries: list[int] | None = None
        for candidate in range(1 << 10):
            candidate_state = state
            candidate_carries = []
            for bit in range(10):
                carry = (candidate >> bit) & 1
                candidate_carries.append(carry)
                candidate_state = ((carry << 7) | (candidate_state >> 1)) & 0xFF
            if candidate_state == target:
                carries = candidate_carries
                break
        assert carries is not None
        for carry in carries:
            pulses.append(TAP.Pulse(offset, 1, 592 if carry else 280, "quantized"))
            offset += 1
        state = target
    return pulses


def test_kernal_decoder_recovers_parity_checked_synthetic_byte() -> None:
    result = TAP._kernal_packet_summary(_pulse_stream_for_byte(0xA5), b"\xA5")

    assert result["packet_count"] == 1
    assert result["packets"][0]["byte_count"] == 1
    assert result["packets"][0]["parity_valid_byte_count"] == 1
    assert result["packets"][0]["first_64_bytes_hex"] == "a5"
    assert result["reference_prefix_matches"][0]["matched_prefix_size"] == 1


def test_measured_loader_uses_descending_pointer_header_order() -> None:
    # zero leader, $16 sync, EAH/EAL/SAH/SAL, then a three-byte payload.
    pulses = _loader_pulses_for_bytes([0x00, 0x16, 0x40, 0x03, 0x40, 0x00, 0xAA, 0xBB, 0xCC])
    ram = bytearray(65536)
    ram[0x4000:0x4003] = b"\xaa\xbb\xcc"

    frames = TAP._loader_01b6_preview(pulses, bytes(ram))["plausible_frames"]

    assert any(
        frame["start_address"] == 0x4000
        and frame["end_address_exclusive"] == 0x4003
        and frame["complete_payload"]
        and frame["runtime_exact_match"]
        for frame in frames
    )


def test_measured_loader_chains_frames_without_a_second_sync() -> None:
    # Two zero bytes, $16 sync, then two adjacent EAH/EAL/SAH/SAL frames.
    pulses = _loader_pulses_for_bytes(
        [
            0x00,
            0x00,
            0x16,
            0x40,
            0x02,
            0x40,
            0x00,
            0xAA,
            0xBB,
            0x40,
            0x04,
            0x40,
            0x02,
            0xCC,
            0xDD,
        ]
    )
    ram = bytearray(65536)
    ram[0x4000:0x4002] = b"\xaa\xbb"
    ram[0x4002:0x4004] = b"\xcc\xdd"

    chains = TAP._loader_01b6_chained_frames(pulses, bytes(ram))

    assert any(
        [(frame["start_address"], frame["end_address_exclusive"]) for frame in chain["frames"]] == [
            (0x4000, 0x4002),
            (0x4002, 0x4004),
        ]
        and all(frame["runtime_exact_match"] for frame in chain["frames"])
        for chain in chains
    )


def test_retained_jabato_side_a_kernal_packets_are_reproducible() -> None:
    tap_path = ROOT / "preservation_corpus/extracted/depth1_8dfc7ab2_Jabato (1989)(Aventuras AD)(Side A).tap"
    reference = ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_second_space_part1.ddb"

    result = TAP.inspect(tap_path, None, reference_ddb=reference.read_bytes())
    kernal = result["kernal_compatible_decoder"]
    adaptive = result["kernal_adaptive_decoder"]

    assert kernal["packet_count"] == 4
    assert [packet["byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert [packet["parity_valid_byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert kernal["packets"][0]["first_64_bytes_hex"].startswith("898887868584838281039f02c0034a414241544f2031")
    assert kernal["reference_prefix_matches"] == []
    profiles = result["segment_timing_profiles"]
    assert len(profiles) == 12
    assert profiles[0]["dominant_cycles"][0] == {"cycles": 384, "count": 18175, "tap_value": 48}
    assert profiles[2]["dominant_cycles"][0] == {"cycles": 280, "count": 1836, "tap_value": 35}
    assert adaptive["packet_count"] == 4
    assert [packet["byte_count"] for packet in adaptive["packets"]] == [202, 202, 299, 299]
    assert adaptive["servo"]["adjustment_count"] > 0


def test_retained_jabato_side_b_packets_and_runtime_frames_are_reproducible() -> None:
    tap_path = ROOT / "preservation_corpus/extracted/depth1_5114b2dd_Jabato (1989)(Aventuras AD)(Side B).tap"
    reference = ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_b_tap_post_input_12_part2.ddb"
    ram = ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_b_tap_post_input_12.ram"

    result = TAP.inspect(tap_path, None, validation_ram=ram.read_bytes(), reference_ddb=reference.read_bytes())
    kernal = result["kernal_compatible_decoder"]
    frames = result["measured_loader_01b6_plausible_frames"]
    exact = [frame for frame in frames if frame.get("runtime_exact_match")]

    assert kernal["packet_count"] == 4
    assert [packet["byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert [packet["parity_valid_byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert kernal["packets"][0]["first_64_bytes_hex"].startswith("898887868584838281039f02c0034a414241544f2032")
    assert len([frame for frame in frames if "runtime_exact_match" in frame]) == 3
    assert {(frame["segment_index"], frame["start_address"], frame["end_address_exclusive"]) for frame in exact} == {
        (7, 0xF800, 0xF900),
        (10, 0xA477, 0xA577),
    }

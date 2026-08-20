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


def test_kernal_decoder_recovers_parity_checked_synthetic_byte() -> None:
    result = TAP._kernal_packet_summary(_pulse_stream_for_byte(0xA5), b"\xA5")

    assert result["packet_count"] == 1
    assert result["packets"][0]["byte_count"] == 1
    assert result["packets"][0]["parity_valid_byte_count"] == 1
    assert result["packets"][0]["first_64_bytes_hex"] == "a5"
    assert result["reference_prefix_matches"][0]["matched_prefix_size"] == 1


def test_retained_jabato_side_a_kernal_packets_are_reproducible() -> None:
    tap_path = ROOT / "preservation_corpus/extracted/depth1_8dfc7ab2_Jabato (1989)(Aventuras AD)(Side A).tap"
    reference = ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_second_space_part1.ddb"

    result = TAP.inspect(tap_path, None, reference_ddb=reference.read_bytes())
    kernal = result["kernal_compatible_decoder"]

    assert kernal["packet_count"] == 4
    assert [packet["byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert [packet["parity_valid_byte_count"] for packet in kernal["packets"]] == [202, 202, 299, 299]
    assert kernal["packets"][0]["first_64_bytes_hex"].startswith("898887868584838281039f02c0034a414241544f2031")
    assert kernal["reference_prefix_matches"] == []
    profiles = result["segment_timing_profiles"]
    assert len(profiles) == 12
    assert profiles[0]["dominant_cycles"][0] == {"cycles": 384, "count": 18175, "tap_value": 48}
    assert profiles[2]["dominant_cycles"][0] == {"cycles": 280, "count": 1836, "tap_value": 35}

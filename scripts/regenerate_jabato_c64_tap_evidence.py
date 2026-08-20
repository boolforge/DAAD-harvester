#!/usr/bin/env python3
"""Regenerate or verify committed Jabato C64 raw-TAP evidence without emulation.

This command uses only the repository's native TAP analyzer, retained original
TAP images, committed 64 KiB RAM evidence, and materialized DDB fixtures. It
does not invoke VICE, c64tapedecode, or any other external decoder. Those tools
remain optional independent validators for acquisition-time evidence only.
"""

from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
ANALYZER = ROOT / "scripts" / "inspect_cbm_tap.py"


def _load_analyzer() -> object:
    spec = importlib.util.spec_from_file_location("inspect_cbm_tap", ANALYZER)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"unable to load native analyzer: {ANALYZER}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


CASES = (
    {
        "side": "A",
        "tap": ROOT / "preservation_corpus/extracted/depth1_8dfc7ab2_Jabato (1989)(Aventuras AD)(Side A).tap",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_a_tap_credits.ram",
        "ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_second_space_part1.ddb",
        "report": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_pulse_analysis.json",
        "exact_frame_count": 7,
    },
    {
        "side": "B",
        "tap": ROOT / "preservation_corpus/extracted/depth1_5114b2dd_Jabato (1989)(Aventuras AD)(Side B).tap",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_b_tap_post_input_12.ram",
        "ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_b_tap_post_input_12_part2.ddb",
        "report": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_b_tap_pulse_analysis.json",
        "exact_frame_count": 2,
    },
)


def _render_report(analyzer: object, case: dict[str, object]) -> str:
    tap = case["tap"]
    ram = case["ram"]
    ddb = case["ddb"]
    assert isinstance(tap, Path) and isinstance(ram, Path) and isinstance(ddb, Path)
    for path in (tap, ram, ddb):
        if not path.is_file():
            raise FileNotFoundError(f"required retained evidence is missing: {path.relative_to(ROOT)}")
    result = analyzer.inspect(tap, None, validation_ram=ram.read_bytes(), reference_ddb=ddb.read_bytes())
    fixed = result["kernal_compatible_decoder"]
    adaptive = result["kernal_adaptive_decoder"]
    if fixed["packet_count"] != 4 or adaptive["packet_count"] != 4:
        raise AssertionError(f"Side {case['side']}: expected four ROM bootstrap packets")
    if [packet["byte_count"] for packet in fixed["packets"]] != [202, 202, 299, 299]:
        raise AssertionError(f"Side {case['side']}: fixed bootstrap packet sizes differ")
    if [packet["byte_count"] for packet in adaptive["packets"]] != [202, 202, 299, 299]:
        raise AssertionError(f"Side {case['side']}: adaptive bootstrap packet sizes differ")
    exact = [
        frame
        for frame in result["measured_loader_01b6_plausible_frames"]
        if frame.get("runtime_exact_match")
    ]
    if len(exact) != case["exact_frame_count"]:
        raise AssertionError(
            f"Side {case['side']}: expected {case['exact_frame_count']} exact custom frames, found {len(exact)}"
        )
    return json.dumps(result, indent=2, sort_keys=True) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="Verify that the committed reports equal a native regeneration without modifying files.",
    )
    args = parser.parse_args()
    analyzer = _load_analyzer()
    for case in CASES:
        report = case["report"]
        assert isinstance(report, Path)
        rendered = _render_report(analyzer, case)
        if args.check:
            if not report.is_file() or report.read_text() != rendered:
                raise AssertionError(
                    f"Side {case['side']}: committed report differs; rerun {Path(__file__).name}"
                )
            print(f"Side {case['side']}: native evidence report verified")
        else:
            report.write_text(rendered)
            print(f"Side {case['side']}: native evidence report regenerated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

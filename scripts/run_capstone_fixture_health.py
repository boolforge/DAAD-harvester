#!/usr/bin/env python3
"""Health-check the pinned Capstone binding with controlled fixture bytes only.

This optional external-tool check never reads a DAAD artifact. It verifies the
documented Capstone binding API for x86 16-bit and Motorola 68000 decoding at
raw address zero, and reports the observed absence of a MOS 6502 architecture
constant in the pinned source. Its output is evidence about one tool build, not
recovered source, a load model, or runtime behavior.
"""

from __future__ import annotations

import hashlib
import json
import sys
from dataclasses import dataclass
from typing import Any


CAPSTONE_SOURCE_REVISION = "3a8d30a66726fd31990fa584f62fd30dcd9f9b50"


@dataclass(frozen=True)
class Fixture:
    architecture: str
    code_hex: str
    expected_instructions: tuple[tuple[int, str, str], ...]


FIXTURES = (
    Fixture("m68000", "4e714e75", ((0, "nop", ""), (2, "rts", ""))),
    Fixture("i8086", "90c3", ((0, "nop", ""), (1, "ret", ""))),
)


def _engine(capstone: Any, architecture: str) -> Any:
    if architecture == "m68000":
        return capstone.Cs(
            capstone.CS_ARCH_M68K,
            capstone.CS_MODE_BIG_ENDIAN | capstone.CS_MODE_M68K_000,
        )
    if architecture == "i8086":
        return capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_16)
    raise ValueError(f"unsupported fixture architecture: {architecture}")


def _decode(capstone: Any, fixture: Fixture) -> dict[str, Any]:
    code = bytes.fromhex(fixture.code_hex)
    decoded = tuple((instruction.address, instruction.mnemonic, instruction.op_str) for instruction in _engine(capstone, fixture.architecture).disasm(code, 0))
    if decoded != fixture.expected_instructions:
        raise RuntimeError(
            f"{fixture.architecture}: decoded instructions differ from the pinned health expectation: {decoded!r}"
        )
    return {
        "architecture": fixture.architecture,
        "fixture_hex": fixture.code_hex,
        "fixture_sha256": hashlib.sha256(code).hexdigest(),
        "decoded_instructions": [list(instruction) for instruction in decoded],
    }


def run() -> dict[str, Any]:
    try:
        import capstone
    except ImportError as exc:
        raise RuntimeError("Capstone Python bindings are not installed; install the pinned source binding before this optional health check") from exc

    first = [_decode(capstone, fixture) for fixture in FIXTURES]
    second = [_decode(capstone, fixture) for fixture in FIXTURES]
    if first != second:
        raise RuntimeError("Capstone fixture decoding was not deterministic across two in-process runs")

    return {
        "schema_version": 1,
        "tool": "Capstone",
        "source_revision": CAPSTONE_SOURCE_REVISION,
        "binding_version": capstone.__version__,
        "fixtures": first,
        "unsupported_architectures": {
            "mos6502": "CS_ARCH_M6502 is absent from the pinned binding",
            "mos8501": "CS_ARCH_M6502 is absent from the pinned binding; MOS 8501 must not be substituted silently"
        },
        "non_claim": "Controlled fixture decoding at raw address zero is not recovered source, an evidenced CPU profile for retained DAAD bytes, a load model, or runtime behavior."
    }


def main() -> int:
    try:
        print(json.dumps(run(), indent=2, sort_keys=True))
    except RuntimeError as exc:
        print(f"Capstone fixture health check failed: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

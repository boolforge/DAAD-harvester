from __future__ import annotations

import sys
from types import SimpleNamespace

import pytest

from scripts import run_capstone_fixture_health


class _Instruction:
    def __init__(self, address: int, mnemonic: str, op_str: str = "") -> None:
        self.address = address
        self.mnemonic = mnemonic
        self.op_str = op_str


class _Engine:
    def __init__(self, instructions: list[_Instruction]) -> None:
        self._instructions = instructions

    def disasm(self, code: bytes, address: int):
        assert address == 0
        return iter(self._instructions)


class _CapstoneBinding:
    CS_ARCH_M68K = 1
    CS_ARCH_X86 = 2
    CS_MODE_BIG_ENDIAN = 4
    CS_MODE_M68K_000 = 8
    CS_MODE_16 = 16
    __version__ = "6.0.0"

    @staticmethod
    def Cs(architecture: int, mode: int) -> _Engine:
        if architecture == _CapstoneBinding.CS_ARCH_M68K:
            assert mode == _CapstoneBinding.CS_MODE_BIG_ENDIAN | _CapstoneBinding.CS_MODE_M68K_000
            return _Engine([_Instruction(0, "nop"), _Instruction(2, "rts")])
        assert architecture == _CapstoneBinding.CS_ARCH_X86
        assert mode == _CapstoneBinding.CS_MODE_16
        return _Engine([_Instruction(0, "nop"), _Instruction(1, "ret")])


def test_capstone_fixture_harness_records_only_controlled_x86_and_m68000_results(monkeypatch) -> None:
    monkeypatch.setitem(sys.modules, "capstone", _CapstoneBinding)

    result = run_capstone_fixture_health.run()

    assert result["source_revision"] == "3a8d30a66726fd31990fa584f62fd30dcd9f9b50"
    assert [fixture["architecture"] for fixture in result["fixtures"]] == ["m68000", "i8086"]
    assert result["fixtures"][0]["decoded_instructions"] == [[0, "nop", ""], [2, "rts", ""]]
    assert "absent" in result["unsupported_architectures"]["mos6502"]
    assert "must not be substituted" in result["unsupported_architectures"]["mos8501"]
    assert "not recovered source" in result["non_claim"]


def test_capstone_fixture_harness_rejects_an_unexpected_decode(monkeypatch) -> None:
    monkeypatch.setitem(sys.modules, "capstone", _CapstoneBinding)
    monkeypatch.setattr(run_capstone_fixture_health, "_engine", lambda capstone, architecture: _Engine([_Instruction(0, "wrong")]))

    with pytest.raises(RuntimeError, match="differ from the pinned health expectation"):
        run_capstone_fixture_health.run()

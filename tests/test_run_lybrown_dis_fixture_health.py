from __future__ import annotations

import subprocess
from pathlib import Path

import pytest

from scripts import run_lybrown_dis_fixture_health


def test_health_harness_requires_the_exact_pinned_script(tmp_path: Path) -> None:
    script = tmp_path / "dis"
    script.write_text("not the pinned script\n", encoding="utf-8")

    with pytest.raises(RuntimeError, match="SHA-256"):
        run_lybrown_dis_fixture_health.run(script)


def test_health_harness_records_deterministic_mos6502_listing_and_refuses_mos8501(tmp_path: Path, monkeypatch) -> None:
    script = tmp_path / "dis"
    script.write_text("pinned content", encoding="utf-8")
    monkeypatch.setattr(run_lybrown_dis_fixture_health, "sha256_file", lambda path: run_lybrown_dis_fixture_health.SCRIPT_SHA256)
    calls: list[list[str]] = []

    def fake_run(command: list[str], **kwargs: object) -> subprocess.CompletedProcess[str]:
        calls.append(command)
        return subprocess.CompletedProcess(command, 0, stdout=run_lybrown_dis_fixture_health.EXPECTED_LISTING, stderr="")

    monkeypatch.setattr(run_lybrown_dis_fixture_health.subprocess, "run", fake_run)
    result = run_lybrown_dis_fixture_health.run(script)

    assert len(calls) == 2
    assert calls[0][1:6] == ["-t", "raw", "-o", "0000", "-c"]
    assert result["architecture"] == "mos6502"
    assert result["fixture_sha256"] == "c45e396ba1d4efd0ae131ef11e13a3eafabc904f8deb603b394344652b68d8b7"
    assert "No MOS 8501" in result["unsupported_architectures"]["mos8501"]


def test_health_harness_rejects_unexpected_listing(tmp_path: Path, monkeypatch) -> None:
    script = tmp_path / "dis"
    script.write_text("pinned content", encoding="utf-8")
    monkeypatch.setattr(run_lybrown_dis_fixture_health, "sha256_file", lambda path: run_lybrown_dis_fixture_health.SCRIPT_SHA256)
    monkeypatch.setattr(
        run_lybrown_dis_fixture_health.subprocess,
        "run",
        lambda command, **kwargs: subprocess.CompletedProcess(command, 0, stdout="wrong\n", stderr=""),
    )

    with pytest.raises(RuntimeError, match="listing differs"):
        run_lybrown_dis_fixture_health.run(script)

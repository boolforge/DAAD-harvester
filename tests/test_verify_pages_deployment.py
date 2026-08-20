"""Regression coverage for public GitHub Pages deployment verification."""

from __future__ import annotations

import hashlib
import json
from unittest.mock import patch

import pytest

from scripts import verify_pages_deployment


def _report_bytes() -> bytes:
    return json.dumps({"summary": {"all_sources": 250, "measured_artifacts": 678}}).encode("utf-8")


def test_verify_once_accepts_measured_matching_report_and_documentation() -> None:
    report = _report_bytes()
    with patch.object(
        verify_pages_deployment,
        "fetch",
        side_effect=[b"<title>DAAD Harvester</title>", report, b"<h1>Documentation index</h1>Clone-to-Contribution"],
    ):
        verify_pages_deployment.verify_once(
            base_url="https://example.invalid/DAAD-harvester/",
            documentation_url="https://example.invalid/DAAD-harvester/documentation/index.html",
            minimum_sources=250,
            minimum_artifacts=678,
            expected_report_sha256=hashlib.sha256(report).hexdigest(),
        )


def test_verify_once_rejects_stale_report_hash() -> None:
    report = _report_bytes()
    with patch.object(
        verify_pages_deployment,
        "fetch",
        side_effect=[b"DAAD Harvester", report],
    ), pytest.raises(RuntimeError, match="hash does not match"):
        verify_pages_deployment.verify_once(
            base_url="https://example.invalid/DAAD-harvester/",
            documentation_url="https://example.invalid/DAAD-harvester/documentation/index.html",
            minimum_sources=1,
            minimum_artifacts=1,
            expected_report_sha256="0" * 64,
        )

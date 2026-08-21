"""Verify deterministic repository-native format generator fixtures.

The primary workflow uses this script to prove that promoted native generators
still emit their pinned fixture bytes and satisfy their independent structural
validators. It performs no network access or external-tool invocation.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from typing import Sequence

from daad_harvester.dsk_generation import build_blank_cpc_system_dsk
from daad_harvester.media_inspection import inspect_native_media


# Updated only through a reviewed fixture-generation change.
BLANK_CPC_SYSTEM_SHA256 = "ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b"


def generated_fixture_evidence() -> dict[str, object]:
    """Return canonical evidence for the first promoted native generator."""

    payload = build_blank_cpc_system_dsk()
    inspection = inspect_native_media("generated-blank-cpc-system.dsk", payload)
    return {
        "schema_version": 1,
        "generator_id": "extended-dsk-blank-cpc-system-v1",
        "technical_medium": "extended_cpc_dsk",
        "status": "generated_structurally_valid",
        "inputs": {
            "creator": "DAAD-HARVEST",
            "profile": "blank_cpc_system_40x1_9x512",
            "filesystem_claim": "none",
        },
        "output": {
            "byte_length": len(payload),
            "sha256": hashlib.sha256(payload).hexdigest(),
            "md5_full": hashlib.md5(payload).hexdigest(),
        },
        "native_validation": {
            "parser": inspection.parser,
            "status": inspection.status,
            "validation": inspection.validation,
            "evidence": inspection.evidence,
        },
        "comparison_boundary": {
            "adp": "source_crosswalk_only",
            "authentic_release": "not_applicable_blank_fixture",
            "emulator": "not_applicable_container_fixture",
        },
    }


def verify() -> dict[str, object]:
    """Validate the promoted fixture and return its canonical evidence."""

    evidence = generated_fixture_evidence()
    output = evidence["output"]
    validation = evidence["native_validation"]
    assert isinstance(output, dict)
    assert isinstance(validation, dict)
    if BLANK_CPC_SYSTEM_SHA256 == "PENDING":
        raise RuntimeError(
            "BLANK_CPC_SYSTEM_SHA256 is not pinned; run with --print-evidence "
            "and review the reported output before updating the verifier"
        )
    if output["sha256"] != BLANK_CPC_SYSTEM_SHA256:
        raise RuntimeError(
            "native Extended DSK fixture SHA-256 differs: "
            f"expected {BLANK_CPC_SYSTEM_SHA256}, got {output['sha256']}"
        )
    if validation["validation"] != "validated_cpc_dsk_track_stream":
        raise RuntimeError(f"native Extended DSK fixture failed inspection: {validation}")
    return evidence


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--print-evidence",
        action="store_true",
        help="print canonical fixture evidence without requiring the pinned SHA-256",
    )
    args = parser.parse_args(argv)
    evidence = generated_fixture_evidence() if args.print_evidence else verify()
    print(json.dumps(evidence, sort_keys=True, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

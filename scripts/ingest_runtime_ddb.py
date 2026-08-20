#!/usr/bin/env python3
"""Materialize one structurally verified DDB from a retained emulator RAM image.

The script deliberately accepts a measured RAM range only after the target-aware
DAAD parser validates it.  It records the emulator-RAM origin, byte range,
expected hash, and structural result in the normal corpus artifact ledger.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

from daad_harvester.daad_parser import DAADBytecodeParser
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.unpack import compute_hashes


def ingest(
    db: Database,
    *,
    source_id: int,
    ram_path: Path,
    output_path: Path,
    filename: str,
    offset: int,
    expected_sha256: str | None = None,
) -> dict[str, object]:
    """Validate and retain one target-addressed DDB from a fixed RAM capture."""
    ram = ram_path.read_bytes()
    if len(ram) != 65_536:
        raise ValueError(f"RAM image must be 65536 bytes, got {len(ram)}")
    parser = DAADBytecodeParser()
    validated = parser._validate_at(ram, offset, {"format": "vice_runtime_ram"}, allow_trailing=True)
    if validated is None:
        validated = parser._validate_at(
            ram, offset, {"format": "vice_runtime_ram"}, allow_trailing=True, legacy=True
        )
    if validated is None:
        raise ValueError(f"no structurally valid DDB at RAM offset 0x{offset:04x}")

    size = int(validated["payload_size"])
    payload = ram[offset:offset + size]
    analysis = parser.parse_ddb(payload, filename)
    if not analysis["is_daad"]:
        raise ValueError(f"bounded payload failed standalone validation: {analysis['reason']}")
    digest = hashlib.sha256(payload).hexdigest()
    if expected_sha256 is not None and digest != expected_sha256:
        raise ValueError(f"SHA-256 mismatch: expected {expected_sha256}, got {digest}")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(payload)
    hashes = compute_hashes(payload)
    details = analysis["details"]
    header = details["header"]
    evidence = {
        "origin_kind": "emulator_ram_range",
        "ram_path": str(ram_path),
        "ram_sha256": hashlib.sha256(ram).hexdigest(),
        "ram_offset": offset,
        "ram_offset_hex": f"0x{offset:04x}",
        "range_end_exclusive": offset + size,
        "range_end_exclusive_hex": f"0x{offset + size:04x}",
        "expected_sha256": expected_sha256,
        "structural_analysis": details,
    }
    artifact = ArtifactRecord(
        id=None,
        source_id=source_id,
        original_filename=filename,
        extracted_path=str(output_path.resolve()),
        archive_depth=3,
        file_size=len(payload),
        md5_full=hashes["md5_full"],
        md5_5000=hashes["md5_5000"],
        sha256=hashes["sha256"],
        sha1=hashes["sha1"],
        crc32=hashes["crc32"],
        md5_tail5000=hashes["md5_tail5000"],
        sha224=hashes["sha224"],
        sha384=hashes["sha384"],
        sha512=hashes["sha512"],
        sha3_256=hashes["sha3_256"],
        sha3_512=hashes["sha3_512"],
        blake2b=hashes["blake2b"],
        blake2s=hashes["blake2s"],
        adler32=hashes["adler32"],
        xxh32=hashes["xxh32"],
        xxh64=hashes["xxh64"],
        xxh128=hashes["xxh128"],
        unpacked=True,
        is_daad_payload=True,
        daad_version_guess=str(analysis["version"]),
        platform_hint=str(analysis["platform"]),
        language=str(analysis["language"]),
        container_format="vice-runtime-ram",
        container_member=f"{ram_path.name}:0x{offset:04x}-0x{offset + size - 1:04x}",
        measured_platform=str(analysis["platform"]),
        ddb_format=str(analysis["ddb_format"]),
        ddb_major_version=int(analysis["ddb_major_version"]),
        fingerprint_confidence=str(analysis["confidence_label"]),
        fingerprint_evidence_json=json.dumps(details, sort_keys=True),
        media_parser="vice-runtime-ddb-ingest",
        media_status="runtime_recovered",
        media_validation="target_aware_structural_and_hash_validated",
        media_evidence_json=json.dumps(evidence, sort_keys=True),
    )
    artifact_id = db.add_artifact(artifact)
    return {
        "artifact_id": artifact_id,
        "output_path": str(output_path),
        "offset": offset,
        "size": size,
        "sha256": digest,
        "ddb_format": analysis["ddb_format"],
        "platform": analysis["platform"],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, required=True)
    parser.add_argument("--source-id", type=int, required=True)
    parser.add_argument("--ram", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--filename", required=True)
    parser.add_argument("--offset", type=lambda value: int(value, 0), required=True)
    parser.add_argument("--expected-sha256")
    args = parser.parse_args()
    result = ingest(
        Database(args.database),
        source_id=args.source_id,
        ram_path=args.ram,
        output_path=args.output,
        filename=args.filename,
        offset=args.offset,
        expected_sha256=args.expected_sha256,
    )
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

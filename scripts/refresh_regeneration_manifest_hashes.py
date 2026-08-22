#!/usr/bin/env python3
"""Refresh hash pins for selected, already-regenerated native manifest entries.

This command never runs regeneration commands and never accesses the network.  It
only records the current SHA-256 values of files already declared by selected
entries.  Callers must run the affected native generators and focused validation
first, then review the manifest diff before committing.

    python scripts/refresh_regeneration_manifest_hashes.py --id static-preservation-report
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST = ROOT / "preservation_corpus" / "regeneration_manifest.json"


def sha256(path: Path) -> str:
    """Return the complete SHA-256 digest of one declared repository file."""

    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def refresh(manifest: dict[str, object], identifiers: set[str]) -> dict[str, object]:
    """Return an updated manifest for exactly the requested native entry IDs."""

    entries = manifest.get("entries")
    if not isinstance(entries, list):
        raise ValueError("manifest has no entries list")
    available = {entry.get("id") for entry in entries if isinstance(entry, dict)}
    unknown = identifiers - available
    if unknown:
        raise ValueError(f"unknown regeneration manifest IDs: {sorted(unknown)!r}")

    for entry in entries:
        if not isinstance(entry, dict) or entry.get("id") not in identifiers:
            continue
        for section in ("inputs", "outputs"):
            records = entry.get(section)
            if not isinstance(records, list):
                raise ValueError(f"{entry['id']}: {section} is not a list")
            for record in records:
                if not isinstance(record, dict) or not isinstance(record.get("path"), str):
                    raise ValueError(f"{entry['id']}: invalid {section} record")
                path = (ROOT / record["path"]).resolve()
                if ROOT not in path.parents or not path.is_file():
                    raise ValueError(f"{entry['id']}: declared path is unavailable: {record['path']}")
                record["sha256"] = sha256(path)
    return manifest


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--id", action="append", required=True, help="native manifest entry ID to refresh; repeatable")
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    args = parser.parse_args(argv)

    manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
    refreshed = refresh(manifest, set(args.id))
    args.manifest.write_text(json.dumps(refreshed, indent=2) + "\n", encoding="utf-8")
    print(f"Regeneration manifest hashes refreshed: {', '.join(sorted(set(args.id)))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

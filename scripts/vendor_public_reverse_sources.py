#!/usr/bin/env python3
"""Vendor public DAAD-related source material with a provenance manifest.

Only source, build, documentation, and license files are copied. Binary release
payloads are deliberately excluded and remain governed by their own manifests.
"""

from __future__ import annotations

import hashlib
import json
import shutil
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / ".audit"
DESTINATION = ROOT / "reverse_engineering" / "public_sources"
MANIFEST = ROOT / "reverse_engineering" / "manifests" / "public_sources.json"
TEXT_EXTENSIONS = {
    ".asm", ".bas", ".bat", ".c", ".cfg", ".cmd", ".h", ".inc", ".ini", ".json",
    ".md", ".pas", ".php", ".py", ".sh", ".txt", ".xml", ".yaml", ".yml",
}
TEXT_NAMES = {"license", "license.txt", "copying", "readme", "readme.md", "makefile"}
SOURCES = (
    {
        "id": "drc-public-source",
        "workspace": "upstream-drc",
        "repository": "https://github.com/daad-adventure-writer/daad",
        "revision": "e7bb170ef94e7b4965c0719b497638cec7aeaca9",
        "license": "GPL-3.0",
        "classification": "public_derivative_source",
    },
    {
        "id": "msx2daad-public-source",
        "workspace": "upstream-msx2daad",
        "repository": "https://github.com/nataliapc/msx2daad",
        "revision": "afdd6d21406107bd2fcb969cbf2f06f234717ecf",
        "license": "project license; retained verbatim in source mirror",
        "classification": "public_derivative_source",
    },
    {
        "id": "maluva-public-source",
        "workspace": "upstream-maluva",
        "repository": "https://github.com/Utodev/MALUVA",
        "revision": "6f4d1291a0bfb0b000f5cc68922108253218dd18",
        "license": "LGPL-3.0",
        "classification": "public_derivative_source",
    },
    {
        "id": "pcdaad-public-source",
        "workspace": "upstream-pcdaad",
        "repository": "https://github.com/Utodev/PCDAAD",
        "revision": "687ef2b67abebc23bdabb903165b372e47970968",
        "license": "MIT",
        "classification": "public_derivative_source",
    },
    {
        "id": "undaad-public-source",
        "workspace": "upstream-undaad",
        "repository": "https://github.com/Utodev/undaad",
        "revision": "8918bbff74da6ef2c52c8560657958cd5704e4a8",
        "license": "LGPL-3.0",
        "classification": "public_derivative_source",
    },
    {
        "id": "daad-ready-public-source-material",
        "workspace": "upstream-daad-ready",
        "repository": "https://github.com/daad-adventure-writer/daad-ready",
        "revision": "c2c77580455981de4f2d782fc01aaee0d4bdcb2c",
        "license": "component-specific; retained license files define scope",
        "classification": "public_derivative_source",
    },
)


def should_copy(path: Path) -> bool:
    return path.name.casefold() in TEXT_NAMES or path.suffix.casefold() in TEXT_EXTENSIONS


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> int:
    DESTINATION.mkdir(parents=True, exist_ok=True)
    entries: list[dict[str, object]] = []
    for source in SOURCES:
        workspace = AUDIT / str(source["workspace"])
        target = DESTINATION / str(source["id"])
        if not workspace.is_dir():
            raise RuntimeError(f"Missing public source workspace: {workspace}")
        if target.exists():
            shutil.rmtree(target)
        copied: list[dict[str, str]] = []
        for path in sorted(workspace.rglob("*")):
            if not path.is_file() or ".git" in path.parts or not should_copy(path):
                continue
            relative = path.relative_to(workspace)
            destination = target / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(path, destination)
            copied.append({"path": str(relative), "sha256": sha256(destination)})
        entries.append({**source, "storage": str(target.relative_to(ROOT)), "file_count": len(copied), "files": copied})
    manifest = {
        "schema_version": 1,
        "purpose": "Public DAAD-related source mirrors for reverse-engineering comparison",
        "non_claim": "These are public derivative/source materials, not recovered original interpreter source.",
        "official_original_source": {
            "repository": "https://github.com/daad-adventure-writer/daad",
            "revision": "4a7e745235a12af5b397902dbd9214bc930c7680",
            "status": "not_provided_in_public_distribution",
        },
        "sources": entries,
    }
    MANIFEST.parent.mkdir(parents=True, exist_ok=True)
    MANIFEST.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Mirrored {sum(int(item['file_count']) for item in entries)} public source files across {len(entries)} workspaces.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

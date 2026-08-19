#!/usr/bin/env python3
"""Materialize the documented-authorized official interpreter corpus reproducibly.

This script does not execute, modify, or decompile copied inputs. It copies only
profiles with exact SHA-256 anchors from the retained official distribution and
writes a machine-readable manifest for later analysis tools.
"""

from __future__ import annotations

import hashlib
import json
import shutil
from datetime import date
from pathlib import Path

from daad_harvester.interpreter_profiles import OFFICIAL_INTERPRETER_PROFILES


ROOT = Path(__file__).resolve().parents[1]
OFFICIAL_REVISION = "4a7e745235a12af5b397902dbd9214bc930c7680"
SOURCE_ROOT = ROOT / ".audit" / "upstream-daad" / "Interpreters"
OUTPUT_ROOT = ROOT / "reverse_engineering" / "artifacts" / "original"
MANIFEST_PATH = ROOT / "reverse_engineering" / "manifests" / "official_interpreters.json"
PLATFORM_DIRECTORIES = {
    "zx": "Spectrum",
    "cpc": "CPC",
    "c64": "C64",
    "plus4": "Plus4",
    "msx": "MSX",
    "pcw": "PCW",
    "atarist": "ST",
    "amiga": "Amiga",
    "dos": "DOS",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_member(platform: str, filenames: tuple[str, ...]) -> Path:
    directory = SOURCE_ROOT / PLATFORM_DIRECTORIES[platform]
    wanted = {name.casefold() for name in filenames}
    matches = [path for path in directory.iterdir() if path.is_file() and path.name.casefold() in wanted]
    if len(matches) != 1:
        raise RuntimeError(f"Expected exactly one member for {platform}/{filenames}; found {matches}")
    return matches[0]


def main() -> int:
    if not SOURCE_ROOT.is_dir():
        raise RuntimeError(f"Missing retained official source tree: {SOURCE_ROOT}")
    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
    MANIFEST_PATH.parent.mkdir(parents=True, exist_ok=True)
    entries: list[dict[str, object]] = []
    for profile in OFFICIAL_INTERPRETER_PROFILES:
        if not profile.sha256:
            continue
        source = source_member(profile.platform, profile.filenames)
        observed_hash = sha256(source)
        if observed_hash != profile.sha256:
            raise RuntimeError(f"Hash mismatch for {profile.profile_id}: {observed_hash} != {profile.sha256}")
        destination = OUTPUT_ROOT / profile.platform / profile.profile_id / source.name
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, destination)
        copied_hash = sha256(destination)
        if copied_hash != observed_hash:
            raise RuntimeError(f"Copy mismatch for {profile.profile_id}")
        entries.append(
            {
                "artifact_id": profile.profile_id,
                "artifact_class": "original_binary",
                "platform": profile.platform,
                "architecture": {
                    "zx": "z80", "cpc": "z80", "msx": "z80", "pcw": "z80",
                    "c64": "mos6502", "plus4": "mos8501",
                    "atarist": "m68000", "amiga": "m68000", "dos": "i8086",
                }[profile.platform],
                "sha256": copied_hash,
                "file_size": destination.stat().st_size,
                "origin": {
                    "repository": "https://github.com/daad-adventure-writer/daad",
                    "revision": OFFICIAL_REVISION,
                    "member_path": str(source.relative_to(ROOT / ".audit" / "upstream-daad")),
                    "observed_filename": source.name,
                },
                "authorization": {
                    "state": "permission_recorded",
                    "evidence_ref": "User-documented authorization received 2026-08-19; retained by repository owner.",
                    "redistribution": "authorized_by_documented_permission",
                    "decision_date": str(date.today()),
                },
                "storage": {"status": "authorized_retained", "path": str(destination.relative_to(ROOT))},
                "analysis": [],
                "language": profile.language,
                "interpreter_version": profile.interpreter_version,
            }
        )
    manifest = {
        "schema_version": 1,
        "purpose": "Documented-authorized official DAAD interpreter artifact inventory",
        "source_revision": OFFICIAL_REVISION,
        "entry_count": len(entries),
        "artifacts": entries,
    }
    MANIFEST_PATH.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Wrote {len(entries)} original interpreter artifacts and manifest {MANIFEST_PATH.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

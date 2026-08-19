#!/usr/bin/env python3
"""Mirror the complete pinned ADP implementation and release assets into the corpus."""

from __future__ import annotations

import hashlib
import json
import shutil
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
UPSTREAM = ROOT / ".audit" / "upstream-adp"
RELEASES = ROOT / ".audit" / "upstream-adp-release-assets"
DESTINATION = ROOT / "reverse_engineering" / "public_implementations" / "adp"
MANIFEST = ROOT / "reverse_engineering" / "manifests" / "adp_implementation.json"
REVISION = "379a6710de11a2378f3d76c25a4d71bca75073bf"


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def mirror_tree(source: Path, destination: Path) -> list[dict[str, object]]:
    if destination.exists():
        shutil.rmtree(destination)
    copied: list[dict[str, object]] = []
    for path in sorted(source.rglob("*")):
        if not path.is_file() or ".git" in path.parts:
            continue
        relative = path.relative_to(source)
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(path, target)
        copied.append({"path": str(relative), "size": target.stat().st_size, "sha256": digest(target)})
    return copied


def main() -> int:
    if not UPSTREAM.is_dir():
        raise RuntimeError(f"Missing pinned ADP source workspace: {UPSTREAM}")
    if not RELEASES.is_dir():
        raise RuntimeError(f"Missing downloaded ADP releases workspace: {RELEASES}")
    source_files = mirror_tree(UPSTREAM, DESTINATION / "source")
    release_files = mirror_tree(RELEASES, DESTINATION / "releases")
    manifest = {
        "schema_version": 1,
        "id": "adp-public-implementation",
        "classification": "public_derivative_implementation",
        "repository": "https://github.com/jlcebrian/ADP",
        "revision": REVISION,
        "project_license": {"path": "docs/LICENSE", "spdx": "MIT", "scope": "ADP project source and documentation; bundled component notices remain preserved in the mirror."},
        "stated_scope": "Portable DAAD interpreter/toolchain for 16-bit games with experimental 8-bit DAAD and PAWS support; builds for modern systems, web, MS-DOS, Amiga, and Atari ST.",
        "source_storage": str((DESTINATION / "source").relative_to(ROOT)),
        "release_storage": str((DESTINATION / "releases").relative_to(ROOT)),
        "source_file_count": len(source_files),
        "release_file_count": len(release_files),
        "source_files": source_files,
        "release_files": release_files,
        "non_claim": "ADP is a modern public implementation. Its source and release artifacts are not recovered source or binary-identical substitutes for historical official DAAD interpreters.",
    }
    MANIFEST.parent.mkdir(parents=True, exist_ok=True)
    MANIFEST.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Mirrored {len(source_files)} ADP source files and {len(release_files)} ADP release assets.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

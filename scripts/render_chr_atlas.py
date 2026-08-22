"""Render a checksum-pinned glyph atlas from a validated legacy ADP-writer CHR file.

The output preserves glyph byte-index order only. It deliberately does not claim a
character code page, text mapping, or runtime bundle relationship.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Sequence

from daad_harvester.chr_generation import render_adp_chr_glyph_atlas


def sha256(data: bytes) -> str:
    """Return the complete SHA-256 identity for retained or derived bytes."""

    return hashlib.sha256(data).hexdigest()


def build_manifest(input_path: Path, output_path: Path, metadata_path: Path, *, scale: int = 1) -> tuple[bytes, bytes, dict[str, object]]:
    """Return deterministic atlas bytes, manifest bytes, and parsed evidence without writing."""

    source = input_path.read_bytes()
    atlas, evidence = render_adp_chr_glyph_atlas(source, scale=scale)
    manifest: dict[str, object] = {
        "schema_version": 1,
        "source_path": str(input_path),
        "source_sha256": sha256(source),
        "derived_path": str(output_path),
        "derived_sha256": sha256(atlas),
        "regeneration_command": (
            f"python scripts/render_chr_atlas.py --input {input_path} "
            f"--output {output_path} --metadata {metadata_path} --scale {scale}"
        ),
        "evidence": evidence,
    }
    return atlas, json.dumps(manifest, indent=2, sort_keys=True).encode("utf-8") + b"\n", manifest


def render(input_path: Path, output_path: Path, metadata_path: Path, *, scale: int = 1) -> dict[str, object]:
    """Render one validated CHR atlas and write a deterministic evidence manifest."""

    atlas, manifest_bytes, manifest = build_manifest(input_path, output_path, metadata_path, scale=scale)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(atlas)
    metadata_path.parent.mkdir(parents=True, exist_ok=True)
    metadata_path.write_bytes(manifest_bytes)
    return manifest


def check(input_path: Path, output_path: Path, metadata_path: Path, *, scale: int = 1) -> None:
    """Reject a missing or stale atlas/manifest pair without modifying repository state."""

    atlas, manifest_bytes, _ = build_manifest(input_path, output_path, metadata_path, scale=scale)
    if not output_path.is_file() or output_path.read_bytes() != atlas:
        raise ValueError(f"atlas output is missing or differs from deterministic regeneration: {output_path}")
    if not metadata_path.is_file() or metadata_path.read_bytes() != manifest_bytes:
        raise ValueError(f"atlas manifest is missing or differs from deterministic regeneration: {metadata_path}")


def main(argv: Sequence[str] | None = None) -> int:
    """Expose deterministic atlas rendering without an implicit output location."""

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="Validated ADP-writer CHR input")
    parser.add_argument("--output", type=Path, required=True, help="Output grayscale PNG atlas")
    parser.add_argument("--metadata", type=Path, required=True, help="Output JSON checksum/provenance manifest")
    parser.add_argument("--scale", type=int, default=1, help="Positive integer glyph-pixel scale")
    parser.add_argument("--check", action="store_true", help="Verify existing outputs without writing them")
    args = parser.parse_args(argv)
    if args.check:
        check(args.input, args.output, args.metadata, scale=args.scale)
    else:
        render(args.input, args.output, args.metadata, scale=args.scale)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

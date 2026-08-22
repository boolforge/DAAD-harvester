#!/usr/bin/env python3
"""Validate the repository's portable agent-skill scaffold."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST = ROOT / "skills" / "manifest.json"


def validate(manifest_path: Path = DEFAULT_MANIFEST) -> list[str]:
    errors: list[str] = []
    try:
        manifest: dict[str, Any] = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        return [f"manifest unreadable: {exc}"]
    skills = manifest.get("skills")
    if not isinstance(skills, list) or not skills:
        return ["manifest has no skills"]
    names = []
    for entry in skills:
        if not isinstance(entry, dict):
            errors.append("skill entry is not an object")
            continue
        name = entry.get("name")
        path_text = entry.get("path")
        names.append(name)
        if not isinstance(name, str) or not re.fullmatch(r"[a-z0-9-]+", name):
            errors.append(f"invalid skill name: {name!r}")
            continue
        if entry.get("always") is not True:
            errors.append(f"skill is not mandatory: {name}")
        if not isinstance(path_text, str):
            errors.append(f"missing path: {name}")
            continue
        path = ROOT / path_text
        if not path.is_file():
            errors.append(f"missing SKILL.md: {path_text}")
            continue
        text = path.read_text(encoding="utf-8")
        frontmatter = re.match(r"\A---\nname: ([^\n]+)\ndescription: ([^\n]+)\n---\n", text)
        if not frontmatter:
            errors.append(f"invalid frontmatter: {path_text}")
        elif frontmatter.group(1) != name or not frontmatter.group(2).strip():
            errors.append(f"frontmatter mismatch or placeholder: {path_text}")
        if "[TODO:" in text:
            errors.append(f"placeholder remains: {path_text}")
    if len(names) != len(set(names)):
        errors.append("duplicate skill names")
    required_order = manifest.get("required_order")
    if required_order != names:
        errors.append("required_order does not match skills order")
    if manifest.get("usage_policy", "").find("every repository operation") < 0:
        errors.append("usage policy does not require use for every repository operation")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    args = parser.parse_args()
    errors = validate(args.manifest)
    if errors:
        print("Skill scaffold validation failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(f"Skill scaffold verified: {len(json.loads(args.manifest.read_text(encoding='utf-8'))['skills'])} mandatory portable skills.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

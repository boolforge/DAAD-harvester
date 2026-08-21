"""Reject obvious non-English markers in project-authored tracked text.

Authentic source mirrors and retained preservation bytes are intentionally
excluded: changing their historical-language content would damage provenance or
hash identity. This check is a deterministic drift guard, not a language model.
"""

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
EXCLUDED_PREFIXES = (
    "preservation_corpus/",
    "reverse_engineering/public_sources/",
    "reverse_engineering/public_implementations/",
)
TEXT_SUFFIXES = {".md", ".py", ".json", ".yml", ".yaml", ".toml", ".ini", ".txt"}
NON_ENGLISH_MARKER = re.compile(r"[¿¡áéíóúüñÁÉÍÓÚÜÑ]")
AUTHENTIC_PROPER_NOUNS = (
    "Diseñador de Aventuras AD",
    "Chichén Itzá",
    "La Estrella de la Mañana",
    "Doña Elisa de Avalón",
)


def tracked_authored_text_paths() -> list[Path]:
    """Return deterministic tracked authored text paths, excluding source evidence."""

    output = subprocess.check_output(["git", "ls-files"], cwd=ROOT, text=True)
    paths: list[Path] = []
    for raw in output.splitlines():
        if raw.startswith(EXCLUDED_PREFIXES) or Path(raw).suffix.lower() not in TEXT_SUFFIXES:
            continue
        paths.append(ROOT / raw)
    return sorted(paths)


def main() -> int:
    """Report stable file/line findings for obvious authored-language drift."""

    findings: list[str] = []
    for path in tracked_authored_text_paths():
        text = path.read_text(encoding="utf-8", errors="replace")
        for line_number, line in enumerate(text.splitlines(), start=1):
            normalized = line
            for proper_noun in AUTHENTIC_PROPER_NOUNS:
                normalized = normalized.replace(proper_noun, "")
            if NON_ENGLISH_MARKER.search(normalized):
                findings.append(f"{path.relative_to(ROOT)}:{line_number}: {line.strip()}")
    if findings:
        print("American English check failed:")
        print("\n".join(f"- {finding}" for finding in findings))
        return 1
    print(f"American English check passed: {len(tracked_authored_text_paths())} authored text files checked.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

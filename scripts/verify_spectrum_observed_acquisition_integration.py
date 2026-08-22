"""Regenerate or verify the retained Spectrum observed-source integration report."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

try:
    from scripts.integrate_authorized_acquisition import integration_report
except ModuleNotFoundError:  # Direct execution places scripts/ rather than the repository root on sys.path.
    from integrate_authorized_acquisition import integration_report

ROOT = Path(__file__).resolve().parents[1]
REGISTRATIONS = ROOT / "research" / "authorized_candidate_sources.json"
CORPUS = ROOT / "preservation_corpus"
REPORT = CORPUS / "derived" / "spectrum_observed_acquisition_integration.json"


def observed_source_plan(registrations: dict[str, object]) -> list[dict[str, object]]:
    """Build a stable corpus-only plan from immutable authorized source observations."""

    entries = registrations.get("registrations")
    if not isinstance(entries, list):
        raise ValueError("authorized source registry has no registration records")
    plan = [
        {"entry": entry}
        for entry in entries
        if isinstance(entry, dict)
        and isinstance(entry.get("source_observed_identity"), dict)
        and entry.get("source_checksum", {}).get("algorithm") == "sha256"
    ]
    if not plan:
        raise ValueError("authorized source registry has no checksum-pinned observed-source records")
    return sorted(plan, key=lambda item: str(item["entry"]["candidate_key"]))


def render(registrations_path: Path = REGISTRATIONS, corpus: Path = CORPUS) -> str:
    """Return the deterministic JSON representation of the retained integration evidence."""

    registrations = json.loads(registrations_path.read_text(encoding="utf-8"))
    return json.dumps(integration_report(observed_source_plan(registrations), corpus), indent=2, sort_keys=True) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--registrations", type=Path, default=REGISTRATIONS)
    parser.add_argument("--corpus", type=Path, default=CORPUS)
    parser.add_argument("--output", type=Path, default=REPORT)
    parser.add_argument("--write", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.write == args.check:
        parser.error("select exactly one of --write or --check")
    expected = render(args.registrations, args.corpus)
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            raise AssertionError(f"Spectrum acquisition integration report is stale: {args.output}")
        print("Spectrum observed-source acquisition integration verified")
    else:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(expected, encoding="utf-8")
        print("Spectrum observed-source acquisition integration written")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

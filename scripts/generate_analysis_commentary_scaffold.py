"""Generate evidence-bound review scaffolding from retained analysis records.

The output deliberately indexes immutable bytes, tool records, and output hashes.
It does not parse analyzer listings, reconstruct source, or infer behavior.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
DERIVED_ROOT = ROOT / "reverse_engineering" / "derived"
OUTPUT = DERIVED_ROOT / "COMMENTARY_REVIEW_SCAFFOLD.md"
_REQUIRED_RECORD_FIELDS = frozenset({
    "analysis_state", "architecture", "artifact_id", "derived_from_sha256",
    "input_path", "load_model", "non_claim", "outputs", "tool_records",
})


def _relative_path(value: str, *, label: str) -> str:
    path = Path(value)
    if path.is_absolute() or ".." in path.parts:
        raise ValueError(f"{label} must be a repository-relative path")
    return path.as_posix()


def load_records(derived_root: Path = DERIVED_ROOT) -> list[dict[str, Any]]:
    """Load retained analysis records in deterministic architecture/artifact order."""

    records: list[dict[str, Any]] = []
    for path in sorted(derived_root.glob("*/**/analysis-run.json")):
        raw = json.loads(path.read_text(encoding="utf-8"))
        if not isinstance(raw, dict) or _REQUIRED_RECORD_FIELDS - raw.keys():
            raise ValueError(f"{path.relative_to(derived_root)} lacks required analysis-record fields")
        if not isinstance(raw["outputs"], list) or not isinstance(raw["tool_records"], list):
            raise ValueError(f"{path.relative_to(derived_root)} has invalid output or tool-record data")
        _relative_path(str(raw["input_path"]), label=f"{raw['artifact_id']} input_path")
        for output in raw["outputs"]:
            if not isinstance(output, dict) or not isinstance(output.get("path"), str) or not isinstance(output.get("sha256"), str):
                raise ValueError(f"{raw['artifact_id']} has invalid output record")
            _relative_path(output["path"], label=f"{raw['artifact_id']} output path")
        for tool in raw["tool_records"]:
            if not isinstance(tool, dict) or not isinstance(tool.get("tool"), str) or not isinstance(tool.get("output"), str):
                raise ValueError(f"{raw['artifact_id']} has invalid tool record")
            _relative_path(tool["output"], label=f"{raw['artifact_id']} tool output")
        records.append(raw)
    return sorted(records, key=lambda record: (record["architecture"], record["artifact_id"]))


def _lineage_table(record: dict[str, Any]) -> list[str]:
    return [
        "| Field | Retained value |",
        "| --- | --- |",
        f"| Artifact ID | `{record['artifact_id']}` |",
        f"| Architecture | `{record['architecture']}` |",
        f"| Immutable input | `{record['input_path']}` |",
        f"| Input SHA-256 | `{record['derived_from_sha256']}` |",
        f"| Analysis state | `{record['analysis_state']}` |",
        f"| Load model | `{record['load_model']}` |",
    ]


def render(records: list[dict[str, Any]]) -> str:
    """Render a deterministic layered review scaffold without semantic synthesis."""

    lines = [
        "# Retained Static-Analysis Commentary Review Scaffold",
        "",
        "> **Evidence scope:** This native index copies only retained analysis-record identity, tool-record, and output-hash metadata. It does not parse or summarize analyzer listings.",
        "",
        "> **Non-claims:** A decoded instruction, CFG edge, symbol, function boundary, pseudocode line, or comment from an external tool is not recovered source code or verified runtime behavior. Every semantic statement requires separately linked native, load-model, trace, emulator, or primary-source evidence.",
        "",
        f"**Record count:** {len(records)}",
        "",
        "## Required review layers",
        "",
        "| Layer | Allowed content | Prohibited shortcut |",
        "| --- | --- | --- |",
        "| Immutable bytes | Retained input path, hash, architecture, and byte range. | Treating an unchanged hash as a semantic interpretation. |",
        "| Decoded instructions | Explicit adapter, CPU, endian, origin, and output reference. | Treating a decode as proof of code/data classification. |",
        "| Tool hypotheses | Named tool output and its recorded configuration boundary. | Calling inferred functions, labels, or pseudocode recovered source. |",
        "| Evidenced behavior | Separate native parser, justified load model, trace, emulator, or primary-source reference. | Inferring behavior solely from an analyzer listing. |",
        "",
    ]
    for record in records:
        lines.extend([f"## `{record['architecture']}` — `{record['artifact_id']}`", ""])
        lines.extend(_lineage_table(record))
        lines.extend(["", "### Retained tool records", "", "| Tool | Return code | Captured output | SHA-256 |", "| --- | ---: | --- | --- |"])
        for tool in sorted(record["tool_records"], key=lambda item: (item["tool"], item["output"])):
            lines.append(
                f"| `{tool['tool']}` | `{tool.get('returncode', 'not recorded')}` | `{tool['output']}` | `{tool.get('sha256', 'not recorded')}` |"
            )
        lines.extend(["", "### Derived output inventory", "", "| Output | Bytes | SHA-256 |", "| --- | ---: | --- |"])
        for output in sorted(record["outputs"], key=lambda item: item["path"]):
            lines.append(f"| `{output['path']}` | `{output.get('size', 'not recorded')}` | `{output['sha256']}` |")
        lines.extend([
            "",
            "### Review placeholders",
            "",
            f"**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `{record['load_model']}` model before adding a claim.",
            "",
            "**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.",
            "",
            "**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.",
            "",
            f"**Record non-claim:** {record['non_claim']}",
            "",
        ])
    return "\n".join(lines).rstrip() + "\n"


def generate(*, derived_root: Path = DERIVED_ROOT, output: Path = OUTPUT, check: bool = False) -> int:
    expected = render(load_records(derived_root))
    if check:
        if not output.is_file() or output.read_text(encoding="utf-8") != expected:
            print("analysis commentary scaffold is stale")
            return 1
        print("analysis commentary scaffold verified")
        return 0
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(expected, encoding="utf-8")
    try:
        display_path = output.relative_to(ROOT)
    except ValueError:
        display_path = output
    print(f"analysis commentary scaffold generated: {display_path}")
    return 0


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="verify the committed deterministic scaffold")
    args = parser.parse_args(argv)
    return generate(check=args.check)


if __name__ == "__main__":
    raise SystemExit(main())

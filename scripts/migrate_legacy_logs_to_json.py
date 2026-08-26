#!/usr/bin/env python3
"""Migrate legacy preservation_corpus .log evidence files to structured JSON.

Three log formats exist in preservation_corpus/logs/ and preservation_corpus/daad_games.log,
all predating the pipeline's current Loguru-based JSON logging:

1. "loggersuite_banner" -- daad_general*.log, daad_games*.log, daad_discovery*.log,
   daad_downloads*.log. Produced by the now-legacy daad_harvester.daad_logger.LoggerSuite:
   fixed-width "==="-delimited blocks of SESSION TAG / CATEGORY / TIMESTAMP / fields,
   with an optional nested "--- HASHES ---" sub-block.

2. "structlog_console" -- batch_*.log, fetch_*.log, unpack_*.log. Captured via shell
   redirection (`> file 2>&1`) of a real pipeline run's console output, so most lines are
   structlog key=value records but some are plain messages from other libraries writing to
   the same stream (httpx's own request logging is the only case observed in this corpus).
   Both are preserved; non-structlog lines become {"type": "raw_line", "text": ...} records
   rather than being silently dropped or force-fit into the wrong shape.

3. "raw_transcript" -- anything matching neither pattern (in this corpus: one file capturing
   raw cpmtools subprocess output). Wrapped verbatim as a single text blob rather than
   guessed at, since inventing structure a transcript doesn't have would misrepresent it.

Per .gitignore's own description of these files ("evidence records... must be retained with
originals and extracts"), this script never deletes or modifies a source .log file. Each
input produces exactly one sibling .json file; run again to refresh migrated_at/re-derive,
which is idempotent since inputs are historical and no longer being appended to.
"""

from __future__ import annotations

import argparse
import ast
import json
import re
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_TARGETS = [
    ROOT / "preservation_corpus" / "logs",
    ROOT / "preservation_corpus" / "daad_games.log",
]

_BANNER_RULE = "=" * 80
_FIELD_LINE = re.compile(r"^([A-Z][A-Z0-9_ ]*):\s?(.*)$")
_STRUCTLOG_TOKEN = re.compile(r"(\w+)=('(?:[^'\\]|\\.)*'|\S*)")
_STRUCTLOG_RESERVED = {"event", "logger", "level", "timestamp"}


def _coerce(token: str) -> Any:
    """Best-effort recovery of a structlog value's original Python type.
    structlog's console renderer writes each value via repr(), so ast.literal_eval
    round-trips it correctly for strings/numbers/bools; anything that isn't a valid
    literal (rare, but not guaranteed impossible) is kept as the raw token."""
    try:
        return ast.literal_eval(token)
    except (ValueError, SyntaxError):
        return token


def _looks_like_structlog_line(line: str) -> bool:
    return bool(_STRUCTLOG_TOKEN.search(line)) and "=" in line.split(" ")[0]


def parse_structlog_line(line: str) -> dict:
    fields = {}
    for key, raw_value in _STRUCTLOG_TOKEN.findall(line):
        fields[key] = _coerce(raw_value)
    return fields


def parse_structlog_console_file(text: str) -> list[dict]:
    records: list[dict] = []
    for line in text.splitlines():
        if not line.strip():
            continue
        if _looks_like_structlog_line(line):
            records.append({"type": "structlog", "fields": parse_structlog_line(line)})
        else:
            records.append({"type": "raw_line", "text": line})
    return records


def parse_banner_file(text: str) -> list[dict]:
    records: list[dict] = []
    lines = text.split("\n")
    i = 0
    while i < len(lines):
        if lines[i].rstrip() != _BANNER_RULE:
            i += 1
            continue
        i += 1  # step past the opening rule
        record: dict = {"session_tag": None, "category": None, "timestamp": None, "fields": {}}
        in_hashes = False
        while i < len(lines) and not lines[i].startswith("=" * 20):
            line = lines[i]
            match = _FIELD_LINE.match(line)
            if line.strip() == "--- HASHES ---":
                in_hashes = True
                record["fields"]["hashes"] = {}
            elif match:
                key, value = match.group(1).strip(), match.group(2).strip()
                if key == "SESSION TAG":
                    record["session_tag"] = value
                elif key == "CATEGORY":
                    record["category"] = value
                elif key == "TIMESTAMP":
                    record["timestamp"] = value
                elif in_hashes:
                    record["fields"]["hashes"][key.lower()] = value
                else:
                    record["fields"][key.lower().replace(" ", "_")] = _coerce(value) if value.lstrip("-").isdigit() else value
            i += 1
        # The line we stopped on is the closing rule (e.g. "==...== drop"); consume it too.
        if i < len(lines) and lines[i].startswith("=" * 20):
            i += 1
        records.append(record)
    return records


def detect_format(path: Path, text: str) -> str:
    if _BANNER_RULE in text:
        return "loggersuite_banner"
    sample_lines = [l for l in text.splitlines()[:20] if l.strip()]
    if sample_lines and sum(_looks_like_structlog_line(l) for l in sample_lines) >= max(1, len(sample_lines) // 2):
        return "structlog_console"
    return "raw_transcript"


def migrate_file(path: Path) -> Path:
    text = path.read_text(encoding="utf-8", errors="replace")
    fmt = detect_format(path, text)

    if fmt == "loggersuite_banner":
        records = parse_banner_file(text)
    elif fmt == "structlog_console":
        records = parse_structlog_console_file(text)
    else:
        records = None  # raw_transcript keeps the whole file as one blob, not a record list

    payload = {
        "source_log_file": path.name,
        "format": fmt,
        "migrated_at": datetime.now(timezone.utc).isoformat(),
    }
    if records is None:
        payload["text"] = text
    else:
        payload["record_count"] = len(records)
        payload["records"] = records

    out_path = path.with_suffix(".json")
    out_path.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    return out_path


def iter_log_files(targets: list[Path]) -> list[Path]:
    files: list[Path] = []
    for target in targets:
        if target.is_dir():
            files.extend(sorted(target.glob("*.log")))
        elif target.is_file():
            files.append(target)
    return files


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "targets", nargs="*", type=Path, default=None,
        help="Specific .log files or directories to migrate (default: the full preservation_corpus log set)",
    )
    args = parser.parse_args()

    targets = args.targets if args.targets else DEFAULT_TARGETS
    log_files = iter_log_files(targets)
    if not log_files:
        print("No .log files found to migrate.")
        return 0

    for log_path in log_files:
        out_path = migrate_file(log_path)
        print(f"{log_path.relative_to(ROOT)} -> {out_path.relative_to(ROOT)}")

    print(f"\nMigrated {len(log_files)} file(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

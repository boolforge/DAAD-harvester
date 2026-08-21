#!/usr/bin/env python3
"""Survey structurally verified retained DDB profiles without mutating corpus data.

Design note: This command follows the DDB round-trip contract.  It groups only
native-parser-verified DDB candidates by concrete layout and execution-relevant
header fields, and distinguishes a direct member from a DDB recovered from a
parent byte range.  It never infers an authoring release or interpreter binary.
"""

from __future__ import annotations

import argparse
import json
from collections import Counter
from pathlib import Path
from typing import Any

from daad_harvester.daad_parser import DAADBytecodeParser


DEFAULT_ROOTS = ("extracted", "derived")


def profile_key(result: dict[str, Any], source_kind: str) -> tuple[Any, ...]:
    """Return the measured profile fields that control initial grammar selection."""

    header = result["details"]["header"]
    wrapper = result["details"]["container_wrapper"]
    return (
        header["layout"],
        header["major_version"],
        header["machine_id"],
        header["platform"],
        header["endianness"],
        header["base_address"],
        header["language"],
        wrapper.get("format", "raw"),
        source_kind,
    )


def survey_retained_profiles(corpus_root: Path) -> list[dict[str, Any]]:
    """Return deterministic grouped profile records for retained extracted/derived bytes."""

    parser = DAADBytecodeParser()
    counts: Counter[tuple[Any, ...]] = Counter()
    samples: dict[tuple[Any, ...], dict[str, Any]] = {}
    for root_name in DEFAULT_ROOTS:
        root = corpus_root / root_name
        for path in sorted(root.rglob("*")):
            if not path.is_file():
                continue
            try:
                data = path.read_bytes()
            except OSError:
                continue
            direct_result = parser.parse_ddb(data, path.name)
            candidates = [("direct", 0, data, direct_result)]
            if not direct_result["is_daad"]:
                embedded = parser.find_embedded_ddb(data)
                if embedded is not None:
                    embedded_offset, embedded_bytes = embedded
                    candidates.append(
                        (
                            "embedded",
                            embedded_offset,
                            embedded_bytes,
                            parser.parse_ddb(embedded_bytes, path.name),
                        )
                    )
            for source_kind, source_offset, candidate, result in candidates:
                if not result["is_daad"]:
                    continue
                key = profile_key(result, source_kind)
                counts[key] += 1
                samples.setdefault(
                    key,
                    {
                        "sample_path": path.as_posix(),
                        "sample_payload_size": len(candidate),
                        "sample_source_offset": source_offset,
                    },
                )
    records = []
    for key in sorted(counts):
        (
            layout,
            major_version,
            machine_id,
            platform,
            endianness,
            base_address,
            language,
            wrapper,
            source_kind,
        ) = key
        records.append(
            {
                "count": counts[key],
                "layout": layout,
                "major_version": major_version,
                "machine_id": machine_id,
                "platform": platform,
                "endianness": endianness,
                "base_address": base_address,
                "language": language,
                "wrapper": wrapper,
                "source_kind": source_kind,
                **samples[key],
            }
        )
    return records


def main() -> int:
    argument_parser = argparse.ArgumentParser(
        description="Survey parser-verified DDB profiles in a retained corpus."
    )
    argument_parser.add_argument(
        "--corpus-root",
        default="preservation_corpus",
        type=Path,
        help="Corpus root containing extracted/ and derived/ directories.",
    )
    argument_parser.add_argument(
        "--format",
        choices=("json", "table"),
        default="table",
        help="Stable output representation (default: table).",
    )
    arguments = argument_parser.parse_args()
    records = survey_retained_profiles(arguments.corpus_root)
    if arguments.format == "json":
        print(json.dumps(records, indent=2, sort_keys=True))
        return 0
    for record in records:
        print(
            "{count}\t{layout}\tv{major_version}\t{platform}\t{endianness}\t"
            "{source_kind}\t{wrapper}\t{sample_payload_size}\t{sample_source_offset:#x}\t"
            "{sample_path}".format(**record)
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

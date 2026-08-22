#!/usr/bin/env python3
"""Generate reproducible redundant static-analysis outputs for authorized inputs.

The runner never executes an analyzed interpreter. It invokes analysis tools on
immutable bytes, writes stdout/stderr/commands/output checksums, and marks raw
binary results as load-model-unverified until a format-specific workflow exists.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "reverse_engineering" / "manifests" / "official_interpreters.json"
WORKFLOW_PATH = ROOT / "reverse_engineering" / "workflows" / "toolchain.json"
DERIVED_ROOT = ROOT / "reverse_engineering" / "derived"
GHIDRA_SCRIPT_DIR = ROOT / "reverse_engineering" / "tools" / "ghidra"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_command_output(destination: Path, command: list[str]) -> dict[str, Any]:
    completed = subprocess.run(command, cwd=ROOT, text=True, capture_output=True, check=False)
    destination.write_text(completed.stdout + ("\n[stderr]\n" + completed.stderr if completed.stderr else ""), encoding="utf-8")
    return {"command": command, "returncode": completed.returncode, "output": str(destination.relative_to(ROOT)), "sha256": sha256(destination)}


def output_hashes(directory: Path) -> list[dict[str, Any]]:
    return [
        {"path": str(path.relative_to(ROOT)), "size": path.stat().st_size, "sha256": sha256(path)}
        for path in sorted(directory.rglob("*"))
        if path.is_file() and path.name != "analysis-run.json"
    ]


def verify(artifact: dict[str, Any], workflow: dict[str, Any]) -> list[str]:
    """Return deterministic retained-analysis verification errors without writing files."""

    artifact_id = artifact["artifact_id"]
    architecture = artifact["architecture"]
    config = workflow["architectures"][architecture]
    target = DERIVED_ROOT / architecture / artifact_id
    record_path = target / "analysis-run.json"
    if not record_path.is_file():
        return [f"{artifact_id}: missing analysis record"]
    try:
        record = json.loads(record_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        return [f"{artifact_id}: invalid analysis record JSON: {exc.msg}"]

    expected = {
        "schema_version": 1,
        "artifact_id": artifact_id,
        "derived_from_sha256": artifact["sha256"],
        "architecture": architecture,
        "input_path": artifact["storage"]["path"],
        "load_model": config["load_model"],
        "analysis_state": "generated_unverified_load_model",
        "non_claim": "Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.",
    }
    errors = [f"{artifact_id}: record {key!r} differs from current manifest/workflow" for key, value in expected.items() if record.get(key) != value]

    outputs = record.get("outputs")
    if not isinstance(outputs, list) or not outputs:
        return [*errors, f"{artifact_id}: missing output hash inventory"]
    output_paths: set[str] = set()
    for output in outputs:
        if not isinstance(output, dict) or not isinstance(output.get("path"), str):
            errors.append(f"{artifact_id}: malformed output inventory entry")
            continue
        output_path = ROOT / output["path"]
        try:
            output_path.relative_to(target)
        except ValueError:
            errors.append(f"{artifact_id}: output lies outside its derived directory: {output['path']}")
            continue
        output_paths.add(output["path"])
        if not output_path.is_file():
            errors.append(f"{artifact_id}: missing derived output: {output['path']}")
            continue
        if output.get("size") != output_path.stat().st_size:
            errors.append(f"{artifact_id}: derived output size mismatch: {output['path']}")
        if output.get("sha256") != sha256(output_path):
            errors.append(f"{artifact_id}: derived output SHA-256 mismatch: {output['path']}")

    records = record.get("tool_records")
    if not isinstance(records, list) or len(records) < 2:
        errors.append(f"{artifact_id}: missing redundant tool records")
    else:
        for tool_record in records:
            if not isinstance(tool_record, dict):
                errors.append(f"{artifact_id}: malformed tool record")
                continue
            output = tool_record.get("output")
            if not isinstance(output, str) or output not in output_paths:
                errors.append(f"{artifact_id}: tool record references an unlisted output")
                continue
            output_path = ROOT / output
            if output_path.is_file() and tool_record.get("sha256") != sha256(output_path):
                errors.append(f"{artifact_id}: tool-record SHA-256 mismatch: {output}")
    return errors


def analyze(artifact: dict[str, Any], workflow: dict[str, Any], include_ghidra: bool) -> dict[str, Any]:
    artifact_id = artifact["artifact_id"]
    source = ROOT / artifact["storage"]["path"]
    architecture = artifact["architecture"]
    config = workflow["architectures"][architecture]
    target = DERIVED_ROOT / architecture / artifact_id
    if target.exists():
        shutil.rmtree(target)
    target.mkdir(parents=True)
    records: list[dict[str, Any]] = []

    r2 = config["radare2"]
    input_size = source.stat().st_size
    r2_command = [
        workflow["tools"]["radare2"]["command"], "-N", "-a", r2["architecture"], "-b", str(r2["bits"]),
        "-qc", f"aaa;afl;pD {input_size}", str(source),
    ]
    records.append({"tool": "radare2", **write_command_output(target / "radare2-analysis.txt", r2_command)})

    static_command = [*config["independent_static_command"], str(source)]
    records.append({"tool": "architecture_static", **write_command_output(target / "independent-static-disassembly.txt", static_command)})

    if include_ghidra:
        project_root = Path("/tmp") / "daad-ghidra-projects" / artifact_id
        shutil.rmtree(project_root, ignore_errors=True)
        project_root.mkdir(parents=True)
        ghidra_command = [
            workflow["tools"]["ghidra"]["local_path"], str(project_root), "analysis", "-import", str(source), "-overwrite",
            "-loader", "BinaryLoader", "-loader-baseAddr", "0x0", "-processor", config["ghidra_language"],
            "-analysisTimeoutPerFile", "120", "-scriptPath", str(GHIDRA_SCRIPT_DIR), "-postScript", "ExportDAADAnalysis.java", str(target),
        ]
        records.append({"tool": "ghidra", **write_command_output(target / "ghidra-headless.log", ghidra_command)})

    result = {
        "schema_version": 1,
        "artifact_id": artifact_id,
        "derived_from_sha256": artifact["sha256"],
        "architecture": architecture,
        "input_path": artifact["storage"]["path"],
        "load_model": config["load_model"],
        "analysis_state": "generated_unverified_load_model",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "tool_records": records,
        "outputs": output_hashes(target),
        "non_claim": "Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.",
    }
    (target / "analysis-run.json").write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifact-id", action="append", help="Analyze only this exact manifest artifact ID; may be repeated.")
    parser.add_argument("--limit", type=int, default=0, help="Maximum selected artifacts; zero means all selected.")
    parser.add_argument("--skip-ghidra", action="store_true", help="Generate independent static tool outputs only.")
    parser.add_argument("--check", action="store_true", help="Verify retained analysis records and hashes without executing tools or writing files.")
    args = parser.parse_args()
    manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    workflow = json.loads(WORKFLOW_PATH.read_text(encoding="utf-8"))
    requested = set(args.artifact_id or [])
    artifacts = [item for item in manifest["artifacts"] if not requested or item["artifact_id"] in requested]
    if requested and len(artifacts) != len(requested):
        missing = requested - {item["artifact_id"] for item in artifacts}
        raise SystemExit(f"Unknown artifact IDs: {sorted(missing)}")
    if args.limit:
        artifacts = artifacts[:args.limit]
    if not artifacts:
        raise SystemExit("No artifacts selected")
    if args.check:
        errors = [error for artifact in artifacts for error in verify(artifact, workflow)]
        if errors:
            print("\n".join(errors))
            return 1
        print(f"Verified {len(artifacts)} retained reverse-analysis record(s) without writing outputs")
        return 0
    failures = 0
    for artifact in artifacts:
        result = analyze(artifact, workflow, not args.skip_ghidra)
        failed = [record for record in result["tool_records"] if record["returncode"] != 0]
        print(f"{artifact['artifact_id']}: {len(result['outputs'])} outputs, {len(failed)} failed tool invocations")
        failures += len(failed)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())

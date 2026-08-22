#!/usr/bin/env python3
"""Run hash-bound architecture-static health fixtures in a temporary directory only."""
from __future__ import annotations
import hashlib, json, subprocess, tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()

def normalized(data: bytes, prefixes: list[str]) -> bytes:
    return b"\n".join(line for line in data.splitlines() if not any(line.startswith(prefix.encode()) for prefix in prefixes)) + b"\n"

def main() -> int:
    contract = json.loads((ROOT / "reverse_engineering/workflows/architecture_static_fixture_health.json").read_text())
    results = []
    with tempfile.TemporaryDirectory(prefix="daad-architecture-static-health-") as temporary:
        root = Path(temporary)
        for profile in contract["profiles"]:
            binary = Path(profile["binary"])
            if not binary.is_file() or digest(binary.read_bytes()) != profile["binary_sha256"]:
                raise RuntimeError(f"{profile['id']}: host binary does not match the contract")
            fixture = root / profile["fixture_filename"]
            fixture.write_bytes(bytes.fromhex(profile["fixture_hex"]))
            command = [str(binary), *profile["command_prefix"], fixture.name]
            outputs = []
            for _ in range(2):
                result = subprocess.run(command, cwd=root, check=True, capture_output=True)
                outputs.append(result.stdout + result.stderr)
            if profile["repeat_raw_byte_identical"]:
                if outputs[0] != outputs[1] or digest(outputs[0]) != profile["raw_listing_sha256"]:
                    raise RuntimeError(f"{profile['id']}: raw fixture output differs from contract")
            else:
                rule = profile["normalization"]
                if digest(normalized(outputs[0], rule["remove_line_prefixes"])) != rule["normalized_listing_sha256"] or normalized(outputs[0], rule["remove_line_prefixes"]) != normalized(outputs[1], rule["remove_line_prefixes"]):
                    raise RuntimeError(f"{profile['id']}: normalized fixture output differs from contract")
            results.append({"id": profile["id"], "raw_byte_identical": outputs[0] == outputs[1]})
    print(json.dumps({"fixture_results": results, "non_claim": contract["non_claim"]}, indent=2, sort_keys=True))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

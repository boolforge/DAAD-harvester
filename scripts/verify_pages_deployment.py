"""Verify that a deployed Pages portal exposes measured report and documentation data."""

from __future__ import annotations

import argparse
import hashlib
import json
import time
from typing import Sequence
from urllib.error import HTTPError, URLError
from urllib.request import urlopen


def fetch(url: str, *, timeout: float) -> bytes:
    """Retrieve one public endpoint with a predictable user agent."""

    with urlopen(url, timeout=timeout) as response:  # noqa: S310 -- explicit CI URL
        if response.status != 200:
            raise RuntimeError(f"{url} returned HTTP {response.status}")
        return response.read()


def verify_once(
    *,
    base_url: str,
    documentation_url: str,
    minimum_sources: int,
    minimum_artifacts: int,
    expected_report_sha256: str | None,
    expected_manifest_sha256: str | None,
    minimum_public_artifacts: int,
) -> None:
    """Validate the deployed root, measured report JSON, and rendered documentation index."""

    root = fetch(base_url, timeout=30).decode("utf-8", errors="replace")
    if "DAAD Harvester" not in root:
        raise RuntimeError(f"{base_url} did not contain the report application shell")
    report_bytes = fetch(f"{base_url}report_data.json", timeout=30)
    observed_report_sha256 = hashlib.sha256(report_bytes).hexdigest()
    if expected_report_sha256 and observed_report_sha256 != expected_report_sha256:
        raise RuntimeError(
            "deployed report JSON hash does not match the committed verified export: "
            f"expected {expected_report_sha256}, observed {observed_report_sha256}"
        )
    report = json.loads(report_bytes)
    summary = report.get("summary", {})
    if int(summary.get("all_sources", 0)) < minimum_sources:
        raise RuntimeError("deployed report does not contain the required retained-source evidence")
    if int(summary.get("measured_artifacts", 0)) < minimum_artifacts:
        raise RuntimeError("deployed report does not contain the required measured-artifact evidence")
    manifest_bytes = fetch(f"{base_url}public_artifacts_manifest.json", timeout=30)
    observed_manifest_sha256 = hashlib.sha256(manifest_bytes).hexdigest()
    if expected_manifest_sha256 and observed_manifest_sha256 != expected_manifest_sha256:
        raise RuntimeError(
            "deployed public artifact manifest hash does not match the committed verified export: "
            f"expected {expected_manifest_sha256}, observed {observed_manifest_sha256}"
        )
    manifest = json.loads(manifest_bytes)
    entries = manifest.get("artifacts", [])
    if not isinstance(entries, list) or len(entries) < minimum_public_artifacts:
        raise RuntimeError("deployed public artifact manifest lacks required retained artifacts")
    sample = entries[0] if entries else None
    if not isinstance(sample, dict) or not isinstance(sample.get("public_path"), str):
        raise RuntimeError("deployed public artifact manifest has no valid artifact path")
    sample_bytes = fetch(f"{base_url}{sample['public_path'].lstrip('/')}", timeout=30)
    expected_sample_sha256 = sample.get("checksums", {}).get("sha256")
    if hashlib.sha256(sample_bytes).hexdigest() != expected_sample_sha256:
        raise RuntimeError("deployed public artifact byte does not match its manifest SHA-256")
    docs = fetch(documentation_url, timeout=30).decode("utf-8", errors="replace")
    if "Documentation index" not in docs or "Clone-to-Contribution" not in docs:
        raise RuntimeError("deployed documentation index is missing expected generated content")


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--url", required=True, help="canonical Pages URL, ending with a slash")
    parser.add_argument("--documentation-url", required=True)
    parser.add_argument("--minimum-sources", type=int, default=1)
    parser.add_argument("--minimum-artifacts", type=int, default=1)
    parser.add_argument(
        "--expected-report-sha256",
        help="require the deployed report JSON to exactly match this committed-export SHA-256",
    )
    parser.add_argument(
        "--expected-manifest-sha256",
        help="require the deployed public artifact manifest to exactly match this committed SHA-256",
    )
    parser.add_argument("--minimum-public-artifacts", type=int, default=1)
    parser.add_argument("--retries", type=int, default=12)
    parser.add_argument("--interval-seconds", type=float, default=10)
    args = parser.parse_args(argv)
    base_url = args.url.rstrip("/") + "/"
    last_error: Exception | None = None
    for attempt in range(1, args.retries + 1):
        try:
            verify_once(
                base_url=base_url,
                documentation_url=args.documentation_url,
                minimum_sources=args.minimum_sources,
                minimum_artifacts=args.minimum_artifacts,
                expected_report_sha256=args.expected_report_sha256,
                expected_manifest_sha256=args.expected_manifest_sha256,
                minimum_public_artifacts=args.minimum_public_artifacts,
            )
        except (HTTPError, URLError, OSError, RuntimeError, ValueError, json.JSONDecodeError) as error:
            last_error = error
            if attempt == args.retries:
                break
            print(f"Pages verification attempt {attempt}/{args.retries} pending: {error}", flush=True)
            time.sleep(args.interval_seconds)
        else:
            print(f"Public Pages deployment verified: {base_url}")
            return 0
    raise SystemExit(f"Pages deployment verification failed after {args.retries} attempt(s): {last_error}")


if __name__ == "__main__":
    raise SystemExit(main())

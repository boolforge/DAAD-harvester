#!/usr/bin/env python3
"""Build a fail-closed authorized acquisition queue from catalog candidates."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from daad_harvester.acquisition import candidate_key, validate_registration

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_CANDIDATES = ROOT / "research" / "catalog_discovery_candidates.json"
DEFAULT_REGISTRATIONS = ROOT / "research" / "authorized_candidate_sources.json"
DEFAULT_POLICY = ROOT / "research" / "acquisition_policy.json"
DEFAULT_OUTPUT = ROOT / "research" / "authorized_acquisition_queue.json"


def load_registrations(path: Path) -> dict[str, dict]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if payload.get("schema_version") != 1 or not isinstance(payload.get("registrations"), list):
        raise ValueError(f"Invalid authorization registration file: {path}")
    records: dict[str, dict] = {}
    for registration in payload["registrations"]:
        key = registration.get("candidate_key")
        if not isinstance(key, str) or key in records:
            raise ValueError("Authorization registrations must have unique candidate_key values")
        records[key] = registration
    return records


def build(
    candidates_path: Path = DEFAULT_CANDIDATES,
    registrations_path: Path = DEFAULT_REGISTRATIONS,
    policy_path: Path = DEFAULT_POLICY,
) -> dict:
    candidates = json.loads(candidates_path.read_text(encoding="utf-8"))["candidates"]
    registrations = load_registrations(registrations_path)
    policy = json.loads(policy_path.read_text(encoding="utf-8"))
    queued, discovery_required, blocked = [], [], []
    for candidate in candidates:
        key = candidate_key(candidate)
        decision = validate_registration(candidate, registrations.get(key), policy)
        record = {
            "candidate_key": key,
            "title": candidate["title"],
            "publisher": candidate["publisher"],
            "year": candidate["year"],
            "language": candidate["language"],
            "catalog_source_url": candidate["source_url"],
            "catalog_platform": candidate.get("platform"),
            "authorization_status": (
                "authorized" if decision.allowed
                else "authorized_source_discovery_required"
                if decision.reason == "authorized_source_discovery_required"
                else "blocked"
            ),
            "reason": decision.reason,
        }
        if decision.allowed:
            registration = decision.registration or {}
            record["source_url"] = registration["source_url"]
            record["source_record_url"] = registration["source_record_url"]
            record["source_release_id"] = registration.get("source_release_id")
            record["release_identity"] = registration["release_identity"]
            if "filename" in registration:
                record["filename"] = registration["filename"]
            if "source_adapter" in registration:
                record["source_adapter"] = registration["source_adapter"]
            if "source_checksum" in registration:
                record["source_checksum"] = registration["source_checksum"]
            if "external_source_terms" in registration:
                record["external_source_terms"] = registration["external_source_terms"]
            if "catalog_identity_variance" in registration:
                record["catalog_identity_variance"] = registration["catalog_identity_variance"]
            if "source_release_identity" in registration:
                record["source_release_identity"] = registration["source_release_identity"]
            if "source_observed_identity" in registration:
                record["source_observed_identity"] = registration["source_observed_identity"]
            if "authorization" in registration:
                record["authorization"] = registration["authorization"]
            else:
                record["authorization_basis"] = "institutional_authorization_directive"
            queued.append(record)
        elif decision.reason == "authorized_source_discovery_required":
            record["institutional_authorization"] = decision.registration
            discovery_required.append(record)
        else:
            blocked.append(record)
    return {
        "schema_version": 1,
        "purpose": "The institutional directive authorizes candidate handling; a direct binary URL remains required before acquisition.",
        "candidate_manifest": str(candidates_path.relative_to(ROOT)),
        "registration_manifest": str(registrations_path.relative_to(ROOT)),
        "policy_manifest": str(policy_path.relative_to(ROOT)),
        "queued_count": len(queued),
        "discovery_required_count": len(discovery_required),
        "blocked_count": len(blocked),
        "queued": queued,
        "discovery_required": discovery_required,
        "blocked": blocked,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--candidates", type=Path, default=DEFAULT_CANDIDATES)
    parser.add_argument("--registrations", type=Path, default=DEFAULT_REGISTRATIONS)
    parser.add_argument("--policy", type=Path, default=DEFAULT_POLICY)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = json.dumps(build(args.candidates, args.registrations, args.policy), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(f"Authorized acquisition queue is stale: {args.output}")
            return 1
        result = json.loads(expected)
        print(f"Authorized acquisition queue verified: {result['queued_count']} queued, {result['discovery_required_count']} awaiting source discovery, {result['blocked_count']} blocked.")
        return 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(expected, encoding="utf-8")
    result = json.loads(expected)
    print(f"Authorized acquisition queue generated: {result['queued_count']} queued, {result['discovery_required_count']} awaiting source discovery, {result['blocked_count']} blocked.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

"""Authorization-aware acquisition contracts for catalog candidates.

A catalog listing is never sufficient permission to download, retain, or redistribute
an artifact. This module validates a small, portable registration format before an
acquisition pipeline may enqueue a direct binary URL.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Mapping
from urllib.parse import urlparse


INSTITUTIONAL_AUTHORIZATION_STATE = "institutional_authorized"
INSTITUTIONAL_AUTHORIZATION_DIRECTIVE = "docs/reverse_engineering/AUTHORIZATION_AND_HANDLING.md"

SUPPORTED_SOURCE_ADAPTERS = frozenset({"itchio_downloader_free_v1"})

ALLOWED_AUTHORIZATION_KINDS = frozenset(
    {
        "public_domain",
        "creative_commons",
        "author_permission",
        "publisher_permission",
        "institutional_authorization",
        "official_free_download",
    }
)


@dataclass(frozen=True)
class AuthorizationDecision:
    """One deterministic candidate authorization result."""

    allowed: bool
    reason: str
    registration: dict[str, Any] | None = None


def candidate_key(candidate: Mapping[str, Any]) -> str:
    """Return the stable key shared by candidate and source registration files."""

    return "|".join(
        str(candidate.get(field, "")).strip().casefold()
        for field in ("title", "publisher", "year", "language")
    )


def global_authorization_decision(policy: Mapping[str, Any] | None) -> AuthorizationDecision:
    """Validate the repository's versioned institutional authorization directive."""

    if not isinstance(policy, Mapping):
        return AuthorizationDecision(False, "missing_global_authorization_policy")
    if policy.get("authorization_state") != INSTITUTIONAL_AUTHORIZATION_STATE:
        return AuthorizationDecision(False, "unsupported_global_authorization_state")
    if policy.get("directive") != INSTITUTIONAL_AUTHORIZATION_DIRECTIVE:
        return AuthorizationDecision(False, "global_authorization_directive_mismatch")
    if policy.get("scope") != "acquire_retain_execute_analyze_publish":
        return AuthorizationDecision(False, "invalid_global_authorization_scope")
    return AuthorizationDecision(True, "institutional_authorized", dict(policy))


def validate_registration(
    candidate: Mapping[str, Any],
    registration: Mapping[str, Any] | None,
    global_policy: Mapping[str, Any] | None = None,
) -> AuthorizationDecision:
    """Validate a direct source and its publication identity before queueing it."""

    global_decision = global_authorization_decision(global_policy)
    if not registration:
        if global_decision.allowed:
            return AuthorizationDecision(False, "authorized_source_discovery_required", global_decision.registration)
        return AuthorizationDecision(False, "no_authorized_source_registration")
    if registration.get("candidate_key") != candidate_key(candidate):
        return AuthorizationDecision(False, "candidate_key_mismatch")
    source_url = registration.get("source_url")
    if not isinstance(source_url, str) or urlparse(source_url).scheme not in {"https", "http"}:
        return AuthorizationDecision(False, "missing_or_invalid_source_url")
    source_adapter = registration.get("source_adapter")
    if source_adapter is not None:
        if not isinstance(source_adapter, Mapping) or source_adapter.get("name") not in SUPPORTED_SOURCE_ADAPTERS:
            return AuthorizationDecision(False, "unsupported_source_adapter")
        if source_adapter.get("page_url") != source_url or not isinstance(source_adapter.get("upload_id"), int):
            return AuthorizationDecision(False, "invalid_source_adapter_registration")
    if global_decision.allowed:
        release_identity = registration.get("release_identity")
        if not isinstance(release_identity, Mapping):
            return AuthorizationDecision(False, "missing_release_identity_evidence")
        if any(str(release_identity.get(field, "")).strip() != str(candidate.get(field, "")).strip() for field in ("title", "publisher", "year")):
            return AuthorizationDecision(False, "release_identity_mismatch")
        source_record_url = registration.get("source_record_url")
        if not isinstance(source_record_url, str) or urlparse(source_record_url).scheme not in {"https", "http"}:
            return AuthorizationDecision(False, "missing_or_invalid_source_record_url")
        return AuthorizationDecision(True, "authorized_by_institutional_directive", dict(registration))
    authorization = registration.get("authorization")
    if not isinstance(authorization, Mapping):
        return AuthorizationDecision(False, "missing_authorization_record")
    kind = authorization.get("kind")
    evidence_url = authorization.get("evidence_url")
    scope = authorization.get("scope")
    if kind not in ALLOWED_AUTHORIZATION_KINDS:
        return AuthorizationDecision(False, "unsupported_authorization_kind")
    if not isinstance(evidence_url, str) or urlparse(evidence_url).scheme not in {"https", "http"}:
        return AuthorizationDecision(False, "missing_authorization_evidence_url")
    if scope not in {"download", "retain", "redistribute"}:
        return AuthorizationDecision(False, "missing_or_invalid_authorization_scope")
    return AuthorizationDecision(True, "authorized", dict(registration))

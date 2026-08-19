"""Normalized provenance vocabulary for DAAD preservation records.

This module deliberately separates a game's publisher release revision, a
source-provided toolchain claim, a structurally measured DDB format, and an
interpreter binary identity.  They answer different questions and must never
be merged into an opaque "DAAD version" string.
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Optional


class SourceRole(str, Enum):
    """The evidentiary role played by a discovered URL."""

    GAME_MEDIA = "game_media"
    RELEASE_CATALOG = "release_catalog"
    TOOL_DISTRIBUTION = "tool_distribution"
    METADATA_ONLY = "metadata_only"


class EvidenceKind(str, Enum):
    """Independently meaningful version and provenance observations."""

    DAAD_FAMILY = "daad_family"
    PLATFORM_RELEASE = "platform_release"
    RELEASE_VERSION = "release_version"
    TOOLCHAIN_CLAIM = "toolchain_claim"
    HISTORICAL_PRODUCT_VERSION = "historical_product_version"
    DDB_FORMAT = "ddb_format"
    INTERPRETER_IDENTITY = "interpreter_identity"
    INTERPRETER_VERSION = "interpreter_version"
    CONTAINER_FORMAT = "container_format"


class EvidenceConfidence(str, Enum):
    """Confidence is evidence-specific, not a blanket score for a game."""

    VERIFIED = "verified"
    STRONG = "strong"
    PROVISIONAL = "provisional"
    UNVERIFIED = "unverified"


CANONICAL_PLATFORMS = (
    "zx",
    "cpc",
    "c64",
    "plus4",
    "msx",
    "pcw",
    "atarist",
    "amiga",
    "dos",
)


_PLATFORM_ALIASES = {
    "zx": "zx",
    "spectrum": "zx",
    "zx spectrum": "zx",
    "sinclair spectrum": "zx",
    "cpc": "cpc",
    "amstrad cpc": "cpc",
    "c64": "c64",
    "commodore 64": "c64",
    "cbm64": "c64",
    "cbm 64": "c64",
    "plus4": "plus4",
    "plus/4": "plus4",
    "commodore plus/4": "plus4",
    "commodore plus 4": "plus4",
    "c16": "plus4",
    "c16 64k": "plus4",
    "msx": "msx",
    "msx1": "msx",
    "msx2": "msx",
    "pcw": "pcw",
    "amstrad pcw": "pcw",
    "atarist": "atarist",
    "atari st": "atarist",
    "st": "atarist",
    "amiga": "amiga",
    "pc": "dos",
    "dos": "dos",
    "ibm pc": "dos",
    "ibm pc dos": "dos",
    "ms dos": "dos",
    "ms-dos": "dos",
}


def normalize_platform(value: Optional[str]) -> Optional[str]:
    """Return a canonical DAAD target platform or ``None`` for unknown input."""

    if value is None:
        return None
    normalized = " ".join(value.lower().replace("_", " ").split())
    return _PLATFORM_ALIASES.get(normalized)


@dataclass(frozen=True)
class VersionEvidence:
    """A source-scoped or measurement-scoped provenance assertion."""

    kind: str
    value: str
    confidence: str
    source_url: Optional[str] = None
    details_json: Optional[str] = None
    source_id: Optional[int] = None
    artifact_id: Optional[int] = None

    def __post_init__(self) -> None:
        if not self.value.strip():
            raise ValueError("Version evidence value must not be empty")
        if self.source_id is None and self.artifact_id is None:
            raise ValueError("Version evidence must be linked to a source or artifact")
        if self.source_id is not None and self.artifact_id is not None:
            raise ValueError("Version evidence cannot target source and artifact simultaneously")


def is_canonical_platform(value: Optional[str]) -> bool:
    """Return whether ``value`` is already a canonical DAAD platform label."""

    return value in CANONICAL_PLATFORMS

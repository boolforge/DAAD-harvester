"""Data models and dataclasses for DAAD Harvester."""

from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from typing import Optional


class SourceTier(str, Enum):
    API = "api"
    ARCHIVE = "archive"
    FORUM = "forum"
    WAYBACK = "wayback"


class SourceStatus(str, Enum):
    PENDING = "pending"
    CATALOGED = "cataloged"
    DOWNLOADED = "downloaded"
    UNPACKED = "unpacked"
    PARTIALLY_UNPACKED = "partially_unpacked"
    ERROR = "error"
    DEAD = "dead"


class Platform(str, Enum):
    """Canonical DAAD targets plus retained legacy labels for old state files."""

    ZX = "zx"
    CPC = "cpc"
    C64 = "c64"
    PLUS4 = "plus4"
    MSX = "msx"
    PCW = "pcw"
    ATARIST = "atarist"
    AMIGA = "amiga"
    DOS = "dos"
    # ``pc`` remains readable from prior state databases and is normalized on
    # new inserts; it is not a canonical all-platform label.
    PC = "pc"
    ORIC = "oric"
    UNKNOWN = "unknown"


@dataclass
class SourceRecord:
    id: Optional[int]
    url: str
    source_tier: str
    status: str = SourceStatus.PENDING.value
    http_status: Optional[int] = None
    content_type: Optional[str] = None
    local_path: Optional[str] = None
    title: Optional[str] = None
    platform: Optional[str] = None
    year: Optional[int] = None
    publisher: Optional[str] = None
    author: Optional[str] = None
    language: Optional[str] = None
    known_game_id: Optional[str] = None
    acquisition_priority: int = 0
    source_name: Optional[str] = None
    source_role: Optional[str] = None
    source_record_url: Optional[str] = None
    source_release_id: Optional[str] = None
    release_version: Optional[str] = None
    toolchain_claim: Optional[str] = None
    provenance_json: Optional[str] = None
    discovered_at: Optional[datetime] = None
    processed_at: Optional[datetime] = None


@dataclass
class ArtifactRecord:
    id: Optional[int]
    source_id: int
    original_filename: str
    extracted_path: str
    archive_depth: int
    file_size: int
    md5_full: str
    md5_5000: str
    sha256: str
    sha1: Optional[str] = None
    crc32: Optional[str] = None
    md5_tail5000: Optional[str] = None
    sha224: Optional[str] = None
    sha384: Optional[str] = None
    sha512: Optional[str] = None
    sha3_256: Optional[str] = None
    sha3_512: Optional[str] = None
    blake2b: Optional[str] = None
    blake2s: Optional[str] = None
    adler32: Optional[str] = None
    xxh32: Optional[str] = None
    xxh64: Optional[str] = None
    xxh128: Optional[str] = None
    unpacked: bool = False
    is_daad_payload: bool = False
    daad_version_guess: Optional[str] = None
    platform_hint: Optional[str] = None
    title: Optional[str] = None
    year: Optional[int] = None
    publisher: Optional[str] = None
    author: Optional[str] = None
    language: Optional[str] = None
    container_format: Optional[str] = None
    container_member: Optional[str] = None
    measured_platform: Optional[str] = None
    ddb_format: Optional[str] = None
    ddb_major_version: Optional[int] = None
    ddb_encoding: Optional[str] = None
    interpreter_identity: Optional[str] = None
    interpreter_version: Optional[str] = None
    fingerprint_confidence: Optional[str] = None
    fingerprint_evidence_json: Optional[str] = None
    media_parser: Optional[str] = None
    media_status: Optional[str] = None
    media_validation: Optional[str] = None
    media_evidence_json: Optional[str] = None


@dataclass
class VersionEvidenceRecord:
    """One independently reviewable version/provenance observation."""

    id: Optional[int]
    kind: str
    value: str
    confidence: str
    source_id: Optional[int] = None
    artifact_id: Optional[int] = None
    source_url: Optional[str] = None
    details_json: Optional[str] = None
    observed_at: Optional[datetime] = None


@dataclass
class GameRecord:
    id: Optional[int]
    artifact_id: int
    game_id: str
    title: str
    platform: str
    language: str
    year: Optional[int]
    publisher: Optional[str]
    author: Optional[str]
    detection_entry: Optional[str] = None

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
    DOWNLOADED = "downloaded"
    UNPACKED = "unpacked"
    PARTIALLY_UNPACKED = "partially_unpacked"
    ERROR = "error"
    DEAD = "dead"


class Platform(str, Enum):
    ZX = "zx"
    CPC = "cpc"
    C64 = "c64"
    AMIGA = "amiga"
    ATARIST = "atarist"
    MSX = "msx"
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
    unpacked: bool = False
    is_daad_payload: bool = False
    daad_version_guess: Optional[str] = None
    platform_hint: Optional[str] = None
    title: Optional[str] = None
    year: Optional[int] = None
    publisher: Optional[str] = None
    author: Optional[str] = None
    language: Optional[str] = None


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


@dataclass
class DetectionEntry:
    game_id: str
    title: str
    platform: str
    language: str
    year: Optional[int]
    publisher: Optional[str]
    author: Optional[str]
    filename: str
    md5_full: str
    md5_5000: str
    file_size: int
    sha256: str

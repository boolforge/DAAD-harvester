"""Pydantic v2 data models establishing strict data contracts across the pipeline."""

from enum import Enum
from typing import Any, Dict, Optional
from pydantic import BaseModel, ConfigDict, Field, field_validator

from daad_harvester.models import SourceStatus

__all__ = [
    "SourceStatus",
    "ConfidenceLevel",
    "SourceModel",
    "ArtifactModel",
    "DDBMetadataModel",
    "InterpreterIdentityModel",
    "CatalogEntryModel",
    "LibraryManifestEntry",
]


class ConfidenceLevel(str, Enum):
    """Validation confidence levels for measured artifacts."""
    VERIFIED = "verified"
    STRONG = "strong"
    MEDIUM = "medium"
    WEAK = "weak"
    UNKNOWN = "unknown"


class SourceModel(BaseModel):
    """Contract for a discovered or queued remote acquisition source."""
    model_config = ConfigDict(from_attributes=True)

    id: Optional[int] = Field(default=None, description="Database primary key")
    source_name: str = Field(description="Name of the discovery adapter or source site")
    url: str = Field(description="Remote URL for fetching or evidence tracking")
    known_game_id: Optional[str] = Field(default=None, description="Normalized game identifier")
    platform: Optional[str] = Field(default=None, description="Platform identifier if known")
    role: str = Field(default="media", description="Role of URL: media or catalog")
    status: SourceStatus = Field(default=SourceStatus.PENDING, description="Fetch workflow status")
    priority: int = Field(default=50, description="Processing priority queue rank")
    content_type: Optional[str] = Field(default=None, description="MIME content type from HTTP response")
    size_bytes: Optional[int] = Field(default=None, description="Fetched file size in bytes")
    sha256: Optional[str] = Field(default=None, description="SHA-256 hex digest of fetched payload")
    download_path: Optional[str] = Field(default=None, description="Relative local path to downloaded file")
    error_message: Optional[str] = Field(default=None, description="Error detail if fetch failed")
    provenance_json: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Metadata dictionary")

    @field_validator("sha256")
    @classmethod
    def validate_sha256(cls, v: Optional[str]) -> Optional[str]:
        """Ensures sha256 checksum is normalized lower-case hex."""
        if v:
            v_clean = v.strip().lower()
            if len(v_clean) != 64 or not all(c in "0123456789abcdef" for c in v_clean):
                raise ValueError("Invalid SHA-256 string format")
            return v_clean
        return None


class ArtifactModel(BaseModel):
    """Contract for a retained raw or extracted binary artifact."""
    model_config = ConfigDict(from_attributes=True)

    id: Optional[int] = Field(default=None, description="Database primary key")
    source_id: int = Field(description="Foreign key pointing to parent SourceModel")
    parent_artifact_id: Optional[int] = Field(default=None, description="ID of parent container artifact if extracted")
    depth: int = Field(default=0, description="Extraction nesting depth level")
    filename: str = Field(description="Base filename of artifact")
    extracted_path: str = Field(description="Relative local file system path")
    size_bytes: int = Field(description="File size in bytes")
    md5: str = Field(description="MD5 hex checksum")
    sha256: str = Field(description="SHA-256 hex checksum")
    container_format: Optional[str] = Field(default=None, description="Native container/disk/archive format type")
    parser_status: str = Field(default="success", description="Extraction or inspection status")
    provenance_json: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Artifact lineage metadata")


class DDBMetadataModel(BaseModel):
    """Contract for a structurally verified DAAD Database (DDB) payload."""
    model_config = ConfigDict(from_attributes=True)

    id: Optional[int] = Field(default=None, description="Database primary key")
    artifact_id: int = Field(description="Foreign key pointing to ArtifactModel")
    ddb_format: str = Field(description="Format label, e.g. daad-v1-legacy, daad-v2, daad-v3")
    target: str = Field(description="Normalized target architecture platform")
    major_version: int = Field(description="DAAD major compiler/format version")
    minor_version: int = Field(default=0, description="DAAD minor compiler version")
    language: str = Field(description="Text language identifier (e.g. es, en)")
    ddb_size: int = Field(description="Declared or measured byte size of DDB table")
    embedded_offset: int = Field(default=0, description="Byte offset if embedded inside another binary")
    process_count: int = Field(default=0, description="Number of process tables validated")
    condact_count: int = Field(default=0, description="Number of condact streams parsed")
    confidence: ConfidenceLevel = Field(default=ConfidenceLevel.VERIFIED, description="Verification level")
    details_json: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Detailed DDB structural facts")


class InterpreterIdentityModel(BaseModel):
    """Contract for an identified DAAD runtime interpreter binary."""
    model_config = ConfigDict(from_attributes=True)

    id: Optional[int] = Field(default=None, description="Database primary key")
    artifact_id: int = Field(description="Foreign key pointing to ArtifactModel")
    interpreter_name: str = Field(description="Registered interpreter profile identity name")
    target: str = Field(description="Target platform architecture")
    version: Optional[str] = Field(default=None, description="Interpreter version string")
    language: Optional[str] = Field(default=None, description="Language identifier")
    profile_sha256: str = Field(description="SHA-256 matching official profile catalog")
    confidence: ConfidenceLevel = Field(default=ConfidenceLevel.VERIFIED, description="Identity confidence level")
    details_json: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Interpreter profile metadata")


class CatalogEntryModel(BaseModel):
    """Contract for a cataloged title release record."""
    model_config = ConfigDict(from_attributes=True)

    id: Optional[int] = Field(default=None, description="Database primary key")
    known_game_id: str = Field(description="Normalized game identifier")
    title: str = Field(description="Canonical title")
    platform: str = Field(description="Platform identifier")
    source_name: str = Field(description="Catalog source provider")
    publisher: Optional[str] = Field(default=None, description="Publisher name")
    release_date: Optional[str] = Field(default=None, description="Release date string")
    evidence_json: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Source provenance details")


class LibraryManifestEntry(BaseModel):
    """Contract for a materialized member of the ready-to-use output library."""
    game_id: str = Field(description="Canonical game identifier")
    title: str = Field(description="Game title")
    platform: str = Field(description="Target platform")
    rel_path: str = Field(description="Relative path within output library")
    source_url: Optional[str] = Field(default=None, description="Original acquisition URL")
    sha256: str = Field(description="SHA-256 of materialized binary")
    classification: str = Field(description="Classification: ready_to_use or support_or_unknown")
    materialization_method: str = Field(default="copy", description="How file was copied or extracted")

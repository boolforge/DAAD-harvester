"""Tests for the Pydantic v2 ETL contract layer in daad_harvester.transform.models.

The most important test in this file is test_source_status_is_the_single_canonical_enum:
an earlier version of this module defined its own SourceStatus with a value set that
silently disagreed with daad_harvester.models.SourceStatus (the enum the legacy database
layer actually persists). Any SourceModel built with `from_attributes=True` off a real
legacy record in a "downloaded", "unpacked", "partially_unpacked", "error", or "dead"
state would raise a pydantic.ValidationError, since only "pending" and "cataloged"
happened to overlap between the two enums. This test exists to make that class of drift
impossible to reintroduce silently.
"""
import pytest
from pydantic import ValidationError

from daad_harvester.models import SourceStatus as LegacySourceStatus
from daad_harvester.transform.models import (
    ArtifactModel,
    ConfidenceLevel,
    SourceModel,
    SourceStatus,
)


def test_source_status_is_the_single_canonical_enum():
    """transform.models.SourceStatus must be daad_harvester.models.SourceStatus itself,
    not a second, independently-defined enum of the same name."""
    assert SourceStatus is LegacySourceStatus


@pytest.mark.parametrize(
    "legacy_value",
    [
        LegacySourceStatus.PENDING,
        LegacySourceStatus.CATALOGED,
        LegacySourceStatus.DOWNLOADED,
        LegacySourceStatus.UNPACKED,
        LegacySourceStatus.PARTIALLY_UNPACKED,
        LegacySourceStatus.ERROR,
        LegacySourceStatus.DEAD,
    ],
)
def test_source_model_accepts_every_legacy_status_value(legacy_value):
    """A SourceModel must be constructible with any status value the legacy sqlite
    layer can actually persist, since that is the whole point of sharing one enum."""
    source = SourceModel(source_name="test", url="https://example.com/a.zip", status=legacy_value)
    assert source.status == legacy_value


def test_source_model_from_attributes_bridges_a_legacy_like_object():
    """Simulates hydrating a SourceModel from an ORM-like/legacy object via
    model_config=ConfigDict(from_attributes=True), the documented intended use."""

    class _LegacyLikeRow:
        id = 7
        source_name = "Spectrum Computing"
        url = "https://example.com/game.tzx"
        known_game_id = None
        platform = "zx"
        role = "media"
        status = LegacySourceStatus.DOWNLOADED
        priority = 20
        content_type = "application/octet-stream"
        size_bytes = 12345
        sha256 = "a" * 64
        download_path = "/tmp/game.tzx"
        error_message = None
        provenance_json = {}

    model = SourceModel.model_validate(_LegacyLikeRow(), from_attributes=True)
    assert model.status == LegacySourceStatus.DOWNLOADED
    assert model.id == 7


def test_source_model_defaults():
    source = SourceModel(source_name="Internet Archive", url="https://example.com/x.zip")
    assert source.status == SourceStatus.PENDING
    assert source.role == "media"
    assert source.priority == 50


@pytest.mark.parametrize(
    "raw,expected",
    [
        ("A" * 64, "a" * 64),
        ("  " + "b" * 64 + "  ", "b" * 64),
    ],
)
def test_sha256_validator_normalizes(raw, expected):
    source = SourceModel(source_name="x", url="https://example.com/x.zip", sha256=raw)
    assert source.sha256 == expected


@pytest.mark.parametrize("bad_value", ["not-a-hash", "a" * 63, "g" * 64, ""])
def test_sha256_validator_rejects_invalid(bad_value):
    if bad_value == "":
        # Empty string is falsy, so the validator's `if v:` guard treats it as "no value".
        source = SourceModel(source_name="x", url="https://example.com/x.zip", sha256=bad_value)
        assert source.sha256 is None
        return
    with pytest.raises(ValidationError):
        SourceModel(source_name="x", url="https://example.com/x.zip", sha256=bad_value)


def test_artifact_model_requires_core_fields():
    artifact = ArtifactModel(
        source_id=1,
        filename="game.tzx",
        extracted_path="/tmp/game.tzx",
        size_bytes=100,
        md5="d" * 32,
        sha256="e" * 64,
    )
    assert artifact.depth == 0
    assert artifact.parser_status == "success"


def test_confidence_level_values():
    assert ConfidenceLevel.VERIFIED.value == "verified"
    assert set(ConfidenceLevel) == {
        ConfidenceLevel.VERIFIED,
        ConfidenceLevel.STRONG,
        ConfidenceLevel.MEDIUM,
        ConfidenceLevel.WEAK,
        ConfidenceLevel.UNKNOWN,
    }

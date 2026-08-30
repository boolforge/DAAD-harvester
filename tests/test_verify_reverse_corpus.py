"""Tests for scripts/verify_reverse_corpus.py.

test_safe_relative_handles_a_manifest_path_that_escapes_root and
test_hash_mismatch_on_an_out_of_root_path_does_not_crash are regression tests for
a real bug found while auditing this file: `path` is always built as
`ROOT / manifest_supplied_string`, but Path's `/` operator silently discards the
left side when the right side is itself absolute
(`ROOT / "/etc/passwd" == Path("/etc/passwd")`). Every "missing file" branch
already guarded `path.relative_to(ROOT)` against that case; every "hash mismatch"
branch next to it did not, so a manifest entry with an absolute path pointing at a
real, wrong-hash file crashed the whole verifier with an unhandled ValueError while
trying to report a completely different, legitimate finding.

Every verify_* function takes a real manifest directory via ROOT/MANIFEST_ROOT
monkeypatching rather than mocking file I/O, since the functions are already small,
pure-ish, and reading real (test-authored) JSON plus real (tmp_path-authored) files
exercises the actual hashing and path logic instead of a re-description of it.
"""
import hashlib
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

import verify_reverse_corpus as m  # noqa: E402


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _setup_manifests(tmp_path, monkeypatch):
    manifest_root = tmp_path / "reverse_engineering" / "manifests"
    manifest_root.mkdir(parents=True)
    monkeypatch.setattr(m, "ROOT", tmp_path)
    monkeypatch.setattr(m, "MANIFEST_ROOT", manifest_root)
    return manifest_root


def _write_manifest(manifest_root, name, payload):
    (manifest_root / name).write_text(json.dumps(payload), encoding="utf-8")


def test_safe_relative_returns_relative_path_when_under_root(tmp_path, monkeypatch):
    monkeypatch.setattr(m, "ROOT", tmp_path)
    nested = tmp_path / "a" / "b.bin"
    assert m.safe_relative(nested) == Path("a/b.bin")


def test_safe_relative_handles_a_manifest_path_that_escapes_root(tmp_path, monkeypatch):
    monkeypatch.setattr(m, "ROOT", tmp_path)
    escaped = m.ROOT / "/etc/passwd"  # Path's own override: this becomes /etc/passwd
    assert escaped == Path("/etc/passwd")
    assert m.safe_relative(escaped) == escaped  # returned as-is, no crash


def test_verify_originals_passes_on_matching_hash(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    artifact_dir = tmp_path / "originals"
    artifact_dir.mkdir()
    content = b"interpreter binary bytes"
    (artifact_dir / "interp.bin").write_bytes(content)

    _write_manifest(manifest_root, "official_interpreters.json", {
        "entry_count": 1,
        "artifacts": [{"artifact_id": "x", "storage": {"path": "originals/interp.bin"}, "sha256": _sha256(content)}],
    })

    errors = []
    checked = m.verify_originals(errors)
    assert errors == []
    assert checked == 1


def test_verify_originals_reports_missing_file(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    _write_manifest(manifest_root, "official_interpreters.json", {
        "entry_count": 1,
        "artifacts": [{"artifact_id": "x", "storage": {"path": "does/not/exist.bin"}, "sha256": "a" * 64}],
    })

    errors = []
    m.verify_originals(errors)
    assert len(errors) == 1
    assert "missing original artifact" in errors[0]


def test_verify_originals_reports_hash_mismatch(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    artifact_dir = tmp_path / "originals"
    artifact_dir.mkdir()
    (artifact_dir / "interp.bin").write_bytes(b"real content")

    _write_manifest(manifest_root, "official_interpreters.json", {
        "entry_count": 1,
        "artifacts": [{"artifact_id": "x", "storage": {"path": "originals/interp.bin"}, "sha256": "0" * 64}],
    })

    errors = []
    m.verify_originals(errors)
    assert len(errors) == 1
    assert "original artifact hash mismatch" in errors[0]


def test_hash_mismatch_on_an_out_of_root_path_does_not_crash(tmp_path, monkeypatch):
    """The exact scenario that used to raise an unhandled ValueError."""
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    escaped_target = tmp_path.parent / f"{tmp_path.name}-outside-escape-target.bin"
    escaped_target.write_bytes(b"real file, just not under ROOT")

    _write_manifest(manifest_root, "official_interpreters.json", {
        "entry_count": 1,
        "artifacts": [{"artifact_id": "x", "storage": {"path": str(escaped_target)}, "sha256": "0" * 64}],
    })

    errors = []
    m.verify_originals(errors)  # must not raise

    assert len(errors) == 1
    assert "hash mismatch" in errors[0]


def test_verify_originals_reports_entry_count_mismatch(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    _write_manifest(manifest_root, "official_interpreters.json", {
        "entry_count": 2,  # says 2, only provides 1
        "artifacts": [{"artifact_id": "x", "storage": {"path": "x.bin"}, "sha256": "a" * 64}],
    })

    errors = []
    checked = m.verify_originals(errors)
    assert checked == 0
    assert "entry_count does not match" in errors[0]


def test_verify_public_sources_checks_every_file_across_every_source(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    source_dir = tmp_path / "public"
    source_dir.mkdir()
    (source_dir / "a.txt").write_bytes(b"a")
    (source_dir / "b.txt").write_bytes(b"b")

    _write_manifest(manifest_root, "public_sources.json", {
        "sources": [
            {
                "id": "site-1",
                "storage": "public",
                "files": [
                    {"path": "a.txt", "sha256": _sha256(b"a")},
                    {"path": "b.txt", "sha256": _sha256(b"b")},
                ],
            }
        ],
    })

    errors = []
    checked = m.verify_public_sources(errors)
    assert errors == []
    assert checked == 2


def test_verify_third_party_manifest_counts_candidates(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    _write_manifest(manifest_root, "third_party_comparisons.json", {"candidates": [{}, {}, {}]})

    errors = []
    assert m.verify_third_party_manifest(errors) == 3
    assert errors == []


def test_verify_adp_verification_reconciles_scenario_summary(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    log_content = b"verification transcript"
    (tmp_path / "log.txt").write_bytes(log_content)

    _write_manifest(manifest_root, "adp_verification.json", {
        "log": {"path": "log.txt", "sha256": _sha256(log_content)},
        "scenario_summary": {"probed": 5, "passed": 3, "blocked": 1, "failed_behavioral_assertions": 1},
    })

    errors = []
    m.verify_adp_verification(errors)
    assert errors == []


def test_verify_adp_verification_flags_unreconciled_summary(tmp_path, monkeypatch):
    manifest_root = _setup_manifests(tmp_path, monkeypatch)
    log_content = b"verification transcript"
    (tmp_path / "log.txt").write_bytes(log_content)

    _write_manifest(manifest_root, "adp_verification.json", {
        "log": {"path": "log.txt", "sha256": _sha256(log_content)},
        "scenario_summary": {"probed": 5, "passed": 3, "blocked": 1, "failed_behavioral_assertions": 0},  # 4 != 5
    })

    errors = []
    m.verify_adp_verification(errors)
    assert any("does not reconcile" in e for e in errors)


def test_main_passes_against_the_real_repository():
    # The real, live check -- exactly what scripts/run_primary_workflow.py runs.
    assert m.main() == 0

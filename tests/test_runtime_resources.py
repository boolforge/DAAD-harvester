"""Committed runtime-resource manifest regression.

The single happy-path test below (checking main() against the real committed
manifest) predates and would not have caught a real bug found while auditing this
script: the "captures" loop's recorded path is external manifest data with no
containment check (unlike the "resources" list a few lines above it in the source,
which explicitly rejects absolute paths before using them), so a manifest entry
with an absolute path escaping ROOT crashed the whole verifier with an unhandled
ValueError while reporting a hash mismatch -- the third time this exact bug class
turned up (after scripts/verify_reverse_corpus.py and
scripts/verify_game_corpus.py), each time in the "hash mismatch" branch sitting
right next to an already-guarded "missing file" branch.
"""
from __future__ import annotations

import json

from scripts import verify_runtime_resources


def test_committed_runtime_resource_manifest_verifies() -> None:
    assert verify_runtime_resources.main() == 0


def _setup(tmp_path, monkeypatch):
    manifest_dir = tmp_path / "preservation_corpus" / "runtime_resources" / "commodore"
    manifest_dir.mkdir(parents=True)
    monkeypatch.setattr(verify_runtime_resources, "ROOT", tmp_path)
    monkeypatch.setattr(verify_runtime_resources, "MANIFEST", manifest_dir / "manifest.json")
    return manifest_dir


def _base_manifest(**overrides):
    manifest = {
        "authorization_directive": "Universal institutional authorization granted",
        "policy_reference": "policy.txt",
        "resources": [],
        "captures": [],
    }
    manifest.update(overrides)
    return manifest


def _link_machine_dirs(manifest_dir):
    for name in ("c64", "plus4"):
        (manifest_dir / name).mkdir()
        (manifest_dir / name.upper()).symlink_to(manifest_dir / name, target_is_directory=True)


def test_safe_relative_handles_a_path_outside_root(tmp_path, monkeypatch):
    monkeypatch.setattr(verify_runtime_resources, "ROOT", tmp_path)
    outside = tmp_path.parent / f"{tmp_path.name}-outside"
    assert verify_runtime_resources.safe_relative(outside) == outside


def test_main_reports_missing_manifest(tmp_path, monkeypatch, capsys):
    _setup(tmp_path, monkeypatch)  # manifest.json is never written

    rc = verify_runtime_resources.main()

    assert rc == 1
    assert "missing" in capsys.readouterr().out


def test_main_rejects_absolute_resource_path(tmp_path, monkeypatch, capsys):
    manifest_dir = _setup(tmp_path, monkeypatch)
    (manifest_dir / "policy.txt").write_text("policy")
    _link_machine_dirs(manifest_dir)
    manifest = _base_manifest(resources=[{"path": "/etc/passwd", "size": 1, "sha256": "a" * 64}])
    verify_runtime_resources.MANIFEST.write_text(json.dumps(manifest))

    rc = verify_runtime_resources.main()

    assert rc == 1
    assert "invalid or duplicate resource path" in capsys.readouterr().out


def test_main_passes_with_matching_resource_and_capture(tmp_path, monkeypatch):
    manifest_dir = _setup(tmp_path, monkeypatch)
    (manifest_dir / "policy.txt").write_text("policy")
    (manifest_dir / "res.bin").write_bytes(b"resource bytes")
    (manifest_dir / "snap.bin").write_bytes(b"snapshot bytes")
    _link_machine_dirs(manifest_dir)

    manifest = _base_manifest(
        resources=[
            {
                "path": "res.bin",
                "size": (manifest_dir / "res.bin").stat().st_size,
                "sha256": verify_runtime_resources.sha256(manifest_dir / "res.bin"),
            }
        ],
        captures=[
            {
                "snapshot": "snap.bin",
                "snapshot_sha256": verify_runtime_resources.sha256(manifest_dir / "snap.bin"),
                "result": "ok",
            }
        ],
    )
    verify_runtime_resources.MANIFEST.write_text(json.dumps(manifest))

    rc = verify_runtime_resources.main()
    assert rc == 0


def test_main_reports_capture_hash_mismatch(tmp_path, monkeypatch, capsys):
    manifest_dir = _setup(tmp_path, monkeypatch)
    (manifest_dir / "policy.txt").write_text("policy")
    (manifest_dir / "snap.bin").write_bytes(b"real content")
    _link_machine_dirs(manifest_dir)

    manifest = _base_manifest(
        captures=[{"snapshot": "snap.bin", "snapshot_sha256": "0" * 64, "result": "ok"}]
    )
    verify_runtime_resources.MANIFEST.write_text(json.dumps(manifest))

    rc = verify_runtime_resources.main()

    out = capsys.readouterr().out
    assert rc == 1
    assert "hash mismatch for capture snapshot" in out


def test_capture_hash_mismatch_on_an_out_of_root_path_does_not_crash(tmp_path, monkeypatch, capsys):
    """The exact scenario that used to raise an unhandled ValueError."""
    manifest_dir = _setup(tmp_path, monkeypatch)
    (manifest_dir / "policy.txt").write_text("policy")
    _link_machine_dirs(manifest_dir)
    escaped_target = tmp_path.parent / f"{tmp_path.name}-outside-escape-target.bin"
    escaped_target.write_bytes(b"real file, just not under ROOT")

    manifest = _base_manifest(
        captures=[{"snapshot": str(escaped_target), "snapshot_sha256": "0" * 64, "result": "ok"}]
    )
    verify_runtime_resources.MANIFEST.write_text(json.dumps(manifest))

    rc = verify_runtime_resources.main()  # must not raise

    out = capsys.readouterr().out
    assert rc == 1
    assert "hash mismatch for capture snapshot" in out


def test_main_reports_missing_machine_directory_links(tmp_path, monkeypatch, capsys):
    manifest_dir = _setup(tmp_path, monkeypatch)
    (manifest_dir / "policy.txt").write_text("policy")
    # deliberately skip _link_machine_dirs()
    manifest = _base_manifest(resources=[{"path": "x", "size": 0, "sha256": "a" * 64}])
    (manifest_dir / "x").write_bytes(b"")
    manifest["resources"][0]["sha256"] = verify_runtime_resources.sha256(manifest_dir / "x")
    verify_runtime_resources.MANIFEST.write_text(json.dumps(manifest))

    rc = verify_runtime_resources.main()

    out = capsys.readouterr().out
    assert rc == 1
    assert "C64 VICE machine-directory link" in out
    assert "Plus/4 VICE machine-directory link" in out

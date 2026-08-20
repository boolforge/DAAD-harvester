"""Verify official DAAD R4 MSX-DOS disk evidence from retained source bytes.

The command reads the committed official R4 release archive with Python's
standard library, validates the embedded MSX.DSK through the native FAT12
profile parser, and compares every emitted member to a fixed byte hash.  It
does not mount a disk image or invoke an emulator, external filesystem tool,
or network service.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys
from zipfile import ZipFile


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.media_inspection import inspect_native_media  # noqa: E402
from daad_harvester.platform_media import extract_fat12  # noqa: E402


ARCHIVE = ROOT / "preservation_corpus/downloads/250_DAAD_R4.zip"
ARCHIVE_MEMBER = "DAAD/LIB/MSX/MSX.DSK"
OUTPUT = ROOT / "preservation_corpus/derived/official_r4/official_r4_msx_disk_evidence.json"
ARCHIVE_SHA256 = "205c35b8eecc6639eb25a1058f07a11d8610b8a23e6dc4ee7a56ff8a150f4f8a"
DISK_SHA256 = "c39ea8a663bae9258563783ef62cd122d1cc1ba1f55749224663190b416fe67e"
EXPECTED_MEMBERS = (
    ("MSXDOS.SYS", 2432, "8f2577eec214ce947e74c740c82d4266ff2933978033433d4532385640b47231"),
    ("COMMAND.COM", 7168, "d4c1f030f585af8cae626af07ed5906759547042f109e7116ae2c38654c9b513"),
    ("DAAD.MDG", 2105, "c588b0e7cbdbd3a591085cd233d471c7a37fed85a88085ced8a560a42a759f06"),
    ("DAAD.Z80", 8400, "1df91cff49dc2dcb42f2e4321644b6e088a0ac63159444bb937a9bff5848a4ca"),
    ("YOURGAME.COM", 559, "cb0d307c041d873d18ae4a0779bf6aa404b2cf329f838b06e2d2d99e3afecbba"),
)


def _sha256(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def build_evidence() -> dict[str, object]:
    archive = ARCHIVE.read_bytes()
    if _sha256(archive) != ARCHIVE_SHA256:
        raise AssertionError("official R4 archive hash differs from the retained source claim")
    with ZipFile(ARCHIVE) as package:
        disk = package.read(ARCHIVE_MEMBER)
    if _sha256(disk) != DISK_SHA256:
        raise AssertionError("embedded MSX.DSK hash differs from the retained source claim")

    inspection = inspect_native_media("MSX.DSK", disk)
    if (
        inspection.status != "recognized_evidence"
        or inspection.validation != "validated_msx_dos_fat12_geometry"
        or inspection.evidence.get("boot_convention") != "msx-dos-eb-fe-90"
    ):
        raise AssertionError(f"MSX-DOS FAT12 validation failed: {inspection}")

    members = extract_fat12(disk)
    observed = tuple((name, len(payload), _sha256(payload)) for name, payload in members)
    if observed != EXPECTED_MEMBERS:
        raise AssertionError(f"MSX.DSK member sequence/hash mismatch: {observed!r}")

    return {
        "schema_version": 1,
        "primary_class": "repository-native",
        "requires_network": False,
        "source": {
            "archive_path": ARCHIVE.relative_to(ROOT).as_posix(),
            "archive_member": ARCHIVE_MEMBER,
            "archive_sha256": ARCHIVE_SHA256,
            "disk_sha256": DISK_SHA256,
        },
        "profile": {
            "identifier": "msx-dos-fat12-currently-verified-2dd-9",
            "boot_convention": "msx-dos-eb-fe-90",
            "validation": inspection.validation,
            "evidence": inspection.evidence,
            "boundary": "Current evidence-backed profile, not a terminal MSX geometry whitelist.",
        },
        "members": [
            {"name": name, "size": size, "sha256": digest}
            for name, size, digest in EXPECTED_MEMBERS
        ],
        "external_validators": [],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="write the deterministic evidence report")
    args = parser.parse_args()
    rendered = json.dumps(build_evidence(), indent=2, sort_keys=True) + "\n"
    if args.write:
        OUTPUT.parent.mkdir(parents=True, exist_ok=True)
        OUTPUT.write_text(rendered, encoding="utf-8")
    elif not OUTPUT.is_file() or OUTPUT.read_text(encoding="utf-8") != rendered:
        raise AssertionError("MSX evidence report differs; rerun with --write after reviewing retained inputs")
    print("Official DAAD R4 MSX disk verified: 5 native FAT12 members, exact hashes.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

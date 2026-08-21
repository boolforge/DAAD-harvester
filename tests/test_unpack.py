import pytest
import io
import zipfile
import tarfile
from unittest.mock import patch, MagicMock
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester import unpack as unpack_module
from daad_harvester.unpack import Unpacker, compute_hashes
from daad_harvester.daad_parser import DAADBytecodeParser

def test_compute_hashes():
    data = b"Hello DAAD Harvester " * 500
    res = compute_hashes(data)
    assert len(res["md5_full"]) == 32
    assert len(res["md5_5000"]) == 32
    assert len(res["md5_tail5000"]) == 32
    assert len(res["sha1"]) == 40
    assert len(res["sha224"]) == 56
    assert len(res["sha256"]) == 64
    assert len(res["sha384"]) == 96
    assert len(res["sha512"]) == 128
    assert len(res["sha3_256"]) == 64
    assert len(res["sha3_512"]) == 128
    assert len(res["crc32"]) == 8
    assert len(res["adler32"]) == 8
    if res["xxh32"]:
        assert len(res["xxh32"]) == 8
        assert len(res["xxh64"]) == 16
        assert len(res["xxh128"]) == 32

def test_unpack_zip(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")

    zip_path = tmp_path / "sample.zip"
    with zipfile.ZipFile(zip_path, "w") as zf:
        zf.writestr("test1.txt", b"file1 content")
        zf.writestr("sub/test2.txt", b"file2 content")

    items = unpacker.unpack_zip(zip_path)
    assert len(items) == 2
    filenames = [item[0] for item in items]
    assert "test1.txt" in filenames
    assert "sub/test2.txt" in filenames

def test_unpack_tar(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")

    tar_path = tmp_path / "sample.tar"
    with tarfile.open(tar_path, "w") as tf:
        data = b"tar content"
        ti = tarfile.TarInfo(name="inside.txt")
        ti.size = len(data)
        tf.addfile(ti, io.BytesIO(data))

    items = unpacker.unpack_tar(tar_path)
    assert len(items) == 1
    assert items[0][0] == "inside.txt"
    assert items[0][1] == b"tar content"

def test_unpack_tap_spectrum(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")

    # Construct mock TAP data
    # Header block: 19 bytes, flag 0x00
    header_payload = b"\x00\x00GAME      \x00\x00\x00\x00\x00\x00\x00"
    header_block = len(header_payload).to_bytes(2, "little") + header_payload

    # Data block: flag 0xFF + payload + checksum
    data_payload = b"\xFF\x01\x02\x03\x04\x05\x00"
    data_block = len(data_payload).to_bytes(2, "little") + data_payload

    tap_data = header_block + data_block
    items = unpacker.unpack_tap(tap_data)
    assert len(items) == 1
    assert items[0][0] == "GAME.bas"
    assert items[0][1] == b"\x01\x02\x03\x04\x05"

def test_unpack_zip_bomb_protection(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")

    # Default ratio is 100x (see config.py: retro disk/tape images are mostly
    # zero-padding and routinely compress 20-50x+, so a lower threshold was
    # rejecting legitimate DAAD disk images as false-positive "zip bombs").
    assert unpacker._is_zip_bomb(compressed_size=1, uncompressed_size=150) is True    # 150x -> bomb
    assert unpacker._is_zip_bomb(compressed_size=100, uncompressed_size=500) is False  # 5x -> a real, if compressible, disk image

def test_unpack_cli_fallback(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    sample_file = tmp_path / "sample.7z"
    sample_file.write_bytes(b"mock 7z data")

    def mock_subprocess_run(cmd, **kwargs):
        # cmd: ['7z', 'x', '-y', '-o<tmpdir>', '<file_path>']
        out_dir = Path(cmd[3][2:])
        (out_dir / "extracted_file.txt").write_bytes(b"uncompressed payload")
        res = MagicMock()
        res.returncode = 0
        return res

    with patch.object(unpack_module, "py7zr", None), \
         patch("shutil.which", return_value="/usr/bin/7z"), \
         patch("subprocess.run", side_effect=mock_subprocess_run):
        items = unpacker.unpack_7z(sample_file)
        assert len(items) == 1
        assert items[0][0] == "extracted_file.txt"
        assert items[0][1] == b"uncompressed payload"

def test_unpack_rar_cli_fallback(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    sample_file = tmp_path / "sample.rar"
    sample_file.write_bytes(b"mock rar data")

    def mock_subprocess_run(cmd, **kwargs):
        out_dir = Path(cmd[4].rstrip("/"))
        (out_dir / "rar_extracted.txt").write_bytes(b"rar payload")
        res = MagicMock()
        res.returncode = 0
        return res

    with patch.object(unpack_module, "rarfile", None), \
         patch("shutil.which", side_effect=lambda t: "/usr/bin/unrar" if t == "unrar" else None), \
         patch("subprocess.run", side_effect=mock_subprocess_run):
        items = unpacker.unpack_rar(sample_file)
        assert len(items) == 1
        assert items[0][0] == "rar_extracted.txt"
        assert items[0][1] == b"rar payload"

def test_sanitize_filename_punycode():
    from daad_harvester.unpack import sanitize_filename, safe_write_bytes

    # Test non-printable / control character filename sanitization
    raw = "\x01WERNER'S QUEST"
    clean = sanitize_filename(raw)
    assert "\x01" not in clean
    assert "WERNER" in clean or "xn--" in clean

    raw_path = "subfolder/test?\x02file.txt"
    clean_path = sanitize_filename(raw_path)
    assert "?" not in clean_path
    assert "\x02" not in clean_path

def test_safe_write_bytes_fallback(tmp_path):
    from daad_harvester.unpack import safe_write_bytes

    normal_file = tmp_path / "valid.bin"
    res_path = safe_write_bytes(normal_file, b"test bytes")
    assert res_path.exists()
    assert res_path.read_bytes() == b"test bytes"

    # Simulate permission error on primary path
    bad_file = tmp_path / "protected" / "file.bin"
    bad_file.parent.mkdir(parents=True, exist_ok=True)
    orig_write = Path.write_bytes

    def mock_write(self, data):
        if self == bad_file:
            raise PermissionError("No permission")
        return orig_write(self, data)

    with patch.object(Path, "write_bytes", autospec=True, side_effect=mock_write):
        fallback_res = safe_write_bytes(bad_file, b"fallback content")
        assert fallback_res.exists()
        assert "fallback_" in fallback_res.name

def test_unpack_source_single_status_update(tmp_path):
    from daad_harvester.models import SourceRecord, SourceStatus

    db = Database(tmp_path / "test.db")
    src_id = db.add_source("http://example.com/test.zip", "archive")

    src_zip = tmp_path / "test.zip"
    with zipfile.ZipFile(src_zip, "w") as zf:
        zf.writestr("game.ddb", b"DAAD mock data " * 10)

    db.update_source_status(src_id, status=SourceStatus.DOWNLOADED.value, local_path=str(src_zip))

    sources = db.get_all_sources()
    src_record = next(s for s in sources if s.id == src_id)

    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    count = unpacker.unpack_source_single(src_record)

    # 2 artifacts recorded: depth0 (test.zip itself) + depth1 (game.ddb extracted)
    assert count == 2
    updated_sources = db.get_all_sources()
    updated_src = next(s for s in updated_sources if s.id == src_id)
    assert updated_src.status == SourceStatus.UNPACKED.value


def test_unpack_retained_torreoscura_cpc_system_dsk_extracts_ddb() -> None:
    root = Path(__file__).resolve().parents[1]
    disk = root / "preservation_corpus/extracted/depth1_d3410775_TO2.DSK"
    unpacker = Unpacker(Database(root / "preservation_corpus/state.db"))
    files = dict(unpacker.unpack_dsk(disk.read_bytes()))
    assert {"PARTE002.CHR", "PARTE002.DAT", "PARTE002.DDB"} <= set(files)
    parsed = DAADBytecodeParser().parse_ddb(files["PARTE002.DDB"], "PARTE002.DDB")
    assert parsed["is_daad"] is True
    assert parsed["ddb_format"] == "daad-v2-legacy"
    assert parsed["platform"] == "pcw"
    assert parsed["details"]["payload_size"] == 14817

def test_unpack_zip_error_cli_fallback(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")

    bad_zip = tmp_path / "unsupported_method.zip"
    bad_zip.write_bytes(b"PK\x03\x04 corrupt or unsupported zip file")

    def mock_subprocess_run(cmd, **kwargs):
        out_dir = Path(kwargs.get("cwd") or tmp_path)
        (out_dir / "unzipped.ddb").write_bytes(b"unzipped content")
        res = MagicMock()
        res.returncode = 0
        return res

    with patch("shutil.which", side_effect=lambda t: "/usr/bin/unzip" if t == "unzip" else None), \
         patch("subprocess.run", side_effect=mock_subprocess_run):
        items = unpacker.unpack_zip(bad_zip)
        assert len(items) == 1
        assert items[0][0] == "unzipped.ddb"
        assert items[0][1] == b"unzipped content"

def test_unpack_arj_cli_fallback(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    arj_path = tmp_path / "game.arj"
    arj_bytes = b"\x60\xea" + b"arj header payload"
    arj_path.write_bytes(arj_bytes)

    def mock_subprocess_run(cmd, **kwargs):
        out_dir = Path(kwargs.get("cwd"))
        (out_dir / "game.ddb").write_bytes(b"arj extracted data")
        res = MagicMock()
        res.returncode = 0
        return res

    with patch("shutil.which", side_effect=lambda t: "/usr/bin/arj" if t == "arj" else None), \
         patch("subprocess.run", side_effect=mock_subprocess_run):
        items = unpacker.extract_container(arj_path, arj_path.name, arj_bytes)
        assert len(items) == 1
        assert items[0][0] == "game.ddb"
        assert items[0][1] == b"arj extracted data"

def test_unpack_retry_failed_and_partially_unpacked_sources(tmp_path):
    from daad_harvester.models import SourceRecord, SourceStatus

    db = Database(tmp_path / "test.db")
    src_failed_id = db.add_source("http://example.com/failed.zip", "archive")
    src_partial_id = db.add_source("http://example.com/partial.zip", "archive")

    zip_file = tmp_path / "test.zip"
    with zipfile.ZipFile(zip_file, "w") as zf:
        zf.writestr("data.ddb", b"retry data")

    db.update_source_status(src_failed_id, status="failed", local_path=str(zip_file))
    db.update_source_status(src_partial_id, status="partially_unpacked", local_path=str(zip_file))

    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    total_artifacts = unpacker.unpack_all_downloaded_sources(parallel=1)

    assert total_artifacts > 0
    updated_failed = next(s for s in db.get_all_sources() if s.id == src_failed_id)
    updated_partial = next(s for s in db.get_all_sources() if s.id == src_partial_id)
    assert updated_failed.status == SourceStatus.UNPACKED.value
    assert updated_partial.status == SourceStatus.UNPACKED.value


def _build_extended_cpc_dsk_with_one_file() -> tuple[bytes, bytes]:
    """Create a minimal one-track CP/M CPC DSK for parser regression tests."""
    disk_header = bytearray(0x100)
    disk_header[:23] = b"EXTENDED CPC DSK File\r\n"
    disk_header[0x30] = 1
    disk_header[0x31] = 1
    disk_header[0x34] = 0x13  # 0x100-byte track header + 9 * 512-byte sectors

    track_header = bytearray(0x100)
    track_header[:12] = b"Track-Info\r\n"
    track_header[0x14] = 2
    track_header[0x15] = 9
    for index in range(9):
        offset = 0x18 + index * 8
        track_header[offset:offset + 8] = bytes([0, 0, 0xC1 + index, 2, 0, 0, 0, 2])

    sectors = bytearray(9 * 512)
    directory = bytearray(32)
    directory[0] = 0
    directory[1:9] = b"GAME    "
    directory[9:12] = b"BIN"
    directory[15] = 8  # eight 128-byte records
    directory[16] = 2  # logical allocation block 2 starts at byte 2048
    sectors[:32] = directory
    payload = b"DAAD" + b"\x7f" * 1020
    sectors[2048:2048 + len(payload)] = payload
    return bytes(disk_header + track_header + sectors), payload


def test_unpack_dsk_reconstructs_cpm_extent_payload(tmp_path):
    db = Database(tmp_path / "test.db")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    disk, payload = _build_extended_cpc_dsk_with_one_file()

    assert unpacker.unpack_dsk(disk) == [("GAME.BIN", payload)]

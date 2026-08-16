import pytest
import io
import zipfile
import tarfile
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.unpack import Unpacker, compute_hashes

def test_compute_hashes():
    data = b"Hello DAAD Harvester " * 500
    m_full, m_5000, sha = compute_hashes(data)
    assert len(m_full) == 32
    assert len(m_5000) == 32
    assert len(sha) == 64

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

    assert unpacker._is_zip_bomb(compressed_size=10, uncompressed_size=200) is True
    assert unpacker._is_zip_bomb(compressed_size=100, uncompressed_size=500) is False

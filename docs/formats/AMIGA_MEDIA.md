# Amiga Media: ADF, ADZ, and DMS

| Header field | Value |
| --- | --- |
| **Question** | How does Harvester preserve raw Amiga media while conditionally reconstructing validated ADF/OFS/FFS content from ADF, ADZ, and DMS inputs? |
| **Evidence scope** | P0 ADF and xDMS references; P1 native DMS/ADF parser tests. |
| **Status** | implementation contract |
| **Implementation links** | [`../../daad_harvester/dms.py`](../../daad_harvester/dms.py), [`../../daad_harvester/platform_media.py`](../../daad_harvester/platform_media.py), [`../../daad_harvester/media_inspection.py`](../../daad_harvester/media_inspection.py), [`../../tests/test_dms.py`](../../tests/test_dms.py) |
| **Non-claims** | ADF size/magic or a DMS header is not a validated filesystem extraction; an IPF/protected disk is not reconstructible as a generic ADF without dedicated evidence. |

## Layered preservation model

| Input | Recognition / integrity | Safe output | Retained relationship |
| --- | --- | --- | --- |
| ADF | Sector image/block arithmetic plus filesystem block checks. | Validated OFS/FFS members where reachable. | Raw ADF hash and block-chain provenance. |
| ADZ | Gzip decompression plus result identity. | ADF child only if decompression succeeds; then normal ADF validation. | ADZ parent → ADF child lineage. |
| DMS | Archive/track framing, CRC-16/ARC, checksum and compression-mode decoding. | Reconstructed ADF only after all required track validations. | DMS parent → byte-exact ADF child lineage. |

## DMS modes and integrity

The native decoder handles the documented `NOCOMP`, `SIMPLE`, `QUICK`, `MEDIUM`, `DEEP`, `HEAVY1`, and `HEAVY2` modes, retaining decoder state where the track format requires it. It validates track-header CRC, packed payload integrity, and unpacked checksums before returning output. Encrypted or invalid tracks produce a precise failure/evidence result, never a partial ADF presented as complete.[1] [2]

## ADF traversal boundary

ADF is a raw sector-dump representation; filesystem extraction requires validating AmigaDOS boot/root/file/directory/extension block relationships and their checksums. An image can therefore be recognized yet yield no trusted member extraction. Extension blocks are preservation evidence, not optional bytes to discard.[1]

## References

[1]: http://lclevy.free.fr/adflib/adf_info.html "ADF format FAQ"
[2]: https://github.com/mlund/xdms-rs "xDMS reference implementation"

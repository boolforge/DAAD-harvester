# DAAD Harvester - Architecture & Forensic Roadmap (TODO.md)

This document tracks technical roadmap items, forensic enhancements, and continuous improvement steps for `daad_harvester`.

---

## 🎯 High-Priority Roadmap

- [x] **Deep Forensic DAAD Parser (`daad_parser.py`)**
  - [x] Implement binary validation of 16-bit process table offset pointers (Proceso 0..n).
  - [x] Implement canonical DAAD vocabulary verb dictionary checks (Spanish and English).
  - [x] Implement system message text scanner.
  - [x] Rejects non-DAAD binaries (RenPy `.data`, PAWS, GAC, SWAN, raw HTML/PHP responses).

- [x] **Multi-Algorithm Cryptographic & Retro Hash Suite**
  - [x] Compute MD5 (Full, 5KB head, 5KB tail), SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, SHA3-256, SHA3-512, BLAKE2b, BLAKE2s, CRC32, Adler32.
  - [x] Integrate fast non-cryptographic hashes: XXH32, XXH64, XXH128 via `xxhash`.
  - [x] Store extended hashes in SQLite database schema.

- [x] **Dedicated DAAD Games Logger (`daad_games.log`)**
  - [x] Log structured records for every verified DAAD game payload.
  - [x] Record timestamp, title, platform, version, source URL, path, and full hash suite.

- [x] **Mass Multi-Source Discovery Crawlers**
  - [x] Internet Archive Search API & CDX Wayback recovery.
  - [x] Aminet Amiga Software Archive crawler.
  - [x] GitHub Search API (DAAD Ready repositories).
  - [x] itch.io game catalog parser.
  - [x] WikiCAAD MediaWiki API crawler.
  - [x] ZXDB & Spectrum Computing crawlers.
  - [x] IFDB & IF Archive crawlers.

- [x] **Advanced Rich TUI Dashboard**
  - [x] Live interactive status layout showing config, ETL counters, and DAAD game discovery feed.
  - [x] Support `--tui` CLI flag.

---

## 🚀 Ongoing / Future Refinements

- [ ] **DAADconds & DAADacts Bytecode Disassembler**
  - Disassemble opcode byte streams for deeper logic verification and extraction of object titles and location room descriptions.
- [ ] **ROMset Container Header Stripping**
  - Automatically strip emulator disk/tape container headers (e.g., Extended DSK headers, TAP headers) to compute raw payload hashes for cross-container matching.
- [ ] **Async HTTP/2 Crawler Scaling**
  - Optimize `httpx` async transport with HTTP/2 connection pooling across retro databases.

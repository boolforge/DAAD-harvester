# 🗡️ DAAD Harvester

[![Python 3.10+](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/downloads/)
[![Android / Termux Ready](https://img.shields.io/badge/Android-Termux%20Ready-brightgreen.svg)](#-android--termux-installation)
[![ScummVM Detection](https://img.shields.io/badge/ScummVM-Detection%20Tables-orange.svg)](https://www.scummvm.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/status-active-success.svg)](#)

A high-performance, resilient ETL pipeline and forensic analysis tool designed for discovering, downloading, recursively unpacking, fingerprinting, and synthesizing ScummVM detection tables for **DAAD (Designed Action Artwork System)** adventure game artifacts across retro-computing archives.

---

## 📖 Overview & Historical Context

### What is DAAD?
Created in the late 1980s by Tim Gilberts for Spanish game developer **Aventuras AD**, the **Designed Action Artwork System (DAAD)** was a state-of-the-art text adventure authoring system and virtual machine. Successor to *The Quill* and *PAWS*, DAAD allowed authors to write a single adventure game source file and target multiple 8-bit and 16-bit platforms:

- **Sinclair ZX Spectrum** (48K / 128K)
- **Amstrad CPC**
- **Commodore 64**
- **Amiga**
- **Atari ST**
- **MS-DOS / IBM PC**
- **MSX / MSX2**
- **Oric / Atmos**

DAAD powered classic Spanish graphic adventure software (*La Aventura Original*, *El Jabato*, *La Diosa de Cozumel*, *Los Templarios*, *Chichén Itzá*), and continues to see active homebrew development today via modern tools like *DAAD Ready*.

---

## 🏗️ Architecture & Pipeline Design

DAAD Harvester operates as an idempotent, 5-stage ETL pipeline backed by a local SQLite state database (`state.db`) in WAL mode for full resumability.

![DAAD Harvester Pipeline Architecture](docs/architecture.svg)

### Key Pipeline Stages

1. **Discovery (`daad_harvester.discover`)**: Crawls high-yield retro archives (Internet Archive, GitHub DAAD Ready repos, IF Archive, WikiCAAD, Aminet, IFDB, ZXDB, Spectrum Computing) using strict filters to eliminate non-game software.
2. **Fetch (`daad_harvester.fetch`)**: Asynchronous downloader with per-domain rate limiting, user-agent randomization, proxy rotation, and Wayback Machine CDX API fallback for broken links.
3. **Unpack (`daad_harvester.unpack`)**: Multi-layer recursive container extraction (ZIP, 7Z, RAR, DSK disk images, TAP/TZX tape dumps, D64, ARJ, LHA, CAB, TAR, ZOO, ARC) with zip-bomb protection.
4. **Fingerprint (`daad_harvester.fingerprint`)**: Deep binary inspection checking 16-bit process table offset pointers (Proceso 0, 1, 2), DAAD vocabulary tokens, and system strings while rejecting non-DAAD binaries.
5. **Synthesize & Report (`daad_harvester.synthesize`)**: Generates ScummVM C++ `ADGameDescription` entries (`detection_tables.h`), JSON catalogs (`daad_catalog.json`), and structured real-time discovery logs (`output/logs/`).

---

## 📊 Live Interactive TUI Dashboard Showcase

Launch the harvester with `--tui` to display a real-time, flicker-free Rich dashboard showing live ETL counters, phase progress, and identified DAAD game payloads:

```text
╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 🗡️ DAAD ENGINE HARVESTER & FORENSIC SUITE                     v1.0.0 | Phase: 4. FINGERPRINT │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭──────────────── Configuration Settings ────────────────╮╭───────────── Live ETL Statistics ──────────────╮
│  Output Dir        ./output                            ││  Discovered Sources                       184  │
│  Logs Dir          ./output/logs                       ││  Downloaded Sources                       128  │
│  DB Path           ./output/state.db                   ││  Unpacked Sources                          96  │
│  Workers           8                                   ││  Extracted Artifacts                      412  │
│  Rate Limit        1.0 req/s                           ││  Verified DAAD Games                       28  │
│  Max Depth         5                                   ││  ScummVM Catalog Entries                   28  │
╰────────────────────────────────────────────────────────╯╰────────────────────────────────────────────────╯
╭────────────────────────────────── Verified DAAD Games Feed (Live) ───────────────────────────────╮
│ ┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┳──────────────┓ │
│ ┃ ID  ┃ Game Title            ┃ Platform ┃ Engine Version  ┃ MD5 (Full)          ┃         Size ┃ │
│ ┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━┩ │
│ │ 1   │ La Aventura Original  │ DOS      │ DAAD DDB        │ a1b2c3d4e5f67890... │     142.5 KB │ │
│ │ 2   │ El Jabato             │ ZX       │ DAAD DDB        │ 8f7e6d5c4b3a2109... │      48.0 KB │ │
│ │ 3   │ La Diosa de Cozumel   │ AMIGA    │ DAAD DDB        │ 1234567890abcdef... │     720.0 KB │ │
│ │ 4   │ Chichén Itzá          │ CPC      │ DAAD DDB        │ 9e8d7c6b5a4f3e21... │     192.0 KB │ │
│ └─────┴───────────────────────┴──────────┴─────────────────┴─────────────────────┴──────────────┘ │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
```

---

## 🛠️ System Requirements & Installation

### Prerequisites
- **Python 3.10+**
- System extraction packages for maximum archive support (`p7zip`, `unzip`, `unar`, `unrar`, `cabextract`, `arj`, `lhasa`).

#### Ubuntu / Debian:
```bash
sudo apt-get update && sudo apt-get install -y p7zip-full unzip unar libarchive-tools unrar cabextract arj lhasa 7zip
```

#### macOS (Homebrew):
```bash
brew install p7zip unzip unar libarchive unrar cabextract arj lhasa 7zip
```

---

## 📱 Android / Termux Installation & Execution

DAAD Harvester is fully optimized for **Android Termux** environments, avoiding `glibc` screen flickering and lockups.

### 1. Install Dependencies in Termux:
```bash
pkg update && pkg upgrade -y
pkg install -y python python-pip git clang libxml2 libxslt libarchive p7zip unzip unar unrar cabextract
```

### 2. Clone & Setup Repository:
```bash
git clone https://github.com/boolforge/daad-harvester.git
cd daad-harvester
pip install -r requirements.txt
```

### 3. Run Pipeline with Termux-Friendly TUI:
```bash
python3 -m daad_harvester --tui --output-dir ./output
```

---

## 🚀 Usage Guide

### Run Full Harvester Pipeline
```bash
python3 -m daad_harvester --tui --output-dir ./output
```

### Run Specific Pipeline Phase
```bash
# Phase 1: Discover URLs & archives
python3 -m daad_harvester --phase discover --output-dir ./output

# Phase 2: Fetch files asynchronously
python3 -m daad_harvester --phase fetch --parallel 8 --output-dir ./output

# Phase 3: Unpack archives & disk images recursively
python3 -m daad_harvester --phase unpack --output-dir ./output

# Phase 4: Forensic fingerprinting
python3 -m daad_harvester --phase fingerprint --output-dir ./output

# Phase 5: Synthesize ScummVM detection tables
python3 -m daad_harvester --phase synthesize --output-dir ./output
```

---

## 🪵 Dedicated Tagged Logging Suite (`output/logs/`)

All execution events are written to structured, timestamp-tagged rotating log files inside `output/logs/`:

- **`daad_general.log`**: Overall system lifecycle, configuration, and phase status.
- **`daad_games.log`**: Verified DAAD games, title metadata, platform hints, and full cryptographic hash suites (`MD5`, `SHA-256`, `SHA-1`, `CRC32`, `XXH64`).
- **`daad_errors.log`**: General system errors, network failures, and unhandled exceptions.
- **`daad_compression_errors.log`**: Detailed extraction errors, corrupt archives, and tool fallbacks.
- **`daad_downloads.log`**: Download attempts, HTTP response codes, and Wayback Machine CDX recovery attempts.
- **`daad_discovery.log`**: Crawler queries, domain status, and discovered source count breakdown.

---

## 🧪 Testing

Run unit and integration tests using `pytest`:
```bash
PYTHONPATH=. python3 -m pytest tests/
```

---

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

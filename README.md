# DAAD Engine Harvester

A specialized, resilient ETL pipeline and forensic analysis tool for discovering, downloading, recursively unpacking, fingerprinting, and generating ScummVM detection tables for **DAAD (Designed Action Artwork System)** adventure game artifacts across retro-computing archives.

---

## 📖 Overview & Historical Context

### What is DAAD?
Created in the late 1980s by Tim Gilberts for Spanish game developer **Aventuras AD**, the **Designed Action Artwork System (DAAD)** was a state-of-the-art text adventure authoring system and virtual machine. As the direct successor to Gilberts' previous authoring systems—*The Quill* and *PAWS (Professional Adventure Writer System)*—DAAD empowered authors to write a single adventure game source file and target multiple 8-bit and 16-bit platforms, including:
- **Sinclair ZX Spectrum** (48K / 128K)
- **Amstrad CPC**
- **Commodore 64**
- **Amiga**
- **Atari ST**
- **MS-DOS / IBM PC**
- **MSX / MSX2**
- **Oric / Atmos**

DAAD games played a monumental role in the golden age of Spanish graphic adventure software (*La Aventura Original*, *Jabato*, *Cozumel*, *Los Templarios*), and the engine continues to see active homebrew development today thanks to modern tooling like *DAAD Ready*.

---

## 🎯 Project Motivation & Purpose

Integrating historical game engines into [ScummVM](https://www.scummvm.org/) requires **detection tables**—serialized C++ data structures containing metadata (`game_id`, `title`, `platform`, `language`) paired with byte-level forensic hashes (`MD5` of full file, `MD5` of first 5,000 bytes, `SHA-256`, file size) to identify known release versions.

Manually collecting, uncompressing multi-layer archives, extracting disk images (`.dsk`, `.d64`), parsing tape dumps (`.tap`), identifying valid DAAD database headers, and constructing C++ structs is slow and error-prone.

**DAAD Harvester** automates this entire pipeline:
1. **Discovers** DAAD game download links across retro databases (ZXDB, IFDB, Spectrum Computing, WikiCAAD, IF Archive).
2. **Downloads** artifacts with proxy rotation, domain rate-limiting, and Internet Archive Wayback Machine CDX recovery for dead links.
3. **Recursively Unpacks** nested archives (`.zip`, `.7z`, `.rar`, `.tar`), disk images (`.dsk`, `.d64`), and tape dumps (`.tap`).
4. **Fingerprints** extracted binary payloads using byte-level heuristics to identify true DAAD databases while filtering out false positives (PAWS, SWAN, GAC).
5. **Synthesizes** ready-to-compile ScummVM C++ detection headers (`detection_tables.h`), JSON catalogs (`daad_catalog.json`), and comprehensive markdown reports (`scrape_report.md`).

---

## 🏗️ Architecture & Pipeline Design

DAAD Harvester operates as an idempotent, 5-stage ETL (Extract, Transform, Load) pipeline backed by a local SQLite database (`state.db`) for state persistence and resumability.

```
                  ┌──────────────────────────────┐
                  │    1. Discovery Phase        │
                  │ (IF Archive, ZXDB, IFDB, etc)│
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │      2. Fetch Phase          │
                  │ (Async HTTP, Wayback CDX)    │
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │      3. Unpack Phase         │
                  │  (ZIP, 7Z, RAR, DSK, TAP)    │
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │    4. Fingerprint Phase      │
                  │ (DDB Process Table Heuristics)│
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │ 5. Synthesize & Report Phase │
                  │(detection_tables.h, Catalog) │
                  └──────────────────────────────┘
```

### 1. Discovery (`daad_harvester.discover`)
Crawls external retro computing APIs and directory structures for DAAD game entries and archive download links:
- **ZXDB API**: ZX Spectrum database queries.
- **IFDB API**: Interactive Fiction Database tags (`daad`, `aventuras ad`).
- **WikiCAAD**: Spanish adventure gaming wiki API and page parsing.
- **Spectrum Computing**: Dedicated ZX Spectrum catalog links.
- **IF Archive**: Deep directory index traversals.

### 2. Fetch (`daad_harvester.fetch`)
- Asynchronous parallel downloder using `httpx` and `aiofiles`.
- **Domain Rate Limiting**: Prevents hitting remote host ban limits.
- **Wayback Fallback**: Automatically queries the Internet Archive CDX API when encountering `404 Not Found` or `410 Gone` errors to retrieve historical snapshots.
- **Content-Disposition & Path Resolution**: Extracts original filenames accurately.

### 3. Unpack (`daad_harvester.unpack`)
Recursively extracts nested containers up to a configurable maximum depth (default: 5 levels):
- **Archives**: `.zip`, `.7z`, `.rar`, `.tar.gz`, `.tar.bz2`, `.xz`.
- **Disk Images**: Amstrad CPC / Spectrum +3 `.dsk` (parsing track/sector CP/M catalog entries), Commodore 64 `.d64` (parsing BAM track 18 sector 1 directory entries).
- **Tape Dumps**: ZX Spectrum `.tap` (parsing header blocks and extracting data blocks).
- **Zip Bomb Protection**: Enforces compressed-to-uncompressed expansion ratio limits (default: 10x).

### 4. Fingerprint (`daad_harvester.fingerprint`)
Performs byte-level forensic inspection on unpacked files:
- **Rejection Engine**: Explicitly filters out PAWS, SWAN, and Graphic Adventure Creator (GAC) files.
- **Process Table Verification**: Inspects the first 16 bytes for 16-bit little-endian offset pointers pointing to Proceso 0, Proceso 1, and Proceso 2, ensuring ascending order and valid file boundary offsets.
- **Keyword & String Scoring**: Analyzes presence of DAAD vocabulary strings (`COGER`, `DEJAR`, `MIRAR`, `NORTE`, `SUR`, `ESTE`, `OESTE`).
- **Platform Detection**: Classifies targets as ZX Spectrum, Amstrad CPC, C64, Amiga, Atari ST, MS-DOS, or MSX.

### 5. Synthesize & Report (`daad_harvester.synthesize`, `daad_harvester.report`)
Generates output artifacts:
- `detection_tables.h`: Ready-to-use C++ `ADGameDescription` entries formatted for ScummVM engine registration.
- `daad_catalog.json`: Machine-readable JSON summary of all identified games and metadata.
- `scrape_report.md`: Markdown summary highlighting total URLs, download success rates, platform distribution, MD5 duplicate/collision reports, and coverage gaps.

---

## 🚀 Installation & Usage

### Prerequisites
- Python 3.10 or higher
- `pip`

### 1. Installation
Clone the repository and install required dependencies:
```bash
git clone https://github.com/user/daad-harvester.git
cd daad-harvester
pip install -r requirements.txt
```

### 2. Running the Pipeline
By default, running the harvester executes all pipeline phases sequentially:
```bash
python3 -m daad_harvester.cli --phase all --output-dir ./output
```

### 3. Command Line Arguments
```
options:
  -h, --help            Show this help message and exit
  --phase {discover,fetch,unpack,fingerprint,synthesize,all}
                        Pipeline phase to execute (default: all)
  --resume              Resume pipeline using existing state database
  --parallel PARALLEL   Number of parallel download workers (default: 8)
  --output-dir OUTPUT_DIR
                        Output directory for state database, downloads, and catalog reports
  --proxy-list PROXY_LIST
                        Path to proxy list text file (one proxy URL per line)
  --version             Show program version number and exit
```

### 4. Step-by-Step Phase Execution Example
You can run phases independently:
```bash
# 1. Discover sources
python3 -m daad_harvester.cli --phase discover --output-dir ./my_catalog

# 2. Download discovered sources
python3 -m daad_harvester.cli --phase fetch --parallel 4 --output-dir ./my_catalog

# 3. Recursively unpack archives and disk images
python3 -m daad_harvester.cli --phase unpack --output-dir ./my_catalog

# 4. Fingerprint extracted files
python3 -m daad_harvester.cli --phase fingerprint --output-dir ./my_catalog

# 5. Synthesize ScummVM C++ detection tables & report
python3 -m daad_harvester.cli --phase synthesize --output-dir ./my_catalog
```

---

## ⚙️ Configuration & Environment Variables

Settings can be customized via environment variables or a `.env` file in the root directory:

| Environment Variable | Default Value | Description |
| :--- | :--- | :--- |
| `DAAD_OUTPUT_DIR` | `./output` | Base output directory |
| `DAAD_DB_PATH` | `./output/state.db` | Path to SQLite state database |
| `DAAD_RATE_LIMIT_PER_DOMAIN` | `1.0` | Allowed requests per second per domain |
| `DAAD_REQUEST_TIMEOUT` | `30.0` | HTTP request timeout in seconds |
| `DAAD_MAX_RETRIES` | `3` | Maximum HTTP retry attempts |
| `DAAD_BACKOFF_BASE` | `1.0` | Base exponential backoff delay (seconds) |
| `DAAD_MAX_UNPACK_DEPTH` | `5` | Max nesting level for recursive unpacking |
| `DAAD_ZIP_BOMB_MAX_RATIO` | `10.0` | Max uncompressed/compressed size ratio limit |
| `DAAD_PARALLEL_WORKERS` | `8` | Parallel download worker concurrency |

---

## 🧪 Testing

The test suite covers unit tests for database operations, configuration, discovery crawlers, recursive unpacking, fingerprinting heuristics, C++ table synthesis, and full pipeline execution.

Run tests using `pytest`:
```bash
python3 -m pytest tests/
```

---

## 📄 License

This project is licensed under the MIT License.

# DAAD Harvester

**DAAD Harvester** is an evidence-led preservation pipeline for public DAAD game artifacts. It does not treat a search result, a catalog page, and a downloadable binary as interchangeable. Instead, it uses game databases and preservation wikis to establish **what a title is**, uses platform-specific archive metadata to establish **which release is being acquired**, and uses local byte-level analysis to establish **what the downloaded payload actually contains**.

DAAD, the *Diseñador de Aventuras AD*, was created for Aventuras AD and supported a broad family of 8-bit and 16-bit platforms.[1] The project exists because that history is fragmented: a title may have several platform releases, archive re-dumps, named master variants, incomplete metadata, and unrelated files that happen to contain the word “DAAD.” A reliable harvester must preserve those distinctions rather than collapsing them into a speculative download list.

> **Trust boundary:** A catalog can prove that a game belongs to the DAAD family. A source record can prove that a public archive associates a file with a platform. Only a downloaded artifact and the local fingerprinting stage can support a binary-level DAAD claim or an exact engine-version label.

![Authentic DAAD Harvester priority-queue capture](docs/assets/tui-priority-queue.png)

*This is a capture from the production TUI renderer against a completed live Internet Archive run. It shows six catalog-backed Amstrad CPC candidates selected before lower-priority sources; it is not a mockup or fabricated interface.*

## What problem does it solve?

Retro-game preservation needs more than a broad scraper. A naïve crawler accumulates HTML pages, purchase gates, dead links, screenshots, files for other authoring systems, and disconnected copies of a title. That creates a false appearance of coverage while wasting bandwidth and making provenance impossible to audit.

DAAD Harvester separates historical knowledge, source discovery, acquisition, extraction, and binary verification. The resulting state database is resumable and reviewable. A run may safely discover nothing from a given website; **zero candidates is preferable to a queue of guessed URLs**.

| Design question | How DAAD Harvester answers it | Result |
| --- | --- | --- |
| Is this a known DAAD title? | Match a title only against an evidence-backed catalog with explicit aliases and source URLs. | Known and unknown discoveries remain distinguishable. |
| Is this a CPC release? | Require source metadata such as Internet Archive’s CPC collection or emulator tag; never infer CPC from a generic `.dsk` suffix. | CPC priority is evidence-based, not filename-based. |
| Should it download first? | Order pending work by a persisted acquisition priority. Known commercial DAAD titles receive priority, with evidenced CPC releases first. | The “low-hanging fruit” is acquired before opportunistic search results. |
| Is it a DAAD binary and which version is it? | Apply byte-level fingerprinting after download and extraction. | The project does not claim exact versions from title metadata alone. |

## Historical evidence catalog

The initial catalog intentionally starts with the six commercial Aventuras AD titles that wikiCAAD explicitly identifies as DAAD games.[2] Computer Emu Zone and CASA independently provide title, year, and platform evidence for the historical releases.[3] [4]

| Canonical title | Year | Catalog-backed platform coverage | Engine statement | CPC acquisition priority |
| --- | ---: | --- | --- | ---: |
| *La Aventura Original* | 1989 | ZX Spectrum, CPC, C64, MSX, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |
| *Jabato* | 1989 | ZX Spectrum, CPC, C64, MSX, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |
| *Cozumel* | 1990 | ZX Spectrum, CPC, C64, MSX, PCW, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |
| *La Aventura Espacial* | 1990 | ZX Spectrum, CPC, C64, MSX, PCW, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |
| *Los Templos Sagrados* | 1991 | ZX Spectrum, CPC, C64, MSX, PCW, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |
| *Chichén Itzá* | 1992 | ZX Spectrum, CPC, C64, MSX, Atari ST, Amiga, PC | DAAD family confirmed; exact binary build requires fingerprinting. | 1200 |

The catalog is deliberately conservative about version language. For example, CPC Power records both a 1992 original *Chichen Itza* disk and a dated 1991-10-14 master variant.[5] That is useful **release-variant evidence**, but it does not prove a DAAD compiler version. The generated `evidence_catalog.json` preserves this boundary so an exact engine label is emitted only after the artifact itself has been inspected.

## Architecture and data flow

The pipeline stores all mutable state in SQLite and can resume each stage independently. `--phase all` runs the catalog stage after discovery and before fetching, allowing the queue to be inspected or bounded before bulk acquisition.

| Stage | Component | Input | Output | Purpose |
| --- | --- | --- | --- | --- |
| 1. Discover | `daad_harvester.discover` | Public APIs and bounded source catalogs | Direct artifact candidates | Adapters enforce source-specific direct-file contracts. |
| 2. Catalog | `daad_harvester.catalog` | Known-game evidence plus queued sources | `evidence_catalog.json` | Shows canonical titles, platform evidence, priority, and source provenance. |
| 3. Fetch | `daad_harvester.fetch` | Priority-ordered pending sources | Local files and HTTP evidence | Streams files, rejects empty/HTML/JSON payloads, and records final HTTP outcomes. |
| 4. Unpack | `daad_harvester.unpack` | Downloaded containers and disk images | Extracted artifacts | Recursively handles supported archives, tape images, C64 disks, and CP/M files in CPC DSK images. |
| 5. Fingerprint | `daad_harvester.fingerprint` | Local extracted bytes | DAAD evidence, hashes, and platform hints | Performs conservative binary analysis; it is the authority for binary claims. |
| 6. Synthesize and report | `daad_harvester.synthesize`, `daad_harvester.report` | Verified records | JSON catalog, C++ candidates, and report | Repeats deterministically without another download. |

### Source contracts

Each adapter is evaluated by its direct-artifact contract, not merely whether a site returns HTTP 200.

| Source | Role | Trust boundary |
| --- | --- | --- |
| [Internet Archive][6] | Primary historical archive and CPC source. | Uses Advanced Search and item metadata; CPC priority is assigned only when the collection or emulator metadata identifies CPC. |
| GitHub | Public project archives and preservation repositories. | Resolves each repository’s actual default branch instead of assuming `main`. |
| Aminet | Amiga candidates. | Queues only direct compatible files from its DAAD search results. |
| [ZXInfo / ZXDB][7] | Spectrum release metadata and direct file paths. | Uses the documented API, rejects unsupported engines and snapshots, and resolves compatible files through Spectrum Computing. |
| [World of Spectrum][8] | Bounded ZX Spectrum source. | Follows the Aventuras AD catalog to pages with explicit DAAD authorship, then accepts only host-local tape or disk archives. |
| WikiCAAD and CASA | Historical evidence sources. | Inform the catalog; they are not treated as automatic binary download sites. |
| CPC Power | CPC release-variant evidence. | Its public download handler is session-bound HTML, not a stable direct-file contract, so it is metadata-only. |
| Planet Emulation | CPC metadata and individual-file pages. | Its own FAQ states that browser download is the supported method and that temporary links are user-specific; it is not automated.[9] |
| itch.io, IFDB, web search, and IF Archive | Opportunistic evidence or discovery. | A page, account, payment, or gated link is never queued as an artifact. Broad IF Archive crawling is intentionally disabled. |

## Installation

DAAD Harvester is a Python package with a console entry point. Python 3.10 or newer is required.

```bash
git clone https://github.com/boolforge/DAAD-harvester.git
cd DAAD-harvester

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e ".[dev]"

daad-harvester --version
daad-harvester --help
```

Install `.` instead of `.[dev]` when test dependencies are not needed.

For broad legacy-archive support on Debian or Ubuntu, install the optional system extractors.

```bash
sudo apt-get update
sudo apt-get install -y 7zip unzip unar libarchive-tools unrar-free cabextract arj lhasa
```

## Recommended first run: catalog, inspect, then acquire

Use a dedicated output directory. It may contain downloaded copyrighted material, logs, and a local SQLite database; it must not be committed.

First, discover current public candidates and write the evidence catalog.

```bash
daad-harvester --phase discover --output-dir ./output
daad-harvester --phase catalog --output-dir ./output
```

Review `output/evidence_catalog.json`. The file states what is catalog-backed, lists each matched source, and makes the version-evidence boundary explicit. A quick inspection can use any JSON viewer or `less`.

```bash
less ./output/evidence_catalog.json
```

Next, acquire only the highest-priority low-hanging fruit. The following command fetches the first six priority-ordered records rather than every discovery result.

```bash
daad-harvester --phase fetch --parallel 2 --max-sources 6 --output-dir ./output
```

Then extract, fingerprint, and synthesize the bounded batch.

```bash
daad-harvester --phase unpack --parallel 2 --output-dir ./output
daad-harvester --phase fingerprint --output-dir ./output
daad-harvester --phase synthesize --output-dir ./output
```

Run the complete pipeline only after reviewing the queue and selecting a rate appropriate for each archive.

```bash
daad-harvester --phase all --parallel 2 --output-dir ./output
```

## Command reference

| Command | Use it when | Important behavior |
| --- | --- | --- |
| `--phase discover` | You need a fresh live queue. | Does not download. |
| `--phase catalog` | You need to inspect known titles, source matches, and priority. | Writes `evidence_catalog.json` from current SQLite state. |
| `--phase fetch --max-sources N` | You want controlled first-batch acquisition. | Fetches the first `N` pending records after priority ordering. |
| `--phase unpack` | Files have downloaded. | Reconstructs CPC CP/M files from CPC DSK images instead of copying track data into every entry. |
| `--phase fingerprint` | You need binary-level DAAD evidence. | A non-match is retained as a useful result; no version is fabricated. |
| `--phase synthesize` | You need outputs for verified artifacts. | Produces the normal catalog, detection candidates, and report. |
| `--phase all` | The queue and network settings are already reviewed. | Runs discover → catalog → fetch → unpack → fingerprint → synthesize. |
| `--tui` | You are in an interactive terminal. | Starts the real Rich dashboard. Tab 2 displays the priority acquisition queue. |

The TUI is optional and should be run from a real terminal.

```bash
daad-harvester --phase fetch --max-sources 6 --parallel 2 --tui --output-dir ./output
```

## Outputs

| Path | Meaning |
| --- | --- |
| `state.db` | Resumable SQLite source, artifact, and game state. It stores `known_game_id` and `acquisition_priority` per source. |
| `evidence_catalog.json` | Source-backed title, platform, priority, and version-evidence catalog. |
| `downloads/` | Bytes accepted by the fetcher after response validation. |
| `extracted/` | Original and recursively extracted artifact bytes. |
| `daad_catalog.json` | Catalog synthesized from binary-verified DAAD artifacts. |
| `detection_tables.h` | Candidate C++ detection entries generated from verified artifacts. |
| `report.md` | Human-readable summary from persisted state. |
| `logs/` | Discovery, download, compression, error, and game-identification logs. |

## Validation and current boundary

Run deterministic checks after a code change.

```bash
python -m pytest
python -m pyflakes daad_harvester/
```

Live archive tests are separate because websites change. A recent controlled run discovered 95 direct candidates, then selected and downloaded the six highest-priority catalog-backed CPC sources. All six downloads completed, and the corrected CPC DSK parser reconstructed named CP/M files rather than generating malformed track copies. The current fingerprint parser did **not** yet identify a DAAD database payload in that first CPC batch. That is recorded as a limitation, not hidden or converted into a false version claim.

This distinction is intentional. The catalog establishes that the six titles are DAAD games; their source metadata establishes that these are CPC candidates; parser support must still recognize the specific executable/data layout before the project marks a binary as a verified DAAD payload. Future parser work should use those saved hashes and extracted files as fixtures only where redistribution is permitted.

## Troubleshooting

| Symptom | Explanation | Action |
| --- | --- | --- |
| A source produces zero files. | The adapter found no direct compatible artifact or the source changed. | Read `logs/daad_discovery.log`; do not add a catalog-page URL as a seed. |
| A `.dsk` does not receive CPC priority. | Generic DSK is ambiguous across retro platforms. | Add platform evidence in the source adapter or archive metadata; do not infer it from the extension. |
| A known title has no exact DAAD version. | A title record is not binary-level engine evidence. | Fetch, unpack, and fingerprint a platform release. |
| The fingerprint stage reports zero matches. | The artifact may be non-DAAD, wrapped, compressed, or not yet supported by the parser. | Keep the result and hashes; do not re-label it manually as verified. |
| A response is rejected as HTML or JSON. | The URL resolved to a page, error, login, or purchase flow. | Treat the rejection as correct behavior and inspect that adapter’s contract. |
| A historical site has a temporary or gated download. | The site does not provide a safe unattended direct-file contract. | Keep it as catalog evidence, not an automated fetch source. |

## Responsible use

Use public sources respectfully. Follow site terms, robots policies, and rate limits; do not bypass payment, authentication, regional restrictions, or access controls. Preserve provenance by keeping the source URL, HTTP response details, hashes, and catalog evidence with any research output.

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE).

## References

[1]: https://github.com/daad-adventure-writer/daad "DAAD Adventure Writer"
[2]: https://wiki.caad.es/DAAD "wikiCAAD: DAAD"
[3]: https://computeremuzone.com/engine/daad?l=en "Computer Emu Zone: Games made with DAAD"
[4]: https://solutionarchive.com/game/id%2C2148/Aventura+Original%2C+La.html "CASA: La Aventura Original"
[5]: https://www.cpc-power.com/index.php?page=detail&onglet=dumps&num=549 "CPC Power: Chichen Itza disk records"
[6]: https://archive.org/metadata/Ci-U-Than_Trilogy_III_Chichen_Itza_1992_Aventuras_AD_es "Internet Archive: Chichen Itza CPC metadata"
[7]: https://api.zxinfo.dk/v3/ "ZXInfo API v3"
[8]: https://worldofspectrum.org/archive/software/text-adventures/la-aventura-original-aventuras-ad-sa "World of Spectrum: La Aventura Original"
[9]: https://www.planetemu.net/faq/les-telechargements-sur-le-site "Planet Emulation download FAQ"

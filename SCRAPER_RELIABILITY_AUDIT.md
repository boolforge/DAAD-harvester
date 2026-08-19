# Scraper Reliability Audit

**Repository:** `boolforge/DAAD-harvester`

**Scope:** Public-page discovery, direct-file admission, download reliability, and source validation

**Audit date:** August 19, 2026
**Working branch:** `fix/scraper-reliability-audit`

## Executive summary

The initial scraping path was not reliable enough for preservation work. It could start a clean run with unverified static URLs, treat catalog or page URLs as download work, use stale or undocumented endpoints, make unsafe assumptions about GitHub branch names, and report incomplete download failure information. Its test suite was also not installable from a clean checkout.

The repair replaces speculative discovery with conservative, source-specific adapters. The resulting pipeline queues only supported direct artifacts, uses documented or live-verified source contracts, records failure status, removes known false positives, and adds World of Spectrum as a bounded DAAD source. The changes were made in atomic commits and pushed to the remote branch immediately after validation.

> **Meaning of the result:** The project now has a reproducible and source-aware discovery path. A discovered URL is a candidate artifact, not a claim that the artifact is a verified DAAD payload. DAAD fingerprinting remains the later authority.

| Area | Audit result |
| --- | --- |
| Clean installation and deterministic tests | Repaired with `pyproject.toml`; `pytest` runs from an installed checkout. |
| Static seed safety | Unverified built-in seeds were removed. |
| Discovery URL contract | Enforced: public HTTP(S), supported file type, deduplication, and source-specific restrictions. |
| Existing source repair | Internet Archive, GitHub, ZXInfo, Aminet, web-search fallback, and opportunistic sources were reviewed and hardened. |
| New reliable source | World of Spectrum Aventuras AD catalog added after live verification. |
| Download diagnostics | Empty bodies are rejected; final HTTP status and content type are persisted on failure. |
| Final deterministic validation | **67 tests passed** and static import checking completed without findings. |
| Final live discovery validation | **95** direct candidate sources were persisted across five active domains. |
| Live fetch and unpack validation | **5/5** representative real sources downloaded with HTTP 200 and reached `unpacked` state. |

## Verified root causes

### 1. The project was not reliably installable or testable

The repository lacked packaging metadata needed to install its package and run the tests from a clean environment. The immediate observable failure was import resolution during test collection. This made a passing local run dependent on a developer’s current working directory rather than the project itself.

**Repair:** Added `pyproject.toml`, installed the project in editable mode during validation, aligned the test workflow with package installation, and ignored local audit/build artifacts. This establishes one canonical local and continuous-integration path.

### 2. Static seeds injected unverified work before discovery

The original static seed catalog contained plausible-looking URLs that were not guaranteed to be public downloadable artifacts. A clean run could therefore begin by attempting to fetch HTML pages, dead paths, or incorrectly constructed archive locations.

**Repair:** The bundled catalog is now intentionally empty. Manual seeds remain possible, but only after a maintainer independently verifies a direct, supported artifact URL. A regression test asserts that a clean run persists no speculative seed.

### 3. Discovery did not consistently distinguish a web page from a downloadable artifact

A crawler must distinguish a catalog page, a game page, a login or purchase page, a directory index, a screenshot, a snapshot, and a binary artifact. The earlier discovery logic did not enforce this contract consistently.

**Repair:** All source insertion now goes through one admission gate. It accepts only HTTP(S) URLs whose path names a supported artifact suffix, rejects duplicates, and preserves a direct-file-only invariant. Source adapters that expose non-suffix download resolvers are not admitted merely because they look like download buttons.

### 4. Source adapters relied on assumptions that the live sites did not support

Several adapters were misaligned with live source behavior. GitHub repositories do not all use `main` as their default branch. ZXInfo’s live, documented v3 search endpoint is `/v3/search`, while the prior behavior was not aligned with that contract. Internet Archive needs item metadata to obtain exact file names. IF Archive did not expose a maintained DAAD-specific index suitable for broad crawling. itch.io entries commonly led to account, purchase, or gated pages rather than direct public artifacts.

**Repair:** GitHub archives now use each repository’s reported `default_branch`; Internet Archive uses item metadata; ZXInfo uses its v3 full-search response and resolves the returned paths through Spectrum Computing. IF Archive is recorded as `SKIPPED_UNVERIFIED_INDEX`, not treated as a broad crawl target. itch.io inspects pages but never queues game, login, account, or purchase URLs as files. The public API and catalog behavior were checked against their live sources.[1] [2] [3]

### 5. False positives leaked into the candidate queue

The live audit uncovered a German university dataset sharing the token “DAAD,” content created with other adventure engines, third-party RZX links, and Z80 snapshots wrapped in ZIP files. Those are not compatible DAAD artifact candidates for this pipeline.

**Repair:** Added explicit homonym exclusions, excluded PAWS/Quill/GAC/SWAN artifacts from the ZXInfo route, excluded Z80/SNA/SZX snapshot archives, and constrained the World of Spectrum route to source-hosted TAP, TZX, and DSK ZIP files. Each observed class is protected by a regression test.

### 6. Failed downloads lost useful diagnostic information

A terminal HTTP failure could be saved only as a generic error. An HTTP 200 response with an empty body could be accepted as a successful file.

**Repair:** The fetcher now rejects empty bodies, deletes their temporary file, logs the rejection, and persists the final HTTP status and content type for failed downloads. Tests cover both an empty HTTP 200 response and a final HTTP 503 response.

## Source decision record

| Source | Decision | Evidence and safeguard |
| --- | --- | --- |
| Internet Archive | Kept and repaired | Search identifies records; item metadata provides canonical file names.[1] |
| GitHub | Kept and repaired | Uses repository `default_branch`, direct archive ZIP, and relevance filtering. |
| Aminet | Kept | Direct supported Amiga artifact links from the public DAAD search. |
| ZXInfo / Spectrum Computing | Kept and repaired | Uses documented v3 search; excludes other engines and unsupported snapshots.[2] |
| World of Spectrum | Added | Bounded Aventuras AD catalog; each game page must state DAAD authorship; source-hosted TAP/TZX/DSK ZIP only.[3] |
| WikiCAAD | Kept as conservative opportunistic route | It may yield zero direct files; pages are never queued as artifacts. |
| IFDB | Kept as conservative opportunistic route | Only outbound direct supported files may enter the queue. |
| itch.io | Kept but deliberately restrictive | No purchase, account, login, or game page is queued as a binary file. |
| DuckDuckGo HTML fallback | Kept but deliberately restrictive | Only current-selector results that resolve to direct supported files are admitted. |
| IF Archive | Explicitly skipped | No maintained DAAD-specific index was verified; broad directory crawling would be noisy and unreliable. |
| Computer Emu Zone | Evaluated but not added | Catalog pages were public, but tested `download.php` endpoints returned HTTP 403. |
| Generation MSX | Evaluated but not added | It provides useful metadata but no verified direct public artifact URL in the inspected entries. |

## Live validation record

All live checks used a fresh output directory, bounded timeouts, one retry, and a five-requests-per-domain ceiling. The final discovery run completed with exit code 0 and no adapter exceptions.

| Domain | Persisted direct candidates | Source adapter |
| --- | ---: | --- |
| `spectrumcomputing.co.uk` | 50 | ZXInfo / ZXDB |
| `www.worldofspectrum.org` | 21 | World of Spectrum Aventuras AD catalog |
| `github.com` | 11 | GitHub repository archives |
| `archive.org` | 11 | Internet Archive metadata |
| `aminet.net` | 2 | Aminet public DAAD search |
| **Total** | **95** | **Final verified discovery run** |

The final run also confirmed that no known false-positive identifiers persisted: the university-course homonym, PAWS prototype, RZX third-party links, and Z80/SNA/SZX snapshots were absent from the source queue. Empty results for IFDB, WikiCAAD, itch.io, and web search were recorded as zero-result outcomes rather than compensated with invented sources.

A production downloader smoke test fetched one representative artifact from each active archive family. Each completed as HTTP 200 and reached `downloaded` state. A subsequent unpack run marked all five source records as `unpacked` and generated 3,679 artifact records, demonstrating the full fetch-to-unpack path.

| Source | Representative file outcome |
| --- | --- |
| Internet Archive | HTTP 200, `application/octet-stream`, downloaded and unpacked. |
| GitHub | HTTP 200, `application/zip`, downloaded and unpacked. |
| Aminet | HTTP 200, `application/octet-stream`, downloaded and unpacked. |
| ZXInfo / Spectrum Computing | HTTP 200, `application/zip`, downloaded and unpacked. |
| World of Spectrum | HTTP 200, `application/zip`, downloaded and unpacked. |

## Change history on the working branch

| Commit | Purpose |
| --- | --- |
| `33790b3` | Make package installation and tests reproducible. |
| `dd367a3` | Stop enqueueing unverified static seeds. |
| `557077b` | Harden discovery adapters against invalid sources. |
| `4df2988` | Filter homonyms and non-DAAD engines. |
| `16fe50c` | Retain failed download status and reject empty files. |
| `4047919` | Discover verified DAAD artifacts from World of Spectrum. |
| `178096d` | Exclude ZX snapshot archives from discovery. |
| `1956083` | Document source-aware scraper design and usage. |

## Recommendations for future maintenance

Keep the direct-artifact admission rule unchanged. When a source changes, write a regression fixture first, independently inspect its public contract, update that adapter only, then run both deterministic tests and a bounded live smoke test. Do not add URLs to the seed catalog as a substitute for repairing an adapter.

When adding a new source, require all of the following: a public and stable catalog or API, a clear relevance boundary for DAAD, a direct artifact URL or a verifiable direct-file resolver, a source-specific regression test, and at least one successful production download. Sources that require a login, payment, browser interaction, or broad unbounded crawling should remain excluded.

## References

[1]: https://archive.org/metadata/Aventura_Original_La_1989_Aventuras_AD_es "Internet Archive metadata example"
[2]: https://api.zxinfo.dk/v3/ "ZXInfo API v3"
[3]: https://worldofspectrum.org/archive/software/text-adventures/la-aventura-original-aventuras-ad-sa "World of Spectrum: La Aventura Original"

# PR #14 ETL Redesign Remediation Audit — 2026-08-26

| Header field | Value |
| --- | --- |
| **Question** | Did the ETL-layer redesign proposed in PR #14 (a single 995(+)/208(-)-line commit) actually work, and if not, what does a corrected, atomized version look like? |
| **Evidence scope** | Static diff review, live reproduction of the pipeline against an empty state, three from-scratch venv reinstalls, isolated `git worktree` verification of every commit, and direct GitHub Actions run inspection, all performed 2026-08-24 through 2026-08-26. |
| **Status** | resolved — merged as PR #15 (12 atomic commits) into `main` at `b8fa00c`; PR #14 closed as superseded. |
| **Implementation links** | [`../../daad_harvester/cli.py`](../../daad_harvester/cli.py), [`../../daad_harvester/unpack.py`](../../daad_harvester/unpack.py), [`../../daad_harvester/extract/`](../../daad_harvester/extract/), [`../../daad_harvester/load/`](../../daad_harvester/load/), [`../../daad_harvester/transform/`](../../daad_harvester/transform/), [`../../requirements-lock.txt`](../../requirements-lock.txt), [`../../.github/workflows/tests.yml`](../../.github/workflows/tests.yml), [`../../tests/test_cli_integration.py`](../../tests/test_cli_integration.py) |
| **Non-claims** | This audit does not claim the Extract-layer redesign (discovery/download) is complete or production-ready — `extract/discover.py` and `extract/downloader.py` remain deliberately unwired scaffolding, documented as such in their own module docstrings. It does not claim `daad_harvester/extract/unpack.py` has been brought to parity with the legacy `Unpacker`; that module is left as an incomplete starting point, not deleted, not finished. |

## Scope

PR #14 proposed migrating the pipeline to an Extract/Transform/Load layout using Pydantic v2, Typer, Loguru, SQLAlchemy, tenacity, and selectolax. This audit reviewed that single commit in full — every changed and added file, cross-referenced against what `cli.py` actually imports and calls — then rebuilt the same architectural direction as 12 independently-tested commits on a new branch, verifying each one in isolation before merging.

## Findings

The core finding was reproduced live, not inferred from the diff: `cli.py` imported `Unpacker` from the new `daad_harvester.extract.unpack` (208 lines) instead of the complete, tested `daad_harvester.unpack` (1074 lines). The new module has no `unpack_all_downloaded_sources` or `reunpack_retained_source` — the two methods `cli.py` actually calls — so every invocation of `--phase unpack`, and therefore the default `--phase all`, raised:

```
AttributeError: 'Unpacker' object has no attribute 'unpack_all_downloaded_sources'
```

No test in the existing suite caught this: `tests/` was byte-identical between `main` and the PR (same tree hash), and the CI "CLI smoke test" step only ran `--version`/`--help`, neither of which calls a pipeline phase.

Additional findings, each verified rather than assumed:

- `daad_harvester/transform/models.py` defined its own `SourceStatus(str, Enum)` with values (`pending`, `cataloged`, `fetched`, `failed`, `skipped`) that only 2-of-7 overlapped with the canonical `daad_harvester.models.SourceStatus` actually persisted by the sqlite layer. A `SourceModel` built `from_attributes=True` off a real legacy record in most states would raise `pydantic.ValidationError`.
- `daad_harvester/load/organize.py`, `load/report.py`, `load/synthesize.py`, `transform/fingerprint.py`, and `transform/daad_parser.py` were one-line re-exports of the existing implementations, not rewrites, despite reading like new modules.
- `daad_harvester/load/storage.py`'s SQLAlchemy `SourceEntity` declares `__tablename__ = "sources"` against the same sqlite file the legacy `Database` class already creates a `sources` table in. Verified empirically (seed a row through the legacy path, call `init_storage()`, confirm the row and legacy schema survive untouched): `Base.metadata.create_all()`'s `checkfirst=True` default makes this a no-op, and `get_session()` has zero callers anywhere in the codebase.
- `daad_harvester/extract/discover.py` and `extract/downloader.py` are genuine new implementations but are not imported by `cli.py` at all; `Discoverer` and `Fetcher` remain the active code paths.
- `extract/discover.py`'s link resolution hand-rolled URL joining instead of `urllib.parse.urljoin`, breaking protocol-relative links (`//cdn.example.com/x` resolved to `https://source.example//cdn.example.com/x`) and `../`-relative links (left the `..` segment unresolved). Reproduced both failure modes directly before fixing.
- `extract/downloader.py` constructed its `httpx.AsyncClient` with `verify=False` unconditionally — a TLS-verification regression not present in the code it would eventually replace — and hardcoded its tenacity retry policy instead of reading the existing configurable `settings.max_retries`/`backoff_base`/`backoff_max`.
- `daad_harvester/fetch.py` constructed `self.async_downloader = Downloader(...)` in `__init__` but never referenced it again in the file; confirmed via grep across the whole module.
- Three explanatory comments capturing real, non-obvious engineering rationale were silently dropped with no replacement: why `zip_bomb_max_ratio` is 100 and not a "standard" lower value, why proxy rotation is limited to once per batch, and why static report export must run after library organization.

## Reproducible commands and results

| Audit gate | Command | Result |
| --- | --- | --- |
| Reproduce the crash (before fixing) | `python -m daad_harvester --phase unpack --output-dir /tmp/x` on the PR #14 commit | **Failed as predicted:** `AttributeError: 'Unpacker' object has no attribute 'unpack_all_downloaded_sources'` |
| Confirm the fix (after) | Same command, on the merged `main` | **Passed:** exits 0; structlog (legacy modules) and Loguru (new modules) both emit correctly formatted output in the same run |
| Full network-free phase sweep | `catalog`, `unpack`, `fingerprint`, `synthesize`, `organize`, `report`, chained against one shared empty state | **Passed:** all six phases exit 0, no tracebacks |
| Python regression suite | `pytest tests/ -q` | **609 passed** |
| Same suite, isolated per commit | `git worktree add` at each of the 12 commit SHAs individually, `pytest tests/ -q` in each | **Passed at every commit**, confirming each is independently self-contained |
| Log migration losslessness | Compared source block/line counts against migrated `record_count` for all 49 files | **0 mismatches** across all 49 |
| Static analysis | `python -m pyflakes daad_harvester/ tests/ scripts/` | **Passed:** no output |
| GitHub Actions (both matrix legs) | Pull request #15, commit `d50988e` | **Passed:** `test (3.10)` and `test (3.12)`, including the extended CLI smoke test |

## Two real incidents surfaced during verification

**A false "flaky CI" signal.** Debug instrumentation added to capture pytest's output piped it through `tee`, which silently discards the real exit code (a shell pipeline's status is its last command's). Every CI run instrumented this way reported false success regardless of the actual test outcome, producing an apparently environment-dependent pattern across several re-runs before the `tee` was identified as the cause. Removing it surfaced the real, deterministic bug: `tests/test_cli_integration.py::test_help` asserted `"--phase" in result.stdout` directly, but Rich (Typer's help renderer) detects it is running inside GitHub Actions and renders its help panel with ANSI color codes, splitting the literal substring across an escape sequence. Reproduced locally with `FORCE_COLOR=1`; fixed with a `strip_ansi()` helper applied before every stdout assertion in that file.

**Unpinned dependencies.** `requirements.txt` used only `>=` floating minimums, no lockfile. This is a real, independent finding on its own merits — a project built around reproducible, evidence-grade pipeline runs should not have CI depend on whatever happens to be latest-on-PyPI at install time — addressed with `requirements-lock.txt` (exact pins, generated from a verified-good resolution) now used by all three CI workflows, guarded by a test that fails if a pin is ever silently loosened.

## What was deliberately not done, and why

- **`extract/discover.py` and `extract/downloader.py` were not wired into `cli.py`.** `daad_harvester.discover.Discoverer` carries 1000+ lines of per-site adapter logic and fixes from the PR #13 forensic audit (previously-fabricated seed URLs, broken discovery endpoints); the new adapters are generic skeletons with none of that. Wiring them in as delivered would be a functional regression, not an improvement.
- **`daad_harvester/extract/unpack.py` was not brought to parity with the legacy `Unpacker`.** The legacy module's 1074 lines cover CP/M, D64/D71/T64, TZX, FAT12, MSA, ADF/ADZ/DMS, and CAS/TAP format handling, all covered by `tests/test_unpack.py`'s fixture-level tests. Rewriting delicate, already-audited binary-format parsing logic blind, without the same fixture coverage to check against, is a worse trade than leaving it as documented, incomplete scaffolding.
- **`daad_harvester/fetch.py` was left untouched.** Every change the original PR made there was either dead code (the unused `async_downloader` reference) or the deletion of comments worth keeping; there was nothing to carry forward.

## Conclusion

The Extract/Transform/Load direction from PR #14 is retained, but the pipeline that actually runs today is the same tested implementation as before this work (`Unpacker`, `Discoverer`, `Fetcher`, unchanged), with genuinely new pieces (Pydantic contracts, Loguru logging, a documented SQLAlchemy scaffold, two unwired-but-tested Extract-layer modules) added alongside it rather than silently swapped in half-finished. Every commit passes the full suite in isolation; the CI smoke test now exercises real phase execution, not just `--help`/`--version`, closing the exact gap that let the original regression ship.

## References

[1]: [PR #15](https://github.com/boolforge/DAAD-harvester/pull/15) "Merged: atomized, fixed rework of the ETL pipeline redesign"
[2]: [PR #14](https://github.com/boolforge/DAAD-harvester/pull/14) "Closed as superseded"
[3]: [`../../tests/test_cli_integration.py`](../../tests/test_cli_integration.py) "In-process CLI integration tests, including the ANSI-stripping fix"
[4]: [`../../scripts/migrate_legacy_logs_to_json.py`](../../scripts/migrate_legacy_logs_to_json.py) "Legacy preservation_corpus log migration, run as part of this same effort"
[5]: [`../../requirements-lock.txt`](../../requirements-lock.txt) "Exact dependency pins added after the tee/exit-code incident"

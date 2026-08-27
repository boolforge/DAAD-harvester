# Global Main-Branch Audit (Phase 1: Verification and Documentation Integrity) — 2026-08-26

| Header field | Value |
| --- | --- |
| **Question** | Beyond the PR #14/#15 remediation, is `main` as a whole in the state its own documentation claims, and is it structured so any agentic system — not only Claude — can pick up work safely? |
| **Evidence scope** | Every offline verification gate the repository defines, run and read directly (not assumed from a prior "passed" badge); a security-focused pass over the highest-risk code (untrusted-archive extraction, subprocess invocation, CLI output handling); a cross-document consistency check of every headline numeric claim; a fast pass over the web report viewer. All performed 2026-08-26 against `main` at `b8fa00c` through `028171b`. |
| **Status** | in progress — this document covers verification and documentation-integrity findings (all resolved). Prioritized code-level refactoring is a separate, later phase; see "What comes next" below. |
| **Implementation links** | [`AGENT.md`](../../AGENT.md), [`LICENSE`](../../LICENSE), [`scripts/check_docs.py`](../../scripts/check_docs.py), [`tests/test_readme_and_todo_baseline.py`](../../tests/test_readme_and_todo_baseline.py) |
| **Non-claims** | This phase did not attempt a line-by-line review of all 54 pipeline modules, 84 scripts, or the reverse-engineering corpus's derived artifacts. It sampled the areas most likely to carry real risk (untrusted-input handling, CI/CD, agent-facing docs) rather than reading everything with equal depth — see "What comes next" for the scope not yet covered. |

## Scope

Requested as a follow-on to the PR #14/#15 remediation: an exhaustive audit of `main`, a real cleanup pass, and an `AGENT.md` making the project easy for any agentic system to pick up. This document covers the first phase: running every verification gate the project itself defines and trusting nothing without re-checking, a security review of the code most exposed to untrusted input, and a cross-document consistency check — the same discipline applied throughout the PR #14/#15 work, now aimed at `main` as a whole.

## What was verified, and how

**Every offline gate the repository defines was run directly, not assumed:**

| Gate | Command | Result |
| --- | --- | --- |
| Environment preflight | `scripts/verify_environment.py` | Passed |
| Regeneration manifest | `scripts/verify_regeneration_manifest.py` | Passed — 20 native entries, 45 inputs, 29 outputs |
| Runtime resources | `scripts/verify_runtime_resources.py` | Passed — 8 resources, 4 captures |
| Game corpus | `scripts/verify_game_corpus.py` | Passed — 265 sources, 1,015 retained artifacts |
| Artifact checksums | `scripts/verify_artifact_checksums.py` | Passed — 1,015 artifacts, full 17-field checksum coverage |
| Reverse-engineering corpus | `scripts/verify_reverse_corpus.py` | Passed — 42 originals, 769 public source files, 2,580 ADP mirror files |
| Documentation integrity | `scripts/check_docs.py` | Passed (after the fix below) |
| Static analysis | `python -m pyflakes daad_harvester scripts` | Passed, no output |
| Full regression suite | `pytest -q` | 612 passed |
| Single authoritative launcher | `scripts/run_primary_workflow.py` | All 21 gates plus the full suite, green |

**Security review, focused on code that handles untrusted input** (archives and files downloaded from the public internet):

- Archive extraction (`daad_harvester/unpack.py`): checked every extraction path (`unpack_zip`, `unpack_tar`, `unpack_7z`, `unpack_rar`) for zip-slip/path-traversal. `sanitize_filename()` defeats it in three independent, overlapping ways — basename-only extraction (`filename.replace("\\", "/").split("/")[-1]` discards every directory component before anything else runs), a character-class substitution that also removes any surviving separator, and a final `.strip(" .")` that collapses pure-dot sequences (`".."`, `"..."`) to empty, falling back to `"unnamed"`. No vulnerability found.
- Subprocess invocation: no `shell=True` anywhere in `daad_harvester/` or `scripts/`; the one external-tool call site (`unpack.py`'s `_unpack_via_cli`) uses list-form arguments with an explicit 60-second timeout.
- Dangerous deserialization: no `eval`, `exec`, `pickle.loads`, or XML parsing anywhere in the codebase.
- Decompression-bomb protection: `zip_bomb_max_ratio` (100x) and `max_unpack_depth` (5) are both enforced and, per the restored comment in `config.py`, were a deliberate, reasoned choice already made during the PR #13 forensic audit — not an oversight to flag here.
- Secrets: no credential-shaped strings in tracked files (one legitimate `os.getenv("OPENAI_API_KEY")` in a vendored third-party tool script, reading from the environment correctly); no `.env`/`.pem`/`id_rsa`-shaped filenames anywhere in git history.
- Web report viewer (`web/report-viewer/src/Home.tsx`, 357 lines): no `dangerouslySetInnerHTML`, no `innerHTML`; the one external `target="_blank"` link carries `rel="noreferrer"`, correctly preventing reverse-tabnabbing.

## Findings and fixes

All of the following were found by running something and checking the result against what the documentation claimed, not by reading prose alone:

1. **README.md's test count was stale by more than half** ("247 passing tests" against a live 612) **and its regeneration-path count was stale too** ("eight" against a live twenty — TODO.md's own copy of this number was already correct, so only README had drifted). Fixed, and now regression-tested.
2. **TODO.md's status-baseline header was stale** ("544 passing tests, 267 sources" against live 612 and 265). Fixed, and now regression-tested.
3. **No test protected either of the above from drifting again**, unlike `research/IMPLEMENTATION_STATUS_MATRIX.md`, which has had this exact protection for a while (`tests/test_implementation_status_matrix.py`, which itself caught real drift more than once). Added `tests/test_readme_and_todo_baseline.py`, reusing the same sqlite query the existing test already trusts, plus a cheap (~1s) `pytest --collect-only` count for the test-total claims.
4. **README.md linked to a `LICENSE` file that did not exist**, even though `pyproject.toml` already declared `license = { text = "MIT" }` and carried the matching PyPI classifier. This had never been caught because `scripts/check_docs.py`'s link checker only scanned `docs/`, not the repository root — where README, AGENT.md, AGENT_WORKFLOW.md, and TODO.md all live. Added the missing LICENSE file and extended the checker's scope to the root, with a regression test locking that scope in (579 links now checked, was 545).
5. **`pyproject.toml`'s `description` field still carried PR #14's overclaiming language** ("Scalable, asynchronous enterprise-grade data pipeline") after the PR #15 remediation had already toned down the same phrase in `daad_harvester/__init__.py`'s docstring. Fixed to match the project's own established voice.
6. **No file named `AGENT.md`/`AGENTS.md` existed**, despite the project already having an unusually thorough agent contract (`AGENT_WORKFLOW.md`, `agent_workflow.json`, five skills under `skills/`) — meaning any tool that specifically auto-discovers that conventional filename found nothing. Added `AGENT.md` as a short front-loaded orientation page that points to the existing contract rather than duplicating it.

## What comes next

This phase deliberately stayed within "verify everything the project already claims, fix what doesn't hold up, close the specific gaps found" — the same discipline that made the PR #14/#15 remediation trustworthy rather than another confident-sounding rewrite. A prioritized code-level refactoring pass (the second half of the original request) is scoped separately and has not started yet. Given how consistently solid this codebase's core logic checked out under direct verification — every gate green, no vulnerability found in the highest-risk code paths — that pass should stay similarly disciplined: look for real, verifiable issues in the large areas not yet sampled (the bulk of `daad_harvester/`'s format-specific modules, the 84 scripts individually, the reverse-engineering derivation pipeline), fix what's actually broken, and resist rewriting code that the project's own extensive fixture-backed tests already prove works.

## References

[1]: [`AGENT.md`](../../AGENT.md) "New top-level agent orientation entry point"
[2]: [`tests/test_readme_and_todo_baseline.py`](../../tests/test_readme_and_todo_baseline.py) "New regression protection for README/TODO numeric claims"
[3]: [`scripts/check_docs.py`](../../scripts/check_docs.py) "Link checking extended to root-level files"
[4]: [`docs/audits/2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md`](2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md) "The preceding PR #14/#15 remediation audit this phase follows"

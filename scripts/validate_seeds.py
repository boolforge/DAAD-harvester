#!/usr/bin/env python3
"""Validates every URL in CANONICAL_DAAD_SEEDS against the real, live internet.

Why this exists: an audit of this codebase found that several "canonical"
seed URLs (see daad_harvester/seeds.py) looked plausible but pointed at
Internet Archive/GitHub items that don't actually exist -- almost certainly
generated rather than sourced from confirmed items. Hand-verifying a hardcoded
list one entry at a time doesn't scale and silently rots as sites reorganize,
so this script instead asks the real internet, every time it's run.

Requires network access to archive.org / github.com / ifarchive.org / etc,
so this can't run from a network-restricted sandbox -- run it from a normal
machine, Termux, or CI (see .github/workflows/tests.yml for how CI wires
this in as a non-blocking, informational job).

Usage:
    python -m scripts.validate_seeds
    python -m scripts.validate_seeds --timeout 15

Exit code is non-zero if any seed is unreachable or clearly not a real
downloadable file (HTML error/redirect page, 404, etc.), so it can be used
as a CI signal -- but treat failures as "needs a human to re-check", not
an automatic build-breaker: third-party retro-computing sites (personal
pages, small archives) go through real, temporary outages too.
"""

import argparse
import asyncio
import sys

import httpx

from daad_harvester.seeds import CANONICAL_DAAD_SEEDS

# Content-Types that mean "this is an error/redirect page, not the actual
# game file" even when the server answered 200 OK -- the same signal
# fetch.py's _is_invalid_web_payload() uses for the real pipeline.
_NON_BINARY_CONTENT_TYPES = (
    "text/html",
    "text/xml",
    "application/json",
    "application/javascript",
    "text/css",
    "text/javascript",
    "application/xml",
)


async def _check_one(client: httpx.AsyncClient, seed: dict) -> tuple[str, bool, str]:
    """Returns (title, ok, detail)."""
    url = seed["url"]
    title = seed.get("title", url)
    try:
        # Prefer HEAD (cheap), but some archive/wiki servers answer HEAD
        # incorrectly (405, or a 200 with no useful headers) even when GET
        # works fine, so fall back to a streamed GET and only read the
        # headers + first chunk rather than the whole file.
        resp = await client.head(url, follow_redirects=True)
        if resp.status_code >= 400 or resp.status_code == 405:
            async with client.stream("GET", url, follow_redirects=True) as resp:
                return await _judge(title, url, resp)
        return await _judge(title, url, resp)
    except httpx.RequestError as exc:
        return title, False, f"connection error: {exc.__class__.__name__}: {exc}"


async def _judge(title: str, url: str, resp: httpx.Response) -> tuple[str, bool, str]:
    if resp.status_code >= 400:
        return title, False, f"HTTP {resp.status_code}"
    content_type = resp.headers.get("content-type", "").lower()
    if any(ct in content_type for ct in _NON_BINARY_CONTENT_TYPES):
        return title, False, f"HTTP {resp.status_code} but content-type={content_type!r} (looks like an error/listing page, not a game file)"
    return title, True, f"HTTP {resp.status_code}, content-type={content_type or 'unknown'}"


async def validate_all(timeout: float) -> int:
    headers = {"User-Agent": "Mozilla/5.0 (compatible; DAAD-harvester seed validator)"}
    broken = 0
    async with httpx.AsyncClient(timeout=timeout, headers=headers) as client:
        results = await asyncio.gather(*[_check_one(client, seed) for seed in CANONICAL_DAAD_SEEDS])

    for title, ok, detail in results:
        status = "OK  " if ok else "FAIL"
        print(f"[{status}] {title}: {detail}")
        if not ok:
            broken += 1

    print(f"\n{len(results) - broken}/{len(results)} seeds reachable and look like real files.")
    if broken:
        print(f"{broken} seed(s) need re-verification -- see daad_harvester/seeds.py's audit note.")
    return broken


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--timeout", type=float, default=20.0, help="Per-request timeout in seconds (default: 20)")
    args = parser.parse_args()
    broken = asyncio.run(validate_all(args.timeout))
    sys.exit(1 if broken else 0)


if __name__ == "__main__":
    main()

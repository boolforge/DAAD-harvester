"""Optional manually verified source seeds.

The harvester intentionally ships with an empty seed catalog. Earlier versions
contained plausible-looking Internet Archive paths and HTML directory pages
that were not verified as downloadable DAAD artifacts. Injecting those values
at startup made every clean run begin with dead or non-binary work items.

Live discovery is the default source of truth. Add a manual seed only after
verifying that it is a direct, supported archive or disk-image URL.
"""

from typing import Any, Dict, List


CANONICAL_DAAD_SEEDS: List[Dict[str, Any]] = []

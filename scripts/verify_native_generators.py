"""Verify deterministic repository-native format generator fixtures.

The primary workflow uses this script to prove that promoted native generators
still emit their pinned fixture bytes and satisfy their independent structural
validators. It performs no network access or external-tool invocation.
"""

from __future__ import annotations

import argparse
import json
from typing import Sequence

from daad_harvester.generator_evidence import generated_fixtures_evidence, verify_native_generators


# Compatibility alias retained for focused callers while installed package
# consumers use the canonical helper directly.
verify = verify_native_generators


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--print-evidence",
        action="store_true",
        help="print canonical fixture evidence without requiring the pinned SHA-256",
    )
    args = parser.parse_args(argv)
    evidence = generated_fixtures_evidence() if args.print_evidence else verify_native_generators()
    print(json.dumps(evidence, sort_keys=True, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

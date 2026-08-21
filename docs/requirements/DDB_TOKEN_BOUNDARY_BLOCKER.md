# Retained DDB Token/Text Boundary Blocker

| Header field | Value |
| --- | --- |
| **Question** | Why was an apparent ADP token/text overlap in the retained legacy V2 DOS `BLANK.DDB` profile rejected? |
| **Evidence scope** | P0 repository-native deterministic reproducer and retained bytes; P1 pinned ADP loader and compiler source; P2 retained original DDB. |
| **Status** | Closed reproducer defect. The original probe exceeded ADP's documented token-index range; it is retained as a negative regression. |
| **Reproduction command** | `python3 scripts/verify_ddb_token_boundary_blocker.py --check` |
| **Generated evidence** | [`../../preservation_corpus/ddb_token_boundary_blocker.json`](../../preservation_corpus/ddb_token_boundary_blocker.json) |

## Exact observation

The retained source is `preservation_corpus/extracted/depth1_98397784_BLANK.DDB`, a 2,652-byte compact legacy V2 DOS DDB with SHA-256 `8f45acdfe4813996cb3895dd66d2d9e6f0685acfc94c1ec35ed3eeb626cdad84`. Its source-byte profile is `legacy-v2-dos-little-raw-blank-r4`.

ADP’s non-PAWS loader starts a nonzero token scan at `tokens + 1`, advances each candidate record until a high-bit byte, and uses `0x00` as the block sentinel.[1] ADP’s compiler writes a leading `0xFF`, token records, and a final `0x00` for its corresponding non-PAWS path.[2] The retained DDB begins at token pointer `0x0251` with `0xFF`, so the rule is a relevant comparison candidate.

The initial repository-native probe incorrectly continued beyond ADP’s `n <= 255` loop and reached token index `256`, byte range `0x0386`–`0x0387`. The same byte start `0x0386` is independently resolved from a legacy text offset table. This did reveal an overlap, but only outside the ADP candidate rule’s permitted index range. A corrected bounded reproduction finds **no** overlap through index `255`.

| Item | Measured value |
| --- | --- |
| Candidate rule | `adp_non_paws_tokens_plus_one_high_bit_termination_zero_sentinel_index_0x80_through_0xff` |
| Retained token-block start | `0x0251` |
| First candidate token range | `0x0386`–`0x0387` |
| Conflicting independent text start | `0x0386` |
| Current action | Preserve the rejected unbounded probe as a negative regression; do not claim semantic token support until a separate complete profile decoder is implemented. |

> A familiar leading byte or an external implementation’s superficially matching scan is not enough to override an independently bounded retained-byte structure. The conflict must be resolved at the profile level.

## Required closure

This probe defect is closed because the bounded reproduction enforces ADP’s documented limit and no longer reports the false overlap. The broader token grammar remains pending under the global DDB grammar requirement: it still needs a profile-specific native decoder, malformed-boundary tests, real-artifact non-overlap evidence, and byte-identical round-trip proof before semantic token support can be claimed.

## **Non-claims**

This record does not claim token support, that `BLANK.DDB` has no token data, that the bytes are corrupt, or that any inferred alternative grammar is correct. It does not treat the existing byte-identical preservation result as semantic token support. It only proves that the earlier reported conflict arose from an unbounded probe, not from ADP’s documented candidate rule.

## References

[1]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-common/ddb.cpp “Pinned ADP `DDB_FillTokenPointers`: token scan start, high-bit record termination, and non-PAWS sentinel”

[2]: https://github.com/jlcebrian/ADP/blob/379a6710de11a2378f3d76c25a4d71bca75073bf/src-tools/dc_main.cpp “Pinned ADP `BuildDDB`: non-PAWS token block marker and sentinel emission”

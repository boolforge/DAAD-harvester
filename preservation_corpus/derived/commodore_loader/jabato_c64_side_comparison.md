# Jabato C64 Original Tape-Side Comparison

> **Evidence class:** P1/P2. This comparison concerns the retained original Planet Emulation Side A and Side B TAP releases only. It does not assign any conclusion to the ASS D64 scene variant until that package has been independently executed and compared.

| Axis | Side A | Side B | Evidence-backed conclusion |
| --- | --- | --- | --- |
| Retained source | 248 | 249 | The two sides are independent original-media sources. |
| Archive SHA-256 | `38b05d44ce794a8564b566c693c019e325c8be3f0e73abeb29304888dfcc29f0` | `4756dbe11f03f3065f22d2c0f55ca89601262c2a5514ce75e5d1358fde64a40d` | The delivered ZIP containers differ. |
| TAP SHA-256 | `99e873fd309be0325e37668f9385937d22337c1a4c1d2b9094ac2ef575082ad1` | `090ff428dfa5731ee29fecb7caaf25c1bf41d36c80d0e0dd7ac34d669cfc8fc6` | The original pulse streams differ. |
| TAP framing | C64-TAPE-RAW V1; 773,967 bytes; 14 physical pause-delimited units | C64-TAPE-RAW V1; 783,446 bytes; 11 physical pause-delimited units | They share a V1 container family but not an identical physical layout. |
| ROM bootstrap packets | Two `JABATO 1` headers and two 299-byte loader packets | Two `JABATO 2` headers and two 299-byte loader packets | Each side has duplicate-pass conventional ROM packets before its later adaptive stream. |
| Low-memory loader packet | 299-byte packet | Same retained SHA-256 and deduplicated corpus member | The standard packet is byte-identical; it is a shared bootstrap component. |
| First verified original DDB | Part 1 at `$3880`–`$99C2`, 24,899 bytes | Part 2 at `$3880`–`$98E7`, 24,680 bytes | Both parts are independently recovered from their original runtime paths. |
| ADP comparator result | Exact SHA-256 `7ffbee6c…b7bdb5e6` match to `JABATO-C64 1.DDB` | Exact SHA-256 `ee3b41f6…4fa48e69` match to `JABATO-C64 2.DDB` | ADP’s two C64 fixtures are validated semantic/database comparators for these exact original runtime ranges. |

The physical comparison isolates one shared component and one unresolved boundary. Both original sides expose the same byte-identical low-memory bootstrap packet through the native ROM-compatible extractor. Their later TAP layouts, pause segmentation, and runtime database payloads differ. The Side A measured `$01B6` loader model recovers seven 256-byte blocks that exactly match retained RAM; the equivalent Side B report reaches the same validated common-loader block pattern. Neither report yet assembles a complete DDB from the later pulse stream.

> **Current conclusion:** Original-runtime recovery is complete for the observed Side A Part 1 and Side B Part 2 paths. Physical pulse-only recovery, full multipart loading behavior, and the exact relationship to the ASS D64 release remain active, separately testable work.

## Evidence links

| Record | Purpose |
| --- | --- |
| [Side A analysis](jabato_side_a_tap_pulse_analysis.json) | Pulse framing, measured-loader candidates, and validated Part 1 RAM blocks. |
| [Side B analysis](jabato_side_b_tap_pulse_analysis.json) | Corresponding Side B framing and measured-loader candidates. |
| [Side A runtime evidence](jabato_c64_external_evidence.md) | Controlled original Side A execution, Part 1 recovery, and loader trace. |
| [Side B acquisition and runtime evidence](jabato_side_b_acquisition.md) | Public acquisition, timed execution, and Part 2 recovery. |
| [ADP comparison scope](adp_jabato_comparison_scope.md) | Fixture provenance and both byte-identity results. |

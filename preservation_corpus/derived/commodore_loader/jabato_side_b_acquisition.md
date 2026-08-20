# Jabato C64 Side B — Public Acquisition Record

> **Evidence class:** P1 — browser-visible public archive acquisition and retained original-byte verification.

| Field | Value |
| --- | --- |
| Public record | `https://www.planetemu.net/rom/commodore-c64-games-adventure-tap/jabato-1989-aventuras-ad-side-b` |
| Archive title on record | `Jabato (1989)(Aventuras AD)(Side B).zip` |
| Record-reported size | 200 Ko |
| Browser-visible acquisition | 2026-08-20; two sequential public download activations |
| Received archive size | 204,831 bytes each |
| Archive SHA-256 | `4756dbe11f03f3065f22d2c0f55ca89601262c2a5514ce75e5d1358fde64a40d` |
| Duplicate result | The two browser downloads are byte-identical; retain one original corpus copy and record the duplicate as acquisition corroboration. |
| ZIP integrity | `unzip -t` reports no errors; archive identifies as `TORRENTZIPPED-D80F967B`. |
| Contained member | `Jabato (1989)(Aventuras AD)(Side B).tap`, 773,967 bytes, timestamp 1996-12-24 23:32. |

The Side B archive is an original media source for the active C64 Part 2 recovery loop. It must remain distinct from the Side A source and from the ASS D64 scene release. Future unpacking, tape analysis, VICE execution, RAM recovery, ADP Part 2 comparison, and physical decoder work must preserve this source-specific provenance.

## Initial bounded runtime observations

The native C64 raw-TAP unpacker materialized the original Side B TAP and four parity-valid ROM packets: two `JABATO 2` headers (202 bytes each) and two low-memory loader packets (299 bytes each). The loader-packet payloads are byte-identical to their Side A counterparts after the conventional packet framing is removed; the headers differ only in their Part 2 identity and duplicate-pass byte sequences.

A bounded VICE autostart under the retained, hash-verified C64 firmware reaches the original Jabato title illustration. The retained `vice/jabato_side_b_tap_autostart.png` and `.vsf` record this state. A second bounded execution with one controlled space input left the visible title unchanged after four seconds, but changed RAM and reached active code at `$0336`; its zero-page state includes `$AC:$AD = $7D:$EB` and `$AE:$AF = $7E:$80`. This is consistent with the shared low-memory tape-loader path, but it is not yet a claim that Part 2 has loaded.

Both retained Side B RAM samples have been structurally scanned with the corrected target-aware V1 inspector and contain no verified DDB at their observed times. These are stage-specific negative results only. A timed post-input execution series remains required before concluding whether Side B needs a longer load interval, a different runtime control, or a source-side handoff from Part 1.

The first two post-input timing samples refine that state sequence without yet assigning an unverified loader semantic. At four seconds, `vice/jabato_side_b_tap_post_input_04.png` still shows the original title illustration. At twelve seconds, `vice/jabato_side_b_tap_post_input_12.png` shows horizontal multicolor stripe output instead of the title. This visible transition establishes that the controlled input is accepted and that Side B enters a later active phase; the corresponding snapshots require RAM extraction and structural comparison before any Part 2 claim.

## Verified Part 2 recovery

The timed RAM series resolves the former Part 2 gap. The four-second sample has no verified DDB. The twelve-second and twenty-eight-second samples each contain an embedded Spanish C64 DAAD legacy V1 DDB at `$3880`, with a validated declared size of 24,680 bytes. The later screen at twenty-eight seconds, retained as `vice/jabato_side_b_tap_post_input_28.png`, presents the Spanish Aventuras A.D. credits headed **JABATO EN AFRICA**.

The exact `$3880`–`$98E7` range from the first verified twelve-second sample is materialized as `jabato_side_b_tap_post_input_12_part2.ddb`. Its SHA-256 is `ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69`, byte-for-byte identical to the retained ADP fixture `JABATO-C64 2.DDB`. The fixture comparison and parser validation are protected by a real-artifact regression. This recovers the original runtime Part 2 database; it does not yet reproduce all of its bytes through the physical Side B pulse stream, which remains a distinct native-decoder closure task.

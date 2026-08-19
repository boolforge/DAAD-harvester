# Jabato C64 Startup: External Evidence Note

> **Evidence class:** P2 — publicly reproducible preservation/catalog observations. This note does not replace retained-byte analysis or controlled emulator measurements.

The retained source-121 image identifies itself as the 1989 Spanish Commodore 64 release of *Jabato vs. Imperio: Libertad*. An independent catalog attributes the release to Aventuras AD, classifies it as a keyboard-controlled graphics/text adventure, and links to releases for Amiga, CPC, Atari ST, MSX, ZX Spectrum, and DOS. This supports treating the observed C64 screen prompt as a keyboard-path loader/runtime question rather than assuming joystick-only interaction.[1]

The Internet Archive item corresponding to the retained `[cr ASS]` C64 release identifies the original emulator extension as `d64` and supplies an externally captured screenshot sequence. Its listed emulator is VICE-resid, providing an independent preservation context for the project’s bounded VICE experiments.[2]

GB64 identifies the release as an ASS-cracked variant in search results, but its live detail page currently presents an anti-automation challenge. It therefore remains a discovery pointer only, not a verified factual source for this research iteration.[3]

A bounded visual analysis of the public C64 longplay reports a title illustration from approximately 00:00 to 00:07, credits from approximately 00:08 to 00:14, and the playable graphics/text-adventure interface from approximately 00:15. The visible play path then consists of keyboard commands. This is not a byte-identical comparison with the retained ASS-cracked disk, but it establishes that the ordinary game path reaches the parser promptly and makes the retained crack-introduction prompt a variant-specific loader/runtime question rather than a property of the game’s canonical parser interface.[4]

| Question | Measured or external evidence | Current result | Next retained-evidence action |
| --- | --- | --- | --- |
| Is keyboard interaction expected? | Lemon64 lists **Keyboard** as the main control.[1] | Yes. | Continue controlled keyboard input traces with explicit screenshots and RAM snapshots. |
| Does an independent archive recognize this specific disk form? | Internet Archive item names the same `[cr ASS]` release and D64 emulator startup.[2] | Yes. | Compare archive screenshot sequence with project stage captures, then retain any observed input/state mapping. |
| Does a catalog prove the startup answer or loader map? | GB64 detail page cannot be read reproducibly at this time. | No. | Do not infer behavior from its search snippet; retain the access result as a P2 limitation. |
| Does a public run reach the DAAD parser quickly? | The cited longplay enters the playable text-adventure interface at roughly 00:15 and shows keyboard commands thereafter.[4] | Yes, for the observed non-byte-identical public run. | Compare the retained ASS startup variant against its own loader path; do not use the longplay as a substitute for retained execution evidence. |

## References

[1]: https://www.lemon64.com/game/jabato-vs-imperio "Lemon64 — Jabato vs. Imperio: Libertad"
[2]: https://archive.org/details/Jabato_1989_Aventuras_AD_es_cr_ASS "Internet Archive — Jabato (1989)(Aventuras AD)(es)[cr ASS]"
[3]: https://gb64.com/game.php?id=13131 "GameBase64 — Jabato vs Imperio Libertad"
[4]: https://www.youtube.com/watch?v=VkljmD_-poE "C64 Longplay: Jabato"

# Source discovery notes

## Spectrum Computing: validated ZX source pattern

On 2026-08-22, the public entry for **Behind Closed Doors** was inspected at <https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors>. The page declares the title, **1988** release date, **Zenobi Software (UK)** as original publisher, English language, and ZX-Spectrum 48K platform. Its downloadable game members are relative paths below `https://spectrumcomputing.co.uk/pub/sinclair/games/`, including `b/BehindClosedDoors.tzx.zip`.

The page also explicitly says that John Wilson permits downloads for **personal usage only** and prohibits offering files to third parties or including them in commercial activity. The repository's institutional authorization covers acquisition and retained analysis, but this external source condition must remain in each source record and is not evidence for redistribution.

The same page provides stable entry URLs for the Zenobi series candidates, including `5999` for *Behind Closed Doors 2: The Sequel*, `6000` for *Behind Closed Doors 3: Revenge of the Ants*, and `6001` for *Behind Closed Doors 4: Balrog's Day Out*. A reusable adapter must fetch every entry page, require exact candidate title, publisher, release year, language, and an actual downloadable supported-media link before registration.

[1]: https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors

## Erinia (2025) English: source found, direct acquisition unavailable

On 2026-08-22, CASA’s English Erinia record at <https://www.solutionarchive.com/game/id%2C10686/Erinia.html> linked to the official distribution page <https://dareint.itch.io/erinia-2025-english>. The official page identifies the English 2025 release by Dareint and lists Amiga, Atari ST, C64, MSX, ZX Spectrum, and CPC media files. However, it requires a purchase of at least USD 2 before the files are accessible. No public direct binary URL was exposed to the unauthenticated page reader.

This is **source-discovery evidence only**. It must remain outside `authorized_candidate_sources.json` and outside the byte-acquisition queue unless a public direct URL is later published or the user explicitly authorizes and completes a purchase through an appropriate account flow. The institutional handling directive does not convert a commercial checkout page into a free or directly retrievable binary source.

[2]: https://www.solutionarchive.com/game/id%2C10686/Erinia.html
[3]: https://dareint.itch.io/erinia-2025-english

## CASA catalog access pattern

The CASA DAAD catalog at <https://solutionarchive.com/list/system%2C34/> was visually reviewed on 2026-08-22. It exposes a public game-title search form and individual game-title links for the 95 DAAD catalog records. The browser view confirmed that the list has title, publisher, and year link elements for each row, but a direct command-line request returned a short non-catalog response. Any automated CASA adapter must therefore validate its search response and record a clear unavailable or access-limited result rather than treating a short HTTP response as an empty catalog.

[4]: https://solutionarchive.com/list/system%2C34/

## Cero Absoluto: official free-download source candidate

On 2026-08-22, the official ESP Soft page <https://amstrad-esp.itch.io/cero-absoluto-amstrad-cpc> was reviewed. It identifies **Cero Absoluto**, ESP Soft, Spanish, and Amstrad CPC; declares that the game was created with DAAD; labels the offering as free; and exposes two game-file download controls, `cero_absoluto.zip` and `cero_absoluto_tape.zip`. The published source terms forbid commercial physical or digital sales without express consent, so future source provenance must retain that non-commercial condition.

The page is a valid release-identity and access evidence candidate. A deterministic adapter still must extract the actual binary URL from the public page, fetch it, measure its checksum, and validate the retained bytes before promoting the candidate to the acquisition queue.

[5]: https://amstrad-esp.itch.io/cero-absoluto-amstrad-cpc

The public `cero_absoluto.zip` control was activated on 2026-08-22 without login or purchase. Chromium’s download history recorded a completed file named `cero_absoluto.zip`. This confirms binary delivery by the public page; the deterministic source adapter must still resolve or retain the final URL and measure the downloaded bytes before queue promotion.

The public itch.io API response for upload `6205261` returns a short-lived `/download/...` URL, but a direct HTTP GET to that URL returns an HTML download-completion page rather than game bytes. The page contains a JavaScript `game_download` control and an alternate-download-mode hint. Therefore the current adapter must not treat the JSON `url` field as a direct binary URL; it requires one further verified step that resolves the actual file delivery endpoint while retaining the temporary cookie session.

## EJVG price-free itch.io releases: official source candidates

On 2026-08-22, the official EJVG pages <https://ejvg.itch.io/the-dark-dagger> and <https://ejvg.itch.io/la-daga-oscura> were reviewed. The English page identifies **The Dark Dagger**, credits Eduardo José Villalobos Galindo, describes ZX Spectrum 128K tape media and DAAD use, and announces a December 2024 release. The Spanish page identifies **La Daga Oscura**, the same creator, ZX Spectrum 128K tape media and DAAD use, and its September 2024 release. Both pages use a name-your-own-price download with no positive minimum price.

The pinned `itchio-downloader` 1.2.0 adapter retrieved both public uploads through direct HTTP without payment: upload `13580661` for the English page and upload `13581099` for the Spanish page. The original catalog titles invert the initial article (`Dark Dagger, The` and `Daga Oscura, La`), while the official pages use `The Dark Dagger` and `La Daga Oscura`; the source record must preserve that title-variant boundary rather than silently normalizing it.

[6]: https://ejvg.itch.io/the-dark-dagger
[7]: https://ejvg.itch.io/la-daga-oscura

## DaReInt official profile: commercial-source boundary

On 2026-08-22, the official profile <https://dareint.itch.io/> was reviewed for the remaining Daniel Revenga candidates. It identifies **Erinia (2025) [English]** at a positive minimum price, **Erinia (2020, 2023, 2024) [Spanish]** at a positive minimum price, and **La Estrella de la Mañana (2017)** at a positive minimum price. These pages establish authoritative publication references but do not expose no-cost binary access. The candidates remain in `discovery_required`; no paid checkout, authentication bypass, or inferred binary URL is permitted.

[8]: https://dareint.itch.io/

## Source review: Sunteam, Taskmaster, Puddle, and FRAMED

On 2026-08-22, official Sunteam pages confirmed that **Golden Seas (ZX Spectrum Next)** is a free 2022 DAAD Ready release and **Die, Ragus! (ZX Spectrum Next)** is a free 2023 DAAD Ready release. The pinned `itchio-downloader` 1.2.0 adapter retrieved public uploads `6330996` and `8486189`, respectively. The source pages are <https://sunteam.itch.io/golden-seas> and <https://sunteam.itch.io/dieragus>.

The official Taskmaster page <https://taskmastersoftware.itch.io/a-case-of-murder> is a free name-your-own-price source and supplies `MurderFinal.tzx` and `MurderRelease.tap`, but its public re-release is dated 2023 whereas the catalog candidate records 2022. It must remain in `discovery_required` until the edition-year boundary is reconciled rather than being silently promoted.

The catalog’s **The Dragnet Case** record concerns an approximate **1989** original PAW game. CASA documents that it was only playtested and never released at the time; Spectrum Computing’s original entry 17418 independently records it as “never released,” PAW-authored, and later recovered. The official itch.io page supplies a public 2022 completion and its 2023 devlog records a re-release, while CASA separately identifies a new DAAD revision from 2023. These are distinct editions, so neither the recovered/2022 PAW files nor the 2023 DAAD version may be registered as the catalog’s 1989 release. The candidate remains in `discovery_required` pending direct source evidence that exactly represents the catalog edition.

The official Rabenstein page <https://8bitgames.itch.io/rabenstein> confirms its name-your-own-price distribution and multi-platform English/Spanish editions but identifies the release as 2020–2022, not the catalog candidate years 2019 and 2023. Spectrum Computing entry 35321 confirms the original ZX Spectrum release as 2020/Mar; the public source repository <https://github.com/ByteProject/Rabenstein> is dated 2020 and describes copyright spanning 2019–2020, but does not establish a 2019 publication nor a 2023 Spanish release. These candidates likewise remain in `discovery_required` pending a source-specific edition match.

A publicly served binary at <https://mycomputerworld.co.uk/framedv1.0.TAP> was probed on 2026-08-22 and returned 116,336 bytes of valid Spectrum TAP data with SHA-256 `67a757ae7d7f2328a34ff1d1807cd28bacdc0e515791e6f11e55f00063004eb3`. ZXInfo/ZXDB entry 0043705 at <https://zxinfo.dk/details/0043705> explicitly records **Framed!**, **Kennard Douglas** as original publisher and author, **2024**, English, and ZX-Spectrum 128K. Together with the review <https://www.youtube.com/watch?v=pMlPWT30-2A>, this closed the Kennard/Ken attribution boundary; the TAP was subsequently acquired, inspected, checksummed, and registered.

[9]: https://sunteam.itch.io/golden-seas
[10]: https://sunteam.itch.io/dieragus
[11]: https://taskmastersoftware.itch.io/a-case-of-murder
[12]: https://8bitgames.itch.io/rabenstein
[13]: https://mycomputerworld.co.uk/framedv1.0.TAP
[14]: https://www.youtube.com/watch?v=pMlPWT30-2A

The 2024 public review <https://www.youtube.com/watch?v=pMlPWT30-2A> was analyzed on 2026-08-22. Its opening screen directly shows **“Welcome to FRAMED! Part 1.”**, **“By Ken Douglas”**, **“Version 1.0”**, **“Created with DAAD Ready! and DAAD Creator Editor”**, and **“(C) 2024 www.mycomputerworld.co.uk.”** This corroborates the served TAP as a 2024 DAAD-related FRAMED release but, by itself, does not establish that **Ken Douglas** is the catalog’s **Kennard Douglas**. The subsequent ZXInfo/ZXDB record cited above explicitly attributes the 2024 English ZX Spectrum 128K release to Kennard Douglas, closing the boundary without relying on the video alone.

## Cetro del Sol source boundary

The official Zona Fi page identifies **El Cetro del Sol** as Toni Pera’s DAAD adventure, and IF-Archive provides the public Spectrum archive `cetro_del_sol.zip`; however, the index timestamps that archive **15 October 2015**. Aminet and contemporary reporting identify later Amiga/16-bit releases around 2015/2020. None of the available source records establishes a 2006 release corresponding to the catalog candidate. The public 2015 Spectrum artifact is therefore not registered as the 2006 edition; the candidate remains in `discovery_required` pending evidence that reconciles the release year.

## Deception of the Mind's Eye source boundary

Spectrum Computing entry 24882 confirms the catalog title, Electric Storm Productions, English, and the 1992/93 development period, but records the release as **never released - recovered** and identifies its engine as **Professional Adventure Writer**. The public TZX and DSK media contain the recovered part one and an explicitly incomplete part-two demo. These materials do not satisfy a published DAAD release boundary; the later DAAD ports are separate editions. The candidate remains in `discovery_required`, with no acquisition of the recovered PAW media into the DAAD corpus.

## Elfos de Maroland source boundary

Spectrum Computing entry 6245 confirms the catalog identity **Los Elfos de Maroland**, Kame Soft, Spanish, 1993, with public TAP and Z80 media, but explicitly identifies its engine as **Professional Adventure Writer**. The original author’s 2023 page confirms that the later DAAD release is a port/remake of the 1993 PAWS adventure, with altered text, fixes, and new puzzles. The available 1993 media are therefore not DAAD artifacts, while the 2023 DAAD edition is a different release already represented separately. The Kame Soft 1993 candidate remains in `discovery_required` without false DAAD registration.

## Eight Feet Under source boundary

Spectrum Computing entry 34668 and the official <https://8bitgames.itch.io/eight-feet-under> page confirm **Eight Feet Under**, Pond Software Ltd, English, DAAD, and a 2019 Spectrum edition. The official page makes multiple platform archives free, but the pinned `itchio-downloader` 1.2.0 adapter deterministically retrieves its first public upload, `game-1719404.zip`, which contains only C64/Plus4 media (`EFU_R6_C64_Plus4.d64` and two C64 TAP sides). It cannot select the listed Spectrum R6 upload, and the public HTML exposes no individual upload identifier before the purchase/download flow. Registering this adapter would therefore acquire an incorrect platform. The candidate remains in `discovery_required` until a direct Spectrum URL or an adapter with deterministic per-upload selection is available.

## Colour Beyond Time source boundary

Spectrum Computing entry 37444 identifies **Colour Beyond Time**, English, DAAD, ZX Spectrum, and a 2022/May/06 release, but names **Lost** as publisher and **Jamie Bradbury** as creator. The official itch.io page at <https://jbizzel.itch.io/cbt> is free and its 2022 development log confirms early release iterations, but identifies its author as **J Bizzel** and currently offers later multi-part/revised media. This does not establish the catalog publisher **Jamie Bradbury** as the official itch.io author nor identify a byte-exact May 2022 edition. The candidate remains in `discovery_required`; no latest itch.io file is substituted for the catalog release.

## Deer Creek source boundary

Spectrum Computing entry 34909 and IFDB independently identify the 2019 English **Deer Creek** as a Gareth Pitchford release produced with Adventuron and converted to a ZX Spectrum version powered by **PAW**. This conflicts with the catalog candidate’s publisher **Primary Resources** and does not establish a DAAD edition. The publicly downloadable Spectrum TAP/TZX and Z80 snapshot are therefore not registered for the DAAD catalog candidate; it remains in `discovery_required` pending a source that closes both the publisher and engine boundaries.

## Great Caravan Caper source boundary

Spectrum Computing entry 34746 provides downloadable 2019 Spectrum TAP/TZX media for **The Great Caravan Caper**, but names **Gareth Pitchford** as original publisher and creator. The public 8bitAG 2019 review confirms that the standalone Spectrum version was a port associated with Gareth Pitchford’s work. Neither record substantiates the catalog publisher **Electric Storm Productions** for the same edition. This is a publisher-boundary mismatch, not a direct source match; the candidate remains in `discovery_required` until a source establishes the Electric Storm release identity or a documented catalog-identity relationship.

## Dream Walker source boundary

Spectrum Computing entry 36880 confirms **Dream Walker**, English, ZX Spectrum 48K, a 2021/Oct/31 release, and PAW authorship, but identifies **Gareth Pitchford (UK)** rather than the catalog publisher **8bitAG**. More importantly, the entry explicitly marks each listed 2021 TAP member as **distribution denied**, so no public binary URL is available through that source. The official 8bitAG page is protected by an access-verification interstitial in the non-interactive reader. This is identity-supporting evidence only; the candidate remains in `discovery_required` until a public direct source is available and the 8bitAG/Gareth identity relationship is documented.

## Zenobi archive media boundary

Spectrum Computing entry 34670 for **Bulbo's Intrepid Adventure** was checked on 2026-08-22. Although it has downloadable Spectrum media, it records a **2019/Jan/29** release by **Pension Productions (UK)**, authored with PAW. It does not identify the catalog candidate’s 2018 Zenobi Software release, so it is excluded from source registration and the candidate remains in `discovery_required`. Source: <https://spectrumcomputing.co.uk/entry/34670/ZX-Spectrum/Bulbos_Intrepid_Adventure>.

On 2026-08-22, Internet Archive metadata established that `zx_Fuddo_Slam_1988_Zenobi_Software` and `zx_Balrog_and_the_Cat_The_1988_Zenobi_Software` both identify title, Zenobi Software, and 1988. Their retained playable files are Z80 emulator snapshots, not original TAP/TZX media: `Fuddo__Slam_1988_Zenobi_Software.z80` (38,617 bytes, SHA-256 `67298b77ab3fab0bbf66740a7a1f43081cb0404fb85907fa036f78cc2608c778`) and `Balrog_and_the_Cat_The_1988_Zenobi_Software.z80` (39,513 bytes, SHA-256 `ea54ac03dc4e822875090e1273f08bcbd2cedbc6e2b141416d13f3e93a5a6fea`). Both snapshots were acquired, inspected, and registered. The latter matches the catalog title exactly; the former documents its `&`-versus-`and` spelling variant explicitly in the source evidence rather than silently normalizing it. Source metadata URLs: <https://archive.org/metadata/zx_Fuddo_Slam_1988_Zenobi_Software> and <https://archive.org/metadata/zx_Balrog_and_the_Cat_The_1988_Zenobi_Software>.

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

The official Rabenstein page <https://8bitgames.itch.io/rabenstein> confirms its name-your-own-price distribution and multi-platform English/Spanish editions but identifies the release as 2020–2022, not the catalog candidate years 2019 and 2023. These candidates likewise remain in `discovery_required` pending a source-specific edition match.

A publicly served binary at <https://mycomputerworld.co.uk/framedv1.0.TAP> was probed on 2026-08-22 and returned 116,336 bytes of valid Spectrum TAP data with SHA-256 `67a757ae7d7f2328a34ff1d1807cd28bacdc0e515791e6f11e55f00063004eb3`. Search results and the public review <https://www.youtube.com/watch?v=pMlPWT30-2A> associate **FRAMED 128K**, Kennard Douglas, and 2024 with that download. It requires a corroborating stable publication record before registration.

[9]: https://sunteam.itch.io/golden-seas
[10]: https://sunteam.itch.io/dieragus
[11]: https://taskmastersoftware.itch.io/a-case-of-murder
[12]: https://8bitgames.itch.io/rabenstein
[13]: https://mycomputerworld.co.uk/framedv1.0.TAP
[14]: https://www.youtube.com/watch?v=pMlPWT30-2A

The 2024 public review <https://www.youtube.com/watch?v=pMlPWT30-2A> was analyzed on 2026-08-22. Its opening screen directly shows **“Welcome to FRAMED! Part 1.”**, **“By Ken Douglas”**, **“Version 1.0”**, **“Created with DAAD Ready! and DAAD Creator Editor”**, and **“(C) 2024 www.mycomputerworld.co.uk.”** This corroborates the served TAP as a 2024 DAAD-related FRAMED release but does not establish that **Ken Douglas** is the catalog’s **Kennard Douglas**, nor name the platform on screen. The candidate remains in `discovery_required` pending a source that explicitly closes that attribution boundary.

## Zenobi archive media boundary

Spectrum Computing entry 34670 for **Bulbo's Intrepid Adventure** was checked on 2026-08-22. Although it has downloadable Spectrum media, it records a **2019/Jan/29** release by **Pension Productions (UK)**, authored with PAW. It does not identify the catalog candidate’s 2018 Zenobi Software release, so it is excluded from source registration and the candidate remains in `discovery_required`. Source: <https://spectrumcomputing.co.uk/entry/34670/ZX-Spectrum/Bulbos_Intrepid_Adventure>.

On 2026-08-22, Internet Archive metadata established that `zx_Fuddo_Slam_1988_Zenobi_Software` and `zx_Balrog_and_the_Cat_The_1988_Zenobi_Software` both identify title, Zenobi Software, and 1988. Their retained playable files are Z80 emulator snapshots, not original TAP/TZX media: `Fuddo__Slam_1988_Zenobi_Software.z80` (38,617 bytes, SHA-256 `67298b77ab3fab0bbf66740a7a1f43081cb0404fb85907fa036f78cc2608c778`) and `Balrog_and_the_Cat_The_1988_Zenobi_Software.z80` (39,513 bytes, SHA-256 `ea54ac03dc4e822875090e1273f08bcbd2cedbc6e2b141416d13f3e93a5a6fea`). Both snapshots were acquired, inspected, and registered. The latter matches the catalog title exactly; the former documents its `&`-versus-`and` spelling variant explicitly in the source evidence rather than silently normalizing it. Source metadata URLs: <https://archive.org/metadata/zx_Fuddo_Slam_1988_Zenobi_Software> and <https://archive.org/metadata/zx_Balrog_and_the_Cat_The_1988_Zenobi_Software>.

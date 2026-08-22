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

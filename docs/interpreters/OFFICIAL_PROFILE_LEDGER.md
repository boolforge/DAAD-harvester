# Official Interpreter Profile Ledger

| Header field | Value |
| --- | --- |
| **Question** | Which exact original-runtime hash anchors does Harvester currently catalog, and where do they come from? |
| **Evidence scope** | P0 public official DAAD distribution revision; P1 SHA-256 measurements retained in source. |
| **Status** | measured |
| **Implementation links** | [`../../daad_harvester/interpreter_profiles.py`](../../daad_harvester/interpreter_profiles.py), [`../../tests/test_fingerprint.py`](../../tests/test_fingerprint.py), [`IDENTITY_PROTOCOL.md`](IDENTITY_PROTOCOL.md) |
| **Non-claims** | This ledger is an anchor catalog, not a complete census of all historical releases, regional variants, cracked versions, or derivative interpreters. |

## Provenance and reproducibility

Every `official` row below is a SHA-256 measurement recorded from the public official DAAD distribution at revision `4a7e745235a12af5b397902dbd9214bc930c7680`, inspected on 2026-08-19. The profile ID deliberately identifies the **binary**, not an asserted whole-product release number. The test suite requires at least one exact SHA-256 anchor for each of the nine canonical platforms.[1] [2]

To reproduce a row, check out the cited revision, obtain the exact listed member from its recorded path/context, compute SHA-256 over the unmodified member bytes, and compare it character-for-character. Any archive wrapper, decompression, filesystem extraction, or newline conversion error changes the evidence and must be retained as a distinct observation.

## Exact anchors: ZX, CPC, C64, Plus/4, MSX, and PCW

| Platform | Profile ID | Observed official filename(s) | SHA-256 | Language |
| --- | --- | --- | --- | --- |
| ZX Spectrum | `daad-zx-ds48ie-official` | `ds48ie.p3f` | `d599b14576cb46f72b34b106f6ad1079cdf0d346ed9ac44e89db7dbd0c0eb3d6` | English |
| ZX Spectrum | `daad-zx-ds48is-official` | `ds48is.p3f` | `e1e0f8ab8e2907eebeb24ada1bf2bb2d27b0622972239827eeb70f56ff5e0566` | Spanish |
| Amstrad CPC | `daad-cpc-dcpcie-official` | `dcpcie.z80` | `7447b56073a6e65242214c505496742346a35de0e81777ed91ea44a2f115ee41` | English |
| Amstrad CPC | `daad-cpc-dcpcis-official` | `dcpcis.z80` | `8d312860b4ce8596b9f6152c1fbc0aa5f3525189daa564dc413bf3173a19659c` | Spanish |
| Commodore 64 | `daad-c64-edi64-official` | `edi64.prg` | `c462192db2a552f079aa7d521f3ae23a3d5c066120b42108a905085e923932c5` | English |
| Commodore 64 | `daad-c64-sdi64-official` | `sdi64.prg` | `767aa97d411ea025d20e25282ae0ac90360b4fb99af01392c38d2721aa7033ec` | Spanish |
| Commodore Plus/4 | `daad-plus4-ediplus4-official` | `ediplus4.prg` | `9df2d6b35d5e138c80e3a38674afd565fe9564f27205d79d24d654d407949523` | English |
| Commodore Plus/4 | `daad-plus4-sdiplus4-official` | `sdiplus4.prg` | `f29050dfe9331634b985a8c5b8cb4ee3b164a4340e355c044284168b8610258c` | Spanish |
| MSX | `daad-msx-msxedi-official` | `msxedi.z80` | `1df91cff49dc2dcb42f2e4321644b6e088a0ac63159444bb937a9bff5848a4ca` | English |
| MSX | `daad-msx-msxsdi-official` | `msxsdi.z80` | `fcae12bd09bc949e1e6cf75b3d1ef87e66c322efe2de005e771fa3b5dd8ddbf8` | Spanish |
| Amstrad PCW | `daad-pcw-pcwedi-official` | `pcwedi.bin` | `358eb0d236db0a2b43fdc66f843eb8e2eed097f77db24e195c14bae5fbb309a2` | English |
| Amstrad PCW | `daad-pcw-pcwsdi-official` | `pcwsdi.bin` | `e52e2a8cc9e720805c7c6c7f8fe9fd706933c73696e695d7c1132063d4e52a7d` | Spanish |

## Exact anchors: Atari ST and Amiga

Filename reuse is normal across target families. The platform-qualified profile ID and SHA-256, rather than the basename, establish identity.

| Platform | Profile ID | Observed official filename(s) | SHA-256 | Language |
| --- | --- | --- | --- | --- |
| Atari ST | `daad-atarist-edi1-official` | `edi1.prg` | `ecc25e01611b1b3f2546c63b67220011f1793809cb177543030d5b626520c7fd` | English |
| Atari ST | `daad-atarist-edi2-official` | `edi2.prg` | `6e1c18327066ead24985d6b9033353f16ca7e70e39863af5320d933194b38a72` | English |
| Atari ST | `daad-atarist-sdi1-official` | `sdi1.prg` | `35a0c10701e59739e1bf7e701e1e1aa7f5bb5112f79445e8038be0502360a9f2` | Spanish |
| Atari ST | `daad-atarist-sdi2-official` | `sdi2.prg` | `04ac433d70777dc15434ec5d7c7002f28b30bc8f1f3ed5c0eef01ea6c245a9b1` | Spanish |
| Amiga | `daad-amiga-edi1-official` | `edi1`, `edi1.prg` | `5f3bd8275d500d44fc41d7ae2a77e86593bd7075b6ad9fffde639265c0990952` | English |
| Amiga | `daad-amiga-edi2-official` | `edi2`, `edi2.prg` | `6926ca43824c00098dcb6267a639aede2ae0640b2640be03fa9a1be965f37664` | English |
| Amiga | `daad-amiga-sdi1-official` | `sdi1`, `sdi1.prg` | `105c27fc80bcb9183409d9774792a8486ec34207d9a29e21efc53e475558c7f7` | Spanish |
| Amiga | `daad-amiga-sdi2-official` | `sdi2`, `sdi2.prg` | `e083dcd70726c97204404fa48eea9db49d839a6af4218408c4d40520dd8ec338` | Spanish |

## Exact anchors: IBM PC/DOS

| Profile ID | Observed official filename | SHA-256 | Language |
| --- | --- | --- | --- |
| `daad-dos-inte1-official` | `inte1.exe` | `1070941c6fa8e73a3b5357be72db97d1f1a6b48ab01fbe895470586ef3a47617` | English |
| `daad-dos-inte2-official` | `inte2.exe` | `4cb3a608f331c20402ab1ad3c13968e86f3c909dc1ebad31d7a3e3b50312837f` | English |
| `daad-dos-inte3-official` | `inte3.exe` | `ea2494b657626db967f36d608b8cabe9ab82832f5d38266c8f1b6e40b9eb7aa3` | English |
| `daad-dos-intecga1-official` | `intecga1.exe` | `665ed57b5ad4b4168a70cc11634159081fc4f1f7ab57b49c75245755efb261c7` | English |
| `daad-dos-intecga2-official` | `intecga2.exe` | `ddc34e84977308c3f592d304473d8398c84b4d70666f0c35aed74e3b88b76d6d` | English |
| `daad-dos-intecga3-official` | `intecga3.exe` | `bdaaafe615ec073d81757e81504b3ffbed337a9bd4729d0aff203a4cbabadb4a` | English |
| `daad-dos-inted-official` | `inted.exe` | `d683e9c9a023e9996d811aa1a803bcc98d0fb3c91055f68ad3ceca4a59d1f9c9` | English |
| `daad-dos-intedm-official` | `intedm.exe` | `3e0d786ce8abdd3225af8f290a19fb3b9ba2fdc32106b401b6c7028e3e5065e1` | English |
| `daad-dos-intem1-official` | `intem1.exe` | `6b50665f29c1024cbad8fe7ee5be42e0eb3ad49e1db8071119bf0e9e1ed57594` | English |
| `daad-dos-intem2-official` | `intem2.exe` | `2ca22c899432c1ab0d96418961f91638ffd3438a8cf4e8f69b8f9419a0dec765` | English |
| `daad-dos-intem3-official` | `intem3.exe` | `a430e15fe634157eae3fc45324787a3e6b79fa15814cb98e709c71407d55c5fc` | English |
| `daad-dos-ints1-official` | `ints1.exe` | `af5a3b732f53ee75042715f618e8a3daec77833491b8582d428ad2ba203129b5` | Spanish |
| `daad-dos-ints2-official` | `ints2.exe` | `39d7d99a40d77f466e648ded927b3c02bdef779411f7151ca51219be360a6455` | Spanish |
| `daad-dos-ints3-official` | `ints3.exe` | `fef8c5eabf256094da57dae6787884243ca3dec98dbe7a3c7438c93509903de3` | Spanish |
| `daad-dos-intscga1-official` | `intscga1.exe` | `bd36734b7909453a3784dfd9f819ba505a82df21f973a9992e58bec58f1e6191` | Spanish |
| `daad-dos-intscga2-official` | `intscga2.exe` | `c478647bba2a3330c89c4233d3b51ba36d6357d7d7d30c7fe270287eab9034e6` | Spanish |
| `daad-dos-intscga3-official` | `intscga3.exe` | `6a8f60d5dcbf5e650934eb452ddfd215325bc5a02fdaf3b9ddf4937afb765cb9` | Spanish |
| `daad-dos-intsd-official` | `intsd.exe` | `797fcca14224a71cd03a02f476d12513f1d360921b24db2502544841b90a0567` | Spanish |
| `daad-dos-intsdm-official` | `intsdm.exe` | `3a8187daf5ab46d3b6deaba955128477e13b5d62713e06f607fa040273514937` | Spanish |
| `daad-dos-intsm1-official` | `intsm1.exe` | `b17f78e22dd71961a21eb94e7afbd85cc1ec104e3860339f40d1e1877db5be51` | Spanish |
| `daad-dos-intsm2-official` | `intsm2.exe` | `27531111a82e9f5f62c6eae7efcc03175542a5ffe6f8d85677e88b3d4db16dab` | Spanish |
| `daad-dos-intsm3-official` | `intsm3.exe` | `54baa0b227cd2c1849c90d6727de130c58cda3a8c0d8c2f8adf50585d3246f01` | Spanish |

## Filename-only historical observation

| Platform | Profile ID | Filename | Classification | Rule |
| --- | --- | --- | --- | --- |
| Commodore Plus/4 | `daad-plus4-ediplus4-historical` | `ediplus4` | Filename-only historical observation; no SHA-256 anchor. | Report as `strong` only when the observed name matches; never `verified` without a future exact profile. |

## Ledger maintenance contract

New entries require a retained source revision/package identity, original member path, reproducible SHA-256 calculation, platform/language metadata where evidenced, and a regression test. Replacing an anchor changes historical reporting behavior and therefore must be reviewed as a provenance change, not a cosmetic catalog update.[1] [2]

## References

[1]: https://github.com/daad-adventure-writer/daad/tree/4a7e745235a12af5b397902dbd9214bc930c7680 "Official DAAD distribution revision used for profile measurements"
[2]: https://github.com/boolforge/DAAD-harvester/blob/main/daad_harvester/interpreter_profiles.py "Harvester’s canonical profile definitions"

# Retained Static-Analysis Commentary Review Scaffold

> **Evidence scope:** This native index copies only retained analysis-record identity, tool-record, and output-hash metadata. It does not parse or summarize analyzer listings.

> **Non-claims:** A decoded instruction, CFG edge, symbol, function boundary, pseudocode line, or comment from an external tool is not recovered source code or verified runtime behavior. Every semantic statement requires separately linked native, load-model, trace, emulator, or primary-source evidence.

**Record count:** 42

## Required review layers

| Layer | Allowed content | Prohibited shortcut |
| --- | --- | --- |
| Immutable bytes | Retained input path, hash, architecture, and byte range. | Treating an unchanged hash as a semantic interpretation. |
| Decoded instructions | Explicit adapter, CPU, endian, origin, and output reference. | Treating a decode as proof of code/data classification. |
| Tool hypotheses | Named tool output and its recorded configuration boundary. | Calling inferred functions, labels, or pseudocode recovered source. |
| Evidenced behavior | Separate native parser, justified load model, trace, emulator, or primary-source reference. | Inferring behavior solely from an analyzer listing. |

## `i8086` — `daad-dos-inte1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-inte1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-inte1-official/INTE1.EXE` |
| Input SHA-256 | `1070941c6fa8e73a3b5357be72db97d1f1a6b48ab01fbe895470586ef3a47617` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte1-official/independent-static-disassembly.txt` | `4713adabe9482a8d44eae67f8e052f2161095e3da67a5b46ec5b510b4ddef0c1` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-headless.log` | `26db92dbcb42752406645f196075108418dc6f1b4e08875b791cdb08d17633f3` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte1-official/radare2-analysis.txt` | `f5976e954108706fa5f08e8aed6d679414e6826f9d44af4947fe921a6f1f5638` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-headless.log` | `6633` | `26db92dbcb42752406645f196075108418dc6f1b4e08875b791cdb08d17633f3` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-listing.txt` | `256897` | `5705bcdcceac030a45e68b54310ff0897a40569cdfbb4a1cb633cdbdf9fb4160` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/ghidra-metadata.json` | `132` | `347e6ad044db2c03f6c9ab1f7d98cb97130a65cda5a1f0c7f24dd9b4f40374b2` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/independent-static-disassembly.txt` | `250091` | `4713adabe9482a8d44eae67f8e052f2161095e3da67a5b46ec5b510b4ddef0c1` |
| `reverse_engineering/derived/i8086/daad-dos-inte1-official/radare2-analysis.txt` | `1684807` | `f5976e954108706fa5f08e8aed6d679414e6826f9d44af4947fe921a6f1f5638` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-inte2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-inte2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-inte2-official/INTE2.EXE` |
| Input SHA-256 | `4cb3a608f331c20402ab1ad3c13968e86f3c909dc1ebad31d7a3e3b50312837f` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte2-official/independent-static-disassembly.txt` | `42d2a416c2dcb8dc829e8d2aee4933e7dd5356f592b876866a2be336fe052edd` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-headless.log` | `1241dba7c9ee0db36a8fd66d9e4aa00bfb8437bf05b130d2e4f36a85f727aea0` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte2-official/radare2-analysis.txt` | `50bc70e395e1ebc6a1bc1246144d0b95df28863c897905eb327acf7e1038c5db` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-headless.log` | `6633` | `1241dba7c9ee0db36a8fd66d9e4aa00bfb8437bf05b130d2e4f36a85f727aea0` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-listing.txt` | `256897` | `a22053efc7eb4bffe55b5efae03db15362e4b456f47eb017e186db5fdfc4d201` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/ghidra-metadata.json` | `132` | `cea1fe88adc07a11f84932a133407fcc4947e2482e995904158ebfd24708112e` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/independent-static-disassembly.txt` | `250039` | `42d2a416c2dcb8dc829e8d2aee4933e7dd5356f592b876866a2be336fe052edd` |
| `reverse_engineering/derived/i8086/daad-dos-inte2-official/radare2-analysis.txt` | `1684908` | `50bc70e395e1ebc6a1bc1246144d0b95df28863c897905eb327acf7e1038c5db` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-inte3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-inte3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-inte3-official/INTE3.EXE` |
| Input SHA-256 | `ea2494b657626db967f36d608b8cabe9ab82832f5d38266c8f1b6e40b9eb7aa3` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte3-official/independent-static-disassembly.txt` | `643a44750dff928f950d20225a4c8b15806f248a71eb9e216e4275013c864d18` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-headless.log` | `418e0e99a7445be7c745bdc43baf9683c109e77bf9b6fd56c6cd09dcdafcbdf0` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-inte3-official/radare2-analysis.txt` | `5e9c6df450a5fa092495703d07c6c1e6d8209a9b2d704f5d69231078052491e4` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-headless.log` | `6633` | `418e0e99a7445be7c745bdc43baf9683c109e77bf9b6fd56c6cd09dcdafcbdf0` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-listing.txt` | `257159` | `5cca7d336343a423a05d46578d41cfdb0dabe60ae67d2f756eff78a765e92963` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/ghidra-metadata.json` | `132` | `e8954cf43cf490cb7f407d68139ca36c196979a46d1c60f41f4c2711dee33175` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/independent-static-disassembly.txt` | `250409` | `643a44750dff928f950d20225a4c8b15806f248a71eb9e216e4275013c864d18` |
| `reverse_engineering/derived/i8086/daad-dos-inte3-official/radare2-analysis.txt` | `1686274` | `5e9c6df450a5fa092495703d07c6c1e6d8209a9b2d704f5d69231078052491e4` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intecga1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intecga1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intecga1-official/INTECGA1.EXE` |
| Input SHA-256 | `665ed57b5ad4b4168a70cc11634159081fc4f1f7ab57b49c75245755efb261c7` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga1-official/independent-static-disassembly.txt` | `ff243fab380a89cf15b70f67dfea0731c674c5d35822d95188560ad0cf355a3c` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-headless.log` | `5ce92fabf68dccebf94a0d638c8a15fdc18191b949365bb9ea6a156b494c1dbe` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga1-official/radare2-analysis.txt` | `c30141574be47ce9e4fbacc8841433741e540d19a5e5474b6d4c66cd1728081f` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-headless.log` | `6684` | `5ce92fabf68dccebf94a0d638c8a15fdc18191b949365bb9ea6a156b494c1dbe` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-listing.txt` | `243892` | `c7856faf45054c58c4d352b01b80d2576e9968361f0580c7a474964126b2557c` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/ghidra-metadata.json` | `135` | `feb1ba1dee0f59fba087bbf3af8018cc78f0932bded49fcd6e1a6ef1c336f6b8` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/independent-static-disassembly.txt` | `237813` | `ff243fab380a89cf15b70f67dfea0731c674c5d35822d95188560ad0cf355a3c` |
| `reverse_engineering/derived/i8086/daad-dos-intecga1-official/radare2-analysis.txt` | `1642247` | `c30141574be47ce9e4fbacc8841433741e540d19a5e5474b6d4c66cd1728081f` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intecga2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intecga2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intecga2-official/INTECGA2.EXE` |
| Input SHA-256 | `ddc34e84977308c3f592d304473d8398c84b4d70666f0c35aed74e3b88b76d6d` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga2-official/independent-static-disassembly.txt` | `0cf7ab397f30178dfb145f57730bf253f8be4d3183ed04e156ee96b56bbc2b60` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-headless.log` | `fed01b85ac67abaa172ed25401a8739dc7430f76519d256d2dd1dc0ed2f55b40` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga2-official/radare2-analysis.txt` | `e4290db0ca50f0649759a11200cd333cc796c06bad2560d9b6b9d8ef60299028` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-headless.log` | `6684` | `fed01b85ac67abaa172ed25401a8739dc7430f76519d256d2dd1dc0ed2f55b40` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-listing.txt` | `243892` | `8e2d674df91c375873aa4adf4a9caa8be1edb8a91756a8fcd3ce4b83c15b1820` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/ghidra-metadata.json` | `135` | `773e40e2e51067e81fc762944a0d0ff5828f5579f8a7bcafba4ee733405c68c0` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/independent-static-disassembly.txt` | `237735` | `0cf7ab397f30178dfb145f57730bf253f8be4d3183ed04e156ee96b56bbc2b60` |
| `reverse_engineering/derived/i8086/daad-dos-intecga2-official/radare2-analysis.txt` | `1642360` | `e4290db0ca50f0649759a11200cd333cc796c06bad2560d9b6b9d8ef60299028` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intecga3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intecga3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intecga3-official/INTECGA3.EXE` |
| Input SHA-256 | `bdaaafe615ec073d81757e81504b3ffbed337a9bd4729d0aff203a4cbabadb4a` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga3-official/independent-static-disassembly.txt` | `7d28a476cae2c8c53337c9acc21f4db3a4a558415c556a50870438bcd80d3346` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-headless.log` | `ea87fe49e1a0fa60ae2712efb28aaa71564a74c5d6ac384876a588d1f905f513` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intecga3-official/radare2-analysis.txt` | `20d44d188ca0d7f08a728aae51654f0d60c0d35babe68f120d9b370423797d63` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-headless.log` | `6684` | `ea87fe49e1a0fa60ae2712efb28aaa71564a74c5d6ac384876a588d1f905f513` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-listing.txt` | `244159` | `22de560fc52a751469d3937f3921f6312dbd5e25d010eed5555d2ad5a035d917` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/ghidra-metadata.json` | `135` | `70081f87c1cfa4f1427eb819a144adf97d11276f8bf6ff57495ba7777e7848fd` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/independent-static-disassembly.txt` | `238056` | `7d28a476cae2c8c53337c9acc21f4db3a4a558415c556a50870438bcd80d3346` |
| `reverse_engineering/derived/i8086/daad-dos-intecga3-official/radare2-analysis.txt` | `1643825` | `20d44d188ca0d7f08a728aae51654f0d60c0d35babe68f120d9b370423797d63` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-inted-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-inted-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-inted-official/INTED.EXE` |
| Input SHA-256 | `d683e9c9a023e9996d811aa1a803bcc98d0fb3c91055f68ad3ceca4a59d1f9c9` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-inted-official/independent-static-disassembly.txt` | `7178bdbcd00f1fc48b76742b7d43de92b14e5aa5b01f10e4af41f32b5029489c` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-headless.log` | `ce9c24f8bf5610d8dd8b279c751212b6e307d3c07658b5613068c165a2f2a482` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-inted-official/radare2-analysis.txt` | `1bbf3702ae5625341bd52a8c2cf175fab81e427b07f85da10b953f0934c167fe` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-headless.log` | `6633` | `ce9c24f8bf5610d8dd8b279c751212b6e307d3c07658b5613068c165a2f2a482` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-listing.txt` | `263413` | `3df1a29f5339ddad164566b64ce80e4ba9c17f792babca24fab79467416a6f1e` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/ghidra-metadata.json` | `132` | `ef97a3f4bf88fee9ac396be081e86440d2ed2a9a5b5a3aef2a49b4c3624346fa` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/independent-static-disassembly.txt` | `256417` | `7178bdbcd00f1fc48b76742b7d43de92b14e5aa5b01f10e4af41f32b5029489c` |
| `reverse_engineering/derived/i8086/daad-dos-inted-official/radare2-analysis.txt` | `1783219` | `1bbf3702ae5625341bd52a8c2cf175fab81e427b07f85da10b953f0934c167fe` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intedm-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intedm-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intedm-official/INTEDM.EXE` |
| Input SHA-256 | `3e0d786ce8abdd3225af8f290a19fb3b9ba2fdc32106b401b6c7028e3e5065e1` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intedm-official/independent-static-disassembly.txt` | `2c856a6a2962427305b13a9196ad3695484b7219414aa46c791ef1c5b5c2bda5` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-headless.log` | `18927fdb7147e20ab64dc1d1bcd9abcc5ca8311bbc4da4ccf4947530a829ef09` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intedm-official/radare2-analysis.txt` | `2410c0f60062607f08a7bd21bd6bf0c98cf2378d28cfe832f597231d3bd1d1e9` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-headless.log` | `6650` | `18927fdb7147e20ab64dc1d1bcd9abcc5ca8311bbc4da4ccf4947530a829ef09` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-listing.txt` | `279936` | `0794ab54dd670477f0054a2418eca0eec4dc2ed031ac02fbfdf67eef47a53ff6` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/ghidra-metadata.json` | `133` | `986d22640fe4b3a876d413053aa2480b6d26f4c3b526c4df0b13a8acbece7183` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/independent-static-disassembly.txt` | `275359` | `2c856a6a2962427305b13a9196ad3695484b7219414aa46c791ef1c5b5c2bda5` |
| `reverse_engineering/derived/i8086/daad-dos-intedm-official/radare2-analysis.txt` | `1911352` | `2410c0f60062607f08a7bd21bd6bf0c98cf2378d28cfe832f597231d3bd1d1e9` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intem1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intem1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intem1-official/INTEM1.EXE` |
| Input SHA-256 | `6b50665f29c1024cbad8fe7ee5be42e0eb3ad49e1db8071119bf0e9e1ed57594` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem1-official/independent-static-disassembly.txt` | `fe411010ac51f450a330470948140100f0824f98aa1d9206ff7d2fb9a3c848d5` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-headless.log` | `34382e006c34f5d1e1298b06b838401a8a9250aee10a2a7979922c81291365c3` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem1-official/radare2-analysis.txt` | `de72348e2b0058d3e1092758c9e4b3f03a1fdafdfc373917ee65c84b77af5153` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-headless.log` | `6650` | `34382e006c34f5d1e1298b06b838401a8a9250aee10a2a7979922c81291365c3` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-listing.txt` | `273697` | `d72ad0c83d358e17dfd18c4317563d85bbe2ec8954f3405c2ea3ce6b74da50ff` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/ghidra-metadata.json` | `133` | `78bdb35268ba541da3ea33d989cf1d8b26c1dd40642bad79955659ba69a02992` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/independent-static-disassembly.txt` | `269439` | `fe411010ac51f450a330470948140100f0824f98aa1d9206ff7d2fb9a3c848d5` |
| `reverse_engineering/derived/i8086/daad-dos-intem1-official/radare2-analysis.txt` | `1807782` | `de72348e2b0058d3e1092758c9e4b3f03a1fdafdfc373917ee65c84b77af5153` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intem2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intem2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intem2-official/INTEM2.EXE` |
| Input SHA-256 | `2ca22c899432c1ab0d96418961f91638ffd3438a8cf4e8f69b8f9419a0dec765` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem2-official/independent-static-disassembly.txt` | `b332c224ab00382d14249c49dce1dc3accc510ee08282f1ebdc183c89fc4559f` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-headless.log` | `2d4dbd0b56e4ef3651b656d1ccc7cf7ee57779f0f7a1ce6c6938e603324ece1c` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem2-official/radare2-analysis.txt` | `eb8189ce96c5a2705356a8a7e2e74b4341b2a27e31e4c3d6af264a6875c75964` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-headless.log` | `6650` | `2d4dbd0b56e4ef3651b656d1ccc7cf7ee57779f0f7a1ce6c6938e603324ece1c` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-listing.txt` | `273697` | `c1832b6d01db47c0422f6232e0214f3ff62d506ea96a639ae8a0b9e335272f5e` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/ghidra-metadata.json` | `133` | `1e2d9727838331d628da35ad499d0f108ef96e3c93a30253f32ca812fa024656` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/independent-static-disassembly.txt` | `269479` | `b332c224ab00382d14249c49dce1dc3accc510ee08282f1ebdc183c89fc4559f` |
| `reverse_engineering/derived/i8086/daad-dos-intem2-official/radare2-analysis.txt` | `1807971` | `eb8189ce96c5a2705356a8a7e2e74b4341b2a27e31e4c3d6af264a6875c75964` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intem3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intem3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intem3-official/INTEM3.EXE` |
| Input SHA-256 | `a430e15fe634157eae3fc45324787a3e6b79fa15814cb98e709c71407d55c5fc` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem3-official/independent-static-disassembly.txt` | `cbd5a5b752a1fc497aa15627a3f79010fbe95affa2ae865887501d436f25350b` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-headless.log` | `c2f7670dee0720862ced5f8930469612d48e617039de3af9cf429f833e46889b` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intem3-official/radare2-analysis.txt` | `fc6459bd64d9bfbeb90497e38a34ff1dea6fe3c352cce625f233479a26a5b850` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-headless.log` | `6650` | `c2f7670dee0720862ced5f8930469612d48e617039de3af9cf429f833e46889b` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-listing.txt` | `273974` | `2488805bcc1290f3d4fdc5cea8a4198978571b8b52583f4549fba64c12b0b2c0` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/ghidra-metadata.json` | `133` | `ce649313f282f693eab742e331614e499ab7c447021296abe4400d99002f28a4` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/independent-static-disassembly.txt` | `269871` | `cbd5a5b752a1fc497aa15627a3f79010fbe95affa2ae865887501d436f25350b` |
| `reverse_engineering/derived/i8086/daad-dos-intem3-official/radare2-analysis.txt` | `1809412` | `fc6459bd64d9bfbeb90497e38a34ff1dea6fe3c352cce625f233479a26a5b850` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-ints1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-ints1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-ints1-official/INTS1.EXE` |
| Input SHA-256 | `af5a3b732f53ee75042715f618e8a3daec77833491b8582d428ad2ba203129b5` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints1-official/independent-static-disassembly.txt` | `47eec72f79567b26426032856e5c21aca6cc45ac6a282aadf5c97e069b209e30` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-headless.log` | `d6a3e3476242787294624e9b2d7d07a60ab591bab8670fcb463122e7396899b3` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints1-official/radare2-analysis.txt` | `30c16af200f7f131a14d243a7806d93f9322e53606a6d805ab0b3439f3010285` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-headless.log` | `6633` | `d6a3e3476242787294624e9b2d7d07a60ab591bab8670fcb463122e7396899b3` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-listing.txt` | `262491` | `78d952099763927833bec9ea53aac6f8d36447564b098c85781e3749c71ac731` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/ghidra-metadata.json` | `132` | `f5e965f07c4ca2f8492f0f3365d6a18178b69543f8dcbc0239872aa9c5048ee7` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/independent-static-disassembly.txt` | `254768` | `47eec72f79567b26426032856e5c21aca6cc45ac6a282aadf5c97e069b209e30` |
| `reverse_engineering/derived/i8086/daad-dos-ints1-official/radare2-analysis.txt` | `1715472` | `30c16af200f7f131a14d243a7806d93f9322e53606a6d805ab0b3439f3010285` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-ints2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-ints2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-ints2-official/INTS2.EXE` |
| Input SHA-256 | `39d7d99a40d77f466e648ded927b3c02bdef779411f7151ca51219be360a6455` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints2-official/independent-static-disassembly.txt` | `eab6470c385d04b65bdefba87230d49b7ac571160278e949d192978d4aea03a3` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-headless.log` | `5ef963a57a62da8265d68f918e001b71ea9a3d92c446f2e4a1cf98d0e405f33d` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints2-official/radare2-analysis.txt` | `663b77334f4cf4955a2724807432a90b8a0728463d2f5f017a81ac98585ab75c` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-headless.log` | `6633` | `5ef963a57a62da8265d68f918e001b71ea9a3d92c446f2e4a1cf98d0e405f33d` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-listing.txt` | `262491` | `6c89a03c9b9a87b7a53cb8bf01b52864d22a60b761664ade39a980c5a5a38a29` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/ghidra-metadata.json` | `132` | `6f2b9b5c7d6b470a29f3caf4e7a6c4f851da40d0047e5e5ae1f9009e432e4130` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/independent-static-disassembly.txt` | `254774` | `eab6470c385d04b65bdefba87230d49b7ac571160278e949d192978d4aea03a3` |
| `reverse_engineering/derived/i8086/daad-dos-ints2-official/radare2-analysis.txt` | `1715573` | `663b77334f4cf4955a2724807432a90b8a0728463d2f5f017a81ac98585ab75c` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-ints3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-ints3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-ints3-official/INTS3.EXE` |
| Input SHA-256 | `fef8c5eabf256094da57dae6787884243ca3dec98dbe7a3c7438c93509903de3` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints3-official/independent-static-disassembly.txt` | `06422c462f278ea75aa50c117a6d14183477ccdde8b722bbcbf06be3de571e41` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-headless.log` | `6093f2c701b40d954368f1f9e1496f2a00414e92b98564229a1e8eca271cbc18` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-ints3-official/radare2-analysis.txt` | `5e29b4d0ef37678639e3588ecb61f2aa1b49165ce11d71358665c171ca014096` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-headless.log` | `6634` | `6093f2c701b40d954368f1f9e1496f2a00414e92b98564229a1e8eca271cbc18` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-listing.txt` | `262773` | `8970ba915934ed671c1cfea96df76ddf4bf86b89cdff988d1612ecf22b4cfdc6` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/ghidra-metadata.json` | `132` | `5cd45b5f217a8675519147ab3fbb9098b09320d58dc99957c4ae4b1b2b2efe9f` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/independent-static-disassembly.txt` | `255073` | `06422c462f278ea75aa50c117a6d14183477ccdde8b722bbcbf06be3de571e41` |
| `reverse_engineering/derived/i8086/daad-dos-ints3-official/radare2-analysis.txt` | `1772286` | `5e29b4d0ef37678639e3588ecb61f2aa1b49165ce11d71358665c171ca014096` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intscga1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intscga1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intscga1-official/INTSCGA1.EXE` |
| Input SHA-256 | `bd36734b7909453a3784dfd9f819ba505a82df21f973a9992e58bec58f1e6191` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga1-official/independent-static-disassembly.txt` | `b41867406b6343f1c36367c1c826e5503493dd715daa8dae59f592912b843572` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-headless.log` | `646808f23f82a74571b79e6b99caea3f20e42b9742b012c04a62380cd831a3f9` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga1-official/radare2-analysis.txt` | `c152bfdb56dcf6d2a37a037d7c31cf8eed548755b737f3c909a813bb4606441f` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-headless.log` | `6684` | `646808f23f82a74571b79e6b99caea3f20e42b9742b012c04a62380cd831a3f9` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-listing.txt` | `249768` | `c62dad324346da8be2aa32c2614cce3904d260cdb8eec87ad122098eb6e00d7d` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/ghidra-metadata.json` | `135` | `241a7046b61807c4558a1c9d13dcdcd92202a766d1e95a94bfe0de7bcf9c17a3` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/independent-static-disassembly.txt` | `242667` | `b41867406b6343f1c36367c1c826e5503493dd715daa8dae59f592912b843572` |
| `reverse_engineering/derived/i8086/daad-dos-intscga1-official/radare2-analysis.txt` | `1683435` | `c152bfdb56dcf6d2a37a037d7c31cf8eed548755b737f3c909a813bb4606441f` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intscga2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intscga2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intscga2-official/INTSCGA2.EXE` |
| Input SHA-256 | `c478647bba2a3330c89c4233d3b51ba36d6357d7d7d30c7fe270287eab9034e6` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga2-official/independent-static-disassembly.txt` | `7b7c2bdd6719269dd824e3e8863eb4c586c3fa0bd6b15f7f61eb95c416e7978e` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-headless.log` | `d2e053a54e3407210c6aa753472c4f735bbfdd77d17bad4f177cf411798c9cbd` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga2-official/radare2-analysis.txt` | `ce1d6166c1dccbaadfaad9056bebc40828fd6d10a9ef631c00304fb353794fb2` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-headless.log` | `6684` | `d2e053a54e3407210c6aa753472c4f735bbfdd77d17bad4f177cf411798c9cbd` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-listing.txt` | `249768` | `21b8c7de9c3c291d73f218a9837e26ae58dadd733b63be0f514a6d3c2b0dc45f` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/ghidra-metadata.json` | `135` | `65731bebff338552c878b8e94a95befcedfbd0f20109eca8f1f1c7ada95d08e2` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/independent-static-disassembly.txt` | `242674` | `7b7c2bdd6719269dd824e3e8863eb4c586c3fa0bd6b15f7f61eb95c416e7978e` |
| `reverse_engineering/derived/i8086/daad-dos-intscga2-official/radare2-analysis.txt` | `1683548` | `ce1d6166c1dccbaadfaad9056bebc40828fd6d10a9ef631c00304fb353794fb2` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intscga3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intscga3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intscga3-official/INTSCGA3.EXE` |
| Input SHA-256 | `6a8f60d5dcbf5e650934eb452ddfd215325bc5a02fdaf3b9ddf4937afb765cb9` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga3-official/independent-static-disassembly.txt` | `2a43fc237201e796e9924d456e4feff6ffb570249090217d2218cc03da165231` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-headless.log` | `84f613cb9a4ee67352426998793e61cee21db97f5839304e989c2125e8d7d3c7` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intscga3-official/radare2-analysis.txt` | `827d8f5976ee8c1529d11eca138353a1ca3fb82e39455ba06f48010e6dedc3e0` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-headless.log` | `6684` | `84f613cb9a4ee67352426998793e61cee21db97f5839304e989c2125e8d7d3c7` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-listing.txt` | `250040` | `04d931fd392ac205a5190d4b52d5aaf2005ea67ba3ddc58738faa47688c3afff` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/ghidra-metadata.json` | `135` | `4f329816a3f74b477a0fe8d60273ad9839661ef0144350b4e9af193da8eb260a` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/independent-static-disassembly.txt` | `243053` | `2a43fc237201e796e9924d456e4feff6ffb570249090217d2218cc03da165231` |
| `reverse_engineering/derived/i8086/daad-dos-intscga3-official/radare2-analysis.txt` | `1684957` | `827d8f5976ee8c1529d11eca138353a1ca3fb82e39455ba06f48010e6dedc3e0` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intsd-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intsd-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intsd-official/INTSD.EXE` |
| Input SHA-256 | `797fcca14224a71cd03a02f476d12513f1d360921b24db2502544841b90a0567` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsd-official/independent-static-disassembly.txt` | `1089f35522502b3b466c18bb35c8f2b34b5db065a5aa0949010c812bb306807e` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-headless.log` | `f3894c1c1533b14ff093351352febf1989428535e41f4041d484e460510bdcf5` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsd-official/radare2-analysis.txt` | `9ec571fe88f4df6c06539d83af620590d83093f0e3989e32bc88e8657f94296d` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-headless.log` | `6633` | `f3894c1c1533b14ff093351352febf1989428535e41f4041d484e460510bdcf5` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-listing.txt` | `269100` | `a27a4dec294fa47e20b7ca0b94834dba9241e5996edba2b4aab2a60e8f58510d` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/ghidra-metadata.json` | `132` | `df5baa4bd937601505fa19c0a7b3c167cc526bd97a672272c0108fa19a2e192a` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/independent-static-disassembly.txt` | `260992` | `1089f35522502b3b466c18bb35c8f2b34b5db065a5aa0949010c812bb306807e` |
| `reverse_engineering/derived/i8086/daad-dos-intsd-official/radare2-analysis.txt` | `1819185` | `9ec571fe88f4df6c06539d83af620590d83093f0e3989e32bc88e8657f94296d` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intsdm-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intsdm-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intsdm-official/INTSDM.EXE` |
| Input SHA-256 | `3a8187daf5ab46d3b6deaba955128477e13b5d62713e06f607fa040273514937` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsdm-official/independent-static-disassembly.txt` | `e50bb3a41c2ffc09d937b39c42b6538bb312a73f819721e8fdddc6b5c3f1a2c4` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-headless.log` | `e77024c1384150be8589cf44fe2973bde7356faa5f44bfe0a6ab3258eae7d959` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsdm-official/radare2-analysis.txt` | `1b3e56270d1cd11571ec7a6deefde516d52cad91255dbbcdcb12a9cfc1f26034` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-headless.log` | `6650` | `e77024c1384150be8589cf44fe2973bde7356faa5f44bfe0a6ab3258eae7d959` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-listing.txt` | `286004` | `785c953ebf81dcbffdca061ee918320855f600f9a8d0677ede19018f386fc434` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/ghidra-metadata.json` | `133` | `f0dcb6f3eb8e5b519ac89423f9a6a06463dc2f87317805f623a4200635bacaca` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/independent-static-disassembly.txt` | `280461` | `e50bb3a41c2ffc09d937b39c42b6538bb312a73f819721e8fdddc6b5c3f1a2c4` |
| `reverse_engineering/derived/i8086/daad-dos-intsdm-official/radare2-analysis.txt` | `1951351` | `1b3e56270d1cd11571ec7a6deefde516d52cad91255dbbcdcb12a9cfc1f26034` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intsm1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intsm1-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intsm1-official/INTSM1.EXE` |
| Input SHA-256 | `b17f78e22dd71961a21eb94e7afbd85cc1ec104e3860339f40d1e1877db5be51` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm1-official/independent-static-disassembly.txt` | `5150f6e747c1f08695d6e7e7c766b54eda0e314abd80883376d0099e1b057016` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-headless.log` | `328ba7606cf3ed40e9eb92bbca118d8174cdd3f47c65dea0e4261c61dfcae051` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm1-official/radare2-analysis.txt` | `2001fc5777770c35a62c7b96dc1b908bf1a68390c9c0b50940ebaf4275956ba6` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-headless.log` | `6650` | `328ba7606cf3ed40e9eb92bbca118d8174cdd3f47c65dea0e4261c61dfcae051` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-listing.txt` | `279395` | `fbc22e42687d78d5f3685d9d09f7ddcf82181354ab7e8c2d349d1796e58ebea1` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/ghidra-metadata.json` | `133` | `0c43a8820e119d0219c93ac9bd592c48e7fdb9b3f7935198b994643a96465a2d` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/independent-static-disassembly.txt` | `274059` | `5150f6e747c1f08695d6e7e7c766b54eda0e314abd80883376d0099e1b057016` |
| `reverse_engineering/derived/i8086/daad-dos-intsm1-official/radare2-analysis.txt` | `1914669` | `2001fc5777770c35a62c7b96dc1b908bf1a68390c9c0b50940ebaf4275956ba6` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intsm2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intsm2-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intsm2-official/INTSM2.EXE` |
| Input SHA-256 | `27531111a82e9f5f62c6eae7efcc03175542a5ffe6f8d85677e88b3d4db16dab` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm2-official/independent-static-disassembly.txt` | `7478196ea3ac7aaf30727bd20757d924cc45946abc53a036d01601a1d3318009` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-headless.log` | `7878e6601dcd14b2379a4bd26a5e6056ba2fe943daa77c5fcb282d759bc5ca7b` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm2-official/radare2-analysis.txt` | `820884d4d1a2a4f4960d1153f9751f0f234337d2ccc947b4dfb8d505231e3653` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-headless.log` | `6650` | `7878e6601dcd14b2379a4bd26a5e6056ba2fe943daa77c5fcb282d759bc5ca7b` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-listing.txt` | `279395` | `bb2a8b2c74e524e04e99374c1adbbaeb3197128dc84f3ac707ec4ebb2331761e` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/ghidra-metadata.json` | `133` | `6262135d0538ee627deef8b96cd75ef43d47984fac5e6a9ac9c9d46eb0b81032` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/independent-static-disassembly.txt` | `273984` | `7478196ea3ac7aaf30727bd20757d924cc45946abc53a036d01601a1d3318009` |
| `reverse_engineering/derived/i8086/daad-dos-intsm2-official/radare2-analysis.txt` | `1914796` | `820884d4d1a2a4f4960d1153f9751f0f234337d2ccc947b4dfb8d505231e3653` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `i8086` — `daad-dos-intsm3-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-dos-intsm3-official` |
| Architecture | `i8086` |
| Immutable input | `reverse_engineering/artifacts/original/dos/daad-dos-intsm3-official/INTSM3.EXE` |
| Input SHA-256 | `54baa0b227cd2c1849c90d6727de130c58cda3a8c0d8c2f8adf50585d3246f01` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm3-official/independent-static-disassembly.txt` | `586a77b8d06d088fc2601bab60b0bb799771348617dff1a5b8493bb492eb5c5f` |
| `ghidra` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-headless.log` | `c30a93c49082f2d9786dbc5b7700a5953c732284b9e798c2516e0bded99f2701` |
| `radare2` | `0` | `reverse_engineering/derived/i8086/daad-dos-intsm3-official/radare2-analysis.txt` | `3e8ecf6d7a61b4e57697b47d8a916c81b85088d3eef6e9109d5406f3edf13653` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-headless.log` | `6650` | `c30a93c49082f2d9786dbc5b7700a5953c732284b9e798c2516e0bded99f2701` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-listing.txt` | `279667` | `517125b2ed805f6e4123f22eed473162547d72a7827df7fa838b6388f73ad5ce` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/ghidra-metadata.json` | `133` | `db1d5e369958b7385fec3e5b73a9e948fba9e756c4fbc741b4269765b71c3745` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/independent-static-disassembly.txt` | `274306` | `586a77b8d06d088fc2601bab60b0bb799771348617dff1a5b8493bb492eb5c5f` |
| `reverse_engineering/derived/i8086/daad-dos-intsm3-official/radare2-analysis.txt` | `1916117` | `3e8ecf6d7a61b4e57697b47d8a916c81b85088d3eef6e9109d5406f3edf13653` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-amiga-edi1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-amiga-edi1-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/amiga/daad-amiga-edi1-official/edi1` |
| Input SHA-256 | `5f3bd8275d500d44fc41d7ae2a77e86593bd7075b6ad9fffde639265c0990952` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi1-official/independent-static-disassembly.txt` | `215328d98a5103306f37811276d8fd5ea231fbc91dbeb6458a0c6c05ffd423ee` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-headless.log` | `f9294e7a1d52185398d4cbfad30a268d976fffe6d2da98aab34697383b4a7beb` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi1-official/radare2-analysis.txt` | `5674e3fc7c8d2b7af7779d08ed6d004b05b5ecdd8c52ed6d21efa65f4df52f66` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-decompilation.c` | `53174` | `dd421354033d6a00b00db982123bf473c53a5c5eb77e120595bb57acd4f61999` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-functions.tsv` | `3769` | `6f6f07485fdf4c64012599f12c02588480132bc431ca0e945b2d99d0d339d73b` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-headless.log` | `7251` | `f9294e7a1d52185398d4cbfad30a268d976fffe6d2da98aab34697383b4a7beb` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-listing.txt` | `252584` | `a70c03356502146ced80d6d64254d59177834329a54f0cc214d307f251e0b61c` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/ghidra-metadata.json` | `125` | `02b3989e4a4b60e750c71a889c85af42cfb8967d3a2a66ca5382ade1e13b0d17` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/independent-static-disassembly.txt` | `192746` | `215328d98a5103306f37811276d8fd5ea231fbc91dbeb6458a0c6c05ffd423ee` |
| `reverse_engineering/derived/m68000/daad-amiga-edi1-official/radare2-analysis.txt` | `1536823` | `5674e3fc7c8d2b7af7779d08ed6d004b05b5ecdd8c52ed6d21efa65f4df52f66` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-amiga-edi2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-amiga-edi2-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/amiga/daad-amiga-edi2-official/edi2` |
| Input SHA-256 | `6926ca43824c00098dcb6267a639aede2ae0640b2640be03fa9a1be965f37664` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi2-official/independent-static-disassembly.txt` | `a3b4111ba0527ff28341b276fbbad30af2c2f0ac099b4421033ac682d535516b` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-headless.log` | `f2f392297ff444dea77155c348f644f20de86d4146f2aab07f6a2b578d1f5959` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-amiga-edi2-official/radare2-analysis.txt` | `7b1acfc1526a53ed579041d5298dd3b871f0850b7e773c375662ddb3f80bdfbc` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-decompilation.c` | `53174` | `1d521c2a1563c0b05b3d3bd72237937cda8fd3ac9092dab5bd4db5e9d34f1389` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-functions.tsv` | `3769` | `6f6f07485fdf4c64012599f12c02588480132bc431ca0e945b2d99d0d339d73b` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-headless.log` | `7251` | `f2f392297ff444dea77155c348f644f20de86d4146f2aab07f6a2b578d1f5959` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-listing.txt` | `252584` | `bd6cd0cef39ebd5ecf1ebb3cb2e3c6a82f9b08838a19a02f1b4a9bc5ae84d645` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/ghidra-metadata.json` | `125` | `21eaee20470a298fb4e426695fb6538dbdccb08daeadb915492138d8c8c5fde7` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/independent-static-disassembly.txt` | `192740` | `a3b4111ba0527ff28341b276fbbad30af2c2f0ac099b4421033ac682d535516b` |
| `reverse_engineering/derived/m68000/daad-amiga-edi2-official/radare2-analysis.txt` | `1536762` | `7b1acfc1526a53ed579041d5298dd3b871f0850b7e773c375662ddb3f80bdfbc` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-amiga-sdi1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-amiga-sdi1-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/amiga/daad-amiga-sdi1-official/sdi1` |
| Input SHA-256 | `105c27fc80bcb9183409d9774792a8486ec34207d9a29e21efc53e475558c7f7` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/independent-static-disassembly.txt` | `63d8894cdd684c2af7ae8bb87936f91ee11526ca8659a9fc997285f20e23063d` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-headless.log` | `3466c11f6248cac573c1ba5f72b831645533e9073c754478268549e701fda6ff` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/radare2-analysis.txt` | `62ed7e91d3a059ac89294874650b8fee83537eeef198f52c085fec70ee51a0b2` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-decompilation.c` | `54110` | `8bba0a7c3365396b7ce3db462e825c682872365e7ce60c4a6a2408d5e4ec50d2` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-functions.tsv` | `3769` | `93a2aa3c1996382cffa989175b25d6cba9096db80bbef5114de573bbba8402b0` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-headless.log` | `7251` | `3466c11f6248cac573c1ba5f72b831645533e9073c754478268549e701fda6ff` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-listing.txt` | `257076` | `9ba958ac328ba807c11ac15710c15b775f7a65c6c55da2cbec1f61aa171719eb` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/ghidra-metadata.json` | `125` | `b899972c528440f3dccd5e31c7d7d560294f45166bf4ddf43ad92f7f12f18e41` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/independent-static-disassembly.txt` | `196291` | `63d8894cdd684c2af7ae8bb87936f91ee11526ca8659a9fc997285f20e23063d` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi1-official/radare2-analysis.txt` | `1569029` | `62ed7e91d3a059ac89294874650b8fee83537eeef198f52c085fec70ee51a0b2` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-amiga-sdi2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-amiga-sdi2-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/amiga/daad-amiga-sdi2-official/sdi2` |
| Input SHA-256 | `e083dcd70726c97204404fa48eea9db49d839a6af4218408c4d40520dd8ec338` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/independent-static-disassembly.txt` | `6b711ae4e23bf184871476db4ba4b4c460a64df42728c4be4d95b9202205efcc` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-headless.log` | `da7b1eb02d3a20ebf61e1336291d20121ab5bdefc79516bac16109c82dd87f7f` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/radare2-analysis.txt` | `c0f397153f3de0ede10a6788dcecb31aedd7e076df868119b75197864fa6fb13` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-decompilation.c` | `54110` | `a0c1cdab4697dcefd4b939307818d818adf29711b7479922f3d6df5e58091983` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-functions.tsv` | `3769` | `93a2aa3c1996382cffa989175b25d6cba9096db80bbef5114de573bbba8402b0` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-headless.log` | `7251` | `da7b1eb02d3a20ebf61e1336291d20121ab5bdefc79516bac16109c82dd87f7f` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-listing.txt` | `257076` | `01a084d4cb6fde515d90460adf59fcde2713b247375bc044721b61defa412741` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/ghidra-metadata.json` | `125` | `a42f1ae4f9fae79299b701d69844e84c1328be96b1fe6dcfcb956c471477612f` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/independent-static-disassembly.txt` | `196285` | `6b711ae4e23bf184871476db4ba4b4c460a64df42728c4be4d95b9202205efcc` |
| `reverse_engineering/derived/m68000/daad-amiga-sdi2-official/radare2-analysis.txt` | `1568968` | `c0f397153f3de0ede10a6788dcecb31aedd7e076df868119b75197864fa6fb13` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-atarist-edi1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-atarist-edi1-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/atarist/daad-atarist-edi1-official/EDI1.PRG` |
| Input SHA-256 | `ecc25e01611b1b3f2546c63b67220011f1793809cb177543030d5b626520c7fd` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi1-official/independent-static-disassembly.txt` | `174929db04006a95e395231d305e4320abfff64b3a6bafabd0b497ddced77cdd` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-headless.log` | `062b539f06dcf7a8be2f189c4e9ea93ea97397d8f93ebee572fde33a1a423b9a` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi1-official/radare2-analysis.txt` | `81d9079a7f35ee9d4b8c7f077cc4259854af28ec00b87ba9be3e95ce49713974` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-decompilation.c` | `19193` | `8656cd1b9992329609b6975a3b5d47f1bac74d66ab1531400a6d46b87881063c` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-functions.tsv` | `1361` | `b636221d2b630fb96673da5292c7ca18555dce01047d2bce5cd6f4c1f54ceb84` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-headless.log` | `7428` | `062b539f06dcf7a8be2f189c4e9ea93ea97397d8f93ebee572fde33a1a423b9a` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-listing.txt` | `339360` | `a878129bfbfe8c36b2dea2cae3ee34f24dbd2efe7c6670705ad8cd076d0ae4f5` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/ghidra-metadata.json` | `129` | `01afc54e87ee45ed7c32103896556133482e9fbd2251c5771e56e6a37beff843` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/independent-static-disassembly.txt` | `226164` | `174929db04006a95e395231d305e4320abfff64b3a6bafabd0b497ddced77cdd` |
| `reverse_engineering/derived/m68000/daad-atarist-edi1-official/radare2-analysis.txt` | `1738878` | `81d9079a7f35ee9d4b8c7f077cc4259854af28ec00b87ba9be3e95ce49713974` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-atarist-edi2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-atarist-edi2-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/atarist/daad-atarist-edi2-official/EDI2.PRG` |
| Input SHA-256 | `6e1c18327066ead24985d6b9033353f16ca7e70e39863af5320d933194b38a72` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi2-official/independent-static-disassembly.txt` | `94f02f8b091cc3ab9e55c91f51123cb414fbdddb859bc97a1a5d24d7b24874f9` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-headless.log` | `efa99d9f78bdafb1d52f91d3505ef0e5d247024027cca559e52cbe475937fec5` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-atarist-edi2-official/radare2-analysis.txt` | `843427b5c3a9f62170dfcf6dd5a3680582af7baf5b6f531741031967f73b9a24` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-decompilation.c` | `19193` | `8656cd1b9992329609b6975a3b5d47f1bac74d66ab1531400a6d46b87881063c` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-functions.tsv` | `1361` | `b636221d2b630fb96673da5292c7ca18555dce01047d2bce5cd6f4c1f54ceb84` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-headless.log` | `7428` | `efa99d9f78bdafb1d52f91d3505ef0e5d247024027cca559e52cbe475937fec5` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-listing.txt` | `339360` | `de3f125a39e8f588fedd9ce571f33ce5df2db5e6d36f1fc1e5c8e7f898db3cf9` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/ghidra-metadata.json` | `129` | `211fffa2346aeca837cb0aa5cc9e18f10800858a6c8a6271061174bc8986f704` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/independent-static-disassembly.txt` | `226162` | `94f02f8b091cc3ab9e55c91f51123cb414fbdddb859bc97a1a5d24d7b24874f9` |
| `reverse_engineering/derived/m68000/daad-atarist-edi2-official/radare2-analysis.txt` | `1738833` | `843427b5c3a9f62170dfcf6dd5a3680582af7baf5b6f531741031967f73b9a24` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-atarist-sdi1-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-atarist-sdi1-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/atarist/daad-atarist-sdi1-official/SDI1.PRG` |
| Input SHA-256 | `35a0c10701e59739e1bf7e701e1e1aa7f5bb5112f79445e8038be0502360a9f2` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/independent-static-disassembly.txt` | `858f8956a83fa67722702681e3afdee147011757b6df9bc1b1180019e8ff25ae` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-headless.log` | `f233e1a8a1b4093143b4900c3f4d0cf29aabfd5f15fc3080617f2ae18f900161` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/radare2-analysis.txt` | `265809bb5db1162a68f1f37c3384a671431468d28a9a1b62e7a0122465e8f159` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-decompilation.c` | `19193` | `5232231f8f692d01a6846555074edc6b65d5bd6f139de9037cb244eba2546c48` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-functions.tsv` | `1361` | `6a9300ea483dbbb3a438a213ac0f8ef668189ceb302bee5ea7fb2bec17c4445c` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-headless.log` | `7428` | `f233e1a8a1b4093143b4900c3f4d0cf29aabfd5f15fc3080617f2ae18f900161` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-listing.txt` | `342256` | `212d3025801be90a95b5abd918f70f818bad8711fd040cfd14c0eb04b5dc7ca8` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/ghidra-metadata.json` | `129` | `c3657f798817d26065b02d2177db6699331b17f1e3ef2b418853ddc886011a37` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/independent-static-disassembly.txt` | `224549` | `858f8956a83fa67722702681e3afdee147011757b6df9bc1b1180019e8ff25ae` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi1-official/radare2-analysis.txt` | `1730371` | `265809bb5db1162a68f1f37c3384a671431468d28a9a1b62e7a0122465e8f159` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `m68000` — `daad-atarist-sdi2-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-atarist-sdi2-official` |
| Architecture | `m68000` |
| Immutable input | `reverse_engineering/artifacts/original/atarist/daad-atarist-sdi2-official/SDI2.PRG` |
| Input SHA-256 | `04ac433d70777dc15434ec5d7c7002f28b30bc8f1f3ed5c0eef01ea6c245a9b1` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/independent-static-disassembly.txt` | `af44f6fb6958b889372db688a68fb319f456cc7f8e85523c58604b1e40b7f2db` |
| `ghidra` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-headless.log` | `824c3c5a8b11637a068fa8093c5dd1341573685581cba3550dcf2193efe36691` |
| `radare2` | `0` | `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/radare2-analysis.txt` | `bddc25f54456ca54f55280281dfc966fac99a5f917799cab89cfc032fa5b355e` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-decompilation.c` | `19193` | `5232231f8f692d01a6846555074edc6b65d5bd6f139de9037cb244eba2546c48` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-functions.tsv` | `1361` | `6a9300ea483dbbb3a438a213ac0f8ef668189ceb302bee5ea7fb2bec17c4445c` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-headless.log` | `7428` | `824c3c5a8b11637a068fa8093c5dd1341573685581cba3550dcf2193efe36691` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-listing.txt` | `342256` | `6aa43bd9148024bf2ebfe8403c8f4e5b7812c908b53fde0d3682ad0577e7324e` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/ghidra-metadata.json` | `129` | `bebbdcf9f3232c1693ae4b6dbc40a1fe0d38c5714b75fc7d56dd215cc8512337` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/independent-static-disassembly.txt` | `224547` | `af44f6fb6958b889372db688a68fb319f456cc7f8e85523c58604b1e40b7f2db` |
| `reverse_engineering/derived/m68000/daad-atarist-sdi2-official/radare2-analysis.txt` | `1730326` | `bddc25f54456ca54f55280281dfc966fac99a5f917799cab89cfc032fa5b355e` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `mos6502` — `daad-c64-edi64-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-c64-edi64-official` |
| Architecture | `mos6502` |
| Immutable input | `reverse_engineering/artifacts/original/c64/daad-c64-edi64-official/edi64.prg` |
| Input SHA-256 | `c462192db2a552f079aa7d521f3ae23a3d5c066120b42108a905085e923932c5` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/mos6502/daad-c64-edi64-official/independent-static-disassembly.txt` | `759b7ac2b43f71d3b0be16c0faf2e3d6b99f1e79f639cfb62efc818c8dff7057` |
| `ghidra` | `0` | `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-headless.log` | `a3d09ec335fdfe87ef67ab91b0be24066c8427a8f6b2e1198c063ca1e8f8240a` |
| `radare2` | `0` | `reverse_engineering/derived/mos6502/daad-c64-edi64-official/radare2-analysis.txt` | `468d7d01d0f2b17c2877c566e88ab283b4ac7f4ec7e46037ee455a0609738ca9` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-headless.log` | `6802` | `a3d09ec335fdfe87ef67ab91b0be24066c8427a8f6b2e1198c063ca1e8f8240a` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-listing.txt` | `157180` | `bff6b4cfd1a0bcf4980b8866079b324e0aeadf51b78cd971612cfaa29c18b68d` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/ghidra-metadata.json` | `122` | `6059955cc4172150bd773baf1da75e735411e261190f381080f394fed22ebf00` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/independent-static-disassembly.txt` | `119065` | `759b7ac2b43f71d3b0be16c0faf2e3d6b99f1e79f639cfb62efc818c8dff7057` |
| `reverse_engineering/derived/mos6502/daad-c64-edi64-official/radare2-analysis.txt` | `1541603` | `468d7d01d0f2b17c2877c566e88ab283b4ac7f4ec7e46037ee455a0609738ca9` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `mos6502` — `daad-c64-sdi64-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-c64-sdi64-official` |
| Architecture | `mos6502` |
| Immutable input | `reverse_engineering/artifacts/original/c64/daad-c64-sdi64-official/sdi64.prg` |
| Input SHA-256 | `767aa97d411ea025d20e25282ae0ac90360b4fb99af01392c38d2721aa7033ec` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/independent-static-disassembly.txt` | `02d6beaed9ba4e74252349fd9ac2420c23d5d2df0b1f7d2a7031510e5ece475a` |
| `ghidra` | `0` | `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-headless.log` | `5f2caca4d354b1660c093968b952228130cfaad14da48732c9535880d62da932` |
| `radare2` | `0` | `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/radare2-analysis.txt` | `741d49d1ec2a9857c766daf23c6ade4281399858a9f213de04db9d90ff07c2f1` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-headless.log` | `6802` | `5f2caca4d354b1660c093968b952228130cfaad14da48732c9535880d62da932` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-listing.txt` | `160585` | `96ace73c02cc8a64c926ef531e4b57611a9159da281e52e41c3158f026dca619` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/ghidra-metadata.json` | `122` | `c7e23c95e557b02759ac586f92cf57f4983949724bc2807b8a5753f9a75d8f9b` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/independent-static-disassembly.txt` | `121667` | `02d6beaed9ba4e74252349fd9ac2420c23d5d2df0b1f7d2a7031510e5ece475a` |
| `reverse_engineering/derived/mos6502/daad-c64-sdi64-official/radare2-analysis.txt` | `1566087` | `741d49d1ec2a9857c766daf23c6ade4281399858a9f213de04db9d90ff07c2f1` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `mos8501` — `daad-plus4-ediplus4-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-plus4-ediplus4-official` |
| Architecture | `mos8501` |
| Immutable input | `reverse_engineering/artifacts/original/plus4/daad-plus4-ediplus4-official/ediplus4.prg` |
| Input SHA-256 | `9df2d6b35d5e138c80e3a38674afd565fe9564f27205d79d24d654d407949523` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/independent-static-disassembly.txt` | `868e34587a88cb1ea98bd75bbce02edb4bca15920c291599de65ebb0405db37b` |
| `ghidra` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-headless.log` | `110466cf975af122b738818e2d450e8f04ea71b5c2207e9e85a6d21d0acd7dc3` |
| `radare2` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/radare2-analysis.txt` | `cc5b30698cfadbfba57e53a0ab91d9ff2adca65332e0363fe62cee537605d2c0` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-headless.log` | `6881` | `110466cf975af122b738818e2d450e8f04ea71b5c2207e9e85a6d21d0acd7dc3` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-listing.txt` | `164094` | `f308366ea388dc1420f702e33367239915e2c0ee065db5b57c7bffcf3ce3f2c6` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/ghidra-metadata.json` | `125` | `b25dc5aaba354ef6679573c3ee46517a6d633d3bcd49d3a44a440ccee16d6109` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/independent-static-disassembly.txt` | `123933` | `868e34587a88cb1ea98bd75bbce02edb4bca15920c291599de65ebb0405db37b` |
| `reverse_engineering/derived/mos8501/daad-plus4-ediplus4-official/radare2-analysis.txt` | `1458740` | `cc5b30698cfadbfba57e53a0ab91d9ff2adca65332e0363fe62cee537605d2c0` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `mos8501` — `daad-plus4-sdiplus4-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-plus4-sdiplus4-official` |
| Architecture | `mos8501` |
| Immutable input | `reverse_engineering/artifacts/original/plus4/daad-plus4-sdiplus4-official/sdiplus4.prg` |
| Input SHA-256 | `f29050dfe9331634b985a8c5b8cb4ee3b164a4340e355c044284168b8610258c` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/independent-static-disassembly.txt` | `eed9cf713ec73f2e16ef15fae97997b87c2119f6fd5fec4aa1258e1c922aa6c8` |
| `ghidra` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-headless.log` | `d7f6b38651f4ced347b848e48efa2e1bcd0a9b966ddd60a706bf7d96a4cce63d` |
| `radare2` | `0` | `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/radare2-analysis.txt` | `a63d1810d95d3832c0826993207222836127dff38082e7d4e5309f2702b6e8d5` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-decompilation.c` | `0` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-functions.tsv` | `45` | `05249c234c32e967211074e14cc4f11c3ef443c5177d1570a715abe3867ee941` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-headless.log` | `6881` | `d7f6b38651f4ced347b848e48efa2e1bcd0a9b966ddd60a706bf7d96a4cce63d` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-listing.txt` | `167574` | `360b12c6a7b02d3096fe4b43fc8018b12c48b5992101d2c37fe7e428f80907a3` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/ghidra-metadata.json` | `125` | `8e34b9841820ba2e23421c9323ca96a45fc6b6a1f7cc21291d44038b2906f02a` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/independent-static-disassembly.txt` | `126490` | `eed9cf713ec73f2e16ef15fae97997b87c2119f6fd5fec4aa1258e1c922aa6c8` |
| `reverse_engineering/derived/mos8501/daad-plus4-sdiplus4-official/radare2-analysis.txt` | `1491161` | `a63d1810d95d3832c0826993207222836127dff38082e7d4e5309f2702b6e8d5` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-cpc-dcpcie-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-cpc-dcpcie-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/cpc/daad-cpc-dcpcie-official/DCPCIE.Z80` |
| Input SHA-256 | `7447b56073a6e65242214c505496742346a35de0e81777ed91ea44a2f115ee41` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/independent-static-disassembly.txt` | `1c23d35ffa1a7344e283cbb63f04c924b59b794710d95bd5a9d8ded4f36f6429` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-headless.log` | `1c655d56df11cf4650e68f0c0b578f46386cc66fdb42aa6648dc4096af91ee46` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/radare2-analysis.txt` | `536dbc0d13114be1e84f750913f12addeae01e56ca0286083f4f60bef16a06d4` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-decompilation.c` | `2414` | `9768578dee3769ae8a153e1eefc60e7d91ae2ef164416d49f81d5a1b7ead1b73` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-functions.tsv` | `480` | `634377dfd258956ddbd51b69d2a23e290e459d21ec7ffa3fd3e1e2b163df3c6d` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-headless.log` | `8252` | `1c655d56df11cf4650e68f0c0b578f46386cc66fdb42aa6648dc4096af91ee46` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-listing.txt` | `131802` | `79c6c021943d4c5cc199b27430740dfe500bdc04f7754950d797665584cf0c23` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/ghidra-metadata.json` | `131` | `79c946d4eff279f1b6931c4efc0bc5ffe1aebcfdb236bb67e3dd7f0f3b2656c8` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/independent-static-disassembly.txt` | `73235` | `1c23d35ffa1a7344e283cbb63f04c924b59b794710d95bd5a9d8ded4f36f6429` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcie-official/radare2-analysis.txt` | `1145747` | `536dbc0d13114be1e84f750913f12addeae01e56ca0286083f4f60bef16a06d4` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-cpc-dcpcis-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-cpc-dcpcis-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/cpc/daad-cpc-dcpcis-official/DCPCIS.Z80` |
| Input SHA-256 | `8d312860b4ce8596b9f6152c1fbc0aa5f3525189daa564dc413bf3173a19659c` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/independent-static-disassembly.txt` | `1327af04919fc33dbeeb8bd8a92f0e4bdbb8936efdef5e06f2728427635095ac` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-headless.log` | `55a0cee5cdb810d1de6d1e302d4ea9c09e185b5578e6201c07e0089e67caa322` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/radare2-analysis.txt` | `daecda4066626a7495c574cb3c7e2ad687128737178abcaa7468d08cb184d8ef` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-decompilation.c` | `2916` | `716fa980eaa0a75b32f17f0abc761877a79dd6f0c5f4090bcecc5ebe17d6c80b` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-functions.tsv` | `480` | `634377dfd258956ddbd51b69d2a23e290e459d21ec7ffa3fd3e1e2b163df3c6d` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-headless.log` | `8252` | `55a0cee5cdb810d1de6d1e302d4ea9c09e185b5578e6201c07e0089e67caa322` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-listing.txt` | `134852` | `862f6be44f98d6f8086293cec8418b4417e3e3ff5ad5f410624e410d68c8c2c6` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/ghidra-metadata.json` | `131` | `1236d983e010e88b253f2226961f017df5bdbd477c0ea4b24de0c026c5d6f077` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/independent-static-disassembly.txt` | `74280` | `1327af04919fc33dbeeb8bd8a92f0e4bdbb8936efdef5e06f2728427635095ac` |
| `reverse_engineering/derived/z80/daad-cpc-dcpcis-official/radare2-analysis.txt` | `1163568` | `daecda4066626a7495c574cb3c7e2ad687128737178abcaa7468d08cb184d8ef` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-msx-msxedi-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-msx-msxedi-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/msx/daad-msx-msxedi-official/MSXEDI.Z80` |
| Input SHA-256 | `1df91cff49dc2dcb42f2e4321644b6e088a0ac63159444bb937a9bff5848a4ca` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-msx-msxedi-official/independent-static-disassembly.txt` | `84b48687579df6bbffb389e5856bb48f34ea7cf5bb14701a1b3f352bb01ab00d` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-headless.log` | `50a6a03895f132543bc035dfa9ae1137151e19f9f096503b74ed9761596f8673` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-msx-msxedi-official/radare2-analysis.txt` | `78b4556d089d5856128bf1e2c84cbde4c91aaac05823bd4d93bb5433e34d96a5` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-decompilation.c` | `4417` | `bc482fca1aec80746696ccf3228b6503348136ed12486a7da6d5a55319dc7d26` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-functions.tsv` | `480` | `d7cec515ec9b41f3538dfbdb155c888ce0f4c1364d9ae2c22263f44f8d9f7d03` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-headless.log` | `8252` | `50a6a03895f132543bc035dfa9ae1137151e19f9f096503b74ed9761596f8673` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-listing.txt` | `144232` | `53e56e7e43e83e2418fa2298a1d67b0734b05f980fbb00df112e04091c4c5d2c` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/ghidra-metadata.json` | `131` | `fd88473e1caec66e1e9cc74b7053dadce221947404d27dd495d10f5b9040b7dd` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/independent-static-disassembly.txt` | `80460` | `84b48687579df6bbffb389e5856bb48f34ea7cf5bb14701a1b3f352bb01ab00d` |
| `reverse_engineering/derived/z80/daad-msx-msxedi-official/radare2-analysis.txt` | `1189300` | `78b4556d089d5856128bf1e2c84cbde4c91aaac05823bd4d93bb5433e34d96a5` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-msx-msxsdi-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-msx-msxsdi-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/msx/daad-msx-msxsdi-official/MSXSDI.Z80` |
| Input SHA-256 | `fcae12bd09bc949e1e6cf75b3d1ef87e66c322efe2de005e771fa3b5dd8ddbf8` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-msx-msxsdi-official/independent-static-disassembly.txt` | `face6fb2ba8e429bb81224f76a72e46bd1d3bd28e71f17ee8009aff22326bc2c` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-headless.log` | `a70be2317403cc46f1f3c3f8de46a0b3b02e24a50720d69f20f324e9eafe2451` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-msx-msxsdi-official/radare2-analysis.txt` | `638f9ff7cbf853e1b527b9a471d91750ce51f9e25dd21e3f5797e5cfdf32e069` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-decompilation.c` | `4461` | `d5c3d52434a3814e7598f853505ed96842ae40243e5770f79ad9d38b2df1b850` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-functions.tsv` | `480` | `d7cec515ec9b41f3538dfbdb155c888ce0f4c1364d9ae2c22263f44f8d9f7d03` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-headless.log` | `8252` | `a70be2317403cc46f1f3c3f8de46a0b3b02e24a50720d69f20f324e9eafe2451` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-listing.txt` | `148005` | `40077a5f8fdf0011544bb1dd9316d619ebc1f0036e8415d9cd7bdc97eafca9bd` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/ghidra-metadata.json` | `131` | `31c03d4961846d183838ad57d595fb0e9a908739c53af3729901f3643a5259c8` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/independent-static-disassembly.txt` | `81953` | `face6fb2ba8e429bb81224f76a72e46bd1d3bd28e71f17ee8009aff22326bc2c` |
| `reverse_engineering/derived/z80/daad-msx-msxsdi-official/radare2-analysis.txt` | `1216291` | `638f9ff7cbf853e1b527b9a471d91750ce51f9e25dd21e3f5797e5cfdf32e069` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-pcw-pcwedi-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-pcw-pcwedi-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/pcw/daad-pcw-pcwedi-official/PCWEDI.BIN` |
| Input SHA-256 | `358eb0d236db0a2b43fdc66f843eb8e2eed097f77db24e195c14bae5fbb309a2` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/independent-static-disassembly.txt` | `9c28452ec363a10a2ec0ba7ff561519acdfb0c4dbbcd378d6493e0df89b338ee` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-headless.log` | `b884fb9276573f454e95910d52c08ccf013bf72121c2526c877cc61a5388df9c` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/radare2-analysis.txt` | `63373866fde857fa5307d0d2657e68a40df5ee19f8374bcbb7ac723d2c3806d8` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-decompilation.c` | `19220` | `a475dbd0ec3e45e9787b3c89ee066f253db8ecd7e7bce07194e36502fa10cdef` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-functions.tsv` | `476` | `dd069f00b24d5796bd9d40b4df322c7f452e6daddacd85cb14307663563237fe` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-headless.log` | `8253` | `b884fb9276573f454e95910d52c08ccf013bf72121c2526c877cc61a5388df9c` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-listing.txt` | `148642` | `d867f0994ac27d5811ef407f5541d9a1f2b6042b04486eeea150bb6d1b8b66ba` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/ghidra-metadata.json` | `131` | `e6ebedffca0cb33fcf03d988ea88dc374b698dd19a2e41417cc1f4d26af0d919` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/independent-static-disassembly.txt` | `83642` | `9c28452ec363a10a2ec0ba7ff561519acdfb0c4dbbcd378d6493e0df89b338ee` |
| `reverse_engineering/derived/z80/daad-pcw-pcwedi-official/radare2-analysis.txt` | `1222862` | `63373866fde857fa5307d0d2657e68a40df5ee19f8374bcbb7ac723d2c3806d8` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-pcw-pcwsdi-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-pcw-pcwsdi-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/pcw/daad-pcw-pcwsdi-official/PCWSDI.BIN` |
| Input SHA-256 | `e52e2a8cc9e720805c7c6c7f8fe9fd706933c73696e695d7c1132063d4e52a7d` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/independent-static-disassembly.txt` | `e5a4f43324726870721f8c8c47f3b09360f0b8bcabe371eb14f93c40f7c1eb35` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-headless.log` | `77a8faaef6c929f470367e51278c80920c5044b5191bc55102a6bfef54d17d02` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/radare2-analysis.txt` | `64a6b24816825a4e16ac840cc9d450dcbcfa738941609b031750e43e2536a614` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-decompilation.c` | `16421` | `43232b106d044dc9f1749d7822704fe15ede5e34229582acc767388bcec37114` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-functions.tsv` | `497` | `709fb4d2c50b531a7d743c4f9f8f421ef7beb947721c46552a2fda56986327bb` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-headless.log` | `8544` | `77a8faaef6c929f470367e51278c80920c5044b5191bc55102a6bfef54d17d02` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-listing.txt` | `153004` | `65c18b4bb01d0751185ce0156910e46b336db98db5b76f31bcda2ca51b3697c5` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/ghidra-metadata.json` | `131` | `ccfa747cd0fb8416fee9e61ef483152e30d279e41add0d29612fd78c567a2b3d` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/independent-static-disassembly.txt` | `85821` | `e5a4f43324726870721f8c8c47f3b09360f0b8bcabe371eb14f93c40f7c1eb35` |
| `reverse_engineering/derived/z80/daad-pcw-pcwsdi-official/radare2-analysis.txt` | `1254595` | `64a6b24816825a4e16ac840cc9d450dcbcfa738941609b031750e43e2536a614` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-zx-ds48ie-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-zx-ds48ie-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/zx/daad-zx-ds48ie-official/DS48IE.P3F` |
| Input SHA-256 | `d599b14576cb46f72b34b106f6ad1079cdf0d346ed9ac44e89db7dbd0c0eb3d6` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48ie-official/independent-static-disassembly.txt` | `281ffca42d2a7e57ec3a85e417ad76d40f6861deebaa7b658185e05d3814717b` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-headless.log` | `f75e247d1f8209b50a4d710768658b03ee2044717e32a9bc592971962e695a0e` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48ie-official/radare2-analysis.txt` | `3d251abcc91fb41d953447006997fc6e033778eb020e5a106fc65233a7dabd37` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-decompilation.c` | `2085` | `63fecbd453db67414505ce0f802094d64c0a3e93f36121523e2d502dd730649b` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-functions.tsv` | `480` | `b147e6484fd2b8ed0a5c4d2a763f5069a951f430a04de6fd47a3c982c1838674` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-headless.log` | `8238` | `f75e247d1f8209b50a4d710768658b03ee2044717e32a9bc592971962e695a0e` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-listing.txt` | `147447` | `ec529234fbbca8e365c1606f1defc65738acd466981fb4584bf19f6882155595` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/ghidra-metadata.json` | `131` | `2484c1d548aba24aeb30ad98767025dca20a4d3d51a2623dc30d5ab9afcfc317` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/independent-static-disassembly.txt` | `79973` | `281ffca42d2a7e57ec3a85e417ad76d40f6861deebaa7b658185e05d3814717b` |
| `reverse_engineering/derived/z80/daad-zx-ds48ie-official/radare2-analysis.txt` | `1173653` | `3d251abcc91fb41d953447006997fc6e033778eb020e5a106fc65233a7dabd37` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

## `z80` — `daad-zx-ds48is-official`

| Field | Retained value |
| --- | --- |
| Artifact ID | `daad-zx-ds48is-official` |
| Architecture | `z80` |
| Immutable input | `reverse_engineering/artifacts/original/zx/daad-zx-ds48is-official/DS48IS.P3F` |
| Input SHA-256 | `e1e0f8ab8e2907eebeb24ada1bf2bb2d27b0622972239827eeb70f56ff5e0566` |
| Analysis state | `generated_unverified_load_model` |
| Load model | `raw_binary_base_0_unverified` |

### Retained tool records

| Tool | Return code | Captured output | SHA-256 |
| --- | ---: | --- | --- |
| `architecture_static` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48is-official/independent-static-disassembly.txt` | `7920bb147e3efd70a7c29ae96003f62d18b07945b055905d032cdba80d0731f9` |
| `ghidra` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-headless.log` | `50ea48fe97640f62972779ef7f6123d4f3171e8fbbe5d7343517640d5009041b` |
| `radare2` | `0` | `reverse_engineering/derived/z80/daad-zx-ds48is-official/radare2-analysis.txt` | `5076b2da0609b8c7c76135e881c10dfeb744c752afa9e2147795093d08adfb10` |

### Derived output inventory

| Output | Bytes | SHA-256 |
| --- | ---: | --- |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-decompilation.c` | `1900` | `7862ad4c5b9186b83aea349f737b81a5323043c46744085e4bc71991cd64c8b2` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-functions.tsv` | `480` | `b147e6484fd2b8ed0a5c4d2a763f5069a951f430a04de6fd47a3c982c1838674` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-headless.log` | `6925` | `50ea48fe97640f62972779ef7f6123d4f3171e8fbbe5d7343517640d5009041b` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-listing.txt` | `165230` | `790208585884412a40e0192353c7b19d577cf8d1915cfedf9d004a22dd325fef` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/ghidra-metadata.json` | `131` | `d459c4e08742e5427c937055c8633daf994b3827212123fe9cd228fad72d6d2b` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/independent-static-disassembly.txt` | `89695` | `7920bb147e3efd70a7c29ae96003f62d18b07945b055905d032cdba80d0731f9` |
| `reverse_engineering/derived/z80/daad-zx-ds48is-official/radare2-analysis.txt` | `1310712` | `5076b2da0609b8c7c76135e881c10dfeb744c752afa9e2147795093d08adfb10` |

### Review placeholders

**Decoded-instruction review:** Pending. Cite exact byte ranges, adapter identity, CPU/endian assumptions, and the stated `raw_binary_base_0_unverified` model before adding a claim.

**Tool-hypothesis review:** Pending. Keep every inferred control-flow, data classification, symbol, function, or pseudocode statement attributed to its recorded tool output.

**Independently evidenced behavior:** Pending. Do not promote behavior from the retained static outputs alone.

**Record non-claim:** Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.

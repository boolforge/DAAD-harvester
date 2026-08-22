# Amstrad CPC Entry-Environment Sources

| Source | Bounded use |
| --- | --- |
| [Amstrad CPC Firmware Manual: Memory Usage](https://www.cantrell.org.uk/david/tech/cpc/cpc-firmware/mem-use.htm) | AMSDOS binary headers contain execution-address data and CPC firmware reserves documented memory regions. |
| [CPC Rulez: ROMs, RAM, and Restart Instructions](https://cpcrulez.fr/codingBOOK_soft968-CPC464-664-6128_firmware_002.htm) | Bank-switched RAM changes visibility and ROM overlays remain relevant to address interpretation. |
| [ChibiAkumas: Amstrad CPC Memory Map](https://www.chibiakumas.com/z80/AmstradCPC.php?noui=1) | CPC ROM overlays affect the `0x0000`–`0x3fff` and `0xc000`–`0xffff` regions; a binary header alone does not identify active overlays. |
| [CPCWiki: AMSDOS Header](https://cpctech.cpcwiki.de/docs/allhead.html) | AMSDOS header fields are loader metadata and not a complete runtime-state record. |

The retained CPC headers establish their load and declared entry fields. These
sources show that a qualified entry configuration additionally needs explicit
RAM/ROM/bank and firmware context. They do not provide an official launch
capture for the retained DCPCIE/DCPCIS profiles.

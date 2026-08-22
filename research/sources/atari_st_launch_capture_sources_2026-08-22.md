# Atari ST Future Launch-Capture Source Record

## Purpose

This record supports only a future official Atari ST PRG launch-capture schema.
It is not a DAAD runtime observation, effective-entry claim, qualified analysis,
or recovered-source claim.

## Documented state categories

GEMDOS documentation describes Pexec-launched processes as having a basepage,
TPA bounds, text/data/BSS addresses, parent and environment pointers, command
line, stack relation, and inherited handles. It further documents launch at the
text base with the basepage address on the stack.[1] GEMDOS/TOS environment,
drive/path, file, memory, and process state are separately documented layers.[1]
[2]

A future official capture must bind exact PRG and loader context; TOS and GEMDOS
identities; Pexec/relocation transition; bootstrap medium; snapshot and machine
configuration; basepage and TPA mapping; text/data/BSS allocation; process,
environment, command-line, and handle state; 68000 registers and stack; and
GEM/AES context. Retained PRG structural records do not provide those facts.

## Non-substitution boundary

An Amiga segment list, generic 68000 state, different Atari ST title, or static
PRG relocation listing cannot satisfy this profile-specific future schema.

## References

[1]: http://peek.poke.free.fr/st/dossiers/dev/devdoc/gemdos.html "Atari GEMDOS reference manual"
[2]: http://cd.textfiles.com/ataricompendium/BOOK/HTML/CHAP2.HTM "GEMDOS overview"

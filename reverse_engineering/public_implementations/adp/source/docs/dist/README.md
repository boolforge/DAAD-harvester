# ADP — ADventure Player

<p align="center">
    <img src="../Logo.png" width="415" alt="ADP — ADventure Player" />
</p>
<p align="center">
    <a href="https://www.adventure-player.com">adventure-player.com</a>
</p>

A [Spanish version](LEEME.txt) of this document is also available.
See [What's new in 0.3](WHATSNEW.txt) for the release summary.

**DAAD** was an authoring tool designed for writing text adventure
games targeting a number of early-1990s home computers. It was
developed by Tim Gilberts for the Spanish company **Aventuras AD**.

**ADP** is a portable interpreter written in minimal C++. It can run
adventures made with **DAAD** on modern platforms, with special
care to support all the features present in games by **Aventuras AD**,
including palette manipulation, double buffering, and digital sound.
It currently runs both 16-bit versions of the adventures (Amiga,
Atari ST, and PC) and 8-bit versions (Spectrum, CPC, MSX, C64, and PCW).

Support for the 8-bit versions is experimental, but covers databases,
snapshots, disk and tape images, and vector graphics on the supported systems.
Experimental support is also available for 48K and 128K PAWS adventures.
PAWS is an earlier ZX Spectrum authoring tool by Tim Gilberts and Graeme
Yeandle.

In addition to modern platforms, the ADP interpreter has been
ported natively to Amiga, Atari ST, and MS-DOS, so it can be
used as a direct replacement for the original interpreters.
There is also Emscripten support to embed games in a web page.

ADP currently supports DAAD V3 extensions developed by Carlos
Sánchez (Uto) and available through his DAAD Ready distribution.

## Disclaimer

This is early software in a **beta** stage. While the program seems to
be reasonably feature-complete, bugs are expected and some games
may still not work properly. Bug reports are welcome!

## How to use ADP

**ADP** releases include a game player called `PLAYER` and a command-line
utility called `DDB`.

- `DDB` is used to execute, inspect, and perform operations on
  game databases (.DDB).

- `CHR` allows converting character sets to images
  (and converting them back after editing).

- `ADPC` allows compiling .SCE source code from versions 1
  and 2 of DAAD, with a high degree of compatibility with the
  original compiler.

- `DSK` allows creating, inspecting, and modifying disk image
  files in the different formats used by DAAD.

- `DMG` is used to create, inspect, and modify graphics
  database files (.DAT) from the 16-bit versions,
  including the new DAT5 format specific to ADP.

Retro ports include only `PLAYER`.

The `DDB` command-line utility takes the name of a `.DDB` file as an
argument. This file is a game database built by a **DAAD** compiler for an
Amiga, Atari ST, or IBM PC target. The interpreter also supports the
following files when they are in the same folder and have the same base name
as the DDB file:

| Extension | Contents |
| --- | --- |
| `.DDB` | Adventure game database |
| `.DAT` | Graphics database (also `.EGA` or `.CGA`) |
| `.CHR` | Character set (also `.CH0` for Atari ST) |
| `.FNT` | Proportional fonts (used instead of `.CHR` when present) |
| `.SCR` | Loading or splash screen (also `.EGS`, `.CGS`, or `.VGS`) |

`PLAYER` runs any DDB file it finds in its own folder. If multiple DDB files
are present, it asks the user to select a part number.

For a game that includes EGA and CGA versions, select one by running
`PLAYER EGA` or `PLAYER CGA`.

## Notes for specific versions

### Windows and macOS

You may get a false-positive warning from Windows Defender or another
antivirus program. These programs may flag unfamiliar executables; the warning
usually disappears after the executable is added to their databases.

### MS-DOS

ADP provides separate 16-bit and 32-bit DOS players. The 16-bit player runs on
older PCs; the 32-bit player requires a 386 or better and at least 2 MB of RAM.
Both support native CGA, EGA, and VGA modes. The 32-bit player also supports
SVGA 640x400 games.

`SETUP.EXE` selects the graphics mode, detects or configures a Sound Blaster,
and writes `ADPSETUP.CFG` in the game directory. The same setup program works
with both DOS players. It is required when a game provides multiple graphics
modes and no mode is selected on the command line. For single-mode games it is
optional, but remains the easiest way to configure sound.

For games with multiple graphics versions, run `PLAYER CGA` or `PLAYER EGA`
to select the native CGA or EGA version.

A Sound Blaster card is supported and, if present, is used to play digital
samples in games that feature them.

### Amiga / Atari ST

Both versions run on base computers with 512 KB of RAM,
but any extra RAM found will be used as a cache to speed
up the loading of images from disk.

On Amiga, 256-color games require an AGA machine and
refuse to run under OCS/ECS.

## Compatibility

Unlike the desktop and web versions, the Amiga and Atari ST versions
are designed to play adventures made for their respective
computer (so, for example, you can't play CGA/EGA games
on Atari ST or Amiga). This behavior changed in version 0.3 to reduce the
executable size and leave more free disk space; cross-platform game support
was also impractical because of poor performance.

**ADP** supports versions 1, 2, and 3 of **DAAD**. Version 1 support was
reconstructed from existing games and may still have compatibility gaps.
`ADPC` can compile preserved DAAD V1 and V2 sources.

The desktop and web versions support disk image files (`.ADF`, `.DSK`) and
try to find the database and support files inside them. This
support is experimental and expects well-formed images without
copy protection or other shenanigans.

PAWS support is also experimental. Most common Spectrum databases work, but
some parser and condact details still differ from the original interpreter.
PC PAW `.PDB` databases are not supported.

## Changes and new features

**ADP** does not extend the original **DAAD** with any additional
libraries, condacts or capabilities. However, a few features that
were not present in the original interpreters have
been implemented for convenience:

### Command-line editor

The editor now has a history of commands. You can press the up/down
cursor keys to navigate previously entered commands.

You can search the history using F8. For example, typing `do` and pressing F8
completes the line with the most recent command that began with `do`.
Pressing F8 again searches for the next entry.

The editor also supports undo and redo. Press Ctrl+Z and Ctrl+Y to undo and
redo the last change, respectively.

The editor supports Ctrl+Left and Ctrl+Right to move the cursor
word by word, Ctrl+Backspace/Delete to delete entire words,
and the ESC key to clear the entire line.

### Keypress sound

Desktop/web versions support keypress 'click' sounds. Press
F10 to toggle the key sound sample or turn it off.

That support has been removed from Atari ST/Amiga players
to reduce the size of the executable (and be less annoying).

### SAVE/LOAD

On platforms that support it, SAVE and LOAD offer a
standard system save/load file dialog.

### WHATO

When WHATO does not produce a suitable object, but there is
an adjective in the user-provided phrase (but no noun and
no unknown words), WHATO will try to resolve the phrase
by identifying the required object using only the adjective.
This experimental change makes *Templos Sagrados*
more playable, and it may disappear in a future release.

### PICTURE

The original PICTURE command loads from disk (or cache) and
decompresses an image to an internal buffer. Afterwards,
DISPLAY copies the buffer to the screen at high
speed. This scheme provides a way for games to make simple
animations by displaying the same image in multiple positions
and clipping windows.

**ADP** supports multiple pictures in the internal buffer,
so you can potentially produce animations with multiple
pictures. PICTURE returns immediately if the requested
picture is already in RAM. The size of the internal buffer
varies, but it is guaranteed to be big enough for a full
screen of pictures.

### Forced delays

**ADP** introduces artificial delays and pauses in some
cases to reproduce animations from the original
Aventuras AD games, which expect a slow computer and do not
have PAUSE commands to delay every animation frame.

In essence, drawing a picture that overwrites a screen
area that has already been modified this frame, changing
a palette color that has already been changed, or invoking
a buffer change, will introduce a small delay.

In addition, text windows will scroll with a delay after
the `[More...]` prompt. This change is experimental and
improves readability in cases such as *Cozumel*'s
intro text, where an instant scroll provides no clue
about where the user should continue reading.

## How to build ADP from the source code

Because of the unusual platforms it supports, **ADP** currently relies on
simple GNU Makefiles. You may need to install some dependencies manually.

Compilation also produces several experimental command-line tools. Tool
packages may include:

- **ADPC:** A compiler for preserved DAAD V1/V2 sources and PAWS source files.

- **DMG:** A tool to inspect, extract, create, and modify graphics database
  files, including support for ADP's new DAT 5 format. Adventure authors can
  use it to take advantage of ADP's 32- and 256-color support.

- **CHR:** A tool to convert character-set and font files to and from editable
  PNGs. You can use it to customize a game's font. It supports the new
  proportional SINTAC format from PC DAAD.

- **DSK:** A tool to create, modify, and inspect files in disk images for the
  supported computers (MS-DOS and Atari ST FAT disks, Amiga ADF files, and
  PCM disk images for PCW and other 8-bit computers).

### Windows

This build requires Visual Studio 2022 or later. Open an x64 native
command prompt (using the start menu icon or calling vcvars64.bat)
and run the following command:

```
C> build Windows Release
```

For convenience, this repository includes x64 LIB files for libpng,
zlib, and SDL. A static version of the SDL library is linked, in
order to create a portable EXE file with no dependencies.

### Unix-like versions (Linux and macOS)

This version requires a recent version of SDL2 and libpng, with
working `libpng-config` and `sdl2-config` command-line tools, alongside
a C++ compiler of your choice, and GNU Make.

For macOS, we recommend installing the required dependencies using
Homebrew, alongside the Xcode command-line tools.

Once the requirements are met, build using `Makefile-linux` or `Makefile-osx`,
depending on your platform:

```
$ make -f Makefile-linux
```

### Emscripten (web port)

This version requires a recent version of Emscripten with support for
SDL2 programs (this should be installed automatically during the
compilation process, but if you are using your Linux distribution's
provided emscripten, your mileage may vary).

Currently, the compiled web port embeds the game files, which means
you must make a separate build for each game you want to port to the web.
To create web players, add a folder for each game to the `web-games` directory
and put all of the game's files (`.DDB`, `.DAT`, `.CHR`) inside. The Makefile
produces a web page for every game in the `out/web` directory.

This port currently uses [KioskBoard](https://github.com/furcan/KioskBoard)
for virtual keyboard support on mobile.

```
$ emmake gnumake -f Makefile-web
```

On Windows, make sure `EMSDK_ENV.bat` is in your path and run:

```
C> build Web
```

### MS-DOS

This version requires a recent version of
[Open Watcom 2](https://github.com/open-watcom/open-watcom-v2#open-watcom-v2-fork),
a fork of the legendary Watcom C/C++ compiler with support for a
more modern C++ language and standard libraries (and many fixes).

Run `OWSETENV.bat` (or `setenv.sh`, depending on your platform) and build with:

```
C> wmake -h -f Makefile-dos MODE=32
C> wmake -h -f Makefile-dos MODE=16
```

The 32-bit build produces `ADP32.EXE`. The 16-bit build produces `ADP16.EXE`
and the shared `SETUP.EXE` configuration utility.

On Windows, if `OWSETENV.bat` is in your path, you can also run:

```
C> build DOS
```

### Amiga

This version currently uses the [Visual Studio Code toolchain](https://github.com/BartmanAbyss/vscode-amiga-debug)
by Bartman^Abyss. Open a command-line environment and add the extension's
platform folder and its `opt/bin` subfolder to your `PATH`.

```
# macOS
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/darwin;$PATH
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/darwin/opt/bin;%PATH%
$ make -f Makefile-amiga
```

```
# Linux
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/linux;$PATH
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/linux/opt/bin;%PATH%
$ make -f Makefile-amiga
```

```
# Windows
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/win32;$PATH
$ PATH=~/.vscode/extensions/bartmanabyss.amiga-debug-1.7.2/bin/win32/opt/bin;%PATH%
$ gnumake -f Makefile-amiga
```

On Windows, you can also run `build Amiga`.

### Atari ST

This version uses the [m68k-atari-mint cross-compilation tools](https://tho-otto.de/crossmint.php)
provided by Thorsten Otto.

You'll need to install at least the following packages:

* binutils
* fdlibm
* GCC (a modern version, such as 13 or later)
* gemlib
* mintlib

A script is provided for Linux to download the requirements for you,
but we still recommend installing them yourself.

You'll also need a working [VASM assembler](http://sun.hasenbraten.de/vasm/)
and libcmini 0.54. The included Makefile assumes `LIBCMINI` is installed in
`$HOME/libcmini`, but you can set the `LIBCMINI` environment variable to the
correct path if necessary. Note that ADP is C++ code, and libcmini
may expect their headers to be included into pure C code only, so if you
find linker errors you can either recompile libcmini to have the proper
symbols or add a few `extern "C" {}` declarations to its headers. The VASM
executable must be named `vasmm68k_mot` and available in your `PATH`.

Once all requirements are met, compile with

```
$ make -f Makefile-atarist
```


## License

**ADP** is released under the terms of the MIT License.
See the [LICENSE](../LICENSE) file for details.

# ADP — ADventure Player

ADP is a portable interpreter and toolchain for text adventures created with
[DAAD](https://en.wikipedia.org/wiki/Professional_Adventure_Writer#DAAD), the
system used by Aventuras AD. It supports games made for 16-bit computers and
provides experimental support for 8-bit DAAD and PAWS games.

ADP runs on Linux, macOS, Windows, and the web, as well as natively on MS-DOS,
Amiga, and Atari ST.

For usage instructions, supported game files, compatibility notes, and
platform-specific build directions, see the [full documentation](docs/dist/README.md).
A [Spanish version](docs/dist/LEEME.txt) is also available.

See [What's new in 0.3](docs/dist/WHATSNEW.txt) for the release summary.

## Programs

- `player` — graphical game player
- `ddb` — command-line player and diagnostic tool
- `adpc` — DAAD and PAWS source compiler
- `dmg` — graphics database editor and converter
- `chr` — character set and font converter
- `dsk` — disk image inspection and manipulation tool
- `setup.exe` — DOS video and Sound Blaster configuration utility

## Building on Linux

The Linux build requires a C++ compiler, GNU Make, SDL2, and libpng, including
the `sdl2-config` and `libpng-config` command-line tools.

```sh
make -f Makefile-linux
```

See the [full build instructions](docs/dist/README.md#how-to-build-adp-from-the-source-code)
for macOS, Windows, web, MS-DOS, Amiga, and Atari ST builds.

## Testing

To build the Linux tools and run the compiler and game regression suites:

```sh
make -f Makefile-linux test
```

See [tests/README.md](tests/README.md) for information about the regression-game
fixtures.

> [!WARNING]
> ADP is beta software. Bugs and compatibility problems are expected,
> particularly with experimental formats.

Project website: [adventure-player.com](https://www.adventure-player.com)

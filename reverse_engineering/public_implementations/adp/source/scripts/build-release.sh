#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

VERSION=$(sed -n 's/^VERSION=//p' version.mk)
RELEASE_VERSION=$(printf '%s' "$VERSION" | tr '[:upper:]' '[:lower:]' | sed 's/beta/beta-/')
RELEASE_DIR=${RELEASE_DIR:-out/release}
PACKAGE_ONLY=0

usage() {
    cat <<EOF
Usage: scripts/build-release.sh [--package-only] [target ...]

Targets: win64 msdos amiga atarist web osx games all

With no target, builds and packages all targets available on this host.
On macOS this means the ARM64 osx package and Games-AD.zip. On Linux it
means every non-Linux package except osx. Linux users should build from
source. Set EMSDK if Emscripten is not installed at \$HOME/Src/emsdk.
Use --package-only to package existing build outputs.
EOF
}

targets=()
while (($#)); do
    case "$1" in
        --package-only) PACKAGE_ONLY=1 ;;
        -h|--help) usage; exit 0 ;;
        all) targets=(all) ;;
        win64|msdos|amiga|atarist|web|osx|games) targets+=("$1") ;;
        *) echo "Unknown target: $1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

if ((${#targets[@]} == 0)) || [[ ${targets[0]} == all ]]; then
    if [[ $(uname -s) == Darwin ]]; then
        targets=(osx games)
    else
        targets=(win64 msdos amiga atarist web games)
    fi
fi

command -v zip >/dev/null || { echo "zip is required" >&2; exit 1; }
mkdir -p "$RELEASE_DIR"
STAGE=$(mktemp -d "${TMPDIR:-/tmp}/adp-release.XXXXXX")
trap 'rm -rf "$STAGE"' EXIT

require_file() {
    [[ -f $1 ]] || { echo "Missing build output: $1" >&2; exit 1; }
}

copy_docs() {
    local dest=$1
    cp docs/dist/CAAD.txt docs/dist/LEEME.txt docs/dist/LONUEVO.txt "$dest/"
    cp docs/dist/README.md docs/dist/WHATSNEW.txt docs/LICENSE "$dest/"
}

make_zip() {
    local name=$1 dir=$2
    rm -f "$RELEASE_DIR/$name"
    (cd "$dir" && zip -q -r "$ROOT/$RELEASE_DIR/$name" .)
    echo "Created $RELEASE_DIR/$name"
}

build_target() {
    ((PACKAGE_ONLY)) && return
    case "$1" in
        win64) make -f Makefile-win64 -j2 ;;
        msdos)
            command -v dos-toolchain >/dev/null || { echo "dos-toolchain is required" >&2; exit 1; }
            dos-toolchain wmake -h -e -f Makefile-dos MODE=16
            dos-toolchain wmake -h -e -f Makefile-dos MODE=32
            ;;
        amiga)
            command -v amiga-toolchain >/dev/null || { echo "amiga-toolchain is required" >&2; exit 1; }
            amiga-toolchain make -f Makefile-amiga -j2
            ;;
        atarist)
            command -v atari-toolchain >/dev/null || { echo "atari-toolchain is required" >&2; exit 1; }
            atari-toolchain make -f Makefile-atarist -j2
            ;;
        web)
            local emsdk_dir=${EMSDK:-$HOME/Src/emsdk}
            [[ -f $emsdk_dir/emsdk_env.sh ]] || { echo "Emscripten not found at $emsdk_dir" >&2; exit 1; }
            # shellcheck disable=SC1090
            source "$emsdk_dir/emsdk_env.sh" >/dev/null
            make -f Makefile-web -j2
            ;;
        osx)
            [[ $(uname -s) == Darwin ]] || { echo "The osx target must be built on macOS" >&2; exit 1; }
            [[ $(uname -m) == arm64 ]] || { echo "The osx release is ARM64-only" >&2; exit 1; }
            make -f Makefile-osx -j2
            ;;
        games) ;;
    esac
}

package_desktop() {
    local platform=$1 player=$2
    shift 2
    local dir="$STAGE/ADP-$RELEASE_VERSION-$platform"
    mkdir -p "$dir/tools"
    cp "$player" "$dir/"
    copy_docs "$dir"
    cp docs/dist/TOOLS-README.txt "$dir/tools/README.txt"
    while (($#)); do cp "$1" "$dir/tools/"; shift; done
    make_zip "ADP-$RELEASE_VERSION-$platform.zip" "$dir"
}

package_games() {
    local dir="$STAGE/Games-AD"
    mkdir -p "$dir"
    cp docs/dist/GAMES-README.txt "$dir/README.txt"
    while IFS= read -r path || [[ -n $path ]]; do
        [[ -z $path || $path == \#* ]] && continue
        [[ $path != /* && $path != *../* ]] || { echo "Unsafe games manifest path: $path" >&2; exit 1; }
        require_file "tests/games/$path"
        mkdir -p "$dir/$(dirname "$path")"
        cp "tests/games/$path" "$dir/$path"
    done < scripts/release-games.txt
    make_zip Games-AD.zip "$dir"
}

for target in "${targets[@]}"; do
    echo "Building $target"
    build_target "$target"
    case "$target" in
        win64)
            for file in out/win64/player.exe out/win64/ddb.exe out/win64/adpc.exe out/win64/dmg.exe out/win64/chr.exe out/win64/dsk.exe; do require_file "$file"; done
            dir="$STAGE/ADP-$RELEASE_VERSION-win64"
            mkdir -p "$dir/tools"
            cp out/win64/player.exe "$dir/"
            [[ ! -f out/win64/SDL2.dll ]] || cp out/win64/SDL2.dll "$dir/"
            copy_docs "$dir"
            cp docs/dist/TOOLS-README.txt "$dir/tools/README.txt"
            cp out/win64/ddb.exe out/win64/adpc.exe out/win64/dmg.exe out/win64/chr.exe out/win64/dsk.exe "$dir/tools/"
            make_zip "ADP-$RELEASE_VERSION-win64.zip" "$dir"
            ;;
        msdos)
            for file in out/adp16.exe out/adp32.exe out/setup.exe; do require_file "$file"; done
            dir="$STAGE/ADP-$RELEASE_VERSION-msdos"
            mkdir -p "$dir"; cp out/adp16.exe out/adp32.exe out/setup.exe "$dir/"; copy_docs "$dir"
            make_zip "ADP-$RELEASE_VERSION-msdos.zip" "$dir"
            ;;
        amiga)
            require_file out/amiga/adp.exe
            dir="$STAGE/ADP-$RELEASE_VERSION-amiga"
            mkdir -p "$dir"; cp out/amiga/adp.exe "$dir/"; copy_docs "$dir"
            make_zip "ADP-$RELEASE_VERSION-amiga.zip" "$dir"
            ;;
        atarist)
            require_file out/atarist/adp.prg
            dir="$STAGE/ADP-$RELEASE_VERSION-atarist"
            mkdir -p "$dir"; cp out/atarist/adp.prg "$dir/"; copy_docs "$dir"
            make_zip "ADP-$RELEASE_VERSION-atarist.zip" "$dir"
            ;;
        web)
            require_file out/web/dist/index.html
            dir="$STAGE/ADP-$RELEASE_VERSION-web"
            mkdir -p "$dir/dist"; cp -R out/web/dist/. "$dir/dist/"; copy_docs "$dir"
            make_zip "ADP-$RELEASE_VERSION-web.zip" "$dir"
            ;;
        osx)
            require_file out/ADP.app/Contents/MacOS/ADP
            dir="$STAGE/ADP-$RELEASE_VERSION-osx"
            mkdir -p "$dir"; cp -R out/ADP.app "$dir/"; copy_docs "$dir"
            mkdir -p "$dir/tools"; cp docs/dist/TOOLS-README.txt "$dir/tools/README.txt"
            for file in out/ddb out/adpc out/dmg out/chr out/dsk; do require_file "$file"; cp "$file" "$dir/tools/"; done
            make_zip "ADP-$RELEASE_VERSION-osx-arm64.zip" "$dir"
            ;;
        games) package_games ;;
    esac
done

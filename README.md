# 3D ASCII Viewer for NeoOS

Interactive 3D model viewer rendering to ASCII art in the terminal.

## Features

- Load and render 3D models (OBJ format)
- Real-time rotation and scaling
- ASCII art output to terminal
- Interactive keyboard controls
- ncurses-based UI

## Quick Start

Build (requires musl):

```bash
git clone https://github.com/NeoOSOrganization/neoos-musl ../neoos-musl
cd ../neoos-musl && make KERNEL_SHIM_DIR=../neoos-kernel/third_party/shim

git clone https://github.com/NeoOSOrganization/neoos-3d-ascii-viewer
cd neoos-3d-ascii-viewer
git submodule update --init upstream
make MUSL_DIR=../neoos-musl/build-output
# Produces: build/3d-ascii-viewer.nex, build/3d-ascii-viewer.test.json,
# build/models/*.{obj,mtl}
```

## Using it with neoos-kernel

This port isn't part of the default gauntlet (it's interactive, not a
regression test) — `build/3d-ascii-viewer.test.json` just declares
`category: "bin"` so `embedfs` places it at `/bin/3d-ascii-viewer.nex`
when this repo's `build/` is one of neoos-kernel's `EMBED_DIRS`.
`build/models/` holds the `.obj`/`.mtl` fixtures the viewer needs — a
DATA fixture, not code, so it stays on the FAT disk (an orchestrator
like neoos-os-builder copies it to `/usr/share/models`, mirroring the
monorepo's `make ports-test` target).

## Build Details

- Statically linked with musl + NeoOS syscall shim
- Single `.nex` binary
- ncurses shim for terminal UI (custom NeoOS implementation)

## Smoke Test

```bash
make smoke-test
# Host-side: verifies build/3d-ascii-viewer.nex is a valid ELF64
# executable. Full interactive validation (renders a model, exits 0,
# no missing syscalls) needs a NeoOS boot -- this repo has none of its
# own.
```

## Implementation Details

- **upstream/**: Original 3D ASCII viewer source (submodule)
- **ncurses-shim/**: NeoOS ncurses emulation layer (replaces real ncurses)
- **Makefile**: Build glue that configures upstream with shim

## Documentation

- Port-specific notes: See `PORTING-NOTES.md`
- General porting guide: https://github.com/NeoOSOrganization/neoos-docs/blob/main/docs/porting.md

## License

Original viewer: See upstream/LICENSE
NeoOS integration: Same as NeoOS kernel
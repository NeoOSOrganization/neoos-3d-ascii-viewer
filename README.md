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
cd ../neoos-musl && make

git clone https://github.com/NeoOSOrganization/neoos-3d-ascii-viewer
cd neoos-3d-ascii-viewer
make MUSL_DIR=../neoos-musl/build-output
# Produces: build/3d-ascii-viewer.nex
```

## Usage

In NeoOS `/ETC/INITTAB`:

```
::once:/3D-ASCII-VIEWER /path/to/model.obj
```

Or interactively:

```bash
/3d-ascii-viewer models/cube.obj
```

## Build Details

- Statically linked with musl + NeoOS syscall shim
- Single `.nex` binary
- ncurses shim for terminal UI (custom NeoOS implementation)

## Smoke Test

```bash
make smoke-test
# Verifies viewer starts and renders basic geometry
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
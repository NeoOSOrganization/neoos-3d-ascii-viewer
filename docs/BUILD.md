# Building 3D ASCII Viewer for NeoOS

## Prerequisites

- x86_64-elf cross-compiler (from neoos-kernel toolchain)
- musl built from neoos-musl repository
- ncurses-shim (provided in this repo)
- Standard build tools: make, gcc

## Build Steps

### 1. Ensure musl is built
```bash
cd ../neoos-musl
make
cd ../neoos-3d-ascii-viewer
```

### 2. Build 3D Viewer
```bash
make MUSL_DIR=../neoos-musl/build-output
```

Expected output:
```
Building 3D ASCII Viewer...
OK 3D Viewer built at build/3d-ascii-viewer.nex
-rwxr-xr-x  user group 400K build/3d-ascii-viewer.nex
```

### 3. Verify build
```bash
make smoke-test
# Output: PASSED: 3D Viewer smoke tests
```

## Binary Output

- **Location:** `build/3d-ascii-viewer.nex`
- **Size:** ~400KB (statically linked with ncurses-shim)
- **Format:** ELF 64-bit LSB executable, x86-64, statically linked
- **Terminal:** Requires VT100/VT220 compatible terminal

## ncurses-shim Integration

This port uses `ncurses-shim/` instead of standard ncurses (which requires dynamic linking).

### Whats Implemented
- `initscr()` / `endwin()` — Terminal initialization
- `mvprintw()` — Print at position
- `getch()` — Get input character
- `clr_scr()` — Clear screen
- Color support (16 colors)
- Terminal size detection

### Whats Missing
- Window support (all output to main terminal)
- Mouse input
- Advanced attributes (blink, underline on some terminals)

## Integration with NeoOS

### In kernel /ETC/INITTAB

```
::once:/3D-ASCII-VIEWER /usr/share/models/cube.obj
```

### In OS builder

```bash
make ISO_CONTENTS="build/3d-ascii-viewer.nex"
```

## Troubleshooting

### "musl not found at ../neoos-musl/build-output"
Ensure musl is built:
```bash
cd ../neoos-musl && make
```

### "x86_64-elf-gcc: command not found"
Add toolchain to PATH:
```bash
export PATH=../neoos-kernel/toolchain/x86_64-elf/bin:$PATH
```

### Viewer starts but no display
- Ensure terminal is VT100+ compatible
- Check stdin/stdout are connected to terminal
- Try: `/3d-ascii-viewer --help`

## Performance

- **Build time:** ~1-2 minutes
- **Binary size:** ~400KB
- **Render time:** Depends on model complexity

## Known Issues

1. **Colors may not display on all terminals**
   - Some terminal emulators dont support 16-color ANSI codes
   - Workaround: Use VT100 compatible terminal

2. **Large models may be slow**
   - Rendering is single-threaded
   - Complex models with 1000+ triangles may lag
   - Mitigation: Simplify models using external tools

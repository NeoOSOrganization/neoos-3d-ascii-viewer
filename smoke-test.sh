#!/bin/bash
# Host-side smoke test: verifies the build artifact's shape. Full
# interactive validation (renders a model, exits cleanly, no missing
# syscalls) happens inside a NeoOS boot -- see neoos-kernel's
# ports-smoke-test / the monorepo's `make ports-test` for the pattern.
set -e

BIN="${1:-build/3d-ascii-viewer.nex}"

[ -f "$BIN" ] || { echo "FAILED: $BIN missing"; exit 1; }

python3 - "$BIN" <<'EOF'
import sys
with open(sys.argv[1], "rb") as f:
    data = f.read(20)
assert data[1:4] == b"ELF", f"not an ELF file: {data[1:4]!r}"
assert data[4] == 2, "not ELF64"
e_type = int.from_bytes(data[16:18], "little")
assert e_type == 2, f"not an executable (e_type={e_type})"
print("smoke-test: OK -- ELF64 executable")
EOF

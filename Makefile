# 3D ASCII Viewer port for NeoOS
# Stub implementation (full build in Phase 3)

MUSL_DIR ?= ../neoos-musl/build-output
BUILD_DIR ?= build

.PHONY: all clean smoke-test

all:
	@echo "3D ASCII Viewer build: placeholder (implementation in Phase 3)"
	@echo "When complete, will:"
	@echo "  1. Configure viewer with ncurses shim from ncurses-shim/"
	@echo "  2. Link against musl from $(MUSL_DIR)"
	@echo "  3. Produce static binary at $(BUILD_DIR)/3d-ascii-viewer.nex"

clean:
	rm -rf $(BUILD_DIR)

smoke-test:
	@echo "3D ASCII Viewer smoke test: placeholder (runs in Phase 3)"
	@echo "Will verify: viewer startup, model loading, ASCII rendering"
# 3D ASCII Viewer port for NeoOS.
#
# The upstream program is built UNMODIFIED, against a seventeen-function
# ncurses replacement (ncurses-shim/) rather than a ported ncurses -- see
# ncurses-shim/ncurses.h for why. -I puts the shim ahead of the search
# path so its <ncurses.h> is the one found.
MUSL_DIR ?= ../neoos-musl/build-output
UPSTREAM_DIR ?= upstream
BUILD_DIR ?= build

CC := x86_64-elf-gcc
AV_SHIM := ncurses-shim
AV_SRCS := $(wildcard $(UPSTREAM_DIR)/src/*.c) $(AV_SHIM)/ncurses_shim.c
MUSL_CFLAGS := -static -nostdlib -nostdinc -ffreestanding \
	-mcmodel=large -fno-pic -mno-red-zone -fno-stack-protector -O2 \
	-isystem $(MUSL_DIR)/include

.PHONY: all clean smoke-test
all: $(BUILD_DIR)/3d-ascii-viewer.nex

$(BUILD_DIR)/3d-ascii-viewer.nex: $(AV_SRCS) user.ld
	@[ -f "$(MUSL_DIR)/lib/libc.a" ] || { echo "error: musl not found at $(MUSL_DIR); build neoos-musl first" >&2; exit 1; }
	@mkdir -p $(BUILD_DIR)
	$(CC) $(MUSL_CFLAGS) -I$(AV_SHIM) -T user.ld -z noexecstack \
		-o $@ $(MUSL_DIR)/lib/crt1.o $(AV_SRCS) \
		-L$(MUSL_DIR)/lib -lc -lgcc
	cp av.test.json $(BUILD_DIR)/3d-ascii-viewer.test.json
	@mkdir -p $(BUILD_DIR)/models
	cp $(UPSTREAM_DIR)/models/*.obj $(UPSTREAM_DIR)/models/*.mtl $(BUILD_DIR)/models/

clean:
	rm -rf $(BUILD_DIR)

smoke-test: $(BUILD_DIR)/3d-ascii-viewer.nex
	./smoke-test.sh $(BUILD_DIR)/3d-ascii-viewer.nex

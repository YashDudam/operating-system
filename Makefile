ASM = nasm

SRC_DIR = src
BUILD_DIR = build

.PHONY: all
all: build $(BUILD_DIR)/boot_floppy.img $(BUILD_DIR)/boot.bin

build:
	mkdir build

$(BUILD_DIR)/boot_floppy.img: $(BUILD_DIR)/boot.bin
	cp $(BUILD_DIR)/boot.bin $(BUILD_DIR)/boot_floppy.img
	truncate -s 1440k $(BUILD_DIR)/boot_floppy.img

$(BUILD_DIR)/boot.bin: $(SRC_DIR)/boot.asm
	$(ASM) -o $(BUILD_DIR)/boot.bin $(SRC_DIR)/boot.asm -f bin

.PHONY: clean
clean:
	rm -f build/*

.PHONY: run
run:
	qemu-system-i386 -fda build/boot_floppy.img


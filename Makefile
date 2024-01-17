ASM = nasm

SRC_DIR = src
BUILD_DIR = build

.PHONY: all
all: build $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/main.bin

build:
	mkdir build

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	$(ASM) -o $(BUILD_DIR)/main.bin $(SRC_DIR)/main.asm -f bin

.PHONY: clean
clean:
	rm -f build/*

.PHONY: run
run:
	qemu-system-i386 -fda build/main_floppy.img


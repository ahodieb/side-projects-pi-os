# Don't use normal gcc, use the arm cross compiler
CC = ./gcc-arm/bin/arm-none-eabi-gcc
LINKER_SCRIPT= ./linker/linker.ld

# For RaspbberryPi 2 & 3
CPU = cortex-a7
CFLAGS= -mcpu=$(CPU) -fpic -ffreestanding

# Sources
KER_SRC = ./src/kernel
KER_HEAD = ./include
KER_SOURCES = $(wildcard $(KER_SRC)/*.c)
ASM_SOURCES = $(wildcard $(KER_SRC)/*.S)

# Build outputs
BUILD_DIR = build
OBJ_DIR= $(BUILD_DIR)/objects
OBJECTS = $(patsubst $(KER_SRC)/%.c, $(OBJ_DIR)/%.o, $(KER_SOURCES))
OBJECTS += $(patsubst $(KER_SRC)/%.S, $(OBJ_DIR)/%.o, $(ASM_SOURCES))
HEADERS = $(wildcard $(KER_HEAD)/*.h)
KER_BUILD_DIR = $(BUILD_DIR)/kernel
KER_IMG_NAME=$(KER_BUILD_DIR)/kernel.img

build: $(OBJECTS) $(HEADERS)
	echo $(objects)
	mkdir -p $(KER_BUILD_DIR)
	$(CC) -T $(LINKER_SCRIPT) -o $(KER_IMG_NAME) -ffreestanding -O2 -nostdlib $(OBJECTS)

$(OBJ_DIR)/%.o: $(KER_SRC)/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -I$(KER_SRC) -I$(KER_HEAD) -c $< -o $@ -O2 -Wall -Wextra

$(OBJ_DIR)/%.o: $(KER_SRC)/%.S
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -I$(KER_SRC) -c $< -o $@

clean: 
	rm -r $(BUILD_DIR)

run: build
	qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel $(KER_IMG_NAME)
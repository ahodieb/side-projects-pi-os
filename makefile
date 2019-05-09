# Don't use normal gcc, use the arm cross compiler
CC = ./gcc-arm/bin/arm-none-eabi-gcc

build:
	$(CC) -mcpu=cortex-a7 -fpic -ffreestanding -c boot.S -o boot.o
	$(CC) -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
	$(CC) -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o kernel.o

run: build
	qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel myos.elf
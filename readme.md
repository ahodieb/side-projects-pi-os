# PiOS

Hobby OS project, following this [guide](https://jsandler18.github.io/tutorial/dev-env.html) to write an OS for raspberry-pi

---

## Getting the compiler 
* Download ARM compiler from [here](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads).
* Extract and rename folder to gcc-arm

## Setting up QEMU
On mac `brew install qemu` just works

## Compiling basic kernel

```bash
./gcc-arm/bin/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c boot.S -o boot.o
./gcc-arm/bin/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
./gcc-arm/bin/arm-none-eabi-gcc -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o kernel.o

```

## Try the Kernel
Run `qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel myos.elf`

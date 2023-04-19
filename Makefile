CC=gcc
INCLUDE_DIR=include
C_FLAGS=-Wall -Werror -Wextra -fno-pie -m32 -ffreestanding -I$(INCLUDE_DIR)
C_FILES=kernel.c $(shell find . -name \*.c | grep -v kernel.c)
OBJS=$(C_FILES:.c=.o)
BOOTLOADER=./boot/boot.bin
KERNEL=kernel.bin
TARGET=os.bin

.PHONY: run compile clean

run: qemu_launch
compile: $(TARGET)

qemu_launch: $(TARGET)
	qemu-system-i386 -drive format=raw,file=$<,index=0,if=floppy

$(TARGET): $(BOOTLOADER) $(KERNEL)
	cat $^ > $@

$(BOOTLOADER): ./boot/boot.asm
	$(MAKE) -C boot all

$(KERNEL): $(OBJS) kernel-entry.o
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary

kernel-entry.o: kernel-entry.elf
	nasm $< -f elf -o $@

%.o: %.c
	$(CC) ${C_FLAGS} -c $< -o $@

clean:
	find . -type f \( -name \*.o -o -name \*.bin \) | xargs --no-run-if-empty rm

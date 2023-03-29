CC=gcc
INCLUDE_DIR = include
C_FLAGS = -Wall -Werror -Wextra -fno-pie -m32 -ffreestanding -I$(INCLUDE_DIR)

all: qemu_launch

qemu_launch: os.bin
	qemu-system-i386 -drive format=raw,file=$<,index=0,if=floppy

os.bin: boot.bin kernel.bin
	cat $^ > $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

kernel.bin: kernel-entry.o kernel.o console.o
	ld -m elf_i386 -s -o $@ -Tlink.ld $^ --oformat binary

kernel-entry.o: kernel-entry.elf
	nasm $< -f elf -o $@

%.o: %.c
	$(CC) ${C_FLAGS} -c $< -o $@

clean:
	$(RM) *.bin *.o

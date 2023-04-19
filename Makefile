CC=gcc
INCLUDE_DIR = include
C_FLAGS = -Wall -Werror -Wextra -fno-pie -m32 -ffreestanding -I$(INCLUDE_DIR)
C_FILES=$(shell find . -name \*.c | tac)
OBJS=$(C_FILES:.c=.o)
TARGET=os.bin
.PHONY: all compile clean

compile: $(TARGET)
all: qemu_launch

qemu_launch: $(TARGET)
	qemu-system-i386 -drive format=raw,file=$<,index=0,if=floppy

$(TARGET): boot.bin kernel.bin
	cat $^ > $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

kernel.bin: $(OBJS) kernel-entry.o
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary
kernel-entry.o: kernel-entry.elf
	nasm $< -f elf -o $@

%.o: %.c
	$(CC) ${C_FLAGS} -c $< -o $@

clean:
	find . -name \*.o | xargs --no-run-if-empty rm
	rm $(TARGET)

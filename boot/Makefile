all: boot.bin

.PHONY:	all

%.bin: %.asm
	nasm $< -f bin -o $@
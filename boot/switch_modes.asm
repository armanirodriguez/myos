[org 0x7c00]
[bits 16]
switch_to_32bit:
    cli
    lgdt  [gdt_descriptor]
    mov   eax, cr0
    or    eax, 0x1
    mov   cr0, eax
    jmp   CODE_SEGMENT_INDEX:begin_32bit_mode

[bits 32]
begin_32bit_mode:
    mov     ax, DATA_SEGMENT_INDEX
    mov     ds, ax
    mov     ss, ax
    mov     es, ax
    mov     fs, ax
    mov     gs, ax
    mov     ebp, 0x90000
    mov     esp, ebp
    jmp     KERNEL_OFFSET

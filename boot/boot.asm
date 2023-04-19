[bits 16]
[org 0x7c00]

call    boot_init
call    kernel_load
call    switch_to_32bit

boot_init:
    pop     bx  ; Save Return Address
    KERNEL_OFFSET equ 0x1000
    NUM_SECTORS equ 9

    ; Stack Setup
    mov     bp, 0x9000
    mov     sp, bp
    ; Save boot drive
    mov     [BOOT_DRIVE], dl
    ; return
    jmp bx

kernel_load:
    ; Read NUM_SECOTRS sectors from disk to KERNEL_ADDRESS
    pusha
    mov     cl, NUM_SECTORS
    mov     bx, KERNEL_OFFSET
    call    disk_read
    popa
    ret


%include "gdt.asm"
%include "switch_modes.asm"
%include "disk_read.asm"
%include "print_string.asm"

BOOT_DRIVE db 0

DISK_READ_ERROR_MSG db "Disk Read Error", 0
DISK_SECTOR_ERROR_MSG db "Mismatch between sectors requested and sectors read", 0

times 510-($-$$) db 0
dw 0xaa55

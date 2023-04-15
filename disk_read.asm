[bits 16]
[org 0x7c00]

disk_read:
    pusha
    mov     ah, 0x02            ; Disk Read Interrupt
    mov     al, 0x09            ; Read 9 sectors
    mov     ch, 0x00            ; Cylinder 0
    mov     cl, 0x02            ; Sector 2
    mov     dh, 0x00            ; Head 0

    int     0x13                ; Perform the read

    jc      disk_read_error     ; Print error message if carry flag is set
    cmp     al, 0x09            ; Check number of sectors
    jne     disk_sector_error
    popa
    ret
disk_read_error:
    mov bx, DISK_READ_ERROR_MSG
    call print_string
    popa
    ret
disk_sector_error:
    mov bx, DISK_SECTOR_ERROR_MSG
    call print_string
    popa
    ret

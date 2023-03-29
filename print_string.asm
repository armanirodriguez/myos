; Print String function
; bx set to starting address of null terminated string
print_string:
    pusha
    mov ah, 0x0E
    mov al, [bx]

    cmp al, 0
    je done_print_string

    int 0x10
    add bx, 1
    jmp print_string

done_print_string:
    popa
    ret

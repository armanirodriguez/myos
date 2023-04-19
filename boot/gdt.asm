[org 0x7c00]
[bits 16]

gdt_start_segment:
    dq 0x0

gdt_code_segment:
; ====== Code Segment Descriptor ====== ;
; Base: 0x0
; Limit: 0xFFFFF
; Type flags: 1010b
;   Code -> 1
;   Conforming -> 0
;   Readable -> 1
;   Accessed -> 0
; First Flags: 1001b
;   Segment Present -> 1
;   Privilege level -> 00
;   Descriptor Type -> 1 (code/data)
; Second Flags: 1100b
;   Granulatiry -> 1
;   Default op. size -> 1 (32 bit)
;   64-bit segment -> 0
;   AVL -> 0
    dw 0xffff       ; Limit (bits 0-15)
    dw 0            ; Base (bits 0-15)
    db 0            ; Base (bits 16-23)
    db 0x9a         ; First Flags + Type Flags
    db 0xcf         ; Second Flags + Limit (bits 16-19)
    db 0            ; Base (bits 24-31)
gdt_data_segment:
; ====== Data Segment Descriptor ====== ;
; Base: 0x0
; Limit: 0xFFFFF
; Type flags: 1010b
;   Code -> 0
;   Expand Down -> 0
;   Writable -> 1
;   Accessed -> 0
; First Flags: 1001b
;   Segment Present -> 1
;   Privilege level -> 00
;   Descriptor Type -> 1 (code/data)
; Second Flags: 1100b
;   Granulatiry -> 1
;   Default op. size -> 1 (32 bit)
;   64-bit segment -> 0
;   AVL -> 0
    dw 0xffff       ; Limit (bits 0-15)
    dw 0            ; Base (bits 0-15)
    db 0            ; Base (bits 16-23)
    db 0x92         ; First Flags + Type Flags
    db 0xcf         ; Second Flags + Limit (bits 16-19)
    db 0            ; Base (bits 24-31)
gdt_end:
gdt_descriptor:
; ====== GDT Descriptor ====== ;
    dw gdt_end - gdt_start_segment - 1  ; Size of GDT   (16 bits)
    dd gdt_start_segment                ; Start Address (32 bits)


; ====== SEGEMENT OFFSETS ====== ;
CODE_SEGMENT_INDEX equ gdt_code_segment - gdt_start_segment
DATA_SEGMENT_INDEX equ gdt_data_segment - gdt_start_segment

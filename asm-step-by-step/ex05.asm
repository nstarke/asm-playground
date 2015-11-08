section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    mov     eax,42  ; eax == 0x2a
    neg     eax     ; eax == 0xffffffd6
    add     eax,42  ; eax == 0x00000000

    nop

section .bss


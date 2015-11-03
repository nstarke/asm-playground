section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    mov     eax,0FFFFFFFFh
    mov     ebx,02Dh
    dec     ebx
    inc     eax

    nop

section .bss


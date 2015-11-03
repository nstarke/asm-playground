section .data
    Snippet db "KANGAROO"
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    mov     ebx,Snippet
    mov     eax,8

DoMore:
    add     byte [ebx],32
    inc     ebx
    dec     eax
    jnz     DoMore

    nop

section .bss


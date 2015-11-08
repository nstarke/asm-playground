section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    ; MUL exercises

    mov     eax,447
    mov     ebx,1739
    mul     ebx

    mov     eax,0FFFFFFFh
    mov     ebx,03B72h
    mul     ebx

    nop

section .bss


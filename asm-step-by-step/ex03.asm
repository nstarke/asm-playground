section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops

    mov eax,5
DoMore: dec eax
    jnz DoMore

    nop

section .bss


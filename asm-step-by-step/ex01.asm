section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    ; begin experiment
    mov     ax,067FEh
    mov     bx,ax
    mov     cl,bh
    mov     ch,bl
    xchg    cl,ch
    ; end experiment

    nop

section .bss


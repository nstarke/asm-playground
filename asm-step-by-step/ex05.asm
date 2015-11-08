section .data
section .text
    global _start

_start:

    nop

    ; Put experiments here, between the two nops
    mov     eax,42  ; eax == 0x2a
    neg     eax     ; eax == 0xffffffd6 - negates value in EAX by applying two's compliment
    add     eax,42  ; eax == 0x00000000

    mov     eax,07ffffffh ; this should be the highest unsigned 32bit integer
    inc     eax           ; this should result in 'wrapping around' to the least negative value.
                          ; this doesn't work on a 64 bit VM, even with a 32bit OS.
    ; Sign extension and MOVSX
    mov     ax,-42        ; eax == 0x800ffd6 - moves ffd6 into lower two bytes
    mov     ebx,eax       ; ebx == 0x800ffd6

    mov     ax,-42
    movsx   ebx,ax

    nop

section .bss


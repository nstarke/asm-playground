; Executable name : UPPERCASER
; Version         : 1.0
; Created date    : 11/8/2015
; Last update     : 11/8/2015
; Author          : Nicholas Starke
; Description     : A simple assembly app that will read from
;                   stdin and convert any lowercase letters to
;                   uppercase.
;
; Build using these commands:
; $ nasm -f elf -g -F stabs uppercaser.asm
; $ ld -o uppercaser uppercaser.o
;

section .bss
    Buff resb 1

section .data

section .text
    global _start

_start:
    nop                     ; this no op keeps gdb happy
Read:
    mov     eax,3           ; specify sys_read call
    mov     ebx,0           ; specify file descriptor 0: Standard Input
    mov     ecx,Buff        ; Pass address of the buffer that will read in
                            ; from stdin
    mov     edx,1           ; tell sys_read to read one char from stdin
    int     80h             ; call sys_read
    cmp     eax,0           ; look at sys_read's return value in EAX
    je      Exit            ; Jump to exit if Equal to 0 (0 means EOF)
    cmp     byte [Buff],61h ; test input char against lowercase 'a'
    jb      Write           ; if below 'a' in ASCII chart, not lowercase
    cmp     byte [Buff],7Ah ; test input against lowercase 'z'
    ja      Write           ; if above 'z' in ASCII chart, not lowercase
                            ; at this point we have a lowercase character.
    sub     byte [Buff],20h ; subtract 20h from lowercase to give uppercase value.
                            ; and now write it out to stdout
Write:
    mov     eax,4           ; specify sys_write call
    mov     ebx,1           ; Specify File descriptor 1: stdin
    mov     ecx,Buff        ; pass address of the character to write
    mov     edx,1           ; pass the number of chars to write
    int     80h             ; call sys_write
    jmp     Read            ; the go to the beginning to get another character.a

Exit:
    mov     eax,1           ; code for exit syscall
    mov     ebx,1           ; return a code of zero to Linx
    int     80h

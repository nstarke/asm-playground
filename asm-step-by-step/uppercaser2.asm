; Executable Name : uppercaser2
; Version         : 1.0
; Created date    : 11/9/2015
; Last update     : 11/9/2015
; Author          : Nicholas Starke
; Description     : A simple program in assembly for Linux
;                   demonstrating simple text file I/O (through redirection)
;                   for reading an input file to a buffer inbocks, forcing
;                   lowercase characters to uppercase, and writing the modified
;                   buffer to an output file
;
; Run it using this command:
; $ uppercaser2 > [OUTPUT_FILE] < [INPUT_FILE]
;
; Build using these commands:
; $ nasm -f elf -g -F stabs uppercaser2.asm
; $ ld -o uppercaser2 uppercaser2.o
;

section .bss                    ; section containing uninitialized data

    BUFFLEN equ 1024            ; Length of buffer
    Buff:   resb BUFFLEN        ; Test Buffer itself

section .data                   ; section containing uninitialized data

section .text                   ; section containing code

global _start                   ; linker needs this to find entry point

_start:
    nop                         ; this nop keeps gdb happy

    ; Read a buffer full of text from stdin:

read:
    mov     eax,3               ; specify sys_read call
    mov     ebx,0               ; specify file descriptor 0: stdin
    mov     ecx,Buff            ; Pass offset of the buffer to read to
    mov     edx,BUFFLEN         ; Pass number of bytes to read at one pass
    int     80h                 ; Call sys_read to fill the buffer
    mov     esi,eax             ; Copy sys_read return value for safekeeping
    cmp     eax,0               ; if eax=0 sys_read reached EOF on stdin
    je      done                ; Jump if Equal if comparison above returns 0

    ; Set up the registers for the process buffer step:

    mov     ecx,esi             ; place the number of bytes read into ecx
    mov     ebp,Buff            ; Place address of buffer into ebp
    dec     ebp                 ; Adjust count to offset

    ; go through the buffer and convert lowercase to uppercase characters:

scan:
    cmp     byte [ebp+ecx],61h  ; Test input char against lowercase 'a'
    jb      next                ; if below 'a' in ASCII, not lowercase
    cmp     byte [ebp+ecx],7Ah  ; Test input char against lowercase 'z'
    ja      next                ; if above 'z' in ASCII, not lowercase
                                ; at this point we have a lowercase char
    sub     byte [ebp+ecx],20h  ; Subtract 20h (32d) to give uppercase

next:
    dec     ecx                 ; Decrement counter
    jnz     scan                ; if characters reamin, loop back

    ; write the buffer full of processed text to stdout:

write:
    mov     eax,4               ; specify sys_write call
    mov     ebx,1               ; specify file descriptor 1: stdout
    mov     ecx,Buff            ; pass offset of the buffer
    mov     edx,esi             ; Pass the number of bytes of data in the buffer
    int     80h                 ; Make the sys_write kernel call
    jmp     read                ; loop back and load another buffer full

    ; End of the party:

done:
    mov     eax,1               ; code for exit syscall
    mov     ebx,0               ; return a code of zero
    int     80h                 ; Make sys_exit kernel call

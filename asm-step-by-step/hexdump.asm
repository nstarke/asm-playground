; Executable name : hexdump
; Version         : 1.0
; Created Date    : 11/14/2015
; Last update     : 11/14/2015
; Author          : Nick Starke
; Description     : Utility that converts binary values to hexadecimal sttrings
;
; Run it this way:
; $ hexdump < (INTPUTFILE)
;
; build using these commands:
; nasm -f elf -g -F stabs hexdump.asm
; ld -o hexdump hexdump.o
;
section .bss                        ; section containing unintialized data

BUFFLEN equ 16                      ; we read the file 16 bytes at a time
Buff: resb BUFFLEN                  ; Text buffer itself

section .data                       ; section containing initialized data

HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
HEXLEN equ $-HexStr
Digits: db "0123456789ABCDEF"

section .text                       ; section containing code

global _start                       ; Linker needs this to find the entry point.

_start:
    nop                             ; this no-op keeps gdb happy.
; Read a buffer full of text from stdin:
read:
    mov eax,3                       ; specifies sys_read call
    mov ebx,0                       ; specify file descriptor 0: STDIN
    mov ecx,Buff                    ; pass offset of the buffer to read to
    mov edx,BUFFLEN                 ; pass number of bytes to read in each pass
    int 80h                         ; call sys_read to fill the buffer
    mov ebp,eax                     ; save # of bytes read from file for later
    cmp eax,0                       ; if eax == 0, sys_read reached EOF on stdin
    je done                         ; Jump if Equal to 0 from above compare

; set up the registers for the process buffer step

    mov esi,Buff                    ; place adress of file buffer into esi
    mov edi,HexStr                  ; place address of line string into edi
    xor ecx,ecx                     ; clearn line string pointer to 0

    ; go through the buffer and convert binary vlaues to hex digits:

scan:
     xor eax,eax                    ; clear eax to 0

; here we calculate the offset into HexStr, which is the value in ecx * 3

    mov edx, ecx                    ; copy the char counter into edx
    shl edx,1                       ; multiiple pointer by 2 using left shift
    add edx,ecx                     ; complete multiplacation by 3

; get a character from the buffer and put it in both eax and ebx

    mov al,byte [esi+ecx]           ; put a byte from the input buffer in al
    mov ebx,eax                     ; duplicate the byte in bl for second nybble

; look up low nybble character and instert it into string

    and al,0Fh                      ; mask out all but the low nybble
    mov al,byte [Digits+eax]        ; Look up the char equivalent of nybble
    mov byte [HexStr+edx+2],al      ; Write LSB char digit to line string

; look up high nybble character and insert it into the string

    shr bl,4                        ; shift high 4 bits of char into low 4 bits
    mov bl,byte [Digits+ebx]        ; look up char equivalent of nybble
    mov byte [HexStr+edx+1],bl      ; write MSB char digit to line string

; Bump the buffer pointer to the next character and see if we're done

    inc ecx                         ; increment line string pointer
    cmp ecx,ebp                     ; Compare to the number of chars in the bufffer
    jna scan                        ; loop bakc i ecx <= number of chars in the buffer

; write the line of hexadeimcal values to stdout:

    mov eax,4                       ; specify sys_write call
    mov ebx,1                       ; specify file descriptor 1: stdout
    mov ecx,HexStr                  ; pass offset of line string
    mov edx,HEXLEN                  ; pass size of the line string
    int 80h                         ; make kernal call to print out line string
    jmp read                        ; loop back and load file buffer again

; all done
done:
    mov eax,1                       ; code for exit syscall
    mov ebx,0                       ; return a code of zero
    int 80h                         ; make kernel call to exit



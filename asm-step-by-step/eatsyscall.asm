; Executable name : EATSYSCALL
; Version         : 1.0
; Created date    : 11/8/2015
; Last update     : 11/8/2015
; Author          : Nicholas Starke
; Description     : A simple assembly app for linux, using NASM
;                   demonstrating the use of Linux INT 80h
;                   syscalls to display text.
;
; Build using these commands:
; $ nasm -f elf -g -F stabs eatsyscall.asm
; $ ld -o eatsyscall eatsyscall.o
;

section .data                           ; Section containing initialized data
    EatMsg: db "Eat at Joe's!",10
    EatLen: equ $-EatMsg

 section .bss                           ; section containing unintiailzied data

 section .text                          ; section containing code

 global _start                          ; Linker needs this to find the entry point

 _start:
    nop                                 ; this no-op keeps gdb happy
    mov     eax,4                       ; specify sys_write syscall
    mov     ebx,1                       ; specify File Descriptor 1: Standard Output
    mov     ecx,EatMsg                  ; Pass offset of the message
    mov     edx,EatLen                  ; Pass the length of the message
    int     80H                         ; Make syscall to output the text to stdout

    mov     eax,1                       ; Specify Exit syscall
    mov     ebx,0                       ; return a code of zero

    int     80H                         ; Make syscall to terminate program

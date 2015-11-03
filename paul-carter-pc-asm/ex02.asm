; based off the tutorial available at: http://www.drpaulcarter.com/pcasm
; You will need the source files provided for linux to compile the
; output library.
;
; file ex02.asm
; Second assembly program.
;
; nasm -f elf ex02.asm
; gcc -o ex02 ex02.o driver.c asm_io.o

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels reger to strings used for output
;
prompt1 db  "Enter a number: ", 0
prompt2 db  "Enter another number: ", 0
prompt3 db  "Enter a third number: ", 0
outmsg1 db  "You entered ", 0
outmsg2 db  " and ", 0
outmsg3 db  ", the sum of these is, ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels reger to double words used to store inputs
;
input1 resd 1
input2 resd 1
input3 resd 1

;
; code is put in the .text segment
;

segment .text
    global  asm_main
asm_main:
    enter   0,0                ; setup routine
    pusha

    mov     eax, prompt1       ; print out prompt
    call    print_string

    call    read_int           ; read integer
    mov     [input1], eax      ; store into input1

    mov     eax, prompt2       ; print out prompt
    call    print_string

    call    read_int           ; read integer
    mov     [input2], eax      ; store into input2

    mov     eax, prompt3
    call    print_string

    call    read_int
    mov     [input3], eax

    mov     eax, [input1]      ; eax = dword at input1
    add     eax, [input2]      ; eax += dword at input 2
    add     eax, [input3]
    mov     ebx, eax           ; ebx = eax

    dump_regs 1                ; print out register values
    dump_mem  2, outmsg1, 1    ; print out memory

;
; next print out result message as series of steps
;

    mov     eax, outmsg1
    call    print_string       ; print out first message
    mov     eax, [input1]
    call    print_int          ; print out input1
    mov     eax, outmsg2
    call    print_string       ; print out second message
    mov     eax, [input2]
    call    print_int          ; print out input 2
    mov     eax, outmsg2
    call    print_string       ; print out second message (again)
    mov     eax, [input3]
    call    print_int          ; print out input 2

    mov     eax, outmsg3
    call    print_string       ; print out third message
    mov     eax, ebx
    call    print_int          ; print out sum (ebx)
    call    print_nl           ; print new-line

    popa
    mov     eax, 0             ; return back to C
    leave
    ret

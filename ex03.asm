; ex03 - Example 2.1.4 from "pcasm-book"
; http://www.drpaulcarter.com/pcasm/
; dependency source can be found at:
; http://www.drpaulcarter.com/pcasm/linux-ex.zip

%include "asm_io.inc"

segment .data               ; Output Strings
prompt      db  "Enter a number: ", 0
square_msg  db  "Square of input is ", 0
cube_msg    db  "Cube of input is ", 0
cube25_msg  db  "Cube of input times 25 is ", 0
quot_msg    db  "Quotient of cube/100 is ", 0
rem_msg     db  "Remainder of cube/100 is ", 0
neg_msg     db  "The negation of the remainder is ", 0

segment .bss
input resd 1

segment .text
    global asm_main
asm_main:
    enter 0,0               ; Setup routine
    pusha
    mov     eax, prompt     ; eax = "Enter a number \0"
    call    print_string    ; print current string value in eax

    call    read_int        ; read an integer value into eax from stdin
                            ; does not perform any input validation
                            ; will accept non-numeric values
    mov     [input], eax    ; move the value of previous read int value into input

    imul    eax             ; edx:eax = eax * eax
    mov     ebx, eax        ; save answer in ebx - ebx = input integer^2
    mov     eax, square_msg ; eax = "Square of input is \0"
    call    print_string    ; print string value currently stored in eax
    mov     eax, ebx        ; move value of ebx into eax so it can be print in next instruction
    call    print_int       ; print current integer value in eax to stdout
    call    print_nl        ; print new line to stdout

    mov     ebx, eax        ; move current integer value in eax to ebx (should be integer^2)
    imul    ebx, [input]    ; ebx *= [input]
    mov     eax, cube_msg
    call    print_string
    mov     eax, ebx
    call    print_int
    call    print_nl

    imul    ecx, ebx, 25       ; ecx = ebx * 25
    mov     eax, cube25_msg
    call    print_string
    mov     eax, ecx
    call    print_int
    call    print_nl

    mov     eax, ebx
    cdq                     ; initialize edx by sign extension - convert double-word to quad-word
                            ; Sign-extends EAX into EDX, forming the quad-word EDX:EAX.
                            ; Since (I)DIV uses EDX:EAX as its input,
                            ; CDQ must be called after setting EAX if EDX is not manually
                            ; initialized (as in 64/32 division) before (I)DIV.
                            ;
                            ; (https://en.wikipedia.org/wiki/X86_instruction_listings)
                            ;
    mov     ecx, 100        ; can't divide by immediate value
    idiv    ecx             ; edx: eax / ecx
                            ; DX:AX = DX:AX / r/m; resulting DX == remainder
                            ;
                            ; (https://en.wikipedia.org/wiki/X86_instruction_listings)
                            ;
    mov     ecx, eax        ; save quotient into ecx
    mov     eax, quot_msg
    call    print_string
    mov     eax, ecx
    call    print_int
    call    print_nl
    mov     eax, rem_msg
    call    print_string
    mov     eax, edx
    call    print_int
    call    print_nl

    neg     edx             ; negate the remainder - two's complement negation.
    mov     eax, neg_msg
    call    print_string
    mov     eax, edx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0          ; return back to C
    leave
    ret

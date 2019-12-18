bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s dw 12345, 20778, 4596
    len equ ($-s)/2
    d times len*10 db 0
    z db 10
; our code starts here
segment code use32 class=code
    start:
        ; Task: take digits from an array of words and memorize them as bytes
        mov ecx, len
        mov esi, 0
        mov edi, 0
        mov bx, 10
        myRepeat:
            mov ax, [s+esi] ; I take the number
            myLoop:
                mov dx, 0 ; convert AX to DX:AX
                div bx ; DX - DX:AX%10, AX - DX:AX/10                                            
                mov [d+edi], dl ; move the last digit to the new array                    
                add edi, 1 ; increment the new array index                              
                cmp AX, 0                                                                          
                ja myLoop ; if AX > 0, we have at least one more digit
            add esi, 2 ; go to the next word
        loop myRepeat
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

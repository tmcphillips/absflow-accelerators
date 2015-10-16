SECTION .data               ; Section containing initialized data

Greeting:           db "Hello, World!", 0AH
GreetingLength:     equ $-Greeting

SECTION .bss                ; Section containing unitialized data

SECTION .text               ; Section containing code

global _start               ; Linker needs this to find the entry point

_start:

    nop                     ; This no-op keeps gdb happy
    mov eax, 4              ; Specify sys_write syscall
    mov ebx, 1              ; Specify File Descriptor 1: Standard output
    mov ecx, Greeting       ; Pass offset of the message
    mov edx, GreetingLength ; Pass the length of the message
    int 80H                 ; Make syscall to output the text to stdout

    mov eax, 1              ; Specify Exit syscall
    mov ebx, 0              ; Return a code of zero
    int 80H                 ; Make syscall to terminate the program

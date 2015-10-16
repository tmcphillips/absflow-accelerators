; ******************************************************************************
;   Name:           HexDump
;   Version:        1.0
;   Date created:   12Dec2010
;   Last modified:  12Dec2010
;   Author:         Timothy M. McPhillips
;   Description:    Program that displays the contents of any file in hex format.

; ****************************  C O N S T A N T S  *****************************

; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT    equ     01h
SYS_READ    equ     03h
SYS_WRITE   equ     04h

; file descriptors for default I/O streams 
STDIN       equ     0
STDOUT      equ     1

; application configuration
BYTESPERLINE     equ    16     ; number of input bytes to display in hex per line


; ********************************  D A T A  ***********************************

SECTION .data           ; Section containing initialized data

space:          db  2Eh  ; space character for delimiting bytes of output
newline:        db  0Ah  ; newline character for delimiting lines of output

; *********************************** B S S ************************************

SECTION .bss            ; Section containing unitialized data

inbuffer:       resb 1  ; Reserve a one-byte buffer for input byte
outbuffer:      resb 1  ; Reserve a one-byte buffer for output hex digit
charcount:      resb 1  ; Reserve one byte for the byte counter

; ********************************  C O D E  ***********************************

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker


; **************************************
; Routine: Main
; **************************************

_start:

    nop                                 ; This no-op keeps gdb happy

    ; initialize character counter
    mov byte [charcount], 0             ; set initial character count to zero

read:

    ; read a character from stdin
    mov eax, SYS_READ                   ; specify the sys_read system call
    mov ebx, STDIN                      ; specify standard input
    mov ecx, inbuffer                   ; specify address to put read character
    mov edx, 1                          ; specify that one character is to be read
    int 80h                             ; make sys_read system call to read next character from stdin

    ; jump to program exit if stdin has closed
    cmp eax, 0                          ; compare sys_read return value (character read count) with zero
    je exit                             ; jump to exit if no character was read

    ; put four high order bits of character in lower 4 bits of AL
    mov al, [inbuffer]                  ; load character into AL
    shr al, 4                           ; shift bits to the right 4 bits
    
    ; call printnybble on upper 4 bits of character
    call printnybble
    
    ; put four high order bits of character in lower 4 bits of AL
    mov al, [inbuffer]                  ; load character into AL
    and al, 0Fh                         ; mask out 4 high-order bits

    ;call printnybble on lower 4 bits of character
    call printnybble

    ; write a space character to stdout
    mov eax, SYS_WRITE                  ; specify sys_write system call
    mov ebx, STDOUT                     ; specify standard output as the file descriptor
    mov ecx, space                      ; pass address of the space character in memory
    mov edx, 1                          ; space character is one byte long
    int 80h                             ; make sys_write system call to write the newline to stdout

    ; count input characters have been represented on the current line of output
    inc byte [charcount]                ; increment the count of characters on the current output line
    
    ; jump to top of loop if max characters per line not yet reached
    cmp byte [charcount], BYTESPERLINE  ; compare the character count with the max bytes per line
    jb read                             ; continue from top of main loop if max count for line not yet reached
    
    ; write a newline character to stdout
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Specify File Descriptor 1: Standard output
    mov ecx, newline                    ; Pass offset of the newline character
    mov edx, 1                          ; Newline character is one byte long
    int 80h                             ; make sys_write system call to write the newline to stdout
    
    ; start counting characters on the next next line
    mov byte [charcount], 0             ; reset character counter to zero

    ; continue by reading next character
    jmp read
    
exit:

    ; exit the program
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program


; ************************************************
; Routine:  printnybble
;
; Register arguments:   
;
;   AL -- Must contain a value between 0 and 15
;         corresponding to the nybble to convert to
;         the corresponding ASCII character in 
;         hexadecimal, i.e. 0-F. 
;
; Registers affected:   EAX, EBX, ECX, EDX, EFLAGS
; Variables affected:   outbuffer
; ************************************************

printnybble:
    
    ; if nybble is less than ten, add '0' to it
    cmp al, 9                          ; compare nybble in AL with 9
    ja tenorgreater                    ; if it's 10 or more handle as such 
    add al, '0'                        ; add the ASCII code of 0 to nybble value
    jmp printchar                      ; print character corresponding to original nybble value
    
tenorgreater:
    
    ; otherwise offset nybble value by the ASCII value of 'A' minus ten
    add al, 'A' - 10                   ; calcualte ASCII code of original nybble value
    
printchar:

    ; write ASCII code of nybble to output buffer
    mov [outbuffer], al                 ; put ASCII code of character to output in the output buffer

    ; write a newline character to stdout
    mov eax, SYS_WRITE                  ; specify sys_write system call
    mov ebx, STDOUT                     ; specify standard output
    mov ecx, outbuffer                  ; pass address of output buffer
    mov edx, 1                          ; character is one byte long
    int 80h                             ; make sys_write system call to write the character to stdout

    ; return to caller
    ret                                 ; return to main routine

; ******************************************************************************
;   Name:           HexDump
;   Version:        2.0
;   Date created:   12Dec2010
;   Last modified:  12Dec2010
;   Author:         Timothy M. McPhillips
;   Description:    Program that displays the contents of any file in hex format.

; ****************************  C O N S T A N T S  *****************************

; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT        equ     01h
SYS_READ        equ     03h
SYS_WRITE       equ     04h

; file descriptors for default I/O streams 
STDIN           equ     0
STDOUT          equ     1

; ASCII codes of delimiter characters
SPACE:          equ     2Eh                 ; space character for delimiting bytes of output
NEWLINE:        equ     0Ah                 ; newline character for delimiting lines of output


; application configuration
INBUFFSIZE      equ     16              ; number of input bytes to display in hex per line
OUTBUFFSIZE     equ     INBUFFSIZE * 3  ; size of output buffer for displaying hex characters 


; ********************************  D A T A  ***********************************

SECTION .data                           ; Section containing initialized data

hexdigits:      db  "0123456789ABCDEF"  ; Lookup table for converting nybbles to hex digits

; *********************************** B S S ************************************

SECTION .bss                            ; Section containing unitialized data

bytesread:      resb    1               ; Reserve one byte for storing number of bytes read
inbuffer:       resb    INBUFFSIZE      ; Reserve a buffer for input bytes
outbuffer:      resb    OUTBUFFSIZE     ; Reserve a buffer for output characters

; ********************************  C O D E  ***********************************

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker


; **************************************
; Routine: Main
;
; Register usage:
;   EAX -- system service number for int80 calls
;       -- return value from system calls
;       --  
; **************************************

_start:

    nop                                 ; This no-op keeps gdb happy

read:

    ; read next block of characters from stdin
    mov eax, SYS_READ                   ; specify the sys_read system call
    mov ebx, STDIN                      ; specify standard input
    mov ecx, inbuffer                   ; specify address to put read character
    mov edx, INBUFFSIZE                 ; specify number of characters to read from stdin
    int 80h                             ; make sys_read system call to read characters from stdin

    ; jump to program exit if stdin has closed
    cmp eax, 0                          ; compare sys_read return value (character read count) with zero
    je exit                             ; jump to exit if no character was read

    ; store the latest number of bytes read
    mov byte [bytesread], al
    
    ; prepare to scan input buffer and to store results in output buffer 
    mov ecx, eax                        ; store latest number of bytes read in counter register ECX
    mov esi, inbuffer                   ; put the address of the start of the input buffer into ESI
    mov edi, outbuffer                  ; put the address of the start of the output buffer into EDI

 scan:

    ; put four high order bits of next character in lower 4 bits of AL
    mov al, byte [esi]                  ; load character from current position in inbuffer into AL
    mov bl, al                          ; copy the character into BL for later use as well
    and eax, 0F0H                       ; mask out all bits in EAX other high nybble of AL
    shr al, 4                           ; shift right 4 bits to isolate upper nybble

    ; copy hex digit corresponding to nybble in next slot in output buffer
    lea eax, [hexdigits + eax]          ; get address of hex digit corresponding to nybble
    mov al, byte [eax]                  ; copy hex digit into EAX
    mov byte [edi], al                  ; store hex digit in output buffer

    ; point at next byte in output buffer
    inc edi                             ; increment destination pointer
    
    ; put four high order bits of character in lower 4 bits of AL
    and ebx, 00Fh                       ; mask out all but lowest 4 high-order bits

    ; copy hex digit corresponding to nybble in next slot in output buffer
    lea eax, [hexdigits + ebx]          ; get address of hex digit corresponding to nybble
    mov al, byte [eax]                  ; copy hex digit into EBX
    mov byte [edi], al                  ; store hex digit in output buffer

    ; point at next byte in output buffer
    inc edi                             ; increment destination pointer

    ; write a space character to next slot in output buffer
    mov byte [edi], SPACE               ; copy space character to output buffer

    ; point at next byte in output buffer
    inc edi                             ; increment destination pointer

    ; point at next bye in input buffer
    inc esi

    ; loop back to scan until counter ECX is zero
    loop scan                           ; decrement ECX and jump to scan if ECX is nonzero
    
    ; write a newline to next slot in output buffer
    mov byte [edi], NEWLINE            ; copy space character to output buffer

    ; calculate number of characters in out buffer to write
    mov ecx, 0                          ; zero out ECX 
    mov cl, byte [bytesread]            ; move into CL the number of bytes
    mov edx, ecx                        ; copy the byte count into EDX
    shl edx, 1                          ; shift EDX left to double it
    add edx, ecx                        ; add ECX to EDX to give 3 times bytes read
    inc edx                             ; add one more to accommodate the newline in the buffer
    
    ; write the output buffer to stdout
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Specify File Descriptor 1: Standard output
    mov ecx, outbuffer                  ; Pass offset of the newline character
    int 80h                             ; make sys_write system call to write the newline to stdout
    
    ; continue by reading next character
    jmp read
    
exit:

    ; exit the program
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program


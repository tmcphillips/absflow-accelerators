; ******************************************************************************
;   Name:           Debug
;   Version:        5.0
;   Date created:   22Jan2010
;   Last modified:  22Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    


; ---------------------------  C O N S T A N T S  ------------------------------

%include "common.inc"
%include "linux.inc"


; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

hexDebugValue:     db      "00000000h", 10

; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data


; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

global DebugPrintHex
extern ValueToHex

; *******************************************************************************
; DebugPrintHex:    Prints a 8-32 bit value to stdout in hexadecimal format.
; Inputs:           Value to print in EDX, number of bytes of EDX to print in ECX.
; Returns:          Nothing
; Modifies:         Nothing
; Calls:            ValueToHex, SYS_WRITE system call
; Description:      

DebugPrintHex:
    
    ; save registers
    pushad

    ; calculate offset for hex buffer address
    mov eax, 4                          ; offset of end of hex buffer is 4 words, 1 per byte of value to display
    sub eax, ecx                        ; subtract number of value bytes to display
    shl eax, 1                          ; double the offset in words to get offset in bytes
    
    ; calculate starting address for hex buffer
    mov edi, hexDebugValue              ; copy address of start of hex buffer into EDI
    add edi, eax                        ; add the offset to get effective start address for the requested number of bytes

    ; render the requested number of bytes (in ECX) of value (in EDX) as hex in memory (at EDI)     
    call ValueToHex

    ; calculate number of characters in hex buffer to print to standard error
    mov edx, 10                         ; maximum value is 8 bytes plus two for the 'h' and newline characters 
    sub edx, eax                        ; subtract the offset to get effective number of bytes to print

    ; write the EDX bytes of hex display buffer to standard error
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDERR                     ; Provide file descriptor for standard error 
    mov ecx, edi                        ; Pass address of the hex buffer
    int 80h                             ; make sys_write system call to write hex buffer to terminal

    ; restore registers
    popad
    
    ; return to caller
    ret

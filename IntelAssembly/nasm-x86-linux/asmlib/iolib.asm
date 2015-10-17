; ******************************************************************************
;   Name:           IOLib
;   Version:        5.0
;   Date created:   20Jan2010
;   Last modified:  20Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    


; ---------------------------  C O N S T A N T S  ------------------------------

%include "linux.inc"


; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

                
; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data


; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code


global PrintStringZ

; *******************************************************************************
; PrintStringZ: Print a zero terminated string to a file.
; Inputs:       Address of string in EAX, file descriptor in EBX.
; Returns:      Nothing
; Modifies:     Nothing
; Calls:        Nothing
; Description:  Scans memory for a null byte starting at the string address,
;               computes the length of the string up to the null, and prints
;               the string using the SYS_WRITE system call.

PrintStringZ:

    ; save all general purpose registers
    pushad

    ; save the start address of the string
    mov esi, eax

    ; search for the string-terminating null byte
    cld                                 ; search upwards in memory
    mov eax, 0                          ; search for a null byte
    mov edi, esi                        ; start the search at the beginning of the string
    mov ecx, 0xFFFF                     ; search no more than 64KB
    repne scasb                         ; perform the search leaving the address of the null in edi

    ; calculate the length of the string
    sub edi, esi                        ; length is adress of the null minus the start of the string

    ; write the string to the file descriptor identified by EBX
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ecx, esi                        ; Pass the address of the string
    mov edx, edi                        ; Pass the length of the string
    int 80h                             ; make sys_write system call to write the string to the file

    ; restore general purpose registers
    popad

    ; return to caller
    ret
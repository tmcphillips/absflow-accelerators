; ******************************************************************************
;   Name:           TermIOLib
;   Version:        5.0
;   Date created:   22Jan2010
;   Last modified:  22Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    


%include "common.inc"

; ---------------------------  C O N S T A N T S  ------------------------------

; kernel service numbers for Linux kernel service dispatcher
SYS_WRITE       equ     04h

; file descriptors for default I/O streams 
STDIN           equ     0
STDOUT          equ     1
STDERR          equ     2
    
; define shorthands for control characters
ESC             equ     27

; define library specific contants
MAX_DISP_COLS   equ 255
MAX_DISP_ROWS   equ 255

; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

; start of composite escape sequence to clear terminal and home cursor
clearAndHome:

; define escape sequence for clearing terminal
clearTerm:      db      ESC, "[2J"
clearTermLen:   equ     $-clearTerm

; define escape sequence for placing cursor in top left-hand corner of screen
homeCursor:     db      ESC, "[01;01H"
homeCursorLen:  equ     $-homeCursor
                
; calculate length of clear-and-home escape sequence
clearHomeLen:   equ     $-clearAndHome

; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data

; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

; exported procedures
global ClearTerm, ClearTermAndHome

; *******************************************************************************
; ClearTerm:        Clear the terminal screen.
; Inputs:           Nothing
; Returns:          Nothing
; Modifies:         Nothing
; Calls:            SYS_WRITE system call
; Description:      Writes a fixed escape sequence to the terminal that causes it to clear.

ClearTerm:

    ; save registers
    PushDataRegisters
    
    ; write the string to the file descriptor identified by EBX
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Provide file descriptor for standard out 
    mov ecx, clearTerm                  ; Pass address of screen clearing escape sequence
    mov edx, clearTermLen               ; Pass the length of the screen clearing escape sequence
    int 80h                             ; make sys_write system call to write the string to the file
    
    ; restore registers
    PopDataRegisters

    ; return to caller
    ret


; *******************************************************************************
; ClearTermAndHome: Clear the terminal screen and move cursor to top left-hand corner 
;                   of console.
; Inputs:           Nothing
; Returns:          Nothing
; Modifies:         Nothing
; Calls:            SYS_WRITE system call
; Description:      Writes two fixed escape sequences to the terminal to first clear
;                   the terminal and then to position the cursor in the top left corner.

ClearTermAndHome:

    ; save data registers
    PushDataRegisters

    ; write the string to the file descriptor identified by EBX
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Provide file descriptor for standard out 
    mov ecx, clearAndHome               ; Pass address of screen clearing escape sequence
    mov edx, clearHomeLen               ; Pass the length of the screen clearing escape sequence
    int 80h                             ; make sys_write system call to write the string to the file
    
    ; restore data registers
    PopDataRegisters

    ; return to caller
    ret    
    
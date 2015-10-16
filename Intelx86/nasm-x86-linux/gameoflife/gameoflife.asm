; ******************************************************************************
;   Name:           HexDump
;   Version:        5.0
;   Date created:   18Jan2010
;   Last modified:  18Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    Program that displays the contents of any file in hex format.
;                   Takes a single file name as an argument or reads from stdin
;                   if no argument is given.


; ---------------------------  C O N S T A N T S  ------------------------------

%include "../asmlib/linux.inc"
%include "../asmlib/debug.inc"
%include "../asmlib/virtdisplay.inc"

; application configuration
GRIDWIDTH   equ     4                                   ; width of the game grid in cells
GRIDHEIGHT  equ     7                                   ; height of the game grid in cells
; --------------------------------  D A T A  -----------------------------------

SECTION .data                                           ; Section containing initialized data


; ----------------------------------  B S S  -----------------------------------

SECTION .bss                                        ; Section containing unitialized data

; reserve space for display buffer sufficient for maximum possible virtual display size
gridOne:    resb    VirtDisplay_GetSize(GRIDWIDTH, GRIDHEIGHT)
gridTwo:    resb    VirtDisplay_GetSize(GRIDWIDTH, GRIDHEIGHT)
     
; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

extern  DebugPrint
extern VirtDisplay_Clear, VirtDisplay_Show, VirtDisplay_Init

global _start                           ; export entry point to linker


_start:

    nop                                 ; provide a instruction on which to set a gdb breakpoint

    ; set up stack frame for program
    mov ebp, esp                        ; save address of initial top of stack in ESP

    mov eax, GRIDWIDTH
    mov ebx, GRIDHEIGHT

    mov esi, gridOne
    call VirtDisplay_Init

    mov esi, gridTwo
    call VirtDisplay_Init
    
    mov esi, gridTwo
    call VirtDisplay_Clear

    mov esi, gridTwo
    call VirtDisplay_Show
           
exit:

    ; exit the program
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program

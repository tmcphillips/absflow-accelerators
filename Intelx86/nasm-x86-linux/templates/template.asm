; ******************************************************************************
;   Name:           ############
;   Version:        1.0
;   Date created:   #########
;   Last modified:  #########
;   Author:         Timothy M. McPhillips
;   Description:    ############################################### 

; ****************************  C O N S T A N T S  *****************************

; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT    equ     01h

; ********************************  D A T A  ***********************************

SECTION .data           ; Section containing initialized data


; *********************************** B S S ************************************

SECTION .bss            ; Section containing unitialized data

; ********************************  C O D E  ***********************************

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker

_start:

    nop                                 ; This no-op keeps gdb happy
	

exit:

    ; exit
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program

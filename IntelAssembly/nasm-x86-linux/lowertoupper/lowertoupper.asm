; ******************************************************************************
;   Name:           LowerToUpper
;   Version:        1.0
;   Date created:   11Dec2010
;   Last modified:  12Dec2010
;   Author:         Timothy M. McPhillips
;   Description:    Text-file filter program that converts lowercase
;                   letters to uppercase equivalents. 

; ****************************  C O N S T A N T S  *****************************

; application-specific constants

CASE_DELTA  equ      2Eh        ; Difference in ASCII codes for upper and 
                                ; lower case letters
BUFFER_SIZE equ     1024        ; Maximum size of the character buffer is 1 KB

; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT    equ     01h         ; service number for sys_exit system call
SYS_READ    equ     03h         ; service number for sys_read system call
SYS_WRITE   equ     04h         ; service number for sys_write system call

; file descriptors for default I/O streams 
STDIN       equ     0           ; file descriptor for standard input
STDOUT      equ     1           ; file descriptor for standard output


; ********************************  D A T A  ***********************************

SECTION .data                           ; Section containing initialized data

; *********************************** B S S ************************************

SECTION .bss                            ; Section containing unitialized data

buffer:         resb    BUFFER_SIZE     ; Reserve the buffer for characters

charcount:      resd   1                ; Reserve a 32-bit doubleword for holding 
                                        ; number of characters currently in buffer

; ********************************  C O D E  ***********************************

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker

_start:

    nop                                 ; This no-op keeps gdb happy
	
read:

    ; read a block of characters from stdin
    mov eax, SYS_READ                   ; specify the sys_read system call
    mov ebx, STDIN                      ; specify standard input
    mov ecx, buffer                     ; specify address of buffer in which to store read characters
    mov edx, BUFFER_SIZE                ; specify that up to BUFFER_SIZE characters are to be read
    int 80h                             ; make sys_read system call to read the characters from stdin
    
    ; jump to program exit if stdin has closed
    cmp eax, 0                          ; compare sys_read return value (character read count) with zero
    je exit                             ; jump to exit if no character was read (end of file)

    ; store number of characters just read into the buffer 
    mov dword [charcount], eax          ; copy system call return value into charcount variable
    mov ecx, eax                        ; copy the same value into a index for scanning the buffer

    ; loop over input buffer
    mov ebp, buffer                     ; put the address of the start of the buffer into EBP
    dec ebp                             ; decrease the address in EBP by one so when index ECX is 1 the 
                                        ; the sum of EBP and the ECX is the start of the buffer
    
 scan:

    ; skip case conversion if buffered character is not a lowercase letter
    cmp byte [ebp + ecx], 'a'           ; compare buffered character with ASCII code for 'a'
    jb nextchar                         ; jump to write if it is below this code
    cmp byte [ebp + ecx], 'z'           ; compare buffered character with ASCII code for 'z'
    ja nextchar                         ; jump to write if it is above this code
    
    ; convert lowercase letter to uppercase
    sub byte [ebp + ecx], CASE_DELTA    ; substract offset between lower and upper case letter ASCII codes
    
nextchar:

    ; loop back to scan until buffer index ECX is zero
    loop scan                           ; decrement ECX and jump to scan if ECX is nonzero
    
write:

    ; write the modified buffer contents to stdout
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Specify File Descriptor 1: Standard output
    mov ecx, buffer                     ; Pass offset of the message
    mov edx, [charcount]                ; Pass the length of the message
    int 80h                             ; make sys_write system call to write current character to stdout

    ; continue by reading next character
    jmp read

exit:

    ; exit
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program

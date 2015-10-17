; ******************************************************************************
;   Name:           HexDump
;   Version:        3.0
;   Date created:   13Jan2010
;   Last modified:  15Jan2010
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
SPACES:         equ     20202020h           ; a doubleword of 4 space characters for blanking output line
NEWLINE:        equ     0Ah                 ; newline character for delimiting lines of output

; application configuration
BYTESPERLINE    equ     16                  ; number of input bytes to display in hex per line
SPACERWIDTH     equ     2                   ; number of blank spaces between hex display and character display (minimum is 1)
DOT             equ     2Eh                 ; character used to replace unprintable characters in display

; ********************************  D A T A  ***********************************

SECTION .data                           ; Section containing initialized data

; lookup table for converting nybbles to hex digits
hexdigits:      db      "0123456789ABCDEF"  

; translation table for converting unprintable characters to dots
printables:     db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, 21h, 22h, 23h, 24h, 25h, 26h, 27h, 28h, 29h, 2Ah, 2Bh, 2Ch, 2Dh, 2Eh, 2Fh
                db      30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 3Ah, 3Bh, 3Ch, 3Dh, 3Eh, 3Fh
                db      40h, 41h, 42h, 43h, 44h, 45h, 46h, 47h, 48h, 49h, 4Ah, 4Bh, 4Ch, 4Dh, 4Eh, 4Fh
                db      50h, 51h, 52h, 53h, 54h, 55h, 56h, 57h, 58h, 59h, 5Ah, 5Bh, 5Ch, 5Dh, 5Eh, 5Fh
                db      60h, 61h, 62h, 63h, 64h, 65h, 66h, 67h, 68h, 69h, 6Ah, 6Bh, 6Ch, 6Dh, 6Eh, 6Fh
                db      70h, 71h, 72h, 73h, 74h, 75h, 76h, 77h, 78h, 79h, 7Ah, 7Bh, 7Ch, 7Dh, 7Eh, 3Eh
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                db      DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT, DOT
                
; *********************************** B S S ************************************

SECTION .bss                            ; Section containing unitialized data

; Reserve a buffer for input bytes
inbuffer:       resb    BYTESPERLINE      

 ; Reserve a buffer for output characters
hexdisplay:     resb    BYTESPERLINE * 3      ; reserve one byte for each of the two hex digits plus one for a space
spacer:         resb    SPACERWIDTH - 1       ; reserve blank space between hex display and character display
chardisplay:    resb    BYTESPERLINE + 2      ; reserve one byte for each character to display plus a two-byte separator 
endofline:      resb    1                     ; reserve one byte for the newline character
DISPLAYSIZE     equ     $-hexdisplay          ; calculate width of display line

; Reserve an extra four bytes to make it safe to blank line four bytes at a time for any value of DISPLAYSIZE 
extra:          resb 4


; ********************************  C O D E  ***********************************

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker


; **************************************
; Routine: Main
; **************************************

_start:

    nop                                 ; provide a instruction on which to set a gdb breakpoint

clear:

    ; write spaces four at a time to clear display buffer
    cld                                 ; set direction flag for upward string operations
    mov eax, SPACES                     ; provide four space characters for writing to the display buffer
    mov edi, hexdisplay                 ; provide the address of the display buffer
    mov ecx, DISPLAYSIZE/4 + 1          ; give the size of the buffer in doublewords rounding up
    rep stosd                           ; fill the display buffer with space characters by doublewords

    ; write a new line to end of the buffer
    mov byte [endofline], NEWLINE

read:

    ; read next block of bytes from stdin
    mov eax, SYS_READ                   ; specify the sys_read system call
    mov ebx, STDIN                      ; specify standard input
    mov ecx, inbuffer                   ; specify address to put read byte
    mov edx, BYTESPERLINE               ; specify number of bytes to read from stdin
    int 80h                             ; make sys_read system call to read bytes from stdin

    ; jump to program exit if stdin has closed
    cmp eax, 0                          ; compare sys_read return value (byte read count) with zero
    je exit                             ; jump to exit if no character was read

    ; prepare to scan input buffer and to store results in output buffer 
    mov ecx, eax                        ; put the number of bytes read in ECX
    mov esi, 0                          ; initialize source byte index    
    mov ebx, printables                 ; load address of printables translation table into EBX

 scan:
 
    ; get current byte from input buffer
    mov dl, byte [inbuffer + esi]       ; load byte from current position in inbuffer into DL
    
    ; write pintable representation of current byte to character display buffer
    mov al, dl                          ; load the current byte into AL
    xlat                                ; translate byte in AL to a printable character if needed
    mov byte [chardisplay + esi], al    ; copy translated byte to its position in the character display buffer
    
    ; put four high order bits of current byte in lower 4 bits of AL
    mov al, dl                          ; laod the current byte into AL
    and eax, 0F0H                       ; mask out all bits in EAX other than high nybbble of current byte
    shr al, 4                           ; shift right 4 bits to isolate upper nybble

    ; calculate position in hex display buffer for displaying representation of current byte
    lea edi, [esi + 2 * esi]            ; offset into hex display is 3 times the index into the input buffer

    ; write hex digit corresponding to upper nybble in next slot in output buffer
    mov al, byte [hexdigits + eax]      ; copy hex digit corresponding to upper nybble into EAX
    mov byte [hexdisplay + edi], al     ; store hex digit in current position in output buffer
    
    ; put lower nybble bits of character in lower 4 bits of DL
    and edx, 0Fh                       ; mask out all but lowest 4 high-order bits of EDX

    ; copy hex digit corresponding to nybble in next slot in output buffer
    mov dl, byte [hexdigits + edx]      ; copy hex digit corresponding to lower nybble into EDX
    mov byte [hexdisplay + edi + 1], dl ; store hex digit in current position in output buffer

    ; increment index into input buffer
    inc esi

    ; loop back to scan until all bytes in input buffer have been dumped to the display buffer
    loop scan                           ; decrement ECX and jump to scan if ECX is nonzero
     
    ; write the output buffer to stdout
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Specify standard output as destination
    mov ecx, hexdisplay                 ; Pass address of the ouput display buffer
    mov edx, DISPLAYSIZE                ; Pass the size of the display buffer
    int 80h                             ; make sys_write system call to write the display buffer stdout
    
    ; continue reading bytes from input
    jmp clear                           ; go to top of main loop
    
exit:

    ; exit the program
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program
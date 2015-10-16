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

; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT        equ     01h
SYS_READ        equ     03h
SYS_WRITE       equ     04h
SYS_OPEN        equ     05h

; file descriptors for default I/O streams 
STDIN           equ     0
STDOUT          equ     1
STDERR          equ     2

; ASCII codes of delimiter characters
SPACES:         equ     20202020h           ; a doubleword of 4 space characters for blanking output line
NEWLINE:        equ     0Ah                 ; newline character for delimiting lines of output

; application configuration
BYTESPERLINE    equ     16                  ; number of input bytes to display in hex per line
ADDHEXSPACER    equ     2                   ; number of spaces between address and hex
HEXCHARSPACER   equ     2                   ; number of blank spaces between hex display and character display
DOT             equ     2Eh                 ; character used to replace unprintable characters in display


; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

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
                
                
; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data

; Reserve a doubleword for the handle of the input file
inputfile:      resd    1


; Reserve a buffer for input bytes
inbuffer:       resb    BYTESPERLINE      

 ; Reserve a buffer for output characters
displayline:
addressdisplay: resb    8                     ; reserve 8 bytes for the relative address of each line plus two spaces
                resb    ADDHEXSPACER          ; reserve a spacer between the address and the hex display
hexdisplay:     resb    BYTESPERLINE * 3 - 1  ; reserve for the hex display two bytes for the hex plus one for a space between byte displayed
                resb    HEXCHARSPACER         ; reserve blank space between hex display and character display (subtracting last blank of hex display)
chardisplay:    resb    BYTESPERLINE          ; reserve a spacer between the hex display and the character display 
endofline:      resb    1                     ; reserve one byte for the newline character
DISPLAYSIZE     equ     $-displayline         ; calculate width of display line

; Reserve an extra four bytes to make it safe to blank line four bytes at a time for any value of DISPLAYSIZE 
extra:          resb 4


; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

global _start                           ; export entry point to linker


extern ByteToHex
extern ValueToHex
extern PrintSysErr

; **************************************
; Routine: Main
; **************************************

_start:

    nop                                 ; provide a instruction on which to set a gdb breakpoint

    ; set up stack frame for program
    mov ebp, esp                        ; save address of initial top of stack in ESP
    
    ; inspect command argument count to see if a file name was provided
    mov eax, [ebp]                      ; load number of command line arguments
    cmp eax, 1                          ; see if any argument was provided (a value of 1 means no arguments)
    je getstdin                         ; will read standard input if no argument
       
openfile:
    
    ; open the input file named by the first argument
    mov eax, SYS_OPEN                   ; specify the sys_open system call
    mov ebx, [ebp + 8]                  ; address of file name is address of first argument to program
    mov ecx, 0                          ; specify address to put read bytes
    mov edx, 0                          ; specify number of bytes to read from stdin
    int 80h
    
    cmp eax, 0
    jl error

    mov [inputfile], eax

    jmp init
       
getstdin:

    mov dword [inputfile], STDIN
 
init:

    ; initialize state
    mov ebp, 0                          ; set address counter to zero

clear:

    ; write spaces four at a time to clear display buffer
    cld                                 ; set direction flag for upward string operations
    mov eax, SPACES                     ; provide four space characters for writing to the display buffer
    mov edi, displayline                ; provide the address of the display buffer
    mov ecx, DISPLAYSIZE/4 + 1          ; give the size of the buffer in doublewords rounding up
    rep stosd                           ; fill the display buffer with space characters by doublewords

    ; write a new line to end of the buffer
    mov byte [endofline], NEWLINE

read:

    ; read next block of bytes from stdin
    mov eax, SYS_READ                   ; specify the sys_read system call
    mov ebx, [inputfile]                ; specify standard input
    mov ecx, inbuffer                   ; specify address to put read bytes
    mov edx, BYTESPERLINE               ; specify number of bytes to read from stdin
    int 80h                             ; make sys_read system call to read bytes from stdin

    ; jump to program exit if stdin has closed
    cmp eax, 0                          ; compare sys_read return value (byte read count) with zero
    je exit                             ; jump to exit if no character was read

    ; store the number of bytes read from stdin
;    mov ecx, eax                        ; the return value from sys_read is the number of bytes read if positive

    ; render the address of the bytes just read relative to the start of the input file
    mov ecx, 4
    mov edx, ebp                        ; copy current offset in file into EDX
    mov edi, addressdisplay             ; provide the destination in memory to which the address is to be rendered
    call ValueToHex                     ; render the current offset as a doubleword in hex

    ; store the number of bytes read from stdin
    mov ecx, eax                        ; the return value from sys_read is the number of bytes read if positive

    ; update the input stream offset counter for the next iteration
    add ebp, ecx                        ; add the number of bytes last read from stdin to the offset

    ; prepare to scan input buffer and to store results in output buffer 
    mov esi, 0                          ; initialize source byte index 

 scan:
 
    ; get current byte from input buffer
    xor edx, edx                        ; clear EDX in preparation for using DL
    mov dl, byte [inbuffer + esi]       ; load byte from current position in input buffer into DL
    
    ; write printable representation of current byte to character display buffer
    mov eax, edx                        ; load the current byte into AL and wipe out higher-order bytes of EAX
    mov ebx, printables                 ; load address of printables translation table into EBX
    xlat                                ; translate byte in AL to a printable character if needed
    mov byte [chardisplay + esi], al    ; copy translated byte to its position in the character display buffer
    
    ; render current byte to memory as two hex digits
    mov al, dl                          ; load the current byte into AL
    lea edi, [hexdisplay + esi + 2*esi] ; offset into hex display is 3 times the index into the input buffer
    call ByteToHex                      ; render the current byte as hex
    
    ; increment index into input buffer
    inc esi

    ; keeping scanning over input buffer until all bytes in it have been dumped to the display buffer
    loop scan                           ; decrement the input byte counter and iterate if there are any left
     
    ; write the output buffer to stdout
    mov eax, SYS_WRITE                  ; Specify sys_write system call
    mov ebx, STDOUT                     ; Specify standard output as destination
    mov ecx, displayline                ; Pass address of the ouput display buffer
    mov edx, DISPLAYSIZE                ; Pass the size of the display buffer
    int 80h                             ; make sys_write system call to write the display buffer stdout
    
    ; continue reading bytes from input
    jmp clear                           ; go to top of main loop
    
exit:

    ; exit the program
    mov eax, SYS_EXIT                   ; specify sys_exit system call
    mov ebx, 0                          ; return a zero indicating success
    int 80h                             ; make sys_exit system call terminate the program

error:

    call PrintSysErr
    
    jmp exit

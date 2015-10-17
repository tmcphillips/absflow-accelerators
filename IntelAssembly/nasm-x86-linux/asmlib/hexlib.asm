; ******************************************************************************
;   Name:           HexLib
;   Version:        5.0
;   Date created:   18Jan2010
;   Last modified:  18Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    Program that displays the contents of any file in hex format.
;                   Takes a single file name as an argument or reads from stdin
;                   if no argument is given.


; ---------------------------  C O N S T A N T S  ------------------------------


; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

; lookup table for converting nybbles to hex digits
hexdigits:      db      "0123456789ABCDEF"  
                
; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data


; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

; exported procedures
global ByteToHex, ValueToHex


; *******************************************************************************
; ByteToHex:    Render a single byte as two hexadecimal characters in memory.
; Inputs:       Byte to render as hex in EAX, destination of hex in EDI
; Returns:      Nothing
; Modifies:     EAX
; Calls:        Nothing
; Description:  Uses a lookup table to convert each nybble of AL to a hex
;               character and writes the two hex characters to memory.

ByteToHex:

    ; save input byte for extracting lower nybble later
    push eax

    ; write to memory hex character corresponding to upper nybble of input byte
    shr al, 4                           ; shift AL right 4 bits to isolate upper nybble
    mov al, byte [hexdigits + eax]     ; look up hex character corresponding to first nybble of input byte
    mov byte [edi], al                  ; store first hex character at requested address

    ; retreive saved copy of input byte
    pop eax

    ; write to memory hex charactdr corresponding to lower nybble of input byte
    and eax, 0Fh                        ; isolate lower nybble of input byte by masking out upper four bits
    mov al, byte [hexdigits + eax]     ; look up hex character corresponding to lower nybble of input byte
    mov byte [edi + 1], al              ; store second hex digit at requested address plus one

    ; return to caller
    ret

; *******************************************************************************
; ValueToHex:   Render a 1-4 byte value to hexadecimal characters in memory.
; Inputs:       Value to render as hex in EDX; number of bytes to render 
;               in ECX; destination of hex in EDI.
; Returns:      None
; Modifies:     EAX, EDX, EDI
; Calls:        ByteToHex
; Description:  Renders 1-4 bytes of EDX with a call to ByteToHex each, starting 
;               with the low-order byte. Each call to ByteToHex points to a 
;               successively lower address in memory.  Two bytes of memory are
;               are required for each byte in EDX to be rendered.
; *******************************************************************************

ValueToHex:

    ; save EAX and EBX registers
    push eax
    push ebx

    ; prepare to iterate over ECX bytes in the input doubleword
    mov ebx, edi                        ; store the destination address in EBX

.loopOverBytes:
    
    ; render current byte of input doubleword as hex
    mov al, dl                          ; copy byte in DL to AL
    and eax, 0FFh                       ; mask out 3 higher-order bytes of EAX
    lea edi, [ebx + 2 * ecx - 2]        ; calculate address to write hex for this byte
    call ByteToHex                      ; convert the current byte to hex
    
    ; move the next byte of the input doubleword into DL
    shr edx, 8                          

    ; keep iterating over bytes until all have been rendered as hex
    loop .loopOverBytes                 ; decrement the loop counter and iterate if nonzero
    
.exit:

    ; restore registers EAX and EBX
    pop ebx
    pop eax
        
    ; return to caller
    ret
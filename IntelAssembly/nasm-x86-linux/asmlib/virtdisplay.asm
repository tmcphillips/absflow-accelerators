; ******************************************************************************
;   Name:           VirtDisplay
;   Version:        5.0
;   Date created:   22Jan2010
;   Last modified:  22Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    


; ---------------------------  C O N S T A N T S  ------------------------------


%include "common.inc"
%include "linux.inc"
%include "debug.inc"
%include "virtdisplay.inc"

; ASCII codes of delimiter characters
SPACES:         equ     30303030h           ; a doubleword of 4 space characters for blanking virtual display
NEWLINE:        equ     0Ah                 ; newline character for delimiting lines of output

; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data


; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data

; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code



global VirtDisplay_Init

VirtDisplay_Init:

    push eax

    mov dword [esi + vdisplay.width], eax
    mov dword [esi + vdisplay.height], ebx
    
    inc eax
    mul bl
    
    mov dword [esi + vdisplay.sizeb], eax
    
    shr eax, 2
    inc eax
    
    mov dword [esi + vdisplay.sized], eax

    pop eax

    ret


; *******************************************************************************
; VirtDisplay_Clear:    Clear the virtual display.
; Inputs:               Nothing
; Returns:              Address of vdisplay structure in ESI.
; Modifies:             Nothing
; Calls:                Nothing
; Description:          Writes spaces to virtual display and terminates each row
;                       of display with a newline

global VirtDisplay_Clear

VirtDisplay_Clear:

    ; save general purpose registers
    pushad

    ; calculate address of display array
    lea edx, [esi + vdisplay.array]         ; store beginning of display array in EDX
    
    ; write spaces four at a time to clear entire display array in one shot
    cld                                     ; set direction flag for upward string operations
    mov edi, edx                            ; copy address of display array to EDI
    mov eax, SPACES                         ; provide four space characters for writing to the display array
    mov ecx, [esi + vdisplay.sized]         ; store size of display array in doublewords in ECX
    rep stosd                               ; fill the display buffer with space characters by doublewords
        
    ; prepare to write newlines to character at end each row of display buffer
    mov edi, edx                            ; copy address of display array to EDI
    mov al, NEWLINE                         ; put ASCII code for newline in AL
    mov ecx, [esi + vdisplay.height]        ; store number of display rows in ECX
    mov edx, [esi + vdisplay.width]         ; store width of display array in EDX
        
    ; loop over rows in display, putting a newline at the end of each
.newlines:
    add edi, edx                            ; point EDI at final character of current display row by adding display width to it   
    stosb                                   ; store a newline at EDI and increment EDI
    loop .newlines                          ; iterate while still have rows to operate on
    
.return:
    
    ; restore general purpose registers
    popad

    ; return to caller
    ret


; *******************************************************************************
; VirtDisplay_Show: Render virtual display to terminal window.
; Inputs:           Address of vdisplay structure in ESI.                   
; Returns:          Nothing
; Modifies:         Nothing
; Calls:            ClearTermAndHome, and SYS_WRITE system call.
; Description:      Writes spaces to virtual display.

extern ClearTermAndHome
global VirtDisplay_Show

VirtDisplay_Show:

    ; save used registers
    PushDataRegisters
    
    ; clear the terminal
    call ClearTermAndHome

    ; write EDX-long buffer at ECX to the terminal window
    mov eax, SYS_WRITE                      ; Specify sys_write system call
    mov ebx, STDOUT                         ; Provide file descriptor for standard out 
    lea ecx, [esi + vdisplay.array]         ; Pass address of the virtual display
    mov edx, [esi + vdisplay.sizeb]         ; Pass the length of the virtual display in bytes
    int 80h                                 ; make sys_write system call to write virtual display to terminal

    ; restore used registers
    PopDataRegisters

    ; return to caller
    ret
    
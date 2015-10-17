
extern DebugPrintHex
extern PrintStringZ


%macro DebugPrintHexReg32 1-2 ""
%ifdef DEBUG
    pushad
    jmp %%endstr
    %defstr LINESTR __LINE__
    %%str: db "[", __FILE__, ":", LINESTR, "] " ,%2, 0
    %%endstr:
    mov eax, %%str
    mov ebx, STDERR 
    call PrintStringZ
    mov edx, %1
    mov ecx, 4
    call DebugPrintHex
    popad
%endif
%endmacro


%macro DebugPrintHexMem8 1
    push ecx
    push edx
    mov ecx, 1
    mov dl, byte [%1]
    call DebugPrintHex
    pop edx
    pop ecx
%endmacro

%macro DebugPrintHexMem16 1
    push ecx
    push edx
    mov ecx, 2
    mov dx, word [%1]
    call DebugPrintHex
    pop edx
    pop ecx
%endmacro

%macro DebugPrintHexMem24 1
    push ecx
    push edx
    mov ecx, 3
    mov edx, dword [%1]
    call DebugPrintHex
    pop edx
    pop ecx
%endmacro

%macro DebugPrintHexMem32 1
    push ecx
    push edx
    mov ecx, 4
    mov edx, dword [%1]
    call DebugPrintHex
    pop edx
    pop ecx
%endmacro

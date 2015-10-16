

; ------------------------------  M A C R O S  ---------------------------------

%macro PushDataRegisters 0
    push eax
    push ebx
    push ecx
    push edx
%endmacro

%macro PopDataRegisters 0
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro


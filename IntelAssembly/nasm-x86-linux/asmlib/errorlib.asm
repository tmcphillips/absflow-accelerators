; ******************************************************************************
;   Name:           ErrorLib
;   Version:        5.0
;   Date created:   20Jan2010
;   Last modified:  20Jan2010
;   Author:         Timothy M. McPhillips
;   Description:    


; ---------------------------  C O N S T A N T S  ------------------------------

%include "linux.inc"

; --------------------------------  D A T A  -----------------------------------

SECTION .data                           ; Section containing initialized data

; linux system error messages named according to their ERRNO codes
EPERM_Text:     db      "Operation not permitted", 10, 0
ENOENT_Text:    db      "No such file or directory", 10, 0
ESRCH_Text:     db      "No such process", 10, 0
EINTR_Text:     db      "Interrupted system call", 10, 0
EIO_Text:       db      "I/O error", 10, 0
ENXIO_Text:     db      "No such device or address", 10, 0
E2BIG_Text:     db      "Argument list too long", 10, 0
ENOEXEC_Text:   db      "Exec format error", 10, 0
EBADF_Text:     db      "Bad file number", 10, 0
ECHILD_Text:    db      "No child processes", 10, 0
EAGAIN_Text:    db      "Try again", 10, 0
ENOMEM_Text:    db      "Out of memory", 10, 0
EACCES_Text:    db      "Permission denied", 10, 0
EFAULT_Text:    db      "Bad address", 10, 0
ENOTBLK_Text:   db      "Block device required", 10, 0
EBUSY_Text:     db      "Device or resource busy", 10, 0
EEXIST_Text:    db      "File exists", 10, 0
EXDEV_Text:     db      "Cross-device link", 10, 0
ENODEV_Text:    db      "No such device", 10, 0
ENOTDIR_Text:   db      "Not a directory", 10, 0
EISDIR_Text:    db      "Is a directory", 10, 0
EINVAL_Text:    db      "Invalid argument", 10, 0
ENFILE_Text:    db      "File table overflow", 10, 0
EMFILE_Text:    db      "Too many open files", 10, 0
ENOTTY_Text:    db      "Not a typewriter", 10, 0
ETXTBSY_Text:   db      "Text file busy", 10, 0
EFBIG_Text:     db      "File too large", 10, 0
ENOSPC_Text:    db      "No space left on device", 10, 0
ESPIPE_Text:    db      "Illegal seek", 10, 0
EROFS_Text:     db      "Read-only file system", 10, 0
EMLINK_Text:    db      "Too many links", 10, 0
EPIPE_Text:     db      "Broken pipe", 10, 0
EDOM_Text:      db      "Math argument out of domain of func", 10, 0
ERANGE_Text:    db      "Math result not representable", 10, 0

; Table of errno messages
ErrMessages:
                dd      EPERM_Text
                dd      ENOENT_Text
                dd      ESRCH_Text
                dd      EINTR_Text
                dd      EIO_Text
                dd      ENXIO_Text
                dd      E2BIG_Text
                dd      ENOEXEC_Text
                dd      EBADF_Text
                dd      ECHILD_Text
                dd      EAGAIN_Text
                dd      ENOMEM_Text
                dd      EACCES_Text
                dd      EFAULT_Text
                dd      ENOTBLK_Text
                dd      EBUSY_Text
                dd      EEXIST_Text
                dd      EXDEV_Text
                dd      ENODEV_Text
                dd      ENOTDIR_Text
                dd      EISDIR_Text
                dd      EINVAL_Text
                dd      ENFILE_Text
                dd      EMFILE_Text
                dd      ENOTTY_Text
                dd      ETXTBSY_Text
                dd      EFBIG_Text
                dd      ENOSPC_Text
                dd      ESPIPE_Text
                dd      EROFS_Text
                dd      EMLINK_Text
                dd      EPIPE_Text
                dd      EDOM_Text
                dd      ERANGE_Text                
                
; ----------------------------------  B S S  -----------------------------------

SECTION .bss                            ; Section containing unitialized data


; --------------------------------  T E X T  -----------------------------------

SECTION .text                           ; section containing code

global PrintSysErr

extern PrintStringZ

; *******************************************************************************
; PrintSysErr:  Prints the message associated with system call error code.
; Inputs:       Error code returned from call in EAX.
; Returns:      Nothing
; Modifies:     EAX
; Calls:        PrintString
; Description:  Looks up address of the error message associated with the error
;               code in EAX, then prints the null-terminated message to stderr.

PrintSysErr:
    
    ; save used registers
    push ebx
    
    ; look up error message in ErrMessages table
    neg eax                             ; turn negative error code into a positive index
    mov eax, [ErrMessages + eax*4 - 4]  ; each address in table is 4 bytes, and first message has index 1
    
    ; write the message addressed by EAX to standard error
    mov ebx, STDERR                     ; specify the standard output file descriptor
    call PrintStringZ                   ; print the zero-terminated message

    ; restore registers
    pop ebx

    ; return to caller
    ret

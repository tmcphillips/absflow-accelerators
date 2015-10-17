


; kernel service numbers for Linux kernel service dispatcher
SYS_EXIT        equ     01h
SYS_READ        equ     03h
SYS_WRITE       equ     04h
SYS_OPEN        equ     05h

; file descriptors for default I/O streams 
STDIN           equ     0
STDOUT          equ     1
STDERR          equ     2

; linux ERRNO codes
ERRNO_EPERM    equ      1
ERRNO_ENOENT   equ      2
ERRNO_ESRCH    equ      3
ERRNO_EINTR    equ      4
ERRNO_EIO      equ      5
ERRNO_ENXIO    equ      6
ERRNO_E2BIG    equ      7
ERRNO_ENOEXEC  equ      8
ERRNO_EBADF    equ      9
ERRNO_ECHILD   equ      10
ERRNO_EAGAIN   equ      11
ERRNO_ENOMEM   equ      12
ERRNO_EACCES   equ      13
ERRNO_EFAULT   equ      14
ERRNO_ENOTBLK  equ      15
ERRNO_EBUSY    equ      16
ERRNO_EEXIST   equ      17
ERRNO_EXDEV    equ      18
ERRNO_ENODEV   equ      19
ERRNO_ENOTDIR  equ      20
ERRNO_EISDIR   equ      21
ERRNO_EINVAL   equ      22
ERRNO_ENFILE   equ      23
ERRNO_EMFILE   equ      24
ERRNO_ENOTTY   equ      25
ERRNO_ETXTBSY  equ      26
ERRNO_EFBIG    equ      27
ERRNO_ENOSPC   equ      28
ERRNO_ESPIPE   equ      29
ERRNO_EROFS    equ      30
ERRNO_EMLINK   equ      31
ERRNO_EPIPE    equ      32
ERRNO_EDOM     equ      33
ERRNO_ERANGE   equ      34

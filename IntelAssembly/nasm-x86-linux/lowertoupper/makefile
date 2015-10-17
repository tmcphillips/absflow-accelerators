ASM = nasm
ASM_FLAGS = -f elf -g -F stabs
OBJS = lowertoupper.o

.SUFFIXES: .o .asm

.asm.o :
	${ASM} ${ASM_FLAGS} $<

lowertoupper: lowertoupper.o
	ld -o $@ ${OBJS}

clean:
	rm -f lowertoupper ${OBJS}

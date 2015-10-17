ASM = nasm
ASM_FLAGS = -f elf -g -F stabs
OBJS = hexdump.o

.SUFFIXES: .o .asm

.asm.o :
	${ASM} ${ASM_FLAGS} $<

hexdump: hexdump.o
	ld -o $@ ${OBJS}

clean:
	rm -f hexdump ${OBJS}

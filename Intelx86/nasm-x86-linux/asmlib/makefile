ASM = nasm
ASM_FLAGS = -f elf -g -F stabs
LIBS = errorlib.o hexlib.o iolib.o termiolib.o virtdisplay.o debug.o
.SUFFIXES: .o .asm

.asm.o :
	${ASM} ${ASM_FLAGS} $<

asmlib.a: ${LIBS}
	ar -rv asmlib.a ${LIBS}

clean:
	rm -f *.o *.a

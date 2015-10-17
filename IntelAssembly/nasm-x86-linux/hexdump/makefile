ASM = nasm
ASM_FLAGS = -f elf -g -F stabs
ASM_LIB_DIR = ../asmlib
LIBS = ${ASM_LIB_DIR}/asmlib.a
INCS = ${ASM_LIB_DIR}/linux.inc
EXES = hexdump

.SUFFIXES: .o .asm

.asm.o : 
	${ASM} ${ASM_FLAGS} $<

hexdump: hexdump.o ${LIBS} ${INCS}
	ld -o $@ hexdump.o ${LIBS}

clean:
	rm -f *.o ${EXES}

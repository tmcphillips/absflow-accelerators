ASM = nasm
ASM_FLAGS = -f elf -g -F stabs -dDEBUG
ASM_LIB_DIR = ../asmlib
LIBS = ${ASM_LIB_DIR}/asmlib.a
EXES = gameoflife

.SUFFIXES: .o .asm

.asm.o : 
	${ASM} ${ASM_FLAGS} -l gameoflife.lst $<

gameoflife: gameoflife.o ${LIBS} ${INCS}
	ld -o $@ gameoflife.o ${LIBS}

clean:
	rm -f *.o ${EXES}

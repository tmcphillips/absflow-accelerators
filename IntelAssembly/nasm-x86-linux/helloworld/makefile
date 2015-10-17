
HelloWorld: HelloWorld.o
	ld -o HelloWorld HelloWorld.o

HelloWorld.o: HelloWorld.asm
	nasm -f elf -g -F stabs HelloWorld.asm

clean:
	rm -f HelloWorld *.o
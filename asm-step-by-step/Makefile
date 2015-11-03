sandbox: sandbox.o
	ld -o sandbox sandbox.o

sandbox.o:
	nasm -f elf -g -F stabs sandbox.asm -l sandbox.lst

ex01: ex01.o
	ld -o ex01 ex01.o

ex01.o:
	nasm -f elf -g -F stabs ex01.asm -l ex01.lst

ex02: ex02.o
	ld -o ex02 ex02.o

ex02.o:
	nasm -f elf -g -F stabs ex02.asm -l ex02.lst


ex03: ex03.o
	ld -o ex03 ex03.o

ex03.o:
	nasm -f elf -g -F stabs ex03.asm -l ex03.lst


ex04: ex04.o
	ld -o ex04 ex04.o

ex04.o:
	nasm -f elf -g -F stabs ex04.asm -l ex04.lst

clean:
	rm *.o *.lst sandbox ex01 ex02 ex03 ex04

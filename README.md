<pre>

------------------------------------------------------------------------------------
			nasm -f elf64 hello.asm && ld hello.o && ./a.out

Para ver qual o processador que tens que usar é "nasm -hf".
Nasm transforma o ficheiro em binário .o e o ld (linkage editor ou binder)
transforma o ficheiro .o em ficheiro executável.
------------------------------------------------------------------------------------

						objdump -D -M intel hello.o		(D grande = com a section .data)
						objdump -d -M intel hello.o		(d pequeno = menos a section .data)

Basicamente isto mostra o que é que o processador percebe com
os comandos que fazes.
Para optimizar não precisas do -D mas sim o -d é o suficiente.
------------------------------------------------------------------------------------

				system_profiler SPHardwareDataType   (Mac)
								lscpu				 (Linux)


Cada processador (Intel, ARM, MIPS) tem o seu código (syntax). Não consegues usar o mesmo
código em ARM.
Processadores Intel i3, i5... têm arquitectura de X86_64 . Funciona tanto 64bits
como 32bits.
------------------------------------------------------------------------------------

			cat /usr/include/x86_64-Linux-gnu/asm/unistd_64.h (Linux)

Isto são as funções do system call.
Mais detalhadas neste site em baixo.

https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

Para chamar system calls, chamas "syscall".
------------------------------------------------------------------------------------

Para usar system calls (exemplo write, exit, etc...)
Tens que os chamar através de Registers.

A ordem dos Registers são:

rax		system call number		este também contem o return value rax.
rdi		1st argument
rsi		2nd argument
rdx		3rd argument
r10		4th argument
r8		5th argument
r9		6th argument

Se quisesses chamar o write. Ou usas o link a baixo ou escreves "man 2 write"
na consola. E retiras a informação. Terminas com syscall.

ssize_t write (int fd, const void *buf, size_t count);
	  . 		  .			  .				 .
	 /|\		 /|\		 /|\			/|\
	  |			  |			  |				 |
	 rax		 rdi		 rsi			rdx

Exemplo:
		mov rax, 1
		mov rdi, 1
		mov rsi, texto
		mov rdx, length
		syscall


https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf
------------------------------------------------------------------------------------

x86_64 registers
https://miro.medium.com/max/575/1*4ipwUzIWd4eqUvcEmZ5tMQ.png


	64bits			32bits		16bits	8bits()

	rax				eax			ax		ah	al



------------------------------------------------------------------------------------

1 byte = 8 bits

Quando fazes "objdump -D -M intel hello.o" aqueles "48 be 00 00"... cada grupo representa
1 byte.

Tanto a instrução como o valor dado representam 1 byte cada. Exemplo em baixo

	_start:
		mov rax, 1
		mov rdi, 1
		mov rsi, text
		mov rdx, 21
		syscall

Se montares isto para object file, .o e fizeres "objdump -D -M intel hello.o",
ficas com isto.

   0:   b8 01 00 00 00          mov    eax,0x1
   5:   bf 01 00 00 00          mov    edi,0x1
   a:   48 be 00 00 00 00 00    movabs rsi,0x0
  11:   00 00 00
  14:   ba 15 00 00 00          mov    edx,0x15
  19:   0f 05                   syscall

O teu compilador já optimiza um bocado, como podes ver, o teu "rax" passou para "eax".
Passou de 64bits para 32bits.

   0:   b8 01 00 00 00          mov    eax,0x1

Isto quero dizer que 1 byte está a ser utilizadas e 3 delas estão nulas.
O byte do b8 não faz parte, o b8 é o "eax". Os outros 4 bytes são o que representa o "eax".
4bytes * 8bits = 32bits = eax.
b8 é o eax.
01 é o 0x1.

Se fores a ver a tabela https://miro.medium.com/max/575/1*4ipwUzIWd4eqUvcEmZ5tMQ.png
eax são 32bits, ou 4 * 8.
Instruction codes https://www.cs.uaf.edu/2016/fall/cs301/lecture/09_28_machinecode.html

   0:  |b8||01 00 00 00|          mov    eax,0x1
	   |  | \_________/
		\/		eax
	Instruction
	code for eax

Tens 3 bytes a não ser utilizadas e só estás a usar 1 byte.
Se fores à tabela, 1 byte é o al ou ah.

------------------------------------------------------------------------------------



sys_write: (1)   												rax

	File Descriptor 			0 (Standard Input)				rdi
								1 (Standard Output)
								2 (Standard Error)

	Buffer						Location of string				rsi

	Count						Length of string				rdx



Kernel:

A kernel is a central component of an operating system. It acts as an interface between
the user applications and the hardware. The sole aim of the kernel is to manage the
communication between the software (user level applications) and the hardware (CPU,
disk memory etc).

A Kernel is a computer program that is the heart and core of an Operating System.
Since the Operating System has control over the system so, the Kernel also has control
over everything in the system. It is the most important part of an Operating System.
Whenever a system starts, the Kernel is the first program that is loaded after the
bootloader because the Kernel has to handle the rest of the thing of the system for the
Operating System. The Kernel remains in the memory until the Operating System is shut-down.

The Kernel is responsible for low-level tasks such as disk management, memory management,
task management, etc. It provides an interface between the user and the hardware components
of the system. When a process makes a request to the Kernel, then it is called System Call.


System Calls:

When a process makes a request to the Kernel, then it is called System Call.
On Ubuntu it's "cat /usr/include/x86_64-Linux-gnu/asm/unistd_64.h"


C:

Quando fazes um código C, aquilo traduz para Assembly e depois em assembly traduz a linguagem
para linguagem binária .o, depois aquilo linka os .o com o .ld e depois é que forma o
executável .out .


Assembly:

db - define bytes.

; - Isto é comment. Tudo o que está à direita de ; é comment.

	add eax, ebx	; adds ebx to eax (Isto é um comment)

equ - Equals.

$ - Current label location.


https://www.youtube.com/watch?v=8rncBCVySEw

</pre>

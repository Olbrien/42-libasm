<pre>
------------------------------------------------------------------------------------
			nasm -f elf64 hello.asm && ld hello.o && ./a.out

Para ver qual o processador que tens que usar é "nasm -hf".
Nasm transforma o ficheiro em binário .o e o ld (linkage editor ou binder)
transforma o ficheiro .o em ficheiro executável.
Adicionar -g para debug:

			nasm -f elf64 -g hello.asm && ld hello.o && ./a.out
------------------------------------------------------------------------------------

			objdump -D -M intel hello.o		(D grande = com a section .data)
			objdump -d -M intel hello.o		(d pequeno = menos a section .data)

Basicamente isto mostra o que é que o processador percebe com
os comandos que fazes e as bytes e bits utilizadas. Instruções etc...
------------------------------------------------------------------------------------

			system_profiler SPHardwareDataType   (Mac)
			lscpu				      (Linux)


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

Structure of an Assembly Program

	section .data
	section .bss
	section .text


section .data
	<variable name> <type> <value>		(dinamicas)
	<constant name> equ <value>			(statics)

	Se forem dinamicas, o <type> é um dos seguintes.

	Type   Length    Name
	db	   8 bits    Byte
	dw     16 bits   Word
	dd     32 bits   Double word
	dq     64 bits   Quadword

		"exemplo db "Hello, World!!!!!",10"

	Statics não mudam. São assim até o fim do programa.

		"pi equ 3.14541"


section .bss
	<variable name> <type> <number>

	Type   Length   Name
	resb   8 bits   Byte
	resw   16 bits  Word
	resd   32 bits  Double word
	resq   64 bits  Quadword

	"dArray resd 20"

	The variables in section .bss do not contain any values; the values
	will be assigned later at execution time. Memory places are not reserved at
	compile time but at execution time.


section .text

	This section contains the program code and starts with the following:

		global	_start

	_start:

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
	  . 	   .		  .		 .
	 /|\      /|\		 /|\		/|\
	  |	   |		  |		 |
	 rax      rdi		 rsi		rdx

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


	64bits			32bits		16bits	8bits(most significant byte of ax/
													least significant byte of ax)
	|rax		|eax	    |ax	   |
	|-------64-----|-----32----|-----16------|
			|-----------|------|------|
				    |---8--|--8---|
				    |------|------|
				    |ah    |al    |

	Exemplo em hexadécimal, como mostrado no objdump.

	rax: 12 34 56 78 90 12 34 56		(8 bytes ou 64bits)
	eax:		  90 12 34 56		(4 bytes ou 32bits)
	ax:		 	34 56		(2 bytes ou 16bits)
	ah:			34		(1 bytes ou 8bits)
	al:			   56		(1 bytes ou 8bits)
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
	 |  |\_________/
	 \/      eax
	Instruction
	code for eax

Tens 3 bytes a não ser utilizadas e só estás a usar 1 byte.
Se fores à tabela, 1 byte é o al ou ah. Tu queres o least significant byte, logo usas
o al.
E agora ficas com

    0:   b0 01                   mov    al,0x1

Optimizado.
------------------------------------------------------------------------------------

Data Types:

Byte 				8 bits
Word 				16 bits
Double Word			32 bits
Quad Word			64 bits
Double Quad Word	128 bits
------------------------------------------------------------------------------------

Endianess:

Order in which bytes are stored in memory.

Address	0	1	2	3	 4	 5	 6	 7
Little Endian  byte0   byte1   byte2   byte3   byte4   byte5   byte6   byte7
Big Endian     byte7   byte6   byte3   byte4   byte3   byte2   byte1   byte0

x86 e x86_64 usam o Little Endian.

Exemplo:

	int i = 0x01234567;

	Little Endian:		67 45 23 01
	   Big Endian:		01 23 45 67

É por isso quando fazes "objdump -d -M intel hello.o" e tens o valor de 1 num eax ou rax
tens.

	0:   b8 |01 00 00 00|          mov    eax,0x1
		Little Endian
------------------------------------------------------------------------------------

Logic:

	NOT

		Converts every 0 into 1 and every 1 into 0.

			A 	0 1	 A 	  = 11001011
			NOT A 	1 0	 NOT A    = 00110100

	OR

		If there is a 1 in A or B or in both, the outcome is a 1.

			A 	0 1 0 1	A 	= 11001011
			B 	0 0 1 1	B 	= 00011000
			A OR B  0 1 1 1	A OR B  = 11011011

	XOR

		Exclusive OR: If there is a 1 in A or B, the outcome is a 1. If A and B are
		both 1 or 0, the outcome is 0.

			A 	 0 1 0 1	A 	= 11001011
			B 	 0 0 1 1	B 	= 00011000
			A XOR B  0 1 1 0	A XOR B = 11010011

		XOR as an assembly instruction that can be used to clear a register.
		Hence, "xor rax, rax" is the same is "mov rax,0". But xor executes
		faster than mov.

			A	= 11001011
			A 	= 11001011
			A XOR A = 00000000

	AND

		If there is a 1 in A and in B, the outcome is a 1; otherwise, it’s 0.

			A 	0 1 0 1	A 	= 11001011
			B 	0 0 1 1	B 	= 00011000
			A AND B 0 0 0 1	A AND B = 00001000
------------------------------------------------------------------------------------

sys_write: (1)   											rax

	File Descriptor 			0 (Standard Input)					rdi
						1 (Standard Output)
						2 (Standard Error)

	Buffer						Location of string				rsi

	Count						Length of string				rdx
------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------

Assembly:

$ - Current label location.



------------------------------------------------------------------------------------

GDB (Debugger)

	Quando compilares o programa tens que compilar com -g para conseguires usar bem o
	gdb.

			nasm -f elf64 -g hello.asm && ld hello.o && ./a.out

	Começas por correr o "gdb a.out".

quit:	Fechar o gdb.

list:	Mostra-te umas quantas linhas de código. Escreve list outra vez e mostra-te mais.
	Podes fazer também list 1, list 11, list 5 etc etc...

	Se vires o "gdb" com % e formato estranho provavelmente tens o gdb a correr num syntax
	diferente do intel.
	Para mudares para o syntax do intel fazes:

set disassembly-flavor intel:	Muda o syntax para intel.

	Para mudar o disassembly-flavor para intel permanentemente. Crias um ficheiro chamado
	".gdbinit" com "set disassembly-flavor intel" lá dentro e guardas dentro do "cd ~".


disassemble (frame):	Mostra os memory addresses (0x000...), mostra os bytes of memory
			(<+0>, <+5>) que são necessários, e mostra as instruções que fizeste.
			Provavelmente chamaste um rax, mas aparece eax. É normal, porque
			o assembler tenta optimizar sempre.

			Usa "disassemble _start". Porque tens que indicar o frame.

help x:		O x quer dizer "examine".
			Examine memory: x/FMT ADDRESS.
			ADDRESS is an expression for the memory address to examine.
			FMT is a repeat count followed by a format letter and a size letter.
			Format letters are o(octal), x(hex), d(decimal), u(unsigned decimal),
  		t(binary), f(float), a(address), i(instruction), c(char), s(string)
  		and z(hex, zero padded on the left).
			Size letters are b(byte), h(halfword), w(word), g(giant, 8 bytes).

	Depois de fazeres o "disassemble _start", podes tirar informações com o x/FTM ADDRESS
	de memória em particular.

	Exemplo:
		Tu sabes que o texto "Hello, World!!!!!" está no movabs. E sabes que é uma string.
		Tens que meter um 0 no fim do "Hello, World!!!" porque se não dá erro. Porque o
		x/s vê a string toda até encontrar um NULL. Se não encontrar continua a ler sem parar.
			text db "Hello, World!!!!!",10,0

		Com NULL terminated:
			"x/s 0x402000"
				0x402000 <text>:		"Hello, World!!!!!\n"
		Sem NULL terminated:
			"x/s 0x402000"
				0x402000 <text>:		"Hello, World!!!!!\n"<error: Cannot access
										 memory at address 0x402012>
		Podes fazer também:
			"x/s &text"
				0x402000 <text>:		"Hello, World!!!!!\n"

		Para ver o primeiro caracter e o código de ASCII.
			"x/c 0x402000"
				0x402000 <text>:		72 'H'

		Para veres os characteres todos.
			"x/18c 0x402000"
				0x402000 <text>:	72 'H'  101 'e' 108 'l' 108 'l' 111 'o' 44 ','  32 ' '  87 'W'
				0x402008:			111 'o' 114 'r' 108 'l' 100 'd' 33 '!'  33 '!'  33 '!'  33 '!'
				0x402010:			33 '!'  10 '\n'

info registers : Shows the information on the registers.
or "ir"

break or b:		Set a breakpoint as we have done before.
disable breakpoint (number)
enable breakpoint (number)
delete breakpoint (number)
continue or c:	Continue execution until next breakpoint.
step or s:		Step into the current line, eventually jumping into the called
				function.
next or n:		Step over the current line and stop at the next line.
help or h:		Show help.
tui enable:		Enable a simple text user interface; to disable, use tui disable.
print or p:		Print the value of a variable, register, and so on.
------------------------------------------------------------------------------------

DDD (Debugger com GUI):

	Corres "ddd a.out". Não esquecer que precisas de o -g e do dwarf.
	Aquilo abre a janela.

	Status -> Registers é útil ter isto aberto.
	Metes o breakpoint, tenta pôr no "main" ou "_start" conforme o main que usas.

	Para o GDB correr e não fechar logo, pelo menos em assembly precisas de pôr o
	function prologue e o function epilogue.

	main:
		push rbp		; function prologue
		mov rbp,rsp		; function prologue
		; código aqui
		; código aqui
		mov rsp,rbp		; function epilogue
		pop rbp			; function epilogue
		ret				; fim do código. Também pode ser o rax 60 rdi 0 syscall.
						; este é uma alternativa mais facil. É a diferença de um
						; return(0) ou exit(0) em C.

	Depois é só correr (run) com o Command Tools (Já deves ter aberto View -> Command Tools).
	E usar Step.


------------------------------------------------------------------------------------

	Instruction 	Flags 				Meaning 			Use

	je		ZF=1 				Jump if equal 			Signed, unsigned
	jne		ZF=0 				Jump if not equal 		Signed, unsigned
	jg 		((SF XOR OF) OR ZF) = 0	Jump if greater 		Signed
	jge 		(SF XOR OF) = 0 		Jump if greater or equal 	Signed
	jl 		(SF XOR OF) = 1 		Jump if lower			Signed
	jle 		(SF XOR OF) OR ZF) = 1 	Jump if lower or equal		Signed
	ja 		(CF OR ZF) = 0 		Jump if above			Unsigned
	jae 		CF=0 				Jump if above or equal 	Unsigned
	jb 		CF=1 				Jump if lesser 		Unsigned
	jbe 		(CF OR ZF) = 1 		Jump if lesser or equal 	Unsigned
------------------------------------------------------------------------------------

Useful Stuff:

	time .a.out - Mostra o tempo que demora o código. É útil.

------------------------------------------------------------------------------------

https://www.youtube.com/watch?v=8rncBCVySEw


nasm -f elf64 -g -F dwarf ft_strlen.s -l ft_strlen.lst 	(dwarf é o debug format)
gcc -o a.out ft_strlen.o -no-pie				(-no-pie é para as funções externas funcionarem)
./a.out


</pre>

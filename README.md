# ft_libasm

###### <i>Recent Update on 17/04/2021.</i>
Finished the project.\
Waiting to be evaluated.

###### <i>Old Update on 07/04/2021.</i>
Started the project.

**** Run This Project ****

<pre>
First download the repository. 

On the root of the folder depending in what machine you are type
`bash linux.sh`
`bash mac.sh`

You need to have DDD and NASM installed.
</pre>

![GitHub Logo](/extras/images/image2.png)

**** Testers ****

[libasm_test](https://github.com/cacharle/libasm_test)

**** Results ****

![GitHub Logo](/extras/images/image1.png)

**** Info ****

Assembly is a pretty difficult language to grasp. It will take you a few days to start to make sense to you.

I've watched a few youtube videos but what really started to click to me was a .PDF called\
"Beginning x64 Assembly Programming From Novice to AVX Professional".

You can find this .PDF online. It has 458 pages but don't worry.\
For this project you only need to read to the page 112. \
This .PDF explains everything better than any video on youtube. It has many examples.

I explain everything I did in detail on the folder "code_explained". \
Make you sure you follow along with the order of the subject.\
ft_strlen (man 3 strlen)\
ft_strcpy (man 3 strcpy)\
ft_strcmp (man 3 strcmp)\
ft_write (man 2 write)\
ft_read (man 2 read)\
ft_strdup (man 3 strdup)

One thing really important, and if you're reading the .PDF, don't ignore the DDD section.\
Using DDD makes you visually see what you are really doing. And that was what made it click for me.\
Really simple to use and very useful.

Here are some useful links:

[Linux System Call Table for x86_64](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)\
[macOS System Call Table for x86_64](https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master/)

[Registers](https://miro.medium.com/max/575/1*4ipwUzIWd4eqUvcEmZ5tMQ.png)

[errno return values](https://docs.freebsd.org/en_US.ISO8859-1/books/developers-handbook/x86-return-values.html)\
[errno Linux](https://cpip.readthedocs.io/en/latest/_static/dictobject.c/errno.h_85b9b44751f37eef65e30f1b57e3f0fb.html)\
[errno macOS](https://unix.superglobalmegacorp.com/Net2/newsrc/sys/errno.h.html)

Here are some useful stuff I picked up:
<pre>
------------------------------------------------------------------------------------
			nasm -f elf64 -g hello.asm && ld hello.o && ./a.out

To see what your processor is type "nasm -hf"
NASM makes the file into binary (.o) and ld is the linkage that makes the 
.o file in an executable file.

-g flag is for debug.

------------------------------------------------------------------------------------

			objdump -D -M intel hello.o	(D = with sections .data .bss .text)
			objdump -d -M intel hello.o	(d = without sections)

This command shows how the bytes and bits are used, how instructions are used, registers,
etc...

------------------------------------------------------------------------------------

			system_profiler SPHardwareDataType   (Mac)
			lscpu				     (Linux)

Each processor (Intel, ARM, MIPS) has their syntax. You can't use the same code in a 
different processor.

------------------------------------------------------------------------------------

			cat /usr/include/x86_64-Linux-gnu/asm/unistd_64.h (Linux)

These are the functions of system call (syscall).
In more detail on the website below.

https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

To use system calls, you call them with syscall.

------------------------------------------------------------------------------------

Structure of an Assembly Program

	section .data
	section .bss
	section .text


section .data
	<variable name> <type> <value>		(dinamicas)
	<constant name> equ <value>		(statics)

	If they are dynamics, the <type> is one of the followings.
	
	Type   Length    Name
	db     8 bits    Byte
	dw     16 bits   Word
	dd     32 bits   Double word
	dq     64 bits   Quadword

		"exemple: db "Hello, World!!!!!",10"

	Statics don't change. They are set in the beggining of the program.

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

To use system calls (exemple write, exit, etc...)
You have to set the Registers correctly.

A ordem dos Registers são:

rax		system call number		This is the return value.
rdi		1st argument
rsi		2nd argument
rdx		3rd argument
r10		4th argument
r8		5th argument
r9		6th argument

If you want to call the write function. 
You type "man 2 write" on the console and you take the bellow information out.

ssize_t write (int fd, const void *buf, size_t count);
	  . 	   .		  .		 .
	 /|\      /|\		 /|\		/|\
	  |	   |		  |		 |
	 rax      rdi		 rsi		rdx

Exemple:
		mov rax, 1
		mov rdi, 1
		mov rsi, texto
		mov rdx, length
		syscall


https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf

------------------------------------------------------------------------------------

x86_64 registers
https://miro.medium.com/max/575/1*4ipwUzIWd4eqUvcEmZ5tMQ.png


	64bits		32bits	    16bits 8bits(ah = most significant byte of ax / al = least significant byte of ax)
										
	|rax		|eax	    |ax	   |
	|-------64------|-----32----|-----16------|
			|-----------|------|------|
				    |---8--|--8---|
				    |------|------|
				    |ah    |al    |

	Exemple in hexadecimal, shown in objdump.	

	rax: 12 34 56 78 90 12 34 56		(8 bytes ou 64bits)
	eax:		  90 12 34 56		(4 bytes ou 32bits)
	ax:		 	34 56		(2 bytes ou 16bits)
	ah:			34		(1 bytes ou 8bits)
	al:			   56		(1 bytes ou 8bits)
	
------------------------------------------------------------------------------------

1 byte = 8 bits

When you do "objdump -D -M intel hello.o" those "48 be 00 00"... each group represents 1 byte.
The instruction and the value each represent 1 byte.

Example:

	_start:
		mov rax, 1
		mov rdi, 1
		mov rsi, text
		mov rdx, 21
		syscall

If you put this on a object file (.o) and do "objdump -D -M intel hello.o"
you get this:

   0:   b8 01 00 00 00          mov    eax,0x1
   5:   bf 01 00 00 00          mov    edi,0x1
   a:   48 be 00 00 00 00 00    movabs rsi,0x0
  11:   00 00 00
  14:   ba 15 00 00 00          mov    edx,0x15
  19:   0f 05                   syscall

Your compiler already optimizes it a bit, as you can see, your "RAX" is now "EAX".
Went from 64 bits to 32bits.

   0:   b8 01 00 00 00          mov    eax,0x1

This means 1 byte is being used and 3 of them are null.
The b8 byte is from "EAX". The other 4 bytes are what "EAX" represents.
4bytes * 8bits = 32bits = eax.

b8 is EAX
01 is 0x1.

If you check the table https://miro.medium.com/max/575/1*4ipwUzIWd4eqUvcEmZ5tMQ.png
EAX are 32 bits, or 4 * 8.
Instruction codes https://www.cs.uaf.edu/2016/fall/cs301/lecture/09_28_machinecode.html

   0:  |b8||01 00 00 00|          mov    eax,0x1
	 |  |\_________/
 	\|/      eax
	 
	Instruction
	code for eax

You have 3 bytes not being used. And 1 being used.
If you're at the table, 1 byte is or al or ah. You want the least significant byte,
therefor you use al.
And now you get:

    0:   b0 01                   mov    al,0x1

Optimized.

------------------------------------------------------------------------------------

Data Types:

Byte 				8 bits
Word 				16 bits
Double Word			32 bits
Quad Word			64 bits
Double Quad Word		128 bits

------------------------------------------------------------------------------------

Endianess:

Order in which bytes are stored in memory.

Address	0	1	2	3	 4	 5	 6	 7
Little Endian  byte0   byte1   byte2   byte3   byte4   byte5   byte6   byte7
Big Endian     byte7   byte6   byte3   byte4   byte3   byte2   byte1   byte0

x86 e x86_64 usam o Little Endian.

Exemple:

	int i = 0x01234567;

	Little Endian:		67 45 23 01
	   Big Endian:		01 23 45 67

This is why when you do "objdump -d -M intel hello.o" you have a value of 1 in the EAX.

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

sys_write: (1)   						rax

	File Descriptor 	0 (Standard Input)		rdi
				1 (Standard Output)
				2 (Standard Error)

	Buffer			Location of string		rsi

	Count			Length of string		rdx
	
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

When you code C, it translates to Assembly and then Assembly translates to Binary Language (.o).
Then you link the .o with .ld and it forms a readable, executable file. Usually "a.out".

------------------------------------------------------------------------------------

Assembly:

$ - Current label location.


------------------------------------------------------------------------------------

GDB (Debugger)

	When you compile the program you have to compile with the flag -g so you can use
	gdb.
			nasm -f elf64 -g hello.asm && ld hello.o && ./a.out

	You start by typing "gdb a.out"

quit:	Close gdb.

list:	This shows a few lines of code. Write list again it shows more.
	You can also do list 1, list 11, list 5, etc etc...

	If you see gdb with "%" and in a weird format most likely you are running gdb on a different
	syntax than Intel.
	
	To change it:

set disassembly-flavor intel:	Changes the syntax to Intel.

	To change the syntax to intel permanently, make a file called "gdbinit" with 
	"set disassembly-flavor intel" inside and save it on "cd ~".

disassemble (frame):	It shows the memory addresses (0x000...), shows the bytes (<+0>, <+5>)
			that are necessary and shows the instructions you did.
			Probably it will say that you called an EAX when you really called a RAX.
			But that's the assembly optimizing.

			Use "disassemble _start" or whatever frame you want to check.

help x:			X means "Examine".
			Examine memory: x/FMT ADDRESS.
						
			ADDRESS is an expression for the memory address to examine.
			FMT is a repeat count followed by a format letter and a size letter.
			Format letters are o(octal), x(hex), d(decimal), u(unsigned decimal),
  		t(binary), f(float), a(address), i(instruction), c(char), s(string)
  		and z(hex, zero padded on the left).
			Size letters are b(byte), h(halfword), w(word), g(giant, 8 bytes).

	After you do "disassemble _start", you can take informations with x/FTM ADDRESS on particular
	pieces of memory.

	Example:
		You know that "Hello, World!!!!" is on movabs. You know it is a string and you have
		to put a '\0' in the end of "Hello, World!!!!" because otherwise it gives an error.
		x/s sees the entire string until it finds a NULL. That's why you end strings with '\0'.
		
			text db "Hello, World!!!!!",10,0

		With NULL terminated:
			"x/s 0x402000"
				0x402000 <text>:		"Hello, World!!!!!\n"
		Without NULL terminated:
			"x/s 0x402000"
				0x402000 <text>:		"Hello, World!!!!!\n"<error: Cannot access
										 memory at address 0x402012>
		You can also:
			"x/s &text"
				0x402000 <text>:		"Hello, World!!!!!\n"

		To see the first caracther and the ASCII code:
			"x/c 0x402000"
				0x402000 <text>:		72 'H'

		To see all the characters:
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

continue or c:		Continue execution until next breakpoint.
step or s:		Step into the current line, eventually jumping into the called
				function.
next or n:		Step over the current line and stop at the next line.
help or h:		Show help.
tui enable:		Enable a simple text user interface; to disable, use tui disable.
print or p:		Print the value of a variable, register, and so on.

------------------------------------------------------------------------------------

DDD (Debugger with GUI):

	Run "ddd a.out". Don't forget you need -g and dwarf.
	It opens a windows.

	Status -> Registers is useful to have it open.
	Put a breakpoint, try to put it on the start function. "main", "_start" whatever it is.
	
	This is important. To run the debbuger, you need to have the Function Prologue and
	the Function Epilogue. Otherwise it won't stop.

	main:
		push rbp		; function prologue
		mov rbp,rsp		; function prologue
		; code here
		; code here
		mov rsp,rbp		; function epilogue
		pop rbp			; function epilogue
		ret			; End of code. It could also be rax 60 rdi 0 syscall.
					; This is an easier alternative. It's the difference between
					; a return or exit(0) in C.

	Then you just press (run) in the Command Tools (You probably have it open already. If not
	it's View -> Command Tools).
	Then use Step.

------------------------------------------------------------------------------------

	Instruction 	Flags 				Meaning 			Use

	je		ZF=1 				Jump if equal 			Signed, unsigned
	jne		ZF=0 				Jump if not equal 		Signed, unsigned
	jg 		((SF XOR OF) OR ZF) = 0		Jump if greater 		Signed
	jge 		(SF XOR OF) = 0 		Jump if greater or equal 	Signed
	jl 		(SF XOR OF) = 1 		Jump if lower			Signed
	jle 		(SF XOR OF) OR ZF) = 1 		Jump if lower or equal		Signed
	ja 		(CF OR ZF) = 0 			Jump if above			Unsigned
	jae 		CF=0 				Jump if above or equal 		Unsigned
	jb 		CF=1 				Jump if lesser 			Unsigned
	jbe 		(CF OR ZF) = 1	 		Jump if lesser or equal 	Unsigned
------------------------------------------------------------------------------------

Useful Stuff:

	time .a.out - Shows the time the code takes to run.

------------------------------------------------------------------------------------

nasm -f elf64 -g -F dwarf ft_strlen.s -l ft_strlen.lst 	(dwarf is the format to debug)
gcc -o a.out ft_strlen.o -no-pie			(-no-pie is needed for external functions)
./a.out
</pre>

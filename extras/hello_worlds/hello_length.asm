global _start
section .text
_start:
		mov rax, 1
		mov rdi, 1
		mov rsi, texto
		mov rdx, length
		syscall

		mov rax, 60
		mov rdi, 0
		syscall
section .data
		texto db "Hello World!!!!!!",10
		length equ $-texto

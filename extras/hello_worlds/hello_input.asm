section .data
		text1 db "Hello. What is your name? "
		text2 db "Nice to meet you "
section .bss
		name1 resb 16
section .text
		global _start
_start:
		call _printHello
		call _getName
		call _nice
		call _printName

		mov rax, 60
		mov rdi, 0
		syscall
_printHello:
		mov rax, 1
		mov rdi, 1
		mov rsi, text1
		mov rdx, 26
		syscall
		ret
_getName:
		mov rax, 0
		mov rdi, 0
		mov rsi, name1
		mov rdx, 16
		syscall
		ret
_nice:
		mov rax, 1
		mov rdi, 1
		mov rsi, text2
		mov rdx, 18
		syscall
		ret
_printName:
		mov rax, 1
		mov rdi, 1
		mov rsi, name1
		mov rdx, 16
		syscall
		ret


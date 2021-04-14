section .data
section .bss
section .text
		global ft_strlen
ft_strlen:
		push rbp
		mov rbp,rsp

		mov rax, 0
		call _compare
_compare:
		cmp BYTE[rdi+rax], 0
		jle _exit
		inc rax
		call _compare
_exit:
		mov rsp,rbp
		pop rbp

		ret


; size_t strlen(const char *s)

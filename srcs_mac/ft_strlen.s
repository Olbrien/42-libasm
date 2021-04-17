section .data
section .bss
section .text
		global _ft_strlen
_ft_strlen:
		push rbp
		mov rbp,rsp

		mov rax, 0
		jmp _compare
_compare:
		cmp BYTE[rdi+rax], 0
		jle _return

		inc rax
		jmp _compare
_return:
		mov rsp,rbp
		pop rbp

		ret

;size_t strlen(const char *s)
;rdi = const char *s

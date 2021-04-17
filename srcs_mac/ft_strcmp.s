section .data
section .bss
section .text
		global _ft_strcmp
_ft_strcmp:
		push rbp
		mov rbp,rsp

		mov rax, 0
		mov rcx, 0
		mov rdx, 0
		mov r8, 0

		jmp _compare
_compare:
		mov cl, BYTE[rdi + r8]
		mov dl, BYTE[rsi + r8]
		call _addToRAX

		cmp rax, 0
		jnz _return
		cmp cl, 0
		jz _return
		cmp dl, 0
		jz _return

		mov rcx, 0
		mov rdx, 0
		inc r8

		jmp _compare
_addToRAX:
		push rcx
		sub rcx, rdx
		add rax, rcx
		pop rcx

		ret
_return:
		mov rsp,rbp
		pop rbp

		ret

;ft_strcmp(const char *s1, const char *s2);
;rdi = const char *s1
;rsi = const char *s2

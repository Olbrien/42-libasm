section .data
section .bss
section .text
		global ft_strcmp
ft_strcmp:
		push rbp
		mov rbp,rsp

		mov rax, 0
		mov rcx, 0 ; rdi char (I'm using cl)
		mov rdx, 0 ; rsi char (I'm using dl)
		mov r8, 0 ; Counter
		jmp _compare
_compare:
		mov cl, BYTE[rdi + r8]
		mov dl, BYTE[rsi + r8]

		push rcx
		sub rcx, rdx
		add rax, rcx
		pop rcx

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
_return:
		mov rsp,rbp
		pop rbp

		ret

;ft_strcmp(const char *s1, const char *s2);
;rdi = const char *s1
;rsi = const char *s2
;
;


section .data
section .bss
section .text
		global ft_strcpy
ft_strcpy:
		push rbp
		mov rbp,rsp

		mov rax, 0
		mov rcx, 0
		mov rdx, 0
		jmp _copy
_copy:
		mov cl, BYTE[rsi + rdx]
		mov BYTE[rdi + rdx], cl
		cmp BYTE[rsi + rdx], 0
		jz _return

		inc rdx
		jmp _copy
_return:
		mov rsp,rbp
		pop rbp

		mov rax, rdi
		ret

;char *strcpy(char *dest, const char *src)
;rdi = destination
;rsi = source
;
;counter  = rdx
;tmp_char = rcx (cl)

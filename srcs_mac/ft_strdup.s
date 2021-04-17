section .data
section .bss
section .text
		global ft_strdup
		extern ft_strlen
		extern ft_strcpy
		extern malloc
ft_strdup:
		push rbp
		mov rbp,rsp

		mov rax, 0
		call _checkEmptyStr
		call _getLen
		call _doMalloc
		jmp _doStrCpy
_checkEmptyStr:
		cmp rdi, 0
		jz _return
		ret
_getLen:
		call ft_strlen
		inc rax
		ret
_doMalloc:
		mov r8, rdi
		push r8
		mov rdi, rax
		call malloc
		pop r8
		cmp rax, 0
		jz _error
		ret
_doStrCpy:
		mov rsi, r8
		mov rdi, rax
		call ft_strcpy
		jmp _return
_error:
		mov rsp,rbp
		pop rbp

		mov rax, 0

		ret
_return:
		mov rsp,rbp
		pop rbp

		ret

;char *strdup(const char *s);
;rdi = const char *s
;
;malloc(sizeof(*dest) * len + 1);
;
;char *strcpy(char *dest, const char *src)
;rdi = destination
;rsi = source
;
;size_t strlen(const char *s)
;rdi = const char *s

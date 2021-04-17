section .data
section .bss
section .text
		global _ft_strdup
		extern _ft_strlen
		extern _ft_strcpy
		extern _malloc
_ft_strdup:
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
		call _ft_strlen
		inc rax
		ret
_doMalloc:
		mov r8, rdi
		push r8
		mov rdi, rax
		call _malloc
		pop r8
		cmp rax, 0
		jz _error
		ret
_doStrCpy:
		mov rsi, r8
		mov rdi, rax
		call _ft_strcpy
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

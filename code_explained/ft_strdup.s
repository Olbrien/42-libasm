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
		cmp rdi, 0	; If the string *s (RDI) is empty. Return.
		jz _return
		ret
_getLen:
		call ft_strlen	; Take the strlen.
		inc rax		; You need to take in account the '\0'. If you copy "Alo", which is 3 of len,
				; you also need the '\0' that the strlen doesn't count. So you increase RAX.
		ret
_doMalloc:
		mov r8, rdi ; Move the string *s (RDI) to a temporary register.
		push r8	; Push the R8 register because you will need to save it in a stack.
				; What happens is that you have now the string *s on R8. And in theory
				; you're not going to touch R8, so you could keep there and not need
				; to do push / pop on R8. Well, for some reason, the call to malloc
				; messes with almost every register. So that's why we save it in the
				; stack and after malloc you retrieve it.
		mov rdi, rax    ; Put the stlren (which was 4 if you were following along) on RDI.
				; void *malloc(size_t size)
		call malloc
		pop r8		; Retrieve the value you had prior on R8 (which was the string *s).
				; Also you need to pop what you pushed here. If you save it, and
				; try to pop it in another function besides _doMalloc it will
				; give a segmentation fault.
		cmp rax, 0	; If Malloc has an error, you go go to _error.
		jz _error
		ret
_doStrCpy:
		mov rsi, r8	; You get the string *s from R8 to RSI. (Let's assume it's still "Alo");
		mov rdi, rax    ; You put the value you got from Malloc on RDI.
		call ft_strcpy	; *ft_strcpy(RDI, RSI) or ft_strcpy(allocated memory, "Alo").
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

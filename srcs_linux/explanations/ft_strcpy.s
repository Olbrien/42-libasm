section .data
section .bss
section .text
		global ft_strcpy
ft_strcpy:
		push rbp	; Function Prologue
		mov rbp,rsp	; Function Prologue

		mov rax, 0	; RAX is where you going to put your Destination for returning.
		mov rcx, 0	; RCX (CL is least significant byte). You going to use CL instead
					; of RCX. Because you want to copy 1 byte (1 char) at a time.
		mov rdx, 0	; RDX is going to be the counter.
		jmp _copy
_copy:
		mov cl, BYTE[rsi + rdx]	; RSI is the Destination, RDX is the counter.
								; You're going to move BYTE[RSI + RDX] or the first char
								; of [RSI + RDX] to the least significant byte of RCX
								; which is CL.

		mov BYTE[rdi + rdx], cl ; Now you're moving the byte you just got to [RDI + RDX].
								; Meaning, you're basically doing "dest[0] = src[0]".

		cmp BYTE[rsi + rdx], 0	; If the Source + RDX is '\0'.
		jz _return
		inc rdx					; Increase counter.
		jmp _copy
_return:
		mov rsp,rbp	; Function Epilogue
		pop rbp		; Function Epilogue

		mov rax, rdi ; Copying the Temporary String you made from bytes of CL
					 ; to the Return Register.
		ret

;char *strcpy(char *dest, const char *src)
;rdi = destination
;rsi = source
;
;counter  = rdx
;tmp_char = rcx (cl)

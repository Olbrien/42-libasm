section .data
section .bss
section .text
		global ft_strcmp
ft_strcmp:
		push rbp
		mov rbp,rsp

		mov rax, 0	; Setting RAX to 0.
		mov rcx, 0	; RCX (cl) it's where I'm going to store the byte(char) of RDI (s1).
		mov rdx, 0	; RDX (dl) it's where I'm going to store the byte(char) of RSI (s2).
		mov r8, 0	; R8 is the counter.

		jmp _compare
_compare:
		mov cl, BYTE[rdi + r8] ; cl has the char of [RDI + R8].
				       ; If RDI has "Hello", [RDI + 0] = "H". cl = "H" or 72 in decimal.
		mov dl, BYTE[rsi + r8] ; dl has the char of [RSI + R8];
				       ; If RSI has "Bye", [RSI + 0] = "B". cl = "B" or 66 in decimal.
		call _addToRAX

		cmp rax, 0	; If "H" != "B", it's not equal, therefor we don't need to loop anymore.
				; If it was equal let's say "H" == "H", then we wanted to loop to the next
				; char.
		jnz _return
		cmp cl, 0	; If s1 has ended. (Encountered a '\0').
		jz _return
		cmp dl, 0	; if s2 has ended. (Encountered a '\0').
		jz _return

		mov rcx, 0	; Reset the RCX.
		mov rdx, 0	; Reset the RDX.
		inc r8		; r8++;

		jmp _compare ; Loop.
_addToRAX:
		push rcx		; This saves RCX in the stack. Because I'm going to use it and I
					; want to retrieve it.
		sub rcx, rdx	; This is RCX = RCX(cl) - RDX(dl). If we're following the example
				; above it's RCX = 72 - 66 which is 6.
		add rax, rcx	; RAX now has 6.
		pop rcx		; Since we used "sub RCX, RDX", RCX changed it's value from 72 to
				; 6. But we stored the value 72 in the stack. So we retrieve it
				; with pop. Now RCX has 72 again.

		ret
_return:
		mov rsp,rbp
		pop rbp

		ret	; We have the RAX filled here with 6 (if we're following the example).

;ft_strcmp(const char *s1, const char *s2);
;rdi = const char *s1
;rsi = const char *s2

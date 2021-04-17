section .data
section .bss
section .text
		global ft_strlen
ft_strlen:
		push rbp	;	Function Prologue: They are necessary for debugging.
		mov rbp,rsp	;			Without these 2 instructions, gdb won't stop.

		mov rax, 0	;	RAX is the return where you want to put the str length.
					;	You set it to 0 because RAX starts with garbage value.

		jmp _compare	;	With 'jmp' you move permenantely
						;	to the function you jumped to. (Example below).
						;	With 'call' if you finish the function you "jumped" to,
						;	you'd be back here.
_compare:
		cmp BYTE[rdi+rax], 0	; 1 BYTE is 8 bits. 1 BYTE is a char.
								; If RDI had "Hello", BYTE RDI would be "H".
								; RDI + 0 = "H", RDI + 1 = "e", etc etc... until
								; RDI + 6 = "'\0'" or 0.

		jle _return	; Jump if Less or Equal. You want jle because
					; you want to go there one more time so you can
					; copy the "'\0'".

		inc rax			; See above motive.
		jmp _compare	; Loop.
_return:
		mov rsp,rbp				;	Function Epilogue: They are necessary for debugging.
		pop rbp					;			Without these 2 instructions, gdb won't stop.

		ret						;	You have the value of the length on RAX. RAX is the
								;	return value.


; 	size_t strlen(const char *s)
;						 .
;						/|\
;						 |
;						rdi
;
;	rax : Is what you want to return. In this case you
;		  want to return the length of strlen.
;
;
;	Differences between call and jmp
;
;	call:
;			mov rax, 0
;			call function2
;			inc rax
;			dec rax
;
;	function2:
;			add rax, 5
;			ret				; Here, when you reach ret, it would go back up
;							; to the line after "call function2".
;							; With 'jmp' instead of 'call', the program would
;							; end here.


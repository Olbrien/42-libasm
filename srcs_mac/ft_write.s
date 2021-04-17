extern ___error
section .data
section .bss
section .text
		global _ft_write
_ft_write:
		push rbp
		mov rbp,rsp

		mov rax, 0x2000004
		syscall
		
		jc _error
		jmp _return
_error:
		mov r8, rax
		call ___error		
		mov [rax], r8
		mov rax, -1
		jmp _return
_return:
		mov rsp,rbp
		pop rbp

		ret

;ssize_t write(int fd, const void *buf, size_t count);
;rdi = fd
;rsi = buf
;rdx = count
;

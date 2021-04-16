extern __errno_location
section .data
section .bss
section .text
		global ft_read
ft_read:
		push rbp
		mov rbp,rsp

		mov rax, 0
		syscall

		cmp rax, 0
		jl _error
		jmp _return
_error:
		mov r8, rax
		call __errno_location
		neg r8
		mov [rax], r8
		mov rax, -1
		jmp _return
_return:
		mov rsp,rbp
		pop rbp

		ret

;ssize_t ft_read(int fd, void *buf, size_t count);
;rdi = fd
;rsi = buf
;rdx = count
;

extern __errno_location	; This extern statement is needed to ise this specific function
						; in this code.
section .data
section .bss
section .text
		global ft_write
ft_write:
		push rbp
		mov rbp,rsp

		mov rax, 0	; This is the syscall table code for "write".
					; We will not write the RDI, RSI, RDX because we already have it from
					; the main.c
					; https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
		syscall		; By typing syscall it goes to the system call 1 (write), and returns
					; a value for RAX.
					; If you entered fd = -5 on your main.c your RAX is probably -9
					; here in Linux.

		cmp rax, 0	; In Linux the value goes from minus to plus. In Mac it adds a Carry
					; Flag.
					; https://docs.freebsd.org/en_US.ISO8859-1/books/developers-handbook/x86-return-values.html
		jl _error	; If its < 0, jump to error.
		jmp _return	; Else, return with the value returned from "Write" syscall.
_error:
		mov r8, rax			  ; Saves the RAX in R8;
		call __errno_location ; This calls the function established in "extern".
							  ; This gets the address of __errno.
							  ; RAX has the address of __errno. Address is [RAX].


		neg r8			; If you keep following the example R8 has a value of -9.
						; But __errno has only positive values. Example: 1 is
						; /* Operation not permitted */ , 2 is /* No such file or
						; directory */ etc...
						; You need to put your -9 positive to correspond to a value in
						; /sys/errno.h

		mov [rax], r8	; You want to change the Address of [RAX].
						; The address is where you're going to set your '9' for
						; /* Bad file descriptor */.
						; To check what it corresponds to, in Linux check:
						; https://cpip.readthedocs.io/en/latest/_static/dictobject.c/errno.h_85b9b44751f37eef65e30f1b57e3f0fb.html
						; On a Mac is:
						; https://unix.superglobalmegacorp.com/Net2/newsrc/sys/errno.h.html

		mov rax, -1	; Now that you set the address of [RAX], it's stored there until someone
					; changes the address. You can change RAX all you want it won't affect
					; the address you previously changed.
					; Return -1 is for errors.
					; I am error.
		jmp _return
_return:
		mov rsp,rbp
		pop rbp

		ret

;ssize_t ft_read(int fd, void *buf, size_t count);
;rdi = fd
;rsi = buf
;rdx = count


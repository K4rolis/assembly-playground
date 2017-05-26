;-----------------------------------------------------------------------------
; Constant definitions
;-----------------------------------------------------------------------------
SYS_EXIT equ 60
SYS_WRITE equ 1

;-----------------------------------------------------------------------------
; Data section
;-----------------------------------------------------------------------------
section .data
    newline: db 0xA
    space: db 0x20

;-----------------------------------------------------------------------------
; Text section
;-----------------------------------------------------------------------------
section .text

global _start ; entry point

_start:
    mov rbp, rsp
    mov rcx, [rbp] ; argc as loop count
    mov rbx, 0

arg_loop:
    mov rax, [rbp + 8*rbx + 8]
    push rcx
    push rbx
    call string_len
    pop rbx
    mov rsi, [rbp + 8*rbx + 8] ; pointer to the string
    mov rdx, rax ; length
    call puts
    mov rsi, newline ; pointer to the string
    call putc
    pop rcx
    inc rbx
    loop arg_loop

exit:
    mov rdi, 0 ; exit status for the exit syscall
    mov rax, SYS_EXIT ; move the exit syscall number to rax
    syscall ; make the syscall


; Takes address in rax and returns the length of NULL-terminated string
; also in rax
string_len:
    push rbp
    mov rbp, rsp

    mov rcx, 0
string_len_loop:
    mov dl, [rax + rcx]
    cmp dl, 0
    je string_len_end
    inc rcx
    jmp string_len_loop

string_len_end:
    mov rax, rcx
    pop rbp ; restore old stack pointer
    ret


; Prints a single character pointed to by rsi to stdout
putc:
    push rbp
    mov rbp, rsp
    mov rdi, 1 ; stdout
    mov rdx, 1 ; length
    mov rax, SYS_WRITE
    syscall
    pop rbp
    ret


; Prints a string pointed to by rsi, length of which is in rdx to stdout
puts:
    push rbp
    mov rbp, rsp
    mov rdi, 1 ; stdout
    mov rax, SYS_WRITE
    syscall
    pop rbp
    ret

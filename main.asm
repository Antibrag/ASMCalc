%macro exit 1
	mov rax, 60
	mov rdi, %1
	syscall
%endmacro

;1 arg - variable
;2 arg - size
%macro Print 2
	mov rsi, %1
	mov rdx, %2
	call _print
%endmacro

;1 arg - variable
;2 arg - size 
%macro Input 2
	mov rsi, %1
	mov rdx, %2
	call _input
%endmacro

section .data
	text_g1 db "Input first num: "
	text_g2 db "Input second num: "
	text_ga db "Input action (+-*/):"
	text_rAnsw db "Answer: "

section .bss
	firstNum resb 8
	secondNum resb 8
	action resb 1

section .text
	global _start
	global _input
	global _print

_start:
	Print text_g1,17
	Input firstNum,8
	exit 0

_input:
	mov rax, 0
	mov rdi, 1
	syscall
	ret

_print:
	mov rax, 1
	mov rdi, 1
	syscall
	ret

%macro exit 1
	mov rax, 60
	mov rdi, %1
	syscall
%endmacro

section .data
	text_g1 db "Input first num: "
	text_g2 db "Input second num: "
	text_ga db "Input action (+-*/):"
	text_rAnsw db "Answer: "

section .bss
	firstNnum resb 8
	secondNum resb 8
	action resb 1

section .text
	global _start

_start:
	exit 0

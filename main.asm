
NUM_LENGTH equ 8

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

%macro atoi 1
	mov rbx, NUM_LENGTH
	call %%atoiLoop

%%atoiLoop:
	mov rax, firstNum
	dec rbx

	add rax, rbx	;Переходим на rbx элемент массива rax
	mov rcx, [rax]	;Получаем число массива
	cmp rcx, 10
	Print text_g1,17
	jne %%atoiLoop

	dec rbx		;Переход на число
	mov [digitSpacePos], bl
	
%%atoiLoop2:
	mov rax, firstNum
	dec rbx

	add rax, rbx
	mov rcx, [rax]
	sub rcx, 48
	push rcx

	cmp rax, firstNum
	jne %%atoiLoop2

	mov %1, 0
	mov rbx, [digitSpacePos]

%%atoiLoop3:
	pop rax
	mul rbx
	add %1, rax	
	dec rbx

	cmp rbx, 0
	jne %%atoiLoop3
	ret
%endmacro

section .data
	text_g1 db "Input first num: "
	text_g2 db "Input second num: "
	text_ga db "Input action (+-*/): "
	text_rAnsw db "Answer: "
	text_err db "unknown operation",10

section .bss
	firstNum resb NUM_LENGTH
	secondNum resb NUM_LENGTH
	action resb 1

	;Variables to output digits
	digitSpace resb 100
	digitSpacePos resb 8

section .text
	global _start

_start:
	Print text_g1,17
	Input firstNum,NUM_LENGTH
	
	Print text_g2,18
	Input secondNum,NUM_LENGTH

	Print text_ga,21
	Input action,1
	
	;mov rax, 8
	mov rbx, [action]

	cmp rbx, 43
	je _calcP

	cmp rbx, 45
	je _calcM

	Print text_err,18
	exit 1

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

_calcP:
	atoi r14
	mov [firstNum], r14
	Print firstNum,NUM_LENGTH
	exit 0

_calcM:
	Print action,1
	exit 0

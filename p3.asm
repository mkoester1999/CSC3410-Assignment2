BITS 32
global _start

section .text

_start:
	;prompt number
	MOV eax, 4 ;SYS_write syscall
	mov ebx, 1 ;stdout fd
	mov ecx, prompt ;message
	mov edx, lenPrompt ;message length
	int 80h ;syscall interrupt
	;;read input  
	mov eax, 3
	mov ebx, 1
	mov ecx, num1
	mov edx, 2
	int 80h

	;convert num1 to decimal
	mov al, [num1]
	sub al, 48
	mov [num1], al
	
	;prompt second number
	MOV eax, 4 ;SYS_write syscall
	mov ebx, 1 ;stdout fd
	mov ecx, prompt ;message
	mov edx, lenPrompt ;message length
	int 80h ;syscall interrupt
	
	;;read input  
	mov eax, 3
	mov ebx, 1
	mov ecx, num2
	mov edx, 2
	int 80h

	;convert num2 to decimal
	mov al, [num2]
	sub al, 48
	mov [num2], al
	
	mov eax, 0
	mov edx, 0
	mov al, 0

	mov ah, 0 ;clear ah

	;perform division
	;move num1 into al
	mov al, [num1]
	idiv byte [num2]
	
	;move quotient into num1 and remainder into num2
	mov [num1], al
	mov [num2], ah
	
	;-----Print Quotient-----
	;print 1st part of message
	mov eax, 4
	mov ebx, 1
	mov ecx, quotientMsg 
	mov edx, lenQuotient
	int 80h

	;convert num1 back to char
	mov al, [num1]
	add al, 48
	mov [num1], al

	;convert

	;print num1 (quotient)
	mov eax, 4
	mov ebx, 1
	mov ecx, num1
	mov edx, 2
	int 80h

	;-----Print Remainder-----
	mov eax, 4
	mov ebx, 1
	mov ecx, remainderMsg
	mov edx, lenRemainder
	int 80h

	;convert num2 to decimal
	mov al, [num2]
	add al, 48
	mov [num2], al

	;print num2
	mov eax, 4
	mov ebx, 1
	mov ecx, num2
	mov edx, 2
	int 80h

	;exit
	mov eax, 1 ;sys_exit
	mov ebx, 0 ;success code
	int 80h

section .data
prompt: DB "Please enter a single-digit number: "
lenPrompt EQU $-prompt
	
quotientMsg: DB "The quotient is: "
lenQuotient EQU $-quotientMsg

remainderMsg: DB "The remainder is: "
lenRemainder EQU $-remainderMsg

section .bss
num1: RESB 2
num2: RESB 2
result: RESB 1


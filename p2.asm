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
	mov ebx, 0
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
	mov ebx, 0
	mov ecx, num2
	mov edx, 2
	int 80h

	;convert num2 to decimal
	mov al, [num2]
	sub al, 48
	mov [num2], al
	
	mov ax, 0
	;move num1 into al
	mov al, [num1]
	imul byte [num2]
	;move result back into num1
	mov [num1], al
	
	;print 1st part of message
	mov eax, 4
	mov ebx, 1
	mov ecx, resultMsg
	mov edx, lenResult
	int 80h

	;convert num1 back to char
	mov al, [num1]
	add al, 48
	mov [num1], al

	;print num1
	mov eax, 4
	mov ebx, 1
	mov ecx, num1
	mov edx, 2
	int 80h

	;exit
	mov eax, 1 ;sys_exit
	mov ebx, 0 ;success code
	int 80h

section .data
prompt: DB "Please enter a single-digit number: "
lenPrompt EQU $-prompt
	
resultMsg: DB "The answer is: ",
lenResult EQU $-resultMsg

section .bss
num1: RESB 2
num2: RESB 2
result: RESB 1


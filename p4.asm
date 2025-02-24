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
	mov ecx, string 
	mov edx, 3
	int 80h

	;mov 1st char int al
	mov al, [string]
	;2nd char into ah
	mov ah, [string+1]

	mov [string], ah
	mov [string+1], al
	
	mov ah, 0
	mov al, 0
	;print out reverse message
	mov eax, 4
	mov ebx, 1
	mov ecx, reverseMsg
	mov edx, lenReverse
	int 80h

	;print reversed string 
	mov eax, 4
	mov ebx, 1
	mov ecx, string
	mov edx, 3
	int 80h

	;exit
	mov eax, 1 ;sys_exit
	mov ebx, 0
	int 80h

section .data
prompt: DB "Please enter a 2-character string: "
lenPrompt EQU $-prompt
	
reverseMsg: DB "The reversed string is: "
lenReverse: EQU $-reverseMsg

section .bss
string: RESB 3


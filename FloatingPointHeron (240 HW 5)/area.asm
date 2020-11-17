; **********************************************
; Program name: "Area of Triangles" (HW 5 for CPSC 240-03, Fall 2020)
; Details: Calculates the floating point area of a triangle given its
; three side lengths, using Heron's formula.
; Copyright (C) 2020  Josh Ibad
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License version 3 as 
; published by the Free Software Foundation.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; A copy of the GNU General Public License v3 is available here:
; <https://gnu.org/licenses/>
; **********************************************

; **********************************************
;Author info:
; Author name: Josh Ibad
; Author email: joshcibad@csu.fullerton.edu
;
;Program info:
; Program name: Area of Triangles
; Programming languages: One module in C, one in x86
; Date program began:	 2020-Nov-12
; Date program completed: 2020-Nov-17
; Files in program:	triangle.c, area.asm
; Status: Complete (as of 2020-Nov-17). Successful after testing.
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
;
;Purpose:
; Accepts three floating point inputs representative of side lengths
; of a triangle. The inputs are validated then the area is calculated
; using Heron's formula. 
;
; Heron's formula:
;	s = (a+b+c)/2
;	Area = sqrt(s * (s-a) * (s-b) * (s-c))
;	
;This file:
; Filename: area.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l area.lis -o area.o area.asm
; Link: gcc -m64 -no-pie -o triangle.out -std=c11 triangle.o area.o        ;Ref Jorgensen, page 226, "-no-pie"
; **********************************************

;Declare library functions called
extern printf
extern scanf
global area

segment .data
; -----
; Initialize data to be used
welcomemsg db "This program will compute the area of your triangle.", 10, 0
mainpromptmsg db "Enter the floating point lengths of the 3 sides of your triangle", 10, 0
promptmsg db "Side %ld: ", 0
strform db "%s", 0
inputverifyformat db 10,"These values were received: %lf, %lf, %lf", 10,10, 0
floatform db "%lf", 0
outputmsg db "The area of this triangle is %lf square meters.", 10, 0
invalidmsg db "Invalid input, please input a floating point number or integer without letters and symbols (except for the the decimal point):", 10, 0
inequalityerrormsg db "Inputs of %lf, %lf, and %lf do not form a valid triangle.", 10, "(Triangle Inequality Theorem states that the sum of any two sides must be greater than the third).", 10, 0

segment .bss
; -----
; Empty segment

segment .text
area:

; -----
; Routine Prologue
;Back up registers to stack to preserve register data
push rbp
mov  rbp,rsp
push rdi
push rsi
push rcx
push rdx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf 
push qword -1	;Push extra to even out offset to 16

; -----
; Output welcome message and prompt for inputs
;Output welcome message
mov qword rdi, strform
mov qword rsi, welcomemsg
mov qword rax, 0
call printf

; -----
; Input three sides of the triangle
;Prompt msg
inputstart:
mov qword rdi, strform			;"%s"
mov qword rsi, mainpromptmsg	;"Enter the floating point lengths of the 3 sides of your triangle"
mov qword rax, 0
call printf

;Zero out registers and set counter variable to start at 1 (i=1)
mov r14, qword 0
movq xmm14, r14
movq xmm13, r14
movq xmm12, r14
mov r14, qword 1

;Loop start [ for(int i=1; i<=3; i++); ]
inputloopstart:
cmp r14, qword 3
jg inequalityerrorcheck
	;Print prompt for each side
	mov qword rdi, promptmsg	;"Side %ld: "
	mov qword rsi, r14
	mov qword rax, 0
	call printf
	
	;Input side length as double float
	mov qword rdi, floatform
	push qword 0	;Allocated stack memory to place scanned data into
	mov qword rsi, rsp
	mov qword rax, 1
	call scanf
	movsd xmm15, [rsp]
	pop r15

	cdqe
	cmp rax, 0
	jg switch_statement

	;Input was invalid
	;Flush buffer to avoid infinite error loop
	mov qword rdi, strform
	push qword 0
	mov qword rsi, rsp
	mov qword rax, 0
	call scanf
	pop qword r15

	mov qword rdi, invalidmsg
	mov qword rax, 0
	call printf
	jmp inputloopstart

switch_statement:
;Move value to correct register based on value of rcx
cmp r14, qword 1
jne switch_case_eins
movsd xmm14, xmm15		;If first input, place float to xmm14
jmp switchend

switch_case_eins:
cmp r14, qword 2
jne switch_case_zwei
movsd xmm13, xmm15		;If second input, place float to xmm13
jmp switchend

switch_case_zwei: ;Default case. No other case left but rcx = 3
movsd xmm12, xmm15		;If third input, place float to xmm12

switchend:
inc r14
jmp inputloopstart ; Prompt for input again

;Check if sides form a valid triangle
; Triangle Inequality Theorem:
;	For any sides X,Y,Z
;	X+Y > Z (error if X+Y <= Z for any three sides)
inequalityerrorcheck:
movsd xmm11, xmm14	;xmm11 = X
addsd xmm11, xmm13	;xmm11 = X+Y
ucomisd xmm11, xmm12
jbe inequalityerror	;if X+Y <= Z

movsd xmm10, xmm13	;xmm10 = Y
addsd xmm10, xmm12	;xmm10 = Y+Z	
ucomisd xmm10, xmm14
jbe inequalityerror	;if Y+Z <= X

movsd xmm9, xmm12	;xmm9 = Z
addsd xmm9, xmm14	;xmm9 = Z+X
ucomisd xmm9, xmm13
jbe inequalityerror	;if Z+X <= Y
jmp inputend		;else

inequalityerror:
mov rax, 1
mov qword rdi, inequalityerrormsg
movsd xmm0, xmm14	;Side 1
movsd xmm1, xmm13	;Side 2
movsd xmm2, xmm12	;Side 3
push qword 0
call printf
pop rax
jmp inputstart

;Valid float input has been accepted
inputend:
;Output the input
mov rax, 1
mov qword rdi, inputverifyformat
movsd xmm0, xmm14	;Side 1
movsd xmm1, xmm13	;Side 2
movsd xmm2, xmm12	;Side 3
push qword 0
call printf
pop rax

; -----
; Calculations
; Heron's formula:
;	s = (a+b+c)/2
;	Area = sqrt(s * (s-a) * (s-b) * (s-c))
;
; Due to inputs being measures of length, inputs and outputs are assumed to be positive
; S = (a+b+c)/2 = (0.5)*(a+b+c)
movsd xmm15, xmm14				;xmm15 = xmm14 (xmm15 = a)
addsd xmm15, xmm13				;xmm15 += xmm13 (xmm15 = a+b)
addsd xmm15, xmm12				;xmm15 += xmm12 (xmm15 = a+b+c)
mov qword r14, 0x3FE0000000000000		; 0.5 in Float Hex form
movq xmm11, r14				;xmm11 = 0.5
mulsd xmm15, xmm11				;xmm15 *= 0.5 (xmm15 = (0.5)*(a+b+c) = s)

movsd xmm11, xmm15				;xmm11 = xmm15 (xmm11 = s)
subsd xmm11, xmm14				;xmm11 -= xmm14 (xmm11 = s-a)
movsd xmm10, xmm15				;xmm10 = xmm15 (xmm11 = s)
subsd xmm10, xmm13				;xmm10 -= xmm13 (xmm10 = s-b)
movsd xmm9, xmm15				;xmm9 = xmm15 (xmm11 = s)
subsd xmm9, xmm12				;xmm9 -= xmm12 (xmm9 = s-c)

mulsd xmm15, xmm11				;xmm15 *= xmm11 (xmm15 = s*(s-a))
mulsd xmm15, xmm10				;xmm15 *= xmm10 (xmm15 = s*(s-a)*(s-b))
mulsd xmm15, xmm9				;xmm15 *= xmm9  (xmm15 = s*(s-a)*(s-b)*(s-c))

sqrtsd xmm14, xmm15				;xmm14 = sqrt(xmm15) (xmm14 = sqrt(s*(s-a)*(s-b)*(s-c)) = Area)

; -----
; Output final results and exit messages
push qword 0
mov qword rax, 1
mov qword rdi, outputmsg
movsd xmm0, xmm14
call printf
pop rax

;Ensure area is to be returned
movsd xmm0, xmm14
; -----
; Routine Epilogue
;Restore registers to original state
pop r8		;Remove extra -1 used to oven out offset, register is arbitrary
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rdx
pop rcx
pop rsi
pop rdi
pop rbp

ret







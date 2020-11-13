; **********************************************
; Program name: "Floating Point Herons Formula" (HW 5 for CPSC 240-03, Fall 2020)
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
; Program name: Floating Point Herons Formula
; Programming languages: One module in C, one in x86
; Date program began:	 2020-Nov-12
; Date program completed: 2020-Nov-
; Files in program:	triangle.c, area.asm
; Status: In progress
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

welcomemsg db "This circle function is brought to you by Josh Ibad, CPSC 240 - 03", 10, 0
promptmsg db "Please enter the radius of a circle as a floating point number: ", 0
strform db "%s", 0
inputverifyformat db "The number %lf was received.", 10, 0
floatform db "%lf", 0
outputmsg db "The circumference of a circle with this radius is %lf meters.", 10, 0
exitmsg db "The circumference will be returned to the main program. Please enjoy your circles.", 10, 0
invalidmsg db "Invalid input, please input a floating point number or integer without letters and symbols except for the the decimal point: ", 0

pi dq 0x400921fb54442d18 ;Obtained from C definition of pi in decimal, converted with calculator to ieee-754 hex

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

;Prompt for radius
mov qword rdi, strform
mov qword rsi, promptmsg
mov qword rax, 0
call printf

inputstart:
;Input radius as double float
mov qword rdi, floatform
push qword 0	;Allocated stack memory to place scanned data into
mov qword rsi, rsp
mov qword rax, 1
call scanf
movsd xmm15, [rsp]
pop r15

cdqe
cmp rax, 0
jg inputend

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

jmp inputstart ; Prompt for input again

;Valid float input has been accepted
inputend:
;Output the input
mov rax, 1
mov qword rdi, inputverifyformat
movsd xmm0, xmm15
push qword 0
call printf
pop rax

; -----
; Calculations
; Due to input being a distance, inputs and outputs are assumed to be positive
; Circumfernce: C = 2*pi*r
mov qword rax, 0x4000000000000000		;2 in Float Hex form
movq xmm12, rax			;Contains the 2 in float
movq xmm13, qword [pi] 	;Contains pi in float form (pi declared as constant in data segment)

						; x = r
mulsd xmm15, xmm12		; x = 2*x = 2*r
mulsd xmm15, xmm13		; x = pi*x = 2*r*pi = Circumeference

;Output circumference
push qword 0
mov qword rax, 1
mov qword rdi, outputmsg
movsd xmm0, xmm15
call printf
pop rax



; -----
; Output final results and exit messages
;Output exit message
	;finale:
;mov qword rdi, strform
;mov qword rsi, exitmsg
;mov qword rax, 0
;call printf

movsd xmm0, xmm15
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







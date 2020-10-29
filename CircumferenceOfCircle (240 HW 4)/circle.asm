; **********************************************
; Program name: "Circumference of Circle" (HW 4 for CPSC 240-03, Fall 2020)
; Details: Calculates the integer circumference and area of a circle given
; its integer radius, using the egyptian estimation of pi.
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
; Author email: ibadecoder@gmail.com
;
;Program info:
; Program name: Circumference of Circle
; Programming languages: One module in C, one in x86
; Date program began:	 2020-Oct-30
; Date program completed: 2020-Oct-30
; Files in program:	circumference.c, circle.asm
; Status: Complete (as of 2020-10-30).  No errors found after extensive testing.
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; Holliday, Floyd	- arithmeticSample.asm 
;	(https://sites.google.com/a/fullerton.edu/activeprofessor/open-source-info/x86-assembly/x86-examples/integer-arithmetic)
;
;Purpose:
; Calculate a circumference of a circle given a radius using double float arithmetic.
;	
;This file:
; Filename: circle.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l circle.lis -o circle.o circle.asm
; Link: gcc -m64 -no-pie -o egyptian.out -std=c11 circumference.o circle.o        ;Ref Jorgensen, page 226, "-no-pie"
; **********************************************


;Declare library functions called
extern printf
extern scanf

global circle

segment .data

; -----
; Initialize data to be used

welcomemsg db "This circle function is brought to you by Josh Ibad, CPSC 240 - 03", 10, 0
promptmsg db "Please enter the radius of a circle as a floating point number: ", 0
stringoutputformat db "%s", 0
inputverifyformat db "The number %lf was received.", 10, 0
doublefloatformat db "%lf", 0
outputmsg db "The circumference of a circle with this radius is %lf meters.", 10, 0
exitmsg db "The circumference will be returned to the main program. Please enjoy your circles.", 10, 0

pi dq 0x400921fb54442d18 ;Obtained from C definition of pi in decimal, converted with calculator to hex

segment .bss

; -----
; Empty segment

segment .text
circle:

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

sub rsp, 16
movdqu oword [rsp], xmm0

sub rsp, 16
movdqu oword [rsp], xmm1

; -----
; Output welcome message and prompt for inputs
;Output welcome message
mov qword rdi, stringoutputformat
mov qword rsi, welcomemsg
mov qword rax, 0
call printf

;Prompt for radius
mov qword rdi, stringoutputformat
mov qword rsi, promptmsg
mov qword rax, 0
call printf


;Input radius as double float
mov qword rdi, doublefloatformat
push qword 0	;Allocated stack memory to place scanned data into
mov qword rsi, rsp
mov qword rax, 0
call scanf
movsd xmm0, [rsp]

;Output the input
mov rax, 1
mov qword rdi, inputverifyformat
call printf

; -----
; Calculations
; Due to input being a distance, inputs and outputs are assumed to be positive
; Circumfernce: C = 2*pi*r
mov qword rax, 2
cvtsi2sd xmm1, rax
mulsd xmm0, xmm1

movsd xmm1, qword [pi]
mulsd xmm0, xmm1

;Output circumference
mov qword rax, 1
mov qword rdi, outputmsg
call printf

sub rsp, 16
movdqu oword [rsp], xmm0


; -----
; Output final results and exit messages
;Output exit message
finale:
mov qword rdi, stringoutputformat
mov qword rsi, exitmsg
mov qword rax, 0
call printf

; -----
; Routine Epilogue
;Restore registers to original state
pop qword r8		;Remove extra padding from pushing 128 bit xmm register

movdqu xmm1, oword [rsp]
add rsp, 16

movdqu xmm0, oword [rsp]
add rsp, 16

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







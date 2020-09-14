; **********************************************
; Program Name: "Sum of Array of Integers" (HW 2 for CPSC 240-03, Fall 2020)
; Details: Prompts user to input an array of integers, repeats the array
; for confirmation, and computes the sum of the array of integers.
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
; Program name: "Sum of Array of Integers"
; Programming languages: One module in C, three modules in x86, one module in C++
; Date program began:	 2020-Sep-13
; Date program completed: 2020-Sep-xx
; Files in program:	main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp
; Status: Work in Progress
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; 
;Purpose:
; Assembly module for gathering user input and creating an array of integers.
; Will detect and handle invalid inputs. Stops taking input with Cntrl + D.
;	
;This file:
; Filename: input_array.asm
; Language: x86-64 (Intel)
; Assemble: ...
; Link: ...        ;Ref Jorgensen, page 226, "-no-pie"
; **********************************************


;Declare library functions called
extern printf
extern scanf

global circle

segment .data

; -----
; Initialize data to be used

welcomemsg db "This circle function is brought to you by Josh Ibad", 10, 0
promptmsg db "Please enter the radius of a circle in whole number of meters: ", 0
stringoutputformat db "%s", 0
inputverifyformat db "The number %1d was received.", 10, 0
signedintegerinputformat db "%ld", 0
outputmsg db "The circumference of a circle with this radius is %ld and %d/7 meters.", 10, 0
exitmsg db "The integer part of the area will be returned to the main program. Please enjoy your circles.", 10, 0
errormsg db "Results are too large for a 64 bit integer.", 10, 0

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

; -----
; Output welcome message and prompt for inputs
;Output welcome message
mov qword rdi, stringoutputformat
mov qword rsi, welcomemsg
mov qword rax, 0
call printf

;Prompt for radius
mov qword rdi, stringoutputformat	;Consider removing<RRR>
mov qword rsi, promptmsg
mov qword rax, 0					;Consider remove<RRR>
call printf

;Input first integer
mov qword rdi, signedintegerinputformat
push qword -1						;WHY, Consider altering <RRR>
mov qword rsi, rsp					;WHY, Consider altering <RRR>
mov qword rax, 0
call scanf
pop qword r15	;Inputted radius integer

;Output the input
mov qword rdi, inputverifyformat
mov rsi, r15
mov qword rdx, r15					;WHY, Both rsi and rdx hold inputted value
mov qword rax, 0
call printf

; -----
; Calculations ----- Have yet to do;
; Due to input being a distance, inputs and outputs are assumed to be positive
; Circumfernce: C = 2r*22/7
mov qword rax, 44
mov qword rdx, 0
mul r15

cmp rdx, 0
jne overflowerror

mov qword r14, 7
div r14

;Output circumference
mov qword rdi, inputverifyformat
mov rsi, rax
	;rdx already contains remainder
mov qword rax, 0
call printf


; Area: A = r*r*22 / 7
mov qword rax, r15
mov qword rdx, 0
mul r15

cmp rdx, 0
jne overflowerror

mov qword r14, 22
mul r14

cmp rdx, 0
jne overflowerror

mov qword r14, 7
div r14

push rax	;Store area in stack
jmp finale

overflowerror:
mov qword rdi, stringoutputformat
mov qword rsi, errormsg
mov qword rax, 0
call printf
mov rax, -1
push rax

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
pop rax		;Retrieve obtained area

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







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
; Date program completed: 2020-Oct-03
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
extern malloc		; Used for allocating memory for arrays in heap space dynamically

global input_array

; -----
; Initialize data to be used
segment .data
stringoutputformat db "%s", 0
longintformat db "%ld", 0
invalidinputmsg db "Please enter a valid integer literal w/o extra characters (no decimal points).\nPress ENTER and CNTL+D to finish.", 10, 0
errormsg db "Program was unable to properly allocate memory for the inputted array. Terminating...", 10, 0

; -----
; Empty segment
segment .bss

segment .text
input_array:

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

mov r15, rdi		; Store the address to store array address to nonvolatile register
mov r14, rsi		; Store the address to store length to nonvolatile register
xor r13, r13		; To be used as counter variable for length

inputloopstart:
	;Input signed long integer
	mov qword rdi, longintformat
	push qword -1
	mov qword rsi, rsp
	xor rax, rax
	call scanf

	cmp rax, 0
	jg inputloopstart
	jl inputloopend
	;User input was invalid
	pop qword r12		; Remove invalid input
	mov qword rdi, stringoutputformat
	mov qword rsi, invalidinputmsg
	mov qword rax, 0
	call printf
	jmp inputloopstart

inputloopend:
pop qword r12		; Clean up stack
; -----
; Allocate heap space for the inputted array and populate with user input
mov rax, r13
mov r11, 8
mul r11
mov rdi, rax
xor rax, rax
call malloc

cmp rax, 0
je errorhandling
xor rcx, rcx
copyloopstart:
	cmp rcx, r13
	jge copyloopend
	pop rbx
	mov [rax + 8*rdi], rbx
	inc rcx
	jmp copyloopstart

copyloopend:
mov [r14], r13
mov [r15], rax
jmp finale

; -----
; Error handling block
; Prints error message and empties stack of values pushed by the function
errorhandling:
mov qword rdi, stringoutputformat
mov qword rsi, errormsg
mov qword rax, 0
call printf

mov rcx, r13
emptyloop:
	pop rax
	loop emptyloop

xor rax, rax

finale:
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







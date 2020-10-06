; ********************************************** 
; Program Name: "Bubble Sorting an Array of Integers" (HW 3 for CPSC 240-03, Fall 2020)
; Details: Prompts user to input an array of integers, repeats the array
; for confirmation, and sorts the array. Ticks at the beginning and end of
; execution are also displayed.
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
; Program name: "Bubble Sorting an Array of Integers"
; Programming Languages: One module in C, two modules in C++, 
;	four modules in x86-64 Intel Assembly
; Date program began:     2020-Oct-04
; Date program completed: 2020-Oct-05
; Files in program:	main.cpp, read_clock.asm, manager.asm, display_array.cpp,
;	bubble_sort.c, swap.asm, input_array.asm.
; Status: Completed (Finished as of 2020-Oct-05). Testing on Ubuntu 20.04, g++9.3.0 success.
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; 
;Purpose:
; Assembly module for gathering user input and creating an array of integers.
; Will detect and handle invalid inputs. Stops taking input with ENTER, CNTL + D.
; Follows C Calling Conventions for Linux Systems.
;	
;This file:
; Filename: input_array.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
; Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
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
invalidinputmsg db "Please enter a valid integer literal w/o extra characters (no decimal points).", 10, 9, "Press ENTER and CNTL+D to finish.", 10, 0
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
mov r13, qword 0	; To be used as counter variable for length
mov rax, qword 0

inputloopstart:
	;Input signed long integer
	mov qword rdi, longintformat
	push qword -1
	push qword -1
	mov rsi, rsp
	xor rax, rax
	call scanf
	pop qword r12
	pop qword r11

	cdqe
	cmp rax, 0
	jg goodinput
	jl inputloopend
	
	; User input was invalid
	; Flush buffer to avoid infinite error loop
	mov qword rdi, stringoutputformat
	push qword -1
	push qword -1
	mov rsi, rsp
	xor rax, rsp
	call scanf
	pop qword r12
	pop qword r12
	
	mov rdi, stringoutputformat
	mov rsi, invalidinputmsg
	xor rax, rax
	call printf
	jmp inputloopstart
	goodinput:
	push qword 0
	push qword r12
	inc r13
	jmp inputloopstart
	
inputloopend:
; -----
; Allocate heap space for the inputted array and populate with user input
mov rax, r13
mov r11, qword 8
mul r11
mov rdi, rax
mov r12, rax
mov qword rax, 0
call malloc

cmp rax, 0
je errorhandling

xor rcx, rcx
mov [r14], r13
mov [r15], rax
add rax, r12
copyloopstart:
	cmp rcx, r13
	jge finale
	pop rbx
	pop r11
	sub rax, 8
	mov [rax], rbx
	inc rcx
	jmp copyloopstart

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







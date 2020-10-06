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
; Date program completed: 2020-Oct-xx
; Files in program:	main.cpp, read_clock.asm, manager.asm, display_array.cpp,
;	bubble_sort.c, swap.asm, input_array.asm.
; Status: Under Development
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; 
;Purpose:
; Returns the number of ticks as calculated by the machine.
;	
;This file:
; Filename: read_clock.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l read_clock.lis -o read_clock.o read_clock.asm
; Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
; **********************************************
extern printf

;Declare library functions called
global read_clock

; -----
; Initialize data to be used
segment .data
stringoutputformat db "%s", 0
errormsg db "Summation caused overflow over signed 64-bit integer. Hence, summation has been terminated", 10, 0
invalidaddressmsg db "Invalid address or length provided. Terminating...", 10, 0

; -----
; Empty segment
segment .bss

segment .text
read_clock:

; -----
; Routine Prologue
; Back up registers to stack to preserve register data
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
; Sum loop
; rdi has been preserved, containing the address of the array
; rsi has been preserved, containig the length of the array

; Perform (rsi = rsi*8 + rdi) to get final address in array
xor rdx, rdx
mov rax, rsi
mov r10, 8
mul r10
mov rsi, rax
add rsi, rdi
jc invalidaddresserror
xor rax, rax		; Zero out rax, the sum accumulator variable 

sumloop:
	cmp rdi, rsi
	jge finale
	add rax, qword [rdi]		
	jo overflowerror	; If overflow error met, jump out of loop and run
							; error handling code.
	add rdi, 8			; Increment the address by a long int's size (8 bytes)
							; Done here to avoid overhead from a "qword [rdi + rcx*8]"
							; Multiplications are more expensive than additions
	jmp sumloop

invalidaddresserror:		
mov qword rdi, stringoutputformat
mov qword rsi, invalidaddressmsg
mov qword rax, 0
call printf
jmp finale

overflowerror:		
mov qword rdi, stringoutputformat
mov qword rsi, errormsg
mov qword rax, 0
call printf
; The rax register already has eroneous result and has been noted in the
; printed message, hence the code does not bother to alter the register
; to another eroneous value (all values in the domain are valid values, 
; no return value is available to be exclusively used for overflow errors)

; <REM> sumloopexit:		; Loop exit. Empty since no further processing required.

finale:
; -----
; Routine Epilogue
; Restore registers to original state
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







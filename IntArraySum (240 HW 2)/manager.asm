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
; Date program completed: 2020-Oct-04
; Files in program:	main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp
; Status: Complete (as of 2020-Oct-04).  No errors found after extensive testing.
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; 
;Purpose:
; Assembly module to manage calling functions from submodules and appropriately transfer
; data between functions and this manager module, displaying messages to show progress.
;	
;This file:
; Filename: manager.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o manager.o input_array.o sum.o display_array.o 
; **********************************************


;Declare library functions and external modules to be called
extern printf
extern input_array
extern display_array
extern sum

global manager

; -----
; Initialize data to be used
segment .data

stringoutputformat db "%s", 0
welcomemsg db "This program will sum your array of integers", 10, 0
inputarraymsg db "Enter a sequence of long integers separated by white space.", 10, 09, "After the last input press ENTER followed by CNTL + D", 10, 0
displayarraymsg db 10, "These %ld numbers were received and placed into the array", 10, 0
sumoutputmsg db 10, "The sum of the %ld numbers in this array is %ld", 10, 0
exitmsg db 10, "The sum will now be returned to the main function.", 10, 0
errormsg db "Program was not able to create the array.", 10, 9, "The program will now terminate", 10, 0

; -----
; Empty segment
segment .bss

segment .text
manager:

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
push qword -1		;Push extra to even out offset to 16

; -----
; Output welcome message and setup any registers or preprocessing needed
mov qword rdi, stringoutputformat
mov qword rsi, welcomemsg
mov qword rax, 0
call printf

; -----
; 	Input Array of Ints
; Output instructions for inputting the array
mov qword rdi, stringoutputformat
mov qword rsi, inputarraymsg
mov qword rax, 0
call printf

; Call input_array module to allow user to input an array of integers
push qword -1
mov rdi, rsp		; Address in stack in which to store array's address
push qword -1
mov rsi, rsp		; Address in stack in which to store array's length
xor rax, rax
call input_array
pop qword r14		; r14 stores the array length
pop qword r13		; r13 stores the array address

cmp rax, 0
je errorhandling

; -----
; 	Display array.
; Print the corresponding message, then call the display_array module to list the
; contents of array for confirmation by the user.
mov qword rdi, displayarraymsg
mov rsi, r14		; Array length
mov qword rax, 0
call printf

; Call display_array and feed in the address of the input array
mov rdi, r13		; Array address
mov rsi, r14		; Array length
xor rax, rax
call display_array

; -----
; 	Sum function
; Call sum function
mov rdi, r13		; Array address
mov rsi, r14		; Array length
xor rax, rax
call sum
mov r15, rax
; Print results
mov qword rdi, sumoutputmsg
mov rsi, r14		; Array length
mov rdx, rax
mov qword rax, 0
call printf

jmp finale

; -----
; Error handling block to print error message if memory allocation failed
errorhandling:
mov qword rdi, stringoutputformat
mov qword rsi, errormsg
mov qword rax, 0
call printf

; -----
; Final blocks of code. Prints final messages, restores former state, preps return val.
finale:
mov qword rdi, stringoutputformat
mov qword rsi, exitmsg
mov qword rax, 0
call printf

mov rax, r15
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







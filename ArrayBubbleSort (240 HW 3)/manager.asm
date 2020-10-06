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
; Assembly module to manage calling functions from submodules and appropriately
; transfer data between functions and this manager module, displaying messages to 
; show progress.
;	
;This file:
; Filename: manager.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
; **********************************************


;Declare library functions and external modules to be called
extern printf
extern input_array
extern display_array
extern bubble_sort

global manager

; -----
; Initialize data to be used
segment .data

stringoutputformat db "%s", 0
welcomemsg db "This program will sum your array of integers", 10, 0
inputarraymsg db "Enter a sequence of long integers separated by white space.", 10, 09, "After the last input press ENTER followed by CNTL + D", 10, 0
displayarraymsg db 10, "These %ld numbers were received and placed into the array", 10, 0
sortmsg db 10, "The array has been sorted by the bubble sort algorithm.", 10, 0
displaysortedarraymsg db 10, "This is the order of the values in the array now:", 10, 0
exitmsg db 10, "The largest number will now be returned to the main function.", 10, 0
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
; Sort array
mov qword rdi, stringoutputformat
mov qword rsi, sortmsg
xor rax, rax
call printf

; Sort the array by calling the bubble_sort module
mov rdi, r13		; Array address
mov rsi, r14		; Array length
xor rax, rax
call bubble_sort

; -----
; 	Display sorted array.
; Print the corresponding message, then call the display_array module to list the
; contents of the sorted array.
mov qword rdi, stringoutputformat
mov qword rsi, displaysortedarraymsg
mov qword rax, 0
call printf

; Call display_array and feed in the address of the input array
mov rdi, r13		; Array address
mov rsi, r14		; Array length
xor rax, rax
call display_array

jmp finale

; -----
; Error handling block to print error message if memory allocation failed
errorhandling:
mov qword rdi, stringoutputformat
mov qword rsi, errormsg
mov qword rax, 0
call printf

mov qword r14, 1	; Safe values for termination after error
mov qword [r13], 0	; Safe values for termination after error
; -----
; Final blocks of code. Prints final messages, restores former state, preps return val.
finale:
mov qword rdi, stringoutputformat
mov qword rsi, exitmsg
mov qword rax, 0
call printf

mov rax, qword [r13 + 8*r14 - 8]	;Access last element of array (the max)
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







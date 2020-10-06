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
; https://en.wikipedia.org/wiki/XOR_swap_algorithm
; 
;Purpose:
; Swaps the values stored in two memory addresses. (Aids in bubble sort)
;	
;This file:
; Filename: swap.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l swap.lis -o swap.o swap.asm
; Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
; **********************************************
;Declare library functions called
global swap

; -----
; Empty
segment .data

; -----
; Empty segment
segment .bss

segment .text
swap:

; -----
; Routine Prologue
; Back up registers to stack to preserve register data
; All registers preserved within module, except for flags
; 	which can be altered by xor op. Thus only rflags is
;	pushed (and rbp to preserve it while using stack)
; Other pushes and pops removed to maximize speed of execution.
push rbp
mov  rbp,rsp
pushf 

; ---
; rdi contains the address to the first operand
; rsi contains the address to the second opeand
; XOR Swap algorithm found in https://en.wikipedia.org/wiki/XOR_swap_algorithm

xor qword [rdi], qword [rsi]	; rdi = rdi XOR rsi
xor qword [rsi], qword [rdi]	; rsi = rsi XOR rdi
xor qword [rdi], qword [rsi]	; rdi = rdi XOR rsi 

; -----
; Routine Epilogue
; Restore registers to original state
popf
pop rbp
ret







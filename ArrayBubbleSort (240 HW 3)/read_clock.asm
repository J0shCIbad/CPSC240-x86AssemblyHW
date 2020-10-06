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
; https://c9x.me/x86/html/file_module_x86_id_278.html
; https://www.intel.com/content/www/us/en/embedded/training/ia-32-ia-64-benchmark-code-execution-paper.html
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

global read_clock

; -----
; Empty segment
segment .data

; -----
; Empty segment
segment .bss

segment .text
read_clock:

; -----
; Routine Prologue
; Back up registers to stack to preserve register data
; The simplistic program preserves other registers, which have been omitted
; from the pushing and popping.
push rbp
mov  rbp,rsp
push rdx
push rcx
pushf 

xor rax, rax
xor rdx, rdx	
rdtscp			; "Read Time-Stamp Counter and Processor ID" instruction,
				; reads time stamp to EDX:EAX and Processor ID to ECX

rol rdx, 32		; Bitwise shift left of rdx by 32 bits
				; Since the higher bits of rdx have been cleared to zero, the
				; rotation ensures that the highest 32 bits contains the contents 
				; of EDX, and the lower 32 bits contains 0's
and rax, rdx	; And to gain one full 64 bit register containing EDX:EAX

; -----
; Routine Epilogue
; Restore registers to original state
popf
pop rcx
pop rdx
pop rbp

ret







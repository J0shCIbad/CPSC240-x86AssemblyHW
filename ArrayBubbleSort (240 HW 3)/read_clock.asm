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
; https://stackoverflow.com/questions/19555121/how-to-get-current-timestamp-in-milliseconds-since-1970-just-the-way-java-gets
;	- The C code is used as a reference for writing assembly x86 counterpart
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

extern clock_gettime
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
push rdi
push rsi
push rcx
push rdx
push r14
push r15
pushf 

mov rdi, qword 0
mov rdi, dword 4	; 32-bit value of 4 denotes CLOCK_MONOTONIC_RAW
push qword 0
push qword 0
mov rsi, rsp		; Address of 16-bytes of memory for struct timespec
call clock_gettime

pop qword rax		; rax contains seconds
pop qword r15		; r15 contains miliseconds

cqo
mov qword r14, 1000000
mul r14
add rax, r15

; -----
; Routine Epilogue
; Restore registers to original state
popf
pop r15
pop r14
pop rdx
pop rcx
pop rsi
pop rdi
pop rbp

ret







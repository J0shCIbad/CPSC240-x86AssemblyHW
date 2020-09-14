README for Egyptian Circle (HW1 for CSUF CPSC240-03, Floyd Holliday, Fall 2020)
Time-stamp: <2020-09-07 11:53:54 Josh Ibad>
------------------------------------------------------------
	Program name: "Egyptian Circle" (HW 1 for CPSC 240-03, Fall 2020)
	Details: Calculates the integer circumference and area of a circle given
	its integer radius, using the egyptian estimation of pi.
	Copyright (C) 2020  Josh Ibad

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License version 3 as 
	published by the Free Software Foundation.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	A copy of the GNU General Public License v3 is available here:
	<https://gnu.org/licenses/>
------------------------------------------------------------
	Author name: Josh Ibad
	Author email: ibadecoder@gmail.com

	Program Name: "Egyptian Circumference"
	Purpose: To calculate the integer circumference and area of a circle
	given its integer radius, using the egyptian estimation of pi.
	Programming Languages: One module in C, one module in x86
	Date program began:     2020-Sep-01
	Date program completed: 2020-Sep-07

	Files in this program: egyptian.c, circle.asm
		egyptian.c	= Driver module for running assembly code
		
		circle.asm	= 
	
	Status: Complete (as of 2020-09-07).  No errors found after extensive testing.
 
	References:
		Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
		Professor Floyd Holliday's: "Arithmetic Integer 1.0 program"
			https://sites.google.com/a/fullerton.edu/activeprofessor/open-source-info/x86-assembly/x86-examples/integer-arithmetic

Compilation and Execution instructions:
	Assemble: nasm -f elf64 -l circle.lis -o circle.o circle.asm
	Compile: gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11
	Link: gcc -m64 -no-pie -o egyptian.out -std=c11 egyptian.o circle.o

Warnings:
	* The module circle.asm contains PIC non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
	non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully.
	* The program is intended to retain results in 64 bit structures. Any
	results that resulted in negative numbers or extremely large numbers
	return an error message noting that the result can not be stored in 64 bits.
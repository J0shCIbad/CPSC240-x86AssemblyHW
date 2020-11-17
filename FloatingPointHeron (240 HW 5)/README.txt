README for Area of Triangles (HW 5 for CSUF CPSC240-03, Floyd Holliday, Fall 2020)
Time-stamp: <2020-11-17 14:03:56 Josh Ibad>
------------------------------------------------------------
	Program name: "Area of Triangles" (HW 5 for CPSC 240-03, Fall 2020)
	Details: Calculates the floating point area of a triangle given its
	three side lengths, using Heron's formula.
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
	Author email: joshcibad@csu.fullerton.edu

	Program Name: "Area of Triangles" (HW 5 for CPSC 240-03, Fall 2020)
	Purpose: Calculates the floating point area of a triangle given its
	three side lengths, using Heron's formula.
	Programming Languages: One module in C, one module in x86
	Date program began:     2020-Nov-12
	Date program completed: 2020-Nov-17

	Files in this program: triangle.c, area.asm
		triangle.c	= A C driver module to call the x86-64 assembly program
		of "area.asm". Prints welcome messages and prints the results of the 
		program call.
		
		area.asm	= Accepts three floating point inputs representative of
		side lengths of a triangle. The inputs are validated then the area 
		is calculated using Heron's formula. 
		
		run.sh = Bash script for assembling, compiling, linking, and running program
		
		README.txt = This file. Contains info about the program.
	
	Status: Complete (as of 2020-Nov-17). Successful after testing.
 
	References:
		Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu

Compilation and Execution instructions:
	Assemble: nasm -f elf64 -l area.lis -o area.o area.asm
	Compile: gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11
	Link: gcc -m64 -no-pie -o triangle.out -std=c11 triangle.o area.o
	Run: ./triangle.out

Warnings:
	* The module circle.asm contains PIC non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
	non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully.
	
	Main warnings:
	* Error checking on inputs utilizes scanf functionality. The program will continually
	prompt the user for a valid input until one is given. When an invalid input is given,
	scanf first tries to truncate the input or convert it to a double. An integer input is
	accepted and converted to its corresponding floating point value. An invalid input such
	as "TEN" can not be understood and is completely rejected, however, "1.0kfv", "1.asv", and "1oif"
	are all accepted as 1.0 since scanf will truncate the invalid portion of the input.
	
	* The printed floating point does not show all digits. However, the hexadecimal reflects the
	full value of the number. The decimal output shows less precision than its hexadecimal counterpart.
README for Harmonic Sum (HW 6 for CSUF CPSC240-03, Floyd Holliday, Fall 2020)
Time-stamp: <2020-11-17 07:38:23 Josh Ibad>
------------------------------------------------------------
	Program name: "Harmonic Sum" (HW 6 for CPSC 240-03, Fall 2020)
	Details: Given an input N, calculates the Harmonic Sum, H(N),
	displaying 9 intermediate values in between.
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

	Program Name: "Harmonic Sum" (HW 6 for CPSC 240-03, Fall 2020)
	Purpose: Given an input N, calculates the Harmonic Sum, H(N),
	displaying 9 intermediate values in between.
	Programming Languages: One module in C++, two modules in x86
	Date program began:     2020-Nov-22
	Date program completed: 2020-Nov-XX

	Files in this program: main.cpp, manager.asm, read_clock.asm
		main.cpp	= A C++ driver module to call the manager x86_64 module.
		Prints welcome and exit messages 
		
		manager.asm	= 
		
		read_clock.asm = Returns the number of ticks as calculated by the machine.
		
		run.sh = Bash script for assembling, compiling, linking, and running program
		
		README.txt = This file. Contains info about the program.
	
	Status: Complete (as of 2020-Nov-17). Successful after testing.
 
	References:
		Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu

Compilation and Execution instructions:
	Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
	Assemble: nasm -f elf64 -l read_clock.lis -o read_clock.o read_clock.asm
	
	Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17
	
	Link: gcc -m64 -no-pie -o main.out -std=c11 main.o manager.o read_clock.o
	Run: ./main.out

Warnings:
	New Warnings:
	* Program checks input if it forms a valid triangle using Triangle Inequality 
	Theorem (that any 2 side lengths summed is greater than the 3rd). If this condition is not met
	the input is considered invalid.
	
	* Upon entering an invalid side length, the program dumps all inputs and prompts the
	user for all three side lengths once more.
	
	* Upon entering three valid side lengths that do not form a valid triangle (under Triangle
	Inequality Theorem) the program also dumps the inputs and prompts the user for all three
	side lengths another time.
	
	Repeating Warnings:
	* Error checking on inputs utilizes scanf functionality. The program will continually
	prompt the user for a valid input until one is given. When an invalid input is given,
	scanf first tries to truncate the input or convert it to a double. 
		* An integer input is accepted and converted to its corresponding floating point value.
		* An invalid input such as "TEN" can not be understood and is completely rejected.
		* The inputs "1.0kfv", "1.asv", and "1oif" are all accepted as 1.0 since scanf will 
		truncate the invalid portion of the input.
	
	* The printed floating point does not show all digits. However, the hexadecimal reflects the
	full value of the number. The decimal output shows less precision than its hexadecimal counterpart.
	
	* The module circle.asm contains PIC non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
	non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully on Ubuntu 20.04, gcc v9.3.0
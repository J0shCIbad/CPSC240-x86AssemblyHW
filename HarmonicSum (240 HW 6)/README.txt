README for Harmonic Sum (HW 6 for CSUF CPSC240-03, Floyd Holliday, Fall 2020)
Time-stamp: <2020-11-25 11:24:23 Josh Ibad>
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
	Date program completed: 2020-Nov-X5
	Status:  Completed (2020-Nov-25). Successful execution after testing on Ubuntu 20.04, gcc v9.3.0

	Files in this program: main.cpp, manager.asm, read_clock.asm
		* main.cpp	= A C++ driver module to call the manager x86_64 module.
		Prints welcome and exit messages 
		
		* manager.asm	= Prompts user to input an integer denoting the number of terms to
		include in the harmonic sum. Then calculates it, outputing intermediate
		values in the way. CPU clock is read before and after the calculation,
		and the difference (the duration of the calculation) is shown.
		
			* This program will check the input and select which algorithm to use.
			For n <= 5, the O(1) runtime asymptotic expansion algortihm is too 
			inaccurate, thus the O(n) regular summation algorithm is used.
			Otherwise, for n > 5, the O(1) runtime asymptotic expansion algorithm
		
		* read_clock.asm = Returns the number of ticks as calculated by the machine.
		
		* r.sh = Bash script for assembling, compiling, linking, and running program
		
		* README.txt = This file. Contains info about the program.
	
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
	* This program uses two different algorithms for calculating H(n), depending on the
	size of n.
		* For small numbers (n <= 5), the program uses the regular summation algorithm
		which runs in O(n) runtime complexity but retains maximum precision.
		* For larger numbers (n > 5), the program uses the asymptotic expaansion algorithm
		which runs in O(1) runtime complexity even for the maximum input of n, at the
		cost of acceptible imprecision which decreases as n grows (|Error| < 1 E -10)
	
	* The asymptotic expansion algorithm used for n > 5 is a very accurate approximation
	of H(n) at the benefit that it performs with O(1) constant runtime and space complexity.
	This will explain the slight imprecision for any number n > 5.
		* The error only decreases as n increases, since the value of the first terms:
		H(n) = ln(n) + y (Euler-mascheroni constant), grows in accuracy for larger values of n.
		* The error should only be at most, 1 E -10
	
	* Because the program directly calculates H(n), it does not actually find intermediate values.
	To fit the expected output, the program calculates the "intermediate" values separately,
	to simulate the program "summing" up to H(n). This adds to the runtime, however due to
	the O(1) time complexity and the "intermediate" values being only 10 intermediates printed,
	the time complexity remains O(1), but multiplied by a constant factor.
	
	Repeating Warnings:
	* Error checking on inputs utilizes scanf functionality. The program will continually
	prompt the user for a valid input until one is given. When an invalid input is given,
	scanf first tries to truncate the input or convert it to a long integer.
		* An input of "10sdcv" is truncated to 10, and accepted as 10
		* An input of "TEN" is completely invalid and rejected
		* An input of 10.01 is truncated to 10, and accepted as 10
	
	* The module circle.asm contains PIC non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
	non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully on Ubuntu 20.04, gcc v9.3.0
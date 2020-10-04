README for Sum of Array of Integers (HW2 for CSUF CPSC240-03, Floyd Holliday, Fall 2020) 
Time-stamp: <2020-10-04 12:26:04 Josh Ibad>
------------------------------------------------------------
	Program name: "Sum of Array of Integers" (HW 2 for CPSC 240-03, Fall 2020)
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

	Program Name: "Sum of Array of Integers"
	Purpose: Prompts user to input an array of integers, repeats the array
	for confirmation, and computes the sum of the array of integers.
	Programming Languages: One module in C, three modules in x86, one module in C++
	Date program began:     2020-Sep-13
	Date program completed: 2020-Oct-04

	Files in this program: main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp
		main.c	= A C driver module to call the x86-64 assembly program of "manager.asm"
		and show the value received from the function call.
		
		manager.asm = Assembly module to manage calling functions from submodules and
		appropriately transfer data between functions and this manager module, 
		displaying messages to show progress.
		
		input_array.asm = Assembly module for gathering user input and creating an 
		array of integers. Will detect and handle invalid inputs. Stops taking input
		with ENTER, CNTL + D. Follows C Calling Conventions for Linux Systems.
		
		sum.asm = Sums together an array of integers given the array address and 
		length. Follows C Calling Conventions for Linux Systems.
		
		display_array.cpp = Displays an array of integers given the array address 
		and length. (To be used in program to confirm user input).
		
		r.sh = Bash script for assembling, compiling, and linking the program
	
	Status: Complete (as of 2020-Oct-04).  No errors found after extensive testing.
 
	References:
		Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
		
Compilation and Execution instructions:
	Assemble:	nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
				nasm -f elf64 -l sum.lis -o sum.o sum.asm
				nasm -f elf64 -l manager.lis -o manager.o manager.asm
				
	Compile: 	g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17
				gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
	
	Link: 		g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o manager.o input_array.o sum.o display_array.o 

	Run:		./main.out

Warnings:
	* The modules manager.asm, input_array.asm, and sum.asm contains PIC 
		non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
		non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully.
	
	* The program has been designed to dynamically allocate the array of inputs, hence
		the program's limits for user input are defined by the available primary
		memory, specifically, a bit less than half of the availalbe primary memory not
		yet used by the program. (This is because the user inputs are first stored on
		the stack, then heap space is allocated of the same size, followed by a
		transfer from the stack to heap.) This was done to avoid arbitrarily-set
		limits by code writers, and to let the machine's hardware limitations determine
		the limits of the program.
	* The program has some error checking for inputs. The program checks if value input
		is a signed integer. Floating point values and String values will not be saved
		and the program will display a message showing the proper inputs to display.
		HOWEVER, inputting an integer value that is too large or too small to store
		properly in a 64-bit signed integer value will cause input to be truncated to
		the most significant digits in the String which will fit a 64-bit signed 
		integer (the maximum being 9223372036854775807). (This was only tested on Ubuntu,
		this behaviour may vary on different on other systems, but is not expected to
		do so due to the documentation of scanf). Overflowing values should not cause a 
		buffer overflow and will not effectively overwrite other written data.
	* Error checking is only done within submodules. If an error occurs in memory 
		allocation, or overflows occur in calculation, the submodules will note the
		error by displaying a message, terminate the submodule execution, but resume
		execution of the rest of the program, displaying erroneous sums and other
		erroneous messages following the error message. However, these errors are quite
		rare, as it requires An unreasonably large amount of inputs from the user, or a
		sequence of unreasonably large numbers which the computer itself can not 
		compute.
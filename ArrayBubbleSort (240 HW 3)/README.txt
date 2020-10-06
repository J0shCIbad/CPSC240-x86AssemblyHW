README for Bubble Sorting an Array of Integers (HW3 for CSUF CPSC240-03, Floyd Holliday, Fall 2020) 
Time-stamp: <2020-10-04 12:26:04 Josh Ibad>
------------------------------------------------------------
	Program name: "Bubble Sorting an Array of Integers" (HW 3 for CPSC 240-03, Fall 2020)
	Details: Prompts user to input an array of integers, repeats the array
	for confirmation, and sorts the array. Ticks at the beginning and end of
	execution are also displayed.
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
	for confirmation, and sorts the array. Tics at the beginning and end of
	execution are also displayed.
	Programming Languages: One module in C, two modules in C++, 
		four modules in x86-64 Intel Assembly
	Date program began:     2020-Oct-04
	Date program completed: 2020-Oct-xx

	Files in program:	main.cpp, read_clock.asm, manager.asm, display_array.cpp,
		bubble_sort.c, swap.asm, input_array.asm.
		
		main.cpp = A C++ Driver module for the program. Calls the read_clock.asm 
			module to print the ticks in the beginning of execution and after it.
			Also prints welcome messages, calls the manager.asm module to execute 
			the majority of the program's code, then prints the obtained values and
			the exit messages.
		
		read_clock.asm = Returns the number of ticks as calculated by the machine.
		
		manager.asm = Assembly module to manage calling functions from submodules and
			appropriately transfer data between functions and this manager module, 
			displaying messages to show progress.
		
		display_array.cpp = Displays an array of integers given the array address 
			and length. (To be used in program to confirm user input).
		
		bubble_sort.c = A C module for sorting an array using the bubble sort 
			algorithm, given the array's address and length. The bubble sort 
			algorithm will, for each iteration, check each consecutive elements in 
			the array and swap them if they are out of order. The algorithm executes
			when no swaps occur during an iteration (detected using a dirty bit). As
			swaps are the most time consuming operation of the algorithm, swapping is
			deferred to an assembly program called swap.asm. 
		
		swap.asm = Swaps the values stored in two memory addresses.
			(Aids in bubble sort)
		
		input_array.asm = Assembly module for gathering user input and creating an 
			array of integers. Will detect and handle invalid inputs. Stops taking
			input with ENTER, CNTL + D. Follows C Calling Conventions for Linux 
			Systems.
		
		r.sh = Bash script for assembling, compiling, and linking the program
	
	Status: Under Development
 
	References:
		Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
		
Compilation and Execution instructions:
	Assemble:	nasm -f elf64 -l read_clock.lis -o read_clock.o read_clock.asm
				nasm -f elf64 -l manager.lis -o manager.o manager.asm
				nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
				nasm -f elf64 -l swap.lis -o swap.o swap.asm
				
	Compile: 	gcc -c -Wall -m64 -no-pie -o bubble_sort.o bubble_sort.c -std=c11
				g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17
				g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17
	
	Link: 		g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o

	Run:		./main.out

Warnings:
	* The modules read_clock.asm, manager.asm, input_array.asm, and swap.asm contains 
		PIC non-compliant code.
	* The assembler outputs a non-compliant object file.
	* The C compiler is directed to create a non-compliant object file.
	* The linker received a parameter telling the linker to expect 
		non-compliant object files, and to output a non-compliant executable.
	* The program runs successfully.
	
	New warnings for HW 3:
	* 
	
	Old warnings for modules used since HW 2:
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
/** 
 * 	Program Name: "Bubble Sorting an Array of Integers" (HW 3 for CPSC 240-03, Fall 2020)
 * 	Details: Prompts user to input an array of integers, repeats the array
 *	for confirmation, and sorts the array. Ticks at the beginning and end of
 *	execution are also displayed.
 *  Copyright (C) 2020  Josh Ibad

 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License version 3 as 
 * 	published by the Free Software Foundation.

 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *	A copy of the GNU General Public License v3 is available here:
 *  <https://gnu.org/licenses/>
 **/

/*
 * Author name: Josh Ibad
 * Author email: ibadecoder@gmail.com
 * 
 * Program name: "Bubble Sorting an Array of Integers"
 * Programming Languages: One module in C, two modules in C++, 
 *		four modules in x86-64 Intel Assembly
 * Date program began:     2020-Oct-04
 * Date program completed: 2020-Oct-xx
 * Files in program:	main.cpp, read_clock.asm, manager.asm, display_array.cpp,
 *		bubble_sort.c, swap.asm, input_array.asm.
 * Status: Under Development
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	A C++ Driver module for the program. Calls the read_clock.asm module to print 
 *  the tics in the beginning of execution and after it. Also prints welcome 
 *	messages, calls the manager.asm module to execute the majority of the program's
 *	code, then prints the obtained values and the exit messages.
 *
 * This file:
 *	Filename: main.cpp
 *	Language: C++
 *	Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17
 *	Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
 */

#include <iostream>
//#include <stdio.h> - For g++8 and below

extern long int manager();
extern long int read_clock();
#define sortArray() manager()

int main(){
	long res = -1;
	res = read_clock();
	std::cout << "The time on the CPU clock is now " << res <<
		" ticks" << std::endl;
	
	std::cout << "Welcome to the \"Bubble Sorting an Array of Integers\" program." <<
		std::endl << "by: Josh Ibad" << std::endl << std::endl;
		
	res = sortArray(); 	//Call to sortArray (alias of the "manager.asm" function)
	
	std::cout << std::endl << "Main received " << res <<
		", and plans to keep it." << std::endl <<
		"Main will return 0 to the OS. Bye" << std::endl;

	res = read_clock();
	std::cout << "The time on the CPU clock is now " << res <<
		" ticks." << std::endl;
		
	return 0;
	
	/* - Use the following commented code instead for g++8 and below
	 * std::cout << "The time on the CPU clock is now ";
	 * printf("%ld", res);
	 * std::cout << " ticks" << std::endl;
	
	 * std::cout << "Welcome to the \"Bubble Sorting an Array of Integers\" program." <<
	 *	std::endl << "by: Josh Ibad" << std::endl << std::endl;
		
	 * res = -1;
	 * res = sortArray(); 	//Call to sortArray (alias of the "manager.asm" function)
	
	 * std::cout << std::endl << "Main received ";
	 * printf("%ld", res);
	 * std::cout << ", and plans to keep it." << std::endl <<
	 * 	"Main will return 0 to the OS. Bye" << std::endl;
		
	 * res = -1;
	 * res = read_clock();
	 * std::cout << "The time on the CPU clock is now ";
	 * printf("%ld", res);
	 * std::cout << " ticks." << std::endl;
	 */
}

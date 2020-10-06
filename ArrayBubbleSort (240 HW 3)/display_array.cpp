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
 *	Displays an array of integers given the array address and length.
 *	(To be used in program to confirm user input).
 *
 * This file:
 *	Filename: display_array.cpp
 *	Language: C++
 *	Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17
 *	Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
 */

#include <iostream>
//#include <stdio.h> - For g++ 8 and below

extern "C" void display_array(long int*, long int);
/**
 * Displays an array to output. The array as implemented in assembly code
 * is stored in the stack, starting from higher memory address to which 
 * int* arr points to, to lower memory address.
 */
void display_array(long int* arr, long int len){
	for(long int i=0; i<len; i++, arr++){
		std::cout << *arr;
		//printf("%ld", *arr); - For g++ 8 and below
		if(i == len-1){
			std::cout << std::endl;
		}else{
			std::cout << "\t";
		}
	}
}

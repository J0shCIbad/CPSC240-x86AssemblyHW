/**
 * 	Program Name: "Sum of Array of Integers" (HW 2 for CPSC 240-03, Fall 2020)
 * 	Details: Prompts user to input an array of integers, repeats the array
 *	for confirmation, and computes the sum of the array of integers.
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
 * Program Name: "Sum of Array of Integers"
 * Programming Languages: One module in C, three modules in x86, one module in C++
 * Date program began:     2020-Sep-13
 * Date program completed: 2020-Sep-xx
 * Files in this program: main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp
 * Status: Work in Progress
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	Displays an array of integers. (To be used in program to confirm user input).
 *
 * This file:
 *	Filename: display_array.cpp
 *	Language: C++
 *	Compile:
 *	Link:
 */

#include <iostream>

/**
 * Displays an array to output. The array as implemented in assembly code
 * is stored in the stack, starting from higher memory address to which 
 * int* arr points to, to lower memory address.
 */
void display_array((long int)* arr, long int len){
	for(long int i=0; i<len; i++, arr--){
		std::cout << *arr;
		if(i == len-1){
			std::cout << std::endl;
		}else{
			std::cout << "\t";
		}
	}
}

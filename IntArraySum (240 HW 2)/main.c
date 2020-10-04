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
 * Date program completed: 2020-Oct-04
 * Files in this program: main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp
 * Status: Complete (as of 2020-Oct-04).  No errors found after extensive testing.
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	A C driver module to call the x86-64 assembly program of "manager.asm" and show the
 *	value received from the function call.
 *
 * This file:
 *	Filename: main.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
 *	Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o manager.o input_array.o sum.o display_array.o 
 */

#include <stdio.h>
#include <stdint.h>

long int manager();
#define sumOfIntArray() manager()

int main(){
	printf("%s\n%s\n\n", "Welcome to \"Sum of Array of Integers\".", "by: Josh Ibad");
	long res = -1;
	res = sumOfIntArray(); //Call to function
	printf("%s%ld%s\n", "Main received integer: ", res, " as the sum of the array, and is not sure what to do with it.");
	printf("%s\n%s\n", "Main will now return 0 to OS. Bye.", "---End of program---");
	return 0;
}

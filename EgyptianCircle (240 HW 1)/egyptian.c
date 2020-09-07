/**
 * 	Program name: "Egyptian Circle" (HW 1 for CPSC 240-03, Fall 2020)
 * 	Details: Calculates the integer circumference and area of a circle given
 *	its integer radius, using the egyptian estimation of pi.
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
 * Program Name: "Egyptian Circumference"
 * Programming Languages: One module in C, one module in x86
 * Date program began:     2020-Sep-01
 * Date program completed: 2020-Sep-07
 * Files in this program: egyptian.c, circle.asm
 * Status: Complete (as of 2020-09-07).  No errors found after extensive testing.
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *	Holliday, Floyd	- arithmeticSample.asm 
 *		(https://sites.google.com/a/fullerton.edu/activeprofessor/open-source-info/x86-assembly/x86-examples/integer-arithmetic)
 *
 * Purpose:
 *	A C driver module to call the x86-64 assembly program of "circle.asm"
 *
 * This file:
 *	Filename: egyptian.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11
 *	Link: gcc -m64 -no-pie -o egyptian.out -std=c11 egyptian.o circle.o
 */

#include <stdio.h>
#include <stdint.h>

long int circle();

int main(){
	printf("%s\n%s\n", "Welcome to <program>.", "Main program calling circle function.");
	long res = -1;
	res = circle(); //Call to function
	printf("%s%ld%s\n", "Main received integer: ", res, " as the area of the circle in square meters.");
	printf("%s\n%s\n", "Main will now return 0 to OS.", "---End of program---");
	return 0;
}

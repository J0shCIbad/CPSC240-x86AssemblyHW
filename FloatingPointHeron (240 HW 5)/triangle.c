/**
 * 	Program name: "Floating Point Herons Formula" (HW 5 for CPSC 240-03, Fall 2020)
 * 	Details: Calculates the floating point area of a triangle given its
 *	three side lengths, using Heron's formula.
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
 * Author email: joshcibad@csu.fullerton.edu
 * 
 * Program Name: "Floating Point Herons Formula"
 * Programming Languages: One module in C, one module in x86
 * Date program began:     2020-Nov-06
 * Date program completed: 2020-Nov-12
 * Files in this program: circumference.c, circle.asm
 * Status: Complete (as of 2020-11-12).  No errors found after extensive testing.
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	A C driver module to call the x86-64 assembly program of "circle.asm". Prints
 *	welcome messages and prints the results of the program call.
 *
 * This file:
 *	Filename: circumference.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o circumference.o circumference.c -std=c11
 *	Link: gcc -m64 -no-pie -o circumference.out -std=c11 circumference.o circle.o
 */

#include <stdio.h>
#include <stdint.h>

double circle();

int main(){
	printf("%s\n%s\n", "Welcome to \"Floating Point Herons Formula\".",
		"The main program will now call the circle function.");
	double res = -1;
	res = circle(); //Call to function
	long unsigned hex = *(long unsigned*)&res; //Hard conversion of type while preserving bits, for printing
	printf("%s: %lf = 0x%lx\n", "The main received this number", res, hex);
	printf("%s\n%s\n", "Have a nice day. Main will now return 0 to OS.", "---End of program---");
	return 0;
}

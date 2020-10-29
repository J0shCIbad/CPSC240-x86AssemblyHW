/**
 * 	Program name: "Circumference Circle" (HW 4 for CPSC 240-03, Fall 2020)
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
 * Program Name: "Circumference of Circle"
 * Programming Languages: One module in C, one module in x86
 * Date program began:     2020-Oct-30
 * Date program completed: 2020-Oct-30
 * Files in this program: circumference.c, circle.asm
 * Status: Complete (as of 2020-10-30).  No errors found after extensive testing.
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
 *	Filename: circumference.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o circumference.o circumference.c -std=c11
 *	Link: gcc -m64 -no-pie -o circumference.out -std=c11 circumference.o circle.o
 */

#include <stdio.h>
#include <stdint.h>

double circle();

/*long doubleToLongHex(double dob){
	long hex = 0;
	for(int i=0; i<64; i++){}
	return hex;
}*/

int main(){
	printf("%s\n%s\n", "Welcome to \"Circumference of Circle\".",
		"The main program will now call the circle function.");
	double res = -1;
	res = circle(); //Call to function
	printf("%s: %f = %#016x", "The main received this number", res, 1);
	printf("%s\n%s\n", "Have a nice day. Main will now return 0 to OS.", "---End of program---");
	return 0;
}

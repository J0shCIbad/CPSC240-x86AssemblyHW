/**
 * 	Program name: "Area of Triangles" (HW 5 for CPSC 240-03, Fall 2020)
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
 * Program Name: "Area of Triangles"
 * Programming Languages: One module in C, one module in x86
 * Date program began:     2020-Nov-12
 * Date program completed: 2020-Nov-17
 * Files in this program: triangle.c, area.asm
 * Status:  Complete (as of 2020-Nov-17). Successful after testing.
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	A C driver module to call the x86-64 assembly program of "area.asm". Prints
 *	welcome messages and prints the results of the program call.
 *
 * This file:
 *	Filename: triangle.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11
 *	Link: gcc -m64 -no-pie -o triangle.out -std=c11 triangle.o area.o
 */

#include <stdio.h>
#include <stdint.h>

double area();

int main(){
	printf("%s\n", "Welcome to \"Area of Triangles\" by Josh Ibad.");
	double res = -1;
	res = area(); //Call to function
	long unsigned hex = *(long unsigned*)&res; //Hard conversion of type while preserving bits, for printing
	printf("The driver received this number 0x%lx, and will keep it.\n", hex);
	printf("%s\n%s\n", "Now 0 will be returned to the OS. Bye", "---End of program---");
	return 0;
}

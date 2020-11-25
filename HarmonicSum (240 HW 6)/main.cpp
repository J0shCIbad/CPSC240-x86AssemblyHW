/**
 * 	Program name: "Harmonic Sum" (HW 6 for CPSC 240-03, Fall 2020)
 * 	Details: Given an input N, calculates the Harmonic Sum, H(N),
 *	displaying 9 intermediate values in between.
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
 * Program Name: "Harmonic Sum"
 * Programming Languages: One module in C++, two modules in x86
 * Date program began:     2020-Nov-22
 * Date program completed: 2020-Nov-25
 * Files in this program: main.cpp, manager.asm, read_clock.asm
 * Status:  Completed (2020-Nov-25). Successful execution after testing on Ubuntu 20.04, gcc v9.3.0
 *
 * References:
 *	Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
 *
 * Purpose:
 *	A C++ driver module to call the manager x86_64 module. Prints welcome
 *	and exit messages.
 *
 * This file:
 *	Filename: main.cpp
 *	Language: C++
 *	Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17
 *	Link: gcc -m64 -no-pie -o main.out -std=c11 main.o manager.o read_clock.o
 */

#include <stdio.h>
#include <stdint.h>


extern "C" double manager();
#define harmonicSum() manager()

int main(){
	printf("%s\n", "Welcome to \"Harmonic Sums\", programmed by Josh Ibad.");
	double res = -1;
	res = harmonicSum(); //Call to function
	printf("The driver received this number %2.15lf, and will keep it.\n", res);
	printf("%s\n%s\n", "A zero will be returned to the OS. Have a nice day.", "---End of program---");
	return 0;
}

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
 *	A C module for sorting an array using the bubble sort algorithm, given the 
 *  array's address and length. The bubble sort algorithm will, for each iteration,
 *  check each consecutive elements in the array and swap them if they are out of
 *  order. The algorithm executes when no swaps occur during an iteration (detected
 *  using a dirty bit). As swaps are the most time consuming operation of the 
 *  algorithm, swapping is deferred to an assembly program called swap.asm. 
 *
 * This file:
 *	Filename: bubble_sort.c
 *	Language: C
 *	Compile: gcc -c -Wall -m64 -no-pie -o bubble_sort.o bubble_sort.c -std=c11
 *	Link: g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o
 */

#include <stdio.h>
#include <stdint.h>

extern void bubble_sort(long int *, long int);

void swap(long int * addr1, long int * addr2);		// Written in x86 as swap.asm
void bubble_sort(long int * arr, long int len){
	char dirtyBit = 1;	//Will denote if swaps occured in iteration
	while(dirtyBit){		//Executes while swap occurs
		dirtyBit = 0;
		for(int i=0; i<len-1; i++){
			if(arr[i] > arr[i+1]){
				swap(arr+i, arr+i+1);
				dirtyBit = 1;
			}
		}
	}
}

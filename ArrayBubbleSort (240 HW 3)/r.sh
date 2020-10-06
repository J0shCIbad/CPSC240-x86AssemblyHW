#!/bin/bash 

#Program: "Bubble Sorting an Array of Integers" (HW 3 for CPSC 240-03, Fall 2020)
#Author: Josh Ibad

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for Program \"Bubble Sorting an Array of Integers\" has begun"

#Assembly
echo "Assemble read_clock.asm"
nasm -f elf64 -l read_clock.lis -o read_clock.o read_clock.asm

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble swap.asm"
nasm -f elf64 -l swap.lis -o swap.o swap.asm


#Compilation
echo "Compile bubble_sort.c"
gcc -c -Wall -m64 -no-pie -o bubble_sort.o bubble_sort.c -std=c11

echo "Compile main.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17

echo "Compile display_array.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17


#Linkage
echo "Link the object files"
g++ -m64 -fno-pie -no-pie -o main.out -std=c++17 main.o read_clock.o manager.o input_array.o display_array.o bubble_sort.o swap.o

echo "Run the program \"Bubble Sorting an Array of Integers\":"
echo " "	#Blank line merely for appearances
./main.out

echo "The script file will terminate"




#Summary
#The modules read_clock.asm, manager.asm, input_array.asm, and swap.asm contains 
#	PIC non-compliant code.
#The assembler outputs a non-compliant object file.
#The C compiler is directed to create a non-compliant object file.
#The C++ compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object
#	files, and to output a non-compliant executable.

#The program runs successfully.

#!/bin/bash

#Program: Sum of Array of Integers
#Author: Josh Ibad

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for Program Sum of Array of Integers has begun"

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Compile display_array.cpp"
gcc -c -Wall -m64 -no-pie -o display_array.o display_array.cpp -std=c++11

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o main.out -std=c11 main.o manager.o input_array.o sum.o display_array.o 

echo "Run the program Sum of Array of Integers:"
./main.out

echo "The script file will terminate"




#Summary
#The module circle.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.

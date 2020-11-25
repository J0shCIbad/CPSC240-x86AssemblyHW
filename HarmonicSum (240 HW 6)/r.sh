#!/bin/bash

#Program: Harmonic Sum
#Author: Josh Ibad

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for Program \"Harmonic Sum\" has begun"

echo "Assemble read_clock.asm"
nasm -f elf64 -l read_clock.lis -o read_clock.o read_clock.asm
echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile main.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o main.out -std=c11 main.o manager.o read_clock.o

echo "Run the program \"Harmonic Sum\":"
./main.out

echo "" #Empty line
echo "Program has terminated"
echo "The script file will now terminate."


#Summary
#The module circle.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.

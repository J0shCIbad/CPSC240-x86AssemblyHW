#!/bin/bash

#Program: Egyptian Circle
#Author: Josh Ibad

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for Program Egyptian Circle has begun"

echo "Assemble circle.asm"
nasm -f elf64 -l circle.lis -o circle.o circle.asm

echo "Compile egyptian.c"
gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o egyptian.out -std=c11 egyptian.o circle.o

echo "Run the program Egyptian Circle:"
./egyptian.out

echo "The script file will terminate"




#Summary
#The module circle.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.

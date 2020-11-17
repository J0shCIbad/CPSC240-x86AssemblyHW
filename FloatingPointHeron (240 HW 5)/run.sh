#!/bin/bash

#Program: Area of Triangles
#Author: Josh Ibad

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for Program \"Area of Triangles\" has begun"

echo "Assemble area.asm"
nasm -f elf64 -l area.lis -o area.o area.asm

echo "Compile triangle.c"
gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o triangle.out -std=c11 triangle.o area.o

echo "Run the program \"Area of Triangles\":"
./triangle.out

echo "" #Empty line
echo "The script file will now terminate."




#Summary
#The module circle.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.

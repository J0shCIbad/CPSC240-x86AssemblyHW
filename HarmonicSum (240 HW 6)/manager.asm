; **********************************************
; Program name: "Harmonic Sum" (HW 6 for CPSC 240-03, Fall 2020)
; Details: Given an input N, calculates the Harmonic Sum, H(N),
; displaying 9 intermediate values in between.
; Copyright (C) 2020  Josh Ibad
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License version 3 as 
; published by the Free Software Foundation.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; A copy of the GNU General Public License v3 is available here:
; <https://gnu.org/licenses/>
; **********************************************

; **********************************************
;Author info:
; Author name: Josh Ibad
; Author email: joshcibad@csu.fullerton.edu
;
;Program info:
; Program Name: "Harmonic Sum"
; Programming Languages: One module in C++, two modules in x86
; Date program began:     2020-Nov-22
; Date program completed: 2020-Nov-25
; Files in this program: main.cpp, manager.asm, read_clock.asm
; Status:  Completed (2020-Nov-25). Successful execution after testing on Ubuntu 20.04, gcc v9.3.0
;
;References:
; Jorgensen, x86-64 Assembly Language Programming w/ Ubuntu
; Euler-Mascheroni Constant = https://en.wikipedia.org/wiki/Euler%E2%80%93Mascheroni_constant
; Asymptotic Expansion for the Harmonic Sum = https://en.wikipedia.org/wiki/Harmonic_number#Calculation
; Denominators of Bernouli(2k)/2k for Asymptotic Expansion: https://oeis.org/A006953
;
;Purpose:
; Prompts user to input an integer denoting the number of terms to
; include in the harmonic sum. Then calculates it, outputing intermediate
; values in the way. CPU clock is read before and after the calculation,
; and the difference (the duration of the calculation) is shown.
;
; This program will check the input and select which algorithm to use.
; For n <= 5, the O(1) runtime asymptotic expansion algortihm is too 
; inaccurate, thus the O(n) regular summation algorithm is used.
; Otherwise, for n > 5, the O(1) runtime asymptotic expansion algorithm
;
;
;NOTE:
; The asymptotic expansion algorithm is based on the following formula,
; and results in a very accurate approximation within an O(1) runtime.
;	H(n) = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6) +
;		1/(240n^8) - 1/(132n^10) + 1/(32760n^12) - 1/(12n^14) + 1/(8160n^16) - ...
;	#Ref: https://en.wikipedia.org/wiki/Harmonic_number#Calculation, https://oeis.org/A006953
;
; Error for n>5 is at most 1 E -10 
; 
; To replicate the desired output, the "intermediates" are calculated regularly and individually.
;
; To avoid function call overheads, the harmonic sum calculation algorithms are not implemented
; as a separate function call, but as another subsection of the code of this file, as a branch
; of execution.
;	
;This file:
; Filename: manager.asm
; Language: x86-64 (Intel)
; Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link: gcc -m64 -no-pie -o main.out -std=c11 main.o manager.o read_clock.o        ;Ref Jorgensen, page 226, "-no-pie"
; **********************************************

;Declare library functions called
extern printf
extern scanf
extern read_clock
global manager

segment .data
; -----
; Initialize data to be used
promptmsg db "Please enter the number of terms to be included in the sum: ", 0
strform db "%s", 0
floatform db "%2.15lf", 0
longform db "%ld", 0

headerform db "| %-20s | %-20s |", 10, 0
intermediateform db "| %-20ld | %-5.15lf   |", 10, 0
rowseparator db "+----------------------+----------------------+", 10, 0

headerparam1 db "n [Num terms added]", 0
headerparam2 db "H(n) [Harmonic Sum]", 0

firstclockreadmsg db "The clock is now %ld tics and the computation will begin.", 10, 10, 0	;Double \n for padding in output
secondclockreadmsg db "The clock is now %ld tics.", 10, 0
elapsedtimemsg db "The elapsed time is %ld tics, which equals %lf seconds.", 10, 0
invalidmsg db "Invalid input, please input a natural number (nonzero positive integer) without letters and symbols.", 10, 0
exitmsg db "The harmonic sum will be returned to the driver.", 10, 0

invlog2e dq 0x3fe62e42fefa39ef			; The constant value of 1/log2(e) in ieee754 hex literal form,
										; 	found using a program that used the cmath library
eulermascheroni dq 0x3fe2788cfc6fb619	; Euler-Mascheroni constant in ieee754 hex literal form
										;	#Ref: https://en.wikipedia.org/wiki/Euler%E2%80%93Mascheroni_constant
										;	Hex form found with C program
										
float1 dq 0
float2 dq 0
float3 dq 0
										
segment .bss
currsum resq 1

segment .text
manager:

;=============================================================================]
; -----
; Routine Prologue
;Back up registers to stack to preserve register data
push rbp
mov  rbp,rsp
push rdi
push rsi
push rcx
push rdx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf 
push qword -1	;Push extra to even out offset to 16

;=============================================================================]
; -----
; Input number of terms for harmonic sum to calculate.
;Output prompt message
inputstart:
mov qword rdi, strform			; "%s"
mov qword rsi, promptmsg		; "Please enter the number of terms to be included in the sum: "
mov qword rax, 0
call printf

	;Input number of terms as long int
	mov qword rdi, longform		; "%ld"
	push qword 0				; Allocated stack memory to place scanned data into
	mov qword rsi, rsp
	xor rax, rax
	call scanf
	pop qword r15				; Pop input to r15

	cdqe
	cmp rax, 0					
	jle inputerror				; If no input accepted, go to input error handling code
	cmp r15, 0
	jg inputend					; If input is a natural number (valid), continue execution to after input
	jmp inputerror2
	
	inputerror:
	;Input was invalid
	;Flush buffer to avoid infinite error loop
	mov qword rdi, strform		; "%s"
	push qword 0
	mov qword rsi, rsp
	xor rax, rax
	call scanf
	pop qword r15

	inputerror2:
	mov qword rdi, strform		; "%s"
	mov qword rsi, invalidmsg	; "Invalid input, please input a natural number (nonzero positive integer) without letters and symbols."
	mov qword rax, 0
	call printf
	jmp inputstart

; Valid float input has been accepted
; User input, N, is at r15
inputend:

; Read clock
call read_clock
mov r13, rax					; Set r13 to cpu tics in ns
push qword rax					; Save clock reading to stack
push qword 0					; Push padding to even out stack
; Print first clock reading
mov qword rdi, firstclockreadmsg	;"The clock is now %ld tics and the computation will begin."
mov qword rsi, r13
xor rax, rax
call printf

;=============================================================================]
; -----
; Intermediate loop set up
xor r12, r12					; Zero out rcx, the loop counter variable
xor r14, r14					; Zero out the temporary input variable, r14
mov rax, r15
cqo
mov rbx, qword 10
idiv rbx
mov r13, rax					; Set r13 to the interval (N/10)

mov qword rdi, strform			; "%s"
mov qword rsi, rowseparator 	; "+---------------------+---------------------+"
xor rax, rax
call printf						; printf("%s", "+---------------------+---------------------+");


mov qword rdi, headerform		; "|%-20s | %-20s|"
mov qword rsi, headerparam1		; "n [Num terms added]"
mov qword rdx, headerparam2		; "H(n) [Harmonic Sum]"
xor rax, rax
call printf						; printf("|%-20s | %-20s|", "n [Num terms added]", "H(n) [Harmonic Sum]");


mov qword rdi, strform			; "%s"
mov qword rsi, rowseparator 	; "+---------------------+---------------------+"
xor rax, rax
call printf						; printf("%s", "+---------------------+---------------------+");




;=============================================================================]
; -----
; Intermediate loop start
; 	Note: This weird placement is used to avoid function call runtime overhead
;	and to take advantage of how asympexp is already setup.
;
;	Note: This is unnecessary due to the O(1) solution used for finding
;	Harmonic sums using the asymptotic expansion approximation. 
;	However, to fit the expected output, the intermediate values are 
;	calculated to simulate the O(n) summation's intermediate outputs.
intermediateloopstart:
inc r12							; Increment r12 here, to fit usage
cmp r12, qword 10
jg finale						; if(n > 10): Exit loop
je realcalciter					; if(n == 10): Place user input in n (instead of adding intervals, 
								;	to avoid errors incurred from truncation via integer division to find interval size)
								
add r14, r13					; else (n<10): Set r14 to the next "intermediate" to calculate,
cmp r14, 0
jg contexec1					; if(r14 <= 0)
mov qword r14, 1				;	r14 = 1; 	//Set r14 to the minimum valid input
contexec1:
jmp algopicker					; 	then jump to calculation segment of code
realcalciter:
mov r14, r15					; For final iteration, use user input as N directly, instead of incrementing by interval size
jmp algopicker

; -----
;  Algorithm picker
;	This is done because asymptotic expansions is too inaccurate with
;	small numbers less than or equal to 5, but becomes acceptable
;	in all values of n great than 5, and is prefered for its O(1) runtime.
algopicker:						; An algorithm picker
cmp r14, 5						; if(r > 5)
jg asympexp						;	Use asymptotic expansion for accurate estimation with O(1) runtime
								; else
jmp regularsummation			; 	Use regular summation method w/ O(n) runtime



;=============================================================================]
regularsummation:
; -----
; Calculations
;	Regular summation. Done only for n < 5 since the asymptotic expansion
;	is too inaccurate when n < 12.
;
;	Otherwise, the program uses the asymptotic expansion
mov rax, 0x3ff0000000000000	; 1 in ieee754
movq xmm15, rax
mov rcx, qword 2			; Start off at n=2, since the counter variable is already 1.0
summationloopstart:
cmp rcx, r14				; while( rcx < r14 ){	//While i < n
jg calculationend
movq xmm14, rax				;	xmm14 = 1;			// x = 1
cvtsi2sd xmm13, rcx		;	xmm13 = rcx;		// y = i
divsd xmm14, xmm13			;	xmm14 /= xmm13;		// x = 1/i
addsd xmm15, xmm14			;	xmm15 += xmm14		// H(n) += 1/i
inc rcx						; 	rcx++
jmp summationloopstart		; }
							; End condition, xmm15 = H(n)



;=============================================================================]
asympexp:
; -----
; Calculations
;	Let H(n) be the Harmonic Sum calculated with n terms,
;	In asymptotic expansion,		#Ref: https://en.wikipedia.org/wiki/Harmonic_number#Calculation, https://oeis.org/A006953
;		H(n) = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6) +
;			1/(240n^8) - 1/(132n^10) + 1/(32760n^12) - 1/(12n^14) + 1/(8160n^16) - ...
;
; Note: This is not implemented as a function to avoid function call runtime overhead
;
; ln(n) = log2(n)/log2(e) = (1/log2(e)) * log2(n)
cvtsi2sd xmm9, r14			; xmm0 = n (Number of terms to include in harmonic sum)
movq qword [currsum], xmm9
fld qword [invlog2e]		; ST(1) = 1/log2(e)
fld qword [currsum]			; ST(0) = n
fyl2x
fstp qword [currsum]		; ST(1) = (1/log2(e)) * log2(n) = log2(n)/log2(e) = ln(n)
movq xmm15, qword [currsum]

addsd xmm15, qword [eulermascheroni]	; xmm15 = ln(N) + y(Euler-Mascheroni Constant)

mov rax, qword 0x3fe0000000000000	; rax = (1/2)
movq xmm14, rax				; xmm14 = 1/2
divsd xmm14, xmm9			; xmm14 = 1/(2n)
addsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n)

mulsd xmm9, xmm9			; xmm9 = N^2
mov rax, qword 0x3fb5555555555555	; rax = (1/12)
movq xmm14, rax				; xmm14 = 1/12
divsd xmm14, xmm9			; xmm14 = 1/(12n^2)
subsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2)

movsd xmm10, xmm9			; xmm10 = N^2
mulsd xmm10, xmm9			; xmm10 *= N^2 = N^4
mov rax, qword 0x3f81111111111111	; rax = (1/120)
movq xmm14, rax				; xmm14 = 1/120
divsd xmm14, xmm10			; xmm14 = 1/(120n^4)
addsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^6
mov rax, qword 0x3f70410410410410	; rax = (1/252)
movq xmm14, rax				; xmm14 = 1/252
divsd xmm14, xmm10			; xmm14 = 1/(252n^6)
subsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^8
mov rax, qword 0x3f71111111111111	; rax = (1/240)
movq xmm14, rax				; xmm14 = 1/240
divsd xmm14, xmm10			; xmm14 = 1/(240n^8)
addsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)
							;	+ 1/(240n^8)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^10
mov rax, qword 0x3f7f07c1f07c1f08	; rax = (1/132)
movq xmm14, rax				; xmm14 = 1/132
divsd xmm14, xmm10			; xmm14 = 1/(132n^10)
subsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)
							;	+ 1/(240n^8) - 1/(132n^10)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^12
mov rax, qword 0x3f00010010010010	; rax = (1/32760)
movq xmm14, rax				; xmm14 = 1/32760
divsd xmm14, xmm10			; xmm14 = 1/(32760n^12)
addsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)
							;	+ 1/(240n^8) - 1/(132n^10) + 1/(32760n^12)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^14
mov rax, qword 0x3fb5555555555555	; rax = (1/12)
movq xmm14, rax				; xmm14 = 1/12
divsd xmm14, xmm10			; xmm14 = 1/(12n^14)
subsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)
							;	+ 1/(240n^8) - 1/(132n^10) + 1/(32760n^12) - 1/(12n^14)

mulsd xmm10, xmm9			; xmm10 *= N^2 = N^16
mov rax, qword 0x3f20101010101010	; rax = (1/8160)
movq xmm14, rax				; xmm14 = 1/8160
divsd xmm14, xmm10			; xmm14 = 1/(8160n^16)
addsd xmm15, xmm14			; xmm15 = ln(n) + y + 1/(2n) - 1/(12n^2) + 1/(120n^4) - 1/(252n^6)
							;	+ 1/(240n^8) - 1/(132n^10) + 1/(32760n^12) - 1/(12n^14) + 1/(8160n^16)


calculationend:
; Print intermediate sum (num of terms then the harmonic sum thus far)
push qword 0
mov qword rdi, intermediateform		; "%-20ld | %-2.15lf"
mov qword rsi, r14					; n
movsd xmm0, xmm15					; H(n)
mov qword rax, 1
call printf							; printf( "%-20ld | %-2.15lf", n, H(n) );
pop rax

jmp intermediateloopstart


								
;=============================================================================]
; -----
; Output final results and exit messages
finale:
mov qword rdi, strform			; "%s"
mov qword rsi, rowseparator 	; "+---------------------+---------------------+"
xor rax, rax
call printf						; printf("%s", "+---------------------+---------------------+");

; Read clock
call read_clock
mov r12, rax					; Set r12 to cpu tics in ns
; Print second clock reading
mov qword rdi, secondclockreadmsg	; "The clock is now %ld tics."
mov qword rsi, r12
xor rax, rax
call printf

; Retrieve first clock reading from stack
pop qword r13					; Remove padding in stack
pop qword r13					; Retrieve first clock reading from stack

; Get the difference between final and initial clock reading
sub r12, r13
cvtsi2sd xmm0, r12				; Convert to float
mov rax, 0x412e848000000000		; 10^6
movq xmm1, rax
divsd xmm0, xmm1				; Convert ns to seconds

; Print the difference between final and initial clock reading (Print runtime)
push qword 0
mov qword rdi, elapsedtimemsg	; "The elapsed time is %ld tics, which equals %lf seconds."
mov rsi, r12
mov qword rax, 1
call printf
pop rax

;Print exit message
mov qword rdi, strform			; "%s"
mov qword rsi, exitmsg			; "The harmonic sum will be returned to the driver."
mov qword rax, 0
call printf

;Ensure harmonic sum is returned to callee
movsd xmm0, xmm15
; -----
; Routine Epilogue
;Restore registers to original state
pop r8		;Remove extra -1 used to oven out offset, register is arbitrary
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rdx
pop rcx
pop rsi
pop rdi
pop rbp

ret







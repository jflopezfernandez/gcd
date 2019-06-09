
;==============================================================================
;
;                           EUCLIDEAN ALGORITHM
;
;==============================================================================
;
;   Author:     Jose Fernando Lopez Fernandez
;
;   Date:       9 June, 2019
;
;   Description:
;
;       This is an implementation of the Euclidean algorithm for finding
;       the greatest common factor of two numbers written in NASM x86-64
;       assembly.
;
;       The two numbers are represented by the two registers, RAX and RBX,
;       and the algorithm terminates when RAX and RBX are equal. The 
;       result could therefore be returned from either RAX or RBX, but I
;       thought a simple XCHG instruction was the simplest way to do so.
;
;       This algorithm uses the subtraction version of the algorithm,
;       rather than the modulus version, as division in x86-64 requires
;       the use of an additional register for the modulus, in addition
;       to the original two for the divisor and the quotient. While x64
;       has almost an embarrassment of riches when it comes to registers
;       as compared to x32 and certainly the days of 16 bits, I think
;       it's preferable to be conservative with register use.
;
;   Building:
;
;       nasm -felf64 -o main.o ./src/main.asm
;       ld -b elf64-x86-64 -o gcd ./main.o
;
;   Execution:
;
;       The two operands are currently hard coded, requiring explicit
;       source file editing, re-assembly, and re-linking. The program
;       is executed as ./gcd after which the exit code containing the
;       result may be queried with 'echo $?'.
;
;------------------------------------------------------------------------------

                SECTION .text
                GLOBAL _start
_start:         MOV     RAX,830         ; b = 830
                MOV     RBX,950         ; a = 950
.GCD:           CMP     RAX,RBX         ; 
                JE      .END            ; while (a != b) {
                JL      .B              ;   if (a > b) {
.A:             SUB     RAX,RBX         ;     a = a - b
                JMP     .GCD            ;   } else {
.B:             SUB     RBX,RAX         ;     b = b - a
                JMP     .GCD            ;   }
.END:           XCHG    RDI,RAX         ; } return a;
                MOV     RAX,60          ; 
                SYSCALL                 ; 


#sum of inverse of first N primes

.data 0x10010000
#This is the number N
Number: .word 5

.data 0x10010128
Result: .word 0


.text
Main:
#Put N in s0
la $t0, Number
lw $s0, ($t0)


#set counter to 0
add $s1, $zero, $zero

#set s2 to constant 1
addi $s2, $zero,1 

#set variable to 0
add $s3, $zero, $zero

#set f3 to 0 
add $t0, $zero, $zero
mtc1 $t0, $f3


MainLoop:
addi $s3, $s3, 1
add $a0, $s3, $zero
jal CheckPrime
bne $v0, $s2, MainLoop
#Number is Prime
addi $s1, $s1, 1
jal Inverse
mtc1 $v0, $f0
add.s $f3, $f3,$f0
bne $s1, $s0, MainLoop

mov.s $f12, $f3
addi $v0, $zero, 2
syscall

la $t0, Result
l.s $f3, ($t0)

j EndProgram


CheckPrime:
add $t0, $a0, $zero

#set variable to 1
addi $t1, $zero, 1
bne $t1, $t0, NotOne
add $v0, $zero, $zero
jr $ra


NotOne:
#set counter to 0
add $t2, $zero, $zero


Loop:
div $t0,$t1
mfhi $t3 #move remainder to t3
bne $t3, $zero, NoAdd
addi $t2, $t2, 1
NoAdd:
addi $t1, $t1, 1
bne $t1,$t0,Loop

addi $t4, $zero, 1
bne $t4, $t2, NoPrime

#YesPrime
addi $v0, $zero, 1
jr $ra

NoPrime:
add $v0, $zero, $zero
jr $ra



Inverse:
#Put argument in f0
mtc1 $a0,$f0

addi $t0, $zero, 1
mtc1 $t0,$f1

div.s $f0, $f1, $f0
mfc1 $v0, $f0
jr $ra





EndProgram:

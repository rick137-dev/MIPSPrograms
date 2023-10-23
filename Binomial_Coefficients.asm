
.data 0x10010000
Number: .word 5 #N

.data 0x10010128
Result: .space 128 #4*2^N


#Program to calculate binomial expansion coefficients of (1+x)^N
.text

Main:
#Set stack pointer to start of stack
addi $sp, $zero, 0x7fffeffc

la $s0, Number
lw $s0, ($s0)#s0 =N

addi $s1, $s0, 1#s1 = N+1
move $a1, $zero
move $a0, $s0

la $s2, Result

move $a0, $s0


MainLoop:
jal BiCoef
sw $v0, ($s2)
addi $s2, $s2, 4
addi $a1, $a1, 1
bne $a1, $s1, MainLoop





j EndProgram



Factorial:
bne $a0, $zero, CheckPassed
li $v0, 1
jr $ra
CheckPassed:
addiu $t0, $a0, 1 #Set t0 = N+1

li $v0, 1
li $t1, 1
Loop:
mul $v0, $v0, $t1
addi $t1, $t1, 1
bne $t1, $t0, Loop
jr $ra


BiCoef: #Result => a0 Choose a1 => a0!/(a1!(a0-a1)!)
subu $t4, $a0, $a1 #t4 = a0-a1

move $t5, $a0 #save a0

addi $sp, $sp, -4
sw $ra, ($sp)

jal Factorial

lw $ra, ($sp)
addi $sp, $sp, 4

move $t2, $v0 #t2 = a0!


move $a0, $a1
addi $sp, $sp, -4
sw $ra, ($sp)

jal Factorial

lw $ra, ($sp)
addi $sp, $sp, 4

move $t3, $v0#t3 = a1!

move $a0, $t4
addi $sp, $sp, -4
sw $ra, ($sp)

jal Factorial

lw $ra, ($sp)
addi $sp, $sp, 4

move $t4, $v0#t4 = (a0-a1)!

div $v0, $t2, $t3
div $v0, $v0, $t4

move $a0, $t5 #reset a0

jr $ra

EndProgram:

.data 0x10010128
Result: .space 48

#Find max N such that N! can be expresssed with 32 bits, put in memory all i! for 1<=i<=Nmax

.text

	la $s0, Result
	li $s1, 0

	MainLoop:
	addi $s1, $s1, 1
	move $a0, $s1
	jal Factorial 
	mfhi $t5
	bne $t5, $zero, Good
	sw $v0, ($s0)
	addiu $s0, $s0, 4
	j MainLoop
	

	
	Good:
	addi $s1, $s1, -1
	j EndProgram
	




Factorial:
bne $a0, $zero, CheckPassed
li $v0, 1
jr $ra
CheckPassed:
addiu $t0, $a0, 1 

li $v0, 1
li $t1, 1
Loop:
mul $v0, $v0, $t1
addi $t1, $t1, 1
bne $t1, $t0, Loop
jr $ra


EndProgram:
j EndProgram



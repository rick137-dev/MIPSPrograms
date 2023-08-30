#Calculates the sum of the factorials of the digits of a number



#to store data in RAM and ROM

.data 0x10010000
number: .word 726 # => 7! + 2! +6! = 5762

.data 0x10010128
result: .word 0


.text

main:
lw $s1, number 
la $s2, result 

	addi $t8, $zero, 3
	addi  $t9, $zero, 5
	add $v1, $zero, $zero
	add $s4, $zero, $zero
	


add $a0, $s1, $zero 
jal FactDigits

sw $v0, ($s2)
add $a0, $v0, $zero
li $v0 1
syscall
j EndProgram




Factorial:
addiu $t0, $zero, 1 
addiu $t1, $zero, 1 
beq $a0, $zero,endloop 
loop:
mul $t1, $t1, $t0 #ultimi 32 bit
beq $t0, $a0, endloop
addiu $t0, $t0, 1 
j loop

endloop:
add $v0,$t1, $zero 
jr $ra #ritorna a main


FactDigits:
add $t0, $a0, $zero
add $t1, $zero, $zero 
addiu $t2, $zero, 10 
mainloop:
div $t0, $t2
mfhi $t3 

addi $sp, $sp, -8
sw $ra, 4($sp) 
sw $a0, ($sp) 
add $a0, $t3, $zero 

add $s5,$t0, $zero 
add $s6, $t1, $zero 


jal Factorial

add $t0,$s5, $zero 
add $t1, $s6, $zero 

	div $v0,$t8
	mfhi $s7
	seq $s0, $s7, $zero
	div $v0, $t9
	mfhi $s7
	seq $s4, $s7, $zero
	or $s4, $s4, $s0
	beq $s4, $zero, Continue
	addi $v1, $v1, 1
	Continue:
	
	
	
div $t0, $t2 #resettare il hi and lo 

lw $ra, 4($sp) #resettare il return address
lw $a0, 0($sp) 
addi $sp,$sp, 8

	

add $t1, $v0, $t1 
mflo $t3 
beq $t3, $zero, finish 
add $t0, $t3, $zero 
j mainloop

finish:
add $v0, $t1, $zero 
jr $ra



EndProgram: #to end the program (drop off bottom)




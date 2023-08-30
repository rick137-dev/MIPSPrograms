#calculate factorial of a number
.data
number: .word 5
result: .word 0


.text

main:
lw $s1, number #get number 
la $s2, result #get address to put result

add $a0, $s1, $zero #put number to calculate factorial of in a0
jal Factorial

sw $v0, ($s2) #put reult in memory
add $s3, $zero, $v0
j EndProgram




Factorial:
addiu $t0, $zero, 1 #set $t0 to 1
addiu $t1, $zero, 1 #set $t1 to 1
loop:
mul $t1, $t1, $t0 #last 32 bits, for now we dont care about overflow
beq $t0, $a0, EndLoop
addiu $t0, $t0, 1 #add 1 to t0
j loop

EndLoop:
add $v0,$t1, $zero #move result in v0
jr $ra #return to main 


EndProgram:
#to end program




.data 0x10010000
array: .word 7 4 9 5 4
array2: .word 2 2 2 2 3
len: .word 5

.text
main:
move $s0, $zero
la $t1, array
la $t2, array2

la $t3, len
lw $t3, ($t3)


move $t4, $zero

Loop:
lw $t5,($t1)
lw $t6, ($t2)
mul $t6, $t5, $t6
add $s0, $s0, $t6
addi $t4, $t4, 1
addi $t1, $t1, 4
addi $t2, $t2, 4
bne $t4, $t3, Loop

#Result of Dot Product of two vectors is kept in $s0
EndProgram:


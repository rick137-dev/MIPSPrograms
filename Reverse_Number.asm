
.data 0x10010000
Number: .word 143 #N


.text
Main:

la $s0, Number
lw $s0, ($s0)

move $s2, $s0

add $s1, $zero, $zero
li $t0, 10

Loop:
mul $s1, $s1, $t0
div $s0, $t0
mfhi $t1
add $s1, $s1, $t1
mflo $t1
move $s0, $t1
bne $s0, $zero, Loop



li $v0, 1
move $a0, $s1
syscall

add $a0, $a0,$s2
syscall

j EndProgram

EndProgram:


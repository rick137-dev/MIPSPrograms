.data 0x10010000
array: .word 7 4 9 5 4
len: .word 5


.data 0x1001001c
result: .space 20
mean: .float 0
variance: .float 0
median: .word 0


#Program to calculate the Mean, Median and Variance of an array
.text
Main:

#copy the array into RAM memory 
la $t0, array
la $t1, result
lw $t2, len

#Set stack pointer to start of stack
addi $sp, $zero, 0x7fffeffc

add $t3, $zero, $t0 #to add to jump 1 byte
add $t4, $zero, $t1
addi $t6, $zero, 0 #set t6 to 1

Copy:
lw $t5, ($t3)
sw $t5, ($t4)
addi $t3,$t3, 4
addi $t4,$t4, 4
addi $t6, $t6, 1
bne $t6, $t2, Copy #repeat until it copies the full list


add $a0, $zero, $t1 #address of array as first arg
add $a1, $zero, $t2 #len of array as second arg



jal Mean
la $t0, mean
s.s $f0, ($t0)


jal Variance
la $t0, variance
s.s $f0, ($t0)


jal BubbleSort
jal Median
la $t0, median
sw $v0, ($t0)

j EndProgram





BubbleSort:
add $t1, $zero, $a0 #set t1 to start address
addi $t2, $a1, -1 #set to len -1
sll $t2, $t2, 2 #multiply by 4
add $t2, $t2, $a0 #set t2 to end address
addi $t0, $zero, 1 #set outerPointer to 1


OuterLoop:
add $t1, $zero, $a0 #set t1 to start address
addi $t0, $t0, 1 #add 1 to OuterPointer
lw $t3, ($t1)
lw $t4, 4($t1)
	InnerLoop:
	ble $t3, $t4, NoSwitch
	sw $t3, 4($t1)
	sw $t4, ($t1)
	NoSwitch:
	addi $t1, $t1, 4
	lw $t3, ($t1)
	lw $t4, 4($t1)
	
	bne $t1, $t2, InnerLoop #if not to end reset InnerLoop
bne $t0, $a1, OuterLoop
jr $ra


	
Mean:
add $t0, $zero, $a0 #set t0 to start address
add $t1,$zero, $a1 #set t1 to length of array
sll $t1, $t1, 2
add $t1, $t1, $t0 #set t1 to end address
add $t2, $zero, $zero #set counter to 0
Loop:
lw $t3, ($t0)
add $t2, $t2, $t3
addi $t0, $t0, 4
bne $t0, $t1, Loop


mtc1 $t2, $f0
cvt.s.w $f0, $f0
mtc1 $a1, $f1
cvt.s.w $f1, $f1
div.s $f0, $f0, $f1
#Output is kept in f0
jr $ra




Variance:
add $s0, $a0, $zero
add $s1, $a1, $zero

sll $s3, $s1, 2
add $s3, $s3, $s0 #set s3 to end address
addi $sp, $sp, -4
sw $ra, ($sp)
#Subroutine Mean and Variance have same arguments
jal Mean 
mtc1 $v0, $f1

lw $ra, ($sp)
addi $sp, $sp, 4

add $t0, $zero, $zero
mtc1 $t0, $f0 #set f0 to 0
cvt.s.w $f0, $f0

VarLoop:
lw $t0, ($s0)
mtc1 $t0, $f3
cvt.s.w $f3, $f3
sub.s $f3, $f3, $f1
mul.s $f3, $f3, $f3
add.s $f0, $f0, $f3
addi $s0, $s0, 4
bne $s0, $s3,  VarLoop

addi $s1, $s1, -1
mtc1 $s1, $f1
cvt.s.w $f1, $f1
div.s $f0, $f0, $f1

jr $ra

Median:
add $s0, $a0, $zero #set s0 to start address
add $s1, $a1, $zero #set s1 to length


mtc1 $s1, $f0
cvt.s.w $f0, $f0
addi $t0, $zero, 2
mtc1 $t0, $f1
cvt.s.w $f1, $f1
div.s $f0, $f0,$f1
cvt.w.s $f0, $f0
mfc1 $t0, $f0

sll $t0, $t0, 2
add $t0, $t0, $a0


lw $v0, ($t0)

jr $ra

EndProgram:







.data
array: .word 4 7 9 5 1 0 2 3 4 8 6 4 1 1
len: .word 14

.text

Main:
la $s0, array #save array start address pointer
lw $s1,len #save length of array
sll $t1, $s1, 2 #multiply length by 4
add $s2, $t1, $s0 #save end of array addres in s2
addiu $t3,$zero,0 #set i = 1



OuterFor:
add $t4, $zero, $s0 #set current address to first element
  InnerFor:
  lw $t1,($t4) # put current element in t1
  lw $t2, 4($t4) #put next element in t2
  slt $t5, $t1, $t2 # 1 if $t1 <= $t2
  bne $t5, $zero, NoSwitch
  Switch:
  sw $t1, 4($t4)
  sw $t2, ($t4)

  
  NoSwitch:
  addiu $t4, $t4,4
  bne  $t4, $s2,InnerFor
  

addiu $t3, $t3, 1
bne $t3,$s1, OuterFor


 



Exit:
lw $s7,-4($s2) #store last element in s7, to check if function worked


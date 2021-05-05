#
# Just a sample, simple example asm code that does not do any meaningful task
#

# data section
.data
fibs:.word   1,2,3,4,5         # "array" of words to contain fib values

# code/instruction section
.text
addi $t0, $0, -1
addi $t1, $0, 0x10010000
sw $t1, 0($t1)

j NEXT_INST # inst with no reg/mem update
NEXT_INST:

addi $t2, $0, 0x10010004
sw $t2, 0($t2)

addi $t3, $0, 0x10010008
sw $t3, 0($t3)

done:

addi $2, $0, 10
syscall

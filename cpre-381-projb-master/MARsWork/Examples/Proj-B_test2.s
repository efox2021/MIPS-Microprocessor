#
# Testing our phase 1 instructions
#
# data section
.data

# code/instruction section
.text

addi  $1,  $0,  1 		# Place “1” in $1
addi  $2,  $0,  2		# Place “2” in $2
addi  $3,  $0,  3		# Place “3” in $3
addi  $4,  $0,  4		# Place “4” in $4
addi  $5,  $0,  5		# Place “5” in $5
addi  $6,  $0,  6		# Place “6” in $6
addi  $7,  $0,  7		# Place “7” in $7
addi  $8,  $0,  8		# Place “8” in $8
addi  $9,  $0,  9		# Place “9” in $9
lui  $10,  0x1001

sw    $1,   0($10)       # Store "1" at mem 256
sw    $2,   4($10)       # Store "2" at mem 260
sw    $3,   8($10)       # Store "3" at mem 264
sw    $4,  12($10)       # Store "4" at mem 268
sw    $5,  16($10)       # Store "5" at mem 272
sw    $6,  20($10)       # Store "6" at mem 276
sw    $7,  24($10)       # Store "7" at mem 280
sw    $8,  28($10)       # Store "8" at mem 284
sw    $9,  32($10)       # Store "9" at mem 288
sw    $10, 36($10)       # Store "10" at mem 292

lw    $11, 0($10)		 # Load from dMem($10) into $11

add $11, $1, $2			 # Add 1 + 2 into $11

addiu $12, $5, 10		 # Addiu 10 + 5 into $12

addu $13, $4, $5		 # Addu 4 + 5 into $13

and $14, $7, $7			 # And 7&7 into $14

andi $15, $9, 120		 # Andi 120 + 9 into $15

lui  $10,  0x1001	     # Load offset for mars into $10
		
sw    $1,   0($10)       # Store "1" at mem 256
sw    $2,   4($10)       # Store "2" at mem 260
		
lw    $4,   0($10)		 # Load from dMem($10) into $a0

addi  $2,  $0,  10 		 # Addi 10 into $at
nor $16, $1, $5			 # Nor 1 + 5 into $16

xor $17, $11, $1		 # Xor $1 and $11 into $17

xori $18, $4, 8			 # Xori $4 and $8 into $18

or $19, $5, $4			 # Or 5 and 4 into $19

ori $20, $1, 256		 # or 1 and 256 into $20

slt $21, $4, $5			 # SLT ? : (4 < 5) into 21

slti $22, $10, 250		 # SLTi ? : ($10 < 250)

sltiu $23, $7, 3		 # SLTiU ? : ($7 < 3) into $23

sltu $24, $5, $2		 # SLTU ? : ($5 < $2) into $24

sll $25, $5, 5			 # Shift left $5 << 5 into $25

srl $26, $6, 3			 # Shift Right $6 >> 3 into $26

sra $27, $3, 5			 # Shift Right Arith $3 >> 5 into $27

sllv $28, $10, $2		 # Shift Left Variable $10 << $2 into $28

srlv $29, $9, $3		 # Shift Right Variable $9 >> $3 into $29

srav $30, $5, $3		 # Shift Right Arith Variable $5 >> $3 into $30

sub $31, $19, $5		 # SUB $19 - $5 into $31 

subu $20, $10, $3		 # SUBU $10 - $3 into $21

beq $0, $0, Print19		 # Unconditional Branch on Equal Print the number 19

Print19: addi $4, $zero, 19	 
		 addi $v0, $0, 1
		 syscall
		 
bne $2, $3, Print24		 # Conditional Branch if ($2 != $3) ? : Print the number 24

Print24: addi $4, $zero, 24
		  addi $v0, $0, 1
		  syscall
		
jal printBin			 # jump to Print the number 15 in 32 bit binary

j die


printBin: addi $8, $0, 15
	   addi $v0, $0, 35
	   syscall
	   jr $31



die: addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
	 syscall                         # Actually cause the halt

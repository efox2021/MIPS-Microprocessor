# Mohammad Pivezhandi
#
# First version of project_c edge test
#
.data
String1: .word 0x00FFFFFF, 0xF0000FFF, 0xFFFF0000, 0x0000000F
String2: .word 0x10FFFFF0, 0x00F00FFF, 0xFFFF0FF0, 0x1000000F
length: .word 4

# code/instruction section
.text


# # addi $29, $0, 0x7fffeffc # initialize the stack pointer as it is in MARS

## Data dependency for i-type to i-type instructions
lui $1, 0x00007fff
ori $1, $1, 0x0000effc
## Data dependency for i-type to r-type instructions
add $29, $0, $1
add $5, $1, $0
## Data dependency for r-type and i-type to r-type instructions
sub $3, $1, $29
sub $3, $5, $29 
## Data dependency for r-type and r-type to r-type instructions
add $6, $5, $3 
## Data dependency for r-type and r-type to r-type instructions
## load instruction
la $13, String2
## load String1 inside 12
lui $1, 0x00001001
ori $12, $1, 0x00000000
## Data dependency for i-type to i-type instructions
lw $7, 0($12)
## Data dependency for i-type and i-type to r-type instructions
add $8, $1, $12
## Data dependency for r-type and i-type to r-type instructions
sub $8, $7, $8
## Data dependency for sw after lw instructions
lw $10, 4($12)
sw $1, 8($12)
## stall Data dependency for sw after lw
lw $11, 8($12)
sw $8, 12($11)
## stall data dependency for r-type after lw and forwarding for lw after sw to the same location in memory
lw $13, 12($11)
add $14, $13, $11
## stall data dependency for i-type after lw and forwarding r_type before lw
lw $14, 12($11)
addi $14, $14, 1
# ## branch instuction
addi $5, $0, 0xFFFFFFFF
## stall for i-type dependency before branch
addi $6, $0, 0x00000000
beq $6, $1, equal
addi $5, $1, 1
## Stall for dependency and Flush for branch prediction
bne $5, $0, notequal

equal: 
addi $6, $0, 0x0000000F
beq $6, $0, equal

notequal:
add $5, $0, $0
bne $5, $0, notequal

## forwarding dependency for sw after r-type and i-type
addi $13, $11, 4
sub $10, $11, $0
sw $10, 12($11)
sw $13, 8($10)

##########################################
### Random Instructions with dependency ###
##########################################
add $2, $3, $29
# initialize the global pointer as it is in MARS
lui $1, 0x00001000
ori $1, $1, 0x00008000
addu $28, $2, $1

addiu $29, $29, -24 

addi  $1,  $1,  0x00000001
addi  $2,  $1,  0x00000002	
addi  $3,  $2,  0x000000FF	
addi  $4,  $1,  0xFFFFFFFF	

addiu  $1,  $4,  1
addiu  $2,  $3,  2	
addiu  $3,  $1,  3	
addiu  $4,  $2,  4
addiu  $5,  $3,  5	

addu  $2,  $5,  $1
addu  $3,  $3,  $4
addu  $4,  $3,  $2
addu  $5,  $3,  $4
addu  $6,  $4,  $5
add  $7,  $6,  $5
add  $9,  $4,  $7
addu $10,  $9,  $7

## and instructions
addi $11, $10, 0x0F00
and $12, $11, $10
andi $11, $12, 0x0000000F

## load instructions
lui $1, 0x00001001
ori $12, $1, 0x00000000


lui $1, 0x00001001
lw $14, 0x00000010($1)
lw $17, 0($12)
lw $18, 4($12)
lw $19, 8($12)
lw $20, 12($12)

## nor instruction
nor $22, $20, $19

## xor instructions
li $15, 0x0FFF
li $16, 0x0FFF
li $17, 0xF000
xor $23, $17, $16
xor $24, $16, $15
xori $25, $24, 0xF000

## or instructions
addi $22, $0, 0x0FF0
addi $16, $0, 0x000F
addi $15, $0, 0x000F
or $22, $16, $15
ori $23, $22, 0xFFFF

## slt instructions
addi $21, $0, 0x0FF0
addi $22, $21, 0x0FF0
addi $23, $21, 0x0FF0
addi $24, $23, 0x0FF0
addi $16, $22, 0x000F
addi $15, $16, 0x000F


slt $24, $15, $16
slt $25, $15, $24
slti $24, $24, 0x0001
sltiu $25, $24, 0
sltu $26, $25, $23

## shift instructions
addi $21, $25, 0x0FF0
addi $22, $21, 0x0FF0
addi $23, $22, 0x0FF0
addi $24, $23, 0x0FF0
addi $16, $24, 0x000F
addi $15, $0, 0x0004

sll $21, $15, 4
srl $22, $16, 4
sra $24, $22, 8
sllv $22, $24, $15
srlv $16, $24, $15
srav $23, $22, $15

## save instructions
li $3, 0xFFFF
li $4, 0x0000
sw $31, 20($29)
sw $3, 12($29)  
sw $4, 16($29)

## sub instuctions
addi $6, $0, 0x0FF0
addi $7, $0, 0x0F00
addi $8, $7, 0xF00F
addi $9, $6, 0x0FFF
sub $7, $8, $6
sub $6, $8, $7

## jump instuctions
addi $4, $6, 0x00000004
addi $5, $7, 0x00000000
addi $6, $5, 0x0000000F
addi $7, $6, 0x00000F0F

loop:
addi $5, $7, 0x00000001
beq $5, $5, caller
j loop

## caller is a recursive JAL
caller:
addiu $29, $29, -16 ## initialize stack memory
sw $31, 12($29)  ## store return addresses
sw $30, 8($29)  ## store value inside frame pointer into the stack
addu $30, $29, $0
sw $4, 16($29)  ## store first argument
sw $5, 20($29)  ## store second argument
sw $6, 24($29)  ## store third argument

jal callee

addu $4, $2, $0
lw $3, 20($29)
lw $2, 24($29)
add $5, $3, $2

jal callee

lw $31, 12($29)
lw $30, 8($29)
addiu $29, $29, 16

add $4, $0, $2
li $2, 1
# syscall

li $2, 10
syscall

callee:
lw $3, 16($29)
lw $2, 20($29)
addu $2, $3, $2
# ## check for jr dependency
addi $31, $31, 8
addi $31, $31, -4
addi $31, $31, -4
jr $31

addi $3, $1, 2
add $4, $3, $31
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

addi $2, $0, 10
syscall
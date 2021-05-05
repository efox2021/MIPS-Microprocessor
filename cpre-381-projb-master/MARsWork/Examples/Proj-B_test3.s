###########################################################################################
# Ehren Fox and Ethan McGill															  #
# CPRe 381 - ProjB																		  #																				
#																						  #
# Bubble Sort Algorithm																	  #
###########################################################################################

    .data
ARRAY:        .word       5,8,12,14,15,20,6,7,14,9,11,4,3,2,1,45

    .text
    .globl  begin
	
	
###########################################################################################
# This bubble sort will iterate through our ARRAY of elements, swapping adjacent elements #
# if the second element is greater than the first. It will continue looping until all     #
# all elements are sorted in ascending order. After each iteration through the ARRAY,     #
# the highest element will be stored at the end of the array, so each subsequent iteration#
# will check one less element.															  #													  
###########################################################################################

begin:
    li $t1,16                     # total number of ARRAY elements - could probably write 
								  # something that finds the length of the ARRAY


###########################################################################################
# main loop will pass through the array until its sorted								  #
########################################################################################### 

main:
    subi $a1,$t1,1                # number of loops decrements after each iteration 
     
	slt $a2, $0, $a1  
	beq $a2, $0, end_sequence     # end program if we're finished
	
    la $a0,ARRAY               	  # base address of ARRAY of items
    li $t2,0                   	  # swapped/unswapped (1 when we swap, reset here)

    jal arr_check                 # do a single sort pass

	
    beq $t2,$0, end_sequence      # if we haven't done a swap then we are done sorting

    subi $t1,$t1,1              
    beq $0, $0, main
	
	
###########################################################################################
# when we reach the end sequence we know that everything has been sorted. End of program. #																  #
# 																						  #
###########################################################################################

end_sequence:																	
    j       end                   # terminate program


###########################################################################################
# arr_check loops through the ARRAY														  #
# 																						  #
# the address of the ARRAY is in $a0 (line 18)											  # 
# the number of iterations (N-1) is in $a1 (line 16)									  #
#																						  #
# will load adjacent elements, and then compare them to see if the second element is 	  #
# greater than the first																  #
###########################################################################################

arr_check:
    lw $s1,0($a0)                 # $s1 = Nth element
    lw $s2,4($a0)                 # $s2 = N+1 Element
    bgt $s1,$s2,element_Swap      # branch to swap if $S2 > $S1
	

checkNext_Element:
    addiu $a0,$a0,4               # After checking one element, go to the next element and point at it
    subiu $a1,$a1,1               # loop counter 
    
	slt $a3, $0, $a1
	bne $a3, $zero, arr_check
    jr $ra                     	  # return once weve finished "pointing" at N-1 elements and			
								  # have swapped necessarily

element_Swap:
    sw $s1,4($a0)                 # Nth items gets value of Nth + 1 item
    sw $s2,0($a0)                 # Nth + 1 item gets value of Nth item
    li $t2,1                      # a swap has occurred, set according variable								  
	j checkNext_Element
	
###########################################################################################
# Once we reach the end of program, we will exit. The ARRAY found at base address $a0 is  #
# sorted in ascending order. Call syscall that ends program.							  #
###########################################################################################

end:
    li $v0,10
    syscall
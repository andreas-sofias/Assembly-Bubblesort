##########################################################################################
############								##################
############		MIPS ASSEMBLY BUBBLESORT 			##################
############								##################
############								##################
##########################################################################################

	.data 
array: 	.word 10, 1, 4, 12, 11, 8, 3, 16, 5, 19, 20, 6, 2, 7, 18, 14, 13, 15, 9, 17
msg1:	.asciiz "\nLoading array from memory." 
msg2: 	.asciiz "\nCommencing bubblesort"
msg3:	.asciiz "\nBUBLESORT COMPLETED!!!"
msg4:	.asciiz "\nNew sequence is : "
blank:	.asciiz " "
newline:.asciiz "\n"
	.globl main 
	
	.text

main:
	la $a0, msg1 
	li $v0, 4
	syscall 
	
	la $a0, msg2 
	li $v0, 4 
	syscall 
		
 
	li $t0, 20 	# $t0 ARRAY SIZE FOR LOOP  
	
	add $t1, $zero, $zero 	#first loop counter
	add $t2, $zero, $zero 	#second loop counter

	li $t3, 1
	j sort_outer_loop

sort_outer_loop: 
	beq $t3, $zero, printloop  #swap counter
	bge $t1, $t0, printloop 
	
	addi $t1, $t1,1 
	add $t2, $zero, $zero
	add $t3, $zero, $zero 	# first loop step
	li $t4, 0		# initializion for array traversal
	li $t5, 4
	blt $t1, $t0, sort_inner_loop

sort_inner_loop: 
	bge $t2, 19,sort_outer_loop	#if bigger-equal to 19 you go to outer loop
	addi $t2, $t2, 1
	lw $t8, array($t4) 		#load array data for comparisons
	lw $t9, array($t5) 
	bgt $t8,$t9, swap_numbers	#compare for swap or not
	ble $t8,$t9, no_swap

swap_numbers:
	
	move $t7, $t9 			#swap
	sw $t8, array($t5) 
	sw $t7, array($t4)

	addi $t3, $t3, 1
	addi $t4, $t4, 4 
	addi $t5, $t5, 4 
	j sort_inner_loop

no_swap:
 
        addi $t4, $t4, 4 	# no-swap scenario
	addi $t5, $t5, 4

	j sort_inner_loop
	
	
	
printloop:			#result printing procedure

	la $a0, msg3 
	li $v0, 4 
	syscall
	la $a0, msg4
	li $v0, 4 
	syscall 
	
	li $t4, 0
	li $t5, 0
	j while_print

while_print: 
	bge $t5, 20, exit
	lw $t7, array($t4)
	
	li $v0, 4 
	la $a0, blank
	syscall
	
	li $v0, 1 
	move $a0, $t7
	syscall 
	
	li $v0, 4 
	la $a0, blank
	syscall 
	
	addi $t5, $t5, 1
	addi $t4, $t4, 4
	j while_print
	

exit:				#exit
	li $v0, 10 
	syscall
	

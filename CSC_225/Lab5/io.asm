#########################################
# 	     Eliska Jelinek 		#
# 		CPE 225			#
# 	       5/20/2024		#
#########################################


.text
printstring:
	li a7, 4
	ecall
	ret

printchar:
	li a7, 11
	ecall
	ret
	
	
readstring:
	# To allow a nested subroutine call to readchar, you may save the ra and s0 to locations set aside in the data section.
	# readstring takes the address of the input buffer as an argument.  
	# The setup is similar to printstring, but reads in the chars instead of printing them.
	# Store the word one character per location in memory.  You must store the word and terminate the string properly
	
	
	# Check if max num of chars inputted # THIS ISN'T NECESSARY
	li t0, 20 # Assuming user will always want to press enter (19 chars + enter)
	beq a2, t0, maxCharsReached
	
	
	# saving ra and a0 to stack
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)

	
	jal readChar	
	mv a1, a0
	# if char is enter
	li t0, 0xa
	beq a1, t0, enterPressed
	lw a0, 4(sp)
	
	# Store char in a0 (userInput)
	sb a1, 0(a0)
	addi a0, a0, 1

	# Add to char count
	addi a2, a2, 1
	
	# Keep calling function
	jal readstring

	enterPressed:
	# move stack pointer back
	lw ra, 0(sp)
	addi sp, sp, 16
	
	# ret
	ret
	
	maxCharsReached:
		# print a new line
		li a0, 0xa
		jal printchar
		j enterPressed

readChar:
	li a7, 12
	ecall
	ret
	
exit:
	# Print exiting
	la a0, exiting
	jal printstring
	# Exit program
	li a7, 10
	ecall
	ret

.data
exiting: .string "Exiting"

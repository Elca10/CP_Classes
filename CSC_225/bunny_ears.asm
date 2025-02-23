# OUR WAY


.text
main:

# Arbitrary number of ears
li a0, 1
jal bunny_ears
li a7, 1
ecall
j exit

## function
#bunny_ears1:
#	# Base case
#	li t0, 0
#	beq t0, a0, return_0
#	
#	li t0, 1
#	sub a0, a0, t0
#	
#	addi a1, a1, 2
#	jal bunny_ears1 # Recursive call
#	
#	# Base case return
#	return_0:
#	li a0, 0
#	#ret
#
#
## print result
#li a7, 1
#mv a0, a1
#ecall









# HIS WAY
bunny_ears:
	beq a0, zero, base_case
	
	# saving ra to stack
	addi sp, sp, -16
	sw ra, 0(sp)
	
	# n - 1
	addi a0, a0, -1
	
	# recursive call
	jal bunny_ears
	addi a0, a0, 2
	
	# move stack pointer back
	lw ra, 0(sp)
	addi sp, sp, 16
	ret
	
	base_case:
	li a0, 0
	ret


li a7, 1
ecall 

exit:
li a7, 10
ecall

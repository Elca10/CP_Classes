.text
main:
li a0, 4 # arbitrary n
jal sum
li a7, 1
ecall
j exit

sum:
	beq a0, zero, baseCase
	
	# saving ra to stack
	addi sp, sp, -16
	sw ra, 0(sp)
	
	sw a0, 4(sp)
	
	# n - 1
	addi a0, a0, -1
	
	# recursive call
	jal sum
	lw a1, 4(sp)
	add a0, a0, a1
	
	
	# move stack pointer back
	lw ra, 0(sp)
	addi sp, sp, 16
	ret
		
	baseCase:
	li a0, 0
	ret


exit:
li a7, 10
ecall
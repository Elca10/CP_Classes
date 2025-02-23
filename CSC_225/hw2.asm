.text
main:
# arbitrary number n in a0
li a0, 1
jal factorial

# print a0
li a7, 1
ecall
j exit

factorial:
	li t0, 1
	beq a0, t0, baseCase
	
		
	# saving ra to stack
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)
	
	# n - 1
	addi a0, a0, -1
	
	# recursive call
	jal factorial
	lw a1, 4(sp)
	mul t0, a1, a0
	mv a0, t0
	
	# move stack pointer back
	lw ra, 0(sp)
	addi sp, sp, 16
	ret
	
	baseCase:
	li a0, 1
	ret


exit:
li a7, 10
ecall


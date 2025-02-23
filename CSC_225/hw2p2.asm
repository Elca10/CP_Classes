.text
main:
# arbitrary number x in a0
li a0, 200
jal func

# print a0
li a7, 1
ecall
j exit

func:
	addi sp, sp, -400 # saving space for 100 ints (each one word)
	# t1 = i
	li t1, 0 # i = 0
	
	# if x > 100, make it 100 for conditional because max numbers it can fit is 100
	li t2, 100
	blt a0, t2, preLoop
	mv a1, t2
	j loop
	
	preLoop:
	mv a1, a0
	
	loop:
		addi sp, sp, 4 # z[i] [increment by 1 word = 4 bytes]
		sw a0, 0(sp) # = x NOTE: x = a0
		
		addi t1, t1, 1 # i ++  
		blt t1, a1, loop # i < x (t1 < a0)
		

	# return 0
	li a0, 0
	ret

exit:
li a7, 10
ecall

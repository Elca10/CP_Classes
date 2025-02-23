



.text
main:
# Head
li a0, 30
li a1, 100
li a2, 20
jal circle

# Body
li a0, 30
li a1, 80
li a2, 30
li a3, 30
jal line

# Left Leg
li a0, 20
li a1, 1
li a2, 30
li a3, 30
jal line

# Right Leg
li a0, 40
li a1, 1
li a2, 30
li a3, 30
jal line

# Left Arm
li a0, 15
li a1, 60
li a2, 30
li a3, 50
jal line

# Right Arm
li a0, 30
li a1, 50
li a2, 45
li a3, 60
jal line

# Left Eye
li a0, 24
li a1, 105
li a2, 3
jal circle

# Right Eye
li a0, 36
li a1, 105
li a2, 3
jal circle

# Mouth Center
li a0, 25
li a1, 90
li a2, 35
li a3, 90
jal line

# Mouth Left
li a0, 25
li a1, 90
li a2, 20
li a3, 95
jal line

# Mouth Right
li a0, 35
li a1, 90
li a2, 40
li a3, 95
jal line

# Exit
li a7, 10
ecall


# Circle(xc, yc, r) [xc = center x coordinate, yc = center y coordinate, r = radius]
circle:
	# t1 = xc
	# t2 = yc
	# t3 = r / y
	# t4 = x
	# t5 = g
	# t6 = diagonalInc
	# t0 = rightInc
	mv t1, a0
	mv t2, a1
	mv t3, a2
	li t4, 0
	li a0, 2
	mul t5, t3, a0 # 2*r
	li a0, 3
	sub t5, a0, t5 # 3 - 2*r
	li a0, 4
	mul t6, t3, a0 # 4*r
	li a0, 10
	sub t6, a0, t6 # 10 - 4*r
	li t0, 6
	
	circleLoop:
		bgt t4, t3, endCircle # if x > y, end loop
		
		# saving ra to stack
		addi sp, sp, -16
		sw ra, 0(sp)
		
		# Plot circle points
		# plot (xc+x, yc+y)
		add a0, t1, t4
		add a1, t2, t3
		jal plot
		# plot (xc+x, yc-y)
		add a0, t1, t4
		sub a1, t2, t3
		jal plot 		
		# plot (xc-x, yc+y)
		sub a0, t1, t4
		add a1, t2, t3
		jal plot 		
		# plot (xc-x, yc-y)
		sub a0, t1, t4
		sub a1, t2, t3
		jal plot 	
		# plot (xc+y, yc+x)
		add a0, t1, t3
		add a1, t2, t4
		jal plot 	
		# plot (xc+y, yc-x)
		add a0, t1, t3
		sub a1, t2, t4
		jal plot	
		# plot (xc-y, yc+x)
		sub a0, t1, t3
		add a1, t2, t4
		jal plot 		
		# plot (xc-y, yc-x)
		sub a0, t1, t3
		sub a1, t2, t4
		jal plot 		
		
		# move stack pointer back
		lw ra, 0(sp)
		addi sp, sp, 16
		
		circleIf: # g >= 0
			blt t5, zero, circleElse # if g < 0, continue to else
			add t5, t5, t6 # g += diagonalInc
			addi t6, t6, 8 # diagonalInc += 8
			j incrementVars # skip else code
		circleElse:
			add t5, t5, t0 # g += rightInc
			addi t6, t6, 4 # diagonalInc += 4
		
		
		incrementVars:
		addi t0, t0, 4 # rightInc += 4
		addi t4, t4, 1 # x += 1
		
		
		
		j circleLoop # return to beginning of loop
	
	
	endCircle:
	ret






line:
    # Function arguments
    # a0 = x0
    # a1 = y0
    # a2 = x1
    # a3 = y1

    # Save the return address and registers we will use
    addi sp, sp, -32
    sw ra, 28(sp)
    sw s0, 24(sp)
    sw s1, 20(sp)
    sw s2, 16(sp)
    sw s3, 12(sp)
    sw s4, 8(sp)
    sw s5, 4(sp)

    # st = abs(y1 - y0) > abs(x1 - x0)
    sub s0, a3, a1            # s0 = y1 - y0
    #abs s0, s0                # s0 = abs(y1 - y0)
    mv a0, s0
    jal abs
    mv s0, a0
    sub s1, a2, a0            # s1 = x1 - x0
    #abs s1, s1                # s1 = abs(x1 - x0)
    mv a0, s0
    jal abs
    mv s1, a0
    bge s0, s1, set_st1       # if abs(y1 - y0) >= abs(x1 - x0), st = 1
    li s2, 0                  # else, st = 0
    j check_swap

set_st1:
    li s2, 1                  # st = 1

check_swap:
    beq s2, zero, check_x     # if st == 0, jump to check_x

    # Swap (x0, y0) and (x1, y1)
    mv s3, a0                 # temp = x0
    mv a0, a1                 # x0 = y0
    mv a1, s3                 # y0 = temp
    mv s3, a2                 # temp = x1
    mv a2, a3                 # x1 = y1
    mv a3, s3                 # y1 = temp

check_x:
    blt a0, a2, no_swap_x     # if x0 < x1, no swap needed

    # Swap (x0, x1) and (y0, y1)
    mv s3, a0                 # temp = x0
    mv a0, a2                 # x0 = x1
    mv a2, s3                 # x1 = temp
    mv s3, a1                 # temp = y0
    mv a1, a3                 # y0 = y1
    mv a3, s3                 # y1 = temp

no_swap_x:
    sub s0, a2, a0            # deltax = x1 - x0
    sub s1, a3, a1            # deltay = y1 - y0
    #abs s1, s1                # deltay = abs(y1 - y0)
    mv a0, s1
    jal abs
    mv s1, a0
    li s4, 0                  # error = 0
    mv s5, a1                 # y = y0

    blt a1, a3, set_ystep1    # if y0 < y1, ystep = 1
    li s3, -1                 # else, ystep = -1
    j loop_start

set_ystep1:
    li s3, 1                  # ystep = 1

loop_start:
    mv t0, a0                 # t0 = x0

loop:
    bge t0, a2, end_loop      # if x > x1, end loop

    beq s2, zero, plot_xy     # if st == 0, plot(x, y)
    mv a0, s5                 # else, plot(y, x)
    mv a1, t0
    jal ra, plot
    j update_error

plot_xy:
    mv a0, t0
    mv a1, s5
    jal ra, plot

update_error:
    add s4, s4, s1            # error = error + deltay
    slli t1, s4, 1            # t1 = 2 * error
    blt t1, s0, next_x        # if 2 * error < deltax, continue
    add s5, s5, s3            # y = y + ystep
    sub s4, s4, s0            # error = error - deltax

next_x:
    addi t0, t0, 1            # x = x + 1
    j loop

end_loop:
    # Restore the saved registers and return
    lw ra, 28(sp)
    lw s0, 24(sp)
    lw s1, 20(sp)
    lw s2, 16(sp)
    lw s3, 12(sp)
    lw s4, 8(sp)
    lw s5, 4(sp)
    addi sp, sp, 32
    ret
    
    
    
   

plot:
# static data at coordinates, turn to 0xF (currently 0x0)
	
	# base + ((256 - y) * 256 + x) * 4
	li a3, 256
	sub a1, a3, a1
	
	# base + (y * 256 + x) * 4
	li a3, 256
	mul a1, a1, a3 # y * 256
	add a1, a1, a0 # + x
	li a3, 4
	mul a1, a1, a3 # * 4
	lw a3, base
	add a3, a3, a1
	lw a4, white
	sw, a4, 0(a3)
	
	
	ret


abs:
	bge a0, zero, pos
	li a7, -1
	mul a0, a0, a7
	pos:
	ret

abs1:
	sub a0, a0, a1
	bge a0, zero, isPositive
	li a7, -1
	mul a0, a0, a7
	isPositive:
	ret
	
	



.data
base: .word 0x10010000
white: .word 0xFFFFFF

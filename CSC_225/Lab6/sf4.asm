


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
    addi sp, sp, -16  # Save return address
    sw ra, 0(sp)
    
    mv t0, a0  # x0
    mv t1, a1  # y0
    mv t2, a2  # x1
    mv t3, a3  # y1
    
    mv a0, t3
    mv a1, t1
    jal abs  # abs(y1 - y0)
    mv t4, a0
    
    mv a0, t2
    mv a1, t0
    jal abs  # abs(x1 - x0)
    mv t5, a0
    
    bgt t4, t5, st1  # if abs(y1 - y0) > abs(x1 - x0)
    li t6, 0
    j swap_done
st1:
    li t6, 1

swap_done:
    beqz t6, check_x  # If not steep (t6 == 0), skip swapping x and y
    mv a0, t0
    mv t0, t1
    mv t1, a0
    
    mv a0, t2
    mv t2, t3
    mv t3, a0

check_x:
    ble t0, t2, skip_swap_xy  # If x0 <= x1, skip swapping
    mv a0, t0
    mv t0, t2
    mv t2, a0
    
    mv a0, t1
    mv t1, t3
    mv t3, a0

skip_swap_xy:
    sub a2, t2, t0  # deltaX
    sub a3, t3, t1  # deltaY
    bge t1, t3, ystep_neg  # ystep = (y1 >= y0) ? 1 : -1
    li a6, 1
    j ystep_done
ystep_neg:
    li a6, -1

ystep_done:
    li a4, 0  # error = 0
    mv a5, t1  # y = y0
    
    mv a7, t0  # x = x0
line_loop:
    beq a7, t2, end_loop  # If x == x1, end loop
    beqz t6, plot_normal
    mv a0, a5
    mv a1, a7
    j plot_and_continue
plot_normal:
    mv a0, a7
    mv a1, a5
plot_and_continue:
    jal plot
    add a4, a4, a3  # error += deltaY
    
    li t4, 2
    mul t5, t4, a4  # 2 * error
    blt t5, a2, skip_ystep  # If 2 * error < deltaX, skip y-step
    add a5, a5, a6  # y += ystep
    sub a4, a4, a2  # error -= deltaX
skip_ystep:
    addi a7, a7, 1  # x++
    j line_loop

end_loop:
    lw ra, 0(sp)  # Restore return address
    addi sp, sp, 16
    ret







# 10010000  ...  10011024
#  ...		   ...
# ????????  ...  ????????
plot:
# static data at coordinates, turn to 0x0 (currently 0xF)
	
	## base + (y * 256) + (x * 4)
	#li a3, 256
	#mul a1, a1, a3 # y * 256
	#li a3, 4
	#mul a0, a0, a3 # x * 4
	#add a0, a0, a1
	##lw a3, 0x10010000
	#lw a3, base
	#add a3, a3, a0
	##lw a4, 0xFFFFFF
	#lw a4, white
	#sw a4, 0(a3)
	
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
	bge a0, zero, nextCheck
	# some register for -1
	li t5, -1 # t5 is not being used yet in the line function and will not be overwriting anything
	mul a0, a0, t5 # make it positive

	nextCheck:
	bge a1, zero, subtract
	# make it positive
	mul a1, a1, t5
	
	subtract:
	sub a0, a0, a1
	ret



.data
base: .word 0x10010000
white: .word 0xFFFFFF

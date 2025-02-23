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
li a3, 50  # Corrected Y coordinate to connect head and body
jal line

# Left Leg
li a0, 20
li a1, 50  # Corrected Y coordinate to connect to body
li a2, 10
li a3, 20  # Corrected length and end coordinates
jal line

# Right Leg
li a0, 40
li a1, 50  # Corrected Y coordinate to connect to body
li a2, 50
li a3, 20  # Corrected length and end coordinates
jal line

# Left Arm
li a0, 16
li a1, 60  # Corrected Y coordinate to connect to body
li a2, 30
li a3, 50  # Adjusted to match body position
jal line

# Right Arm
li a0, 30
li a1, 50  # Corrected to match body position
li a2, 45
li a3, 60  # Adjusted to match body position
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
li a3, 85  # Adjusted Y coordinate
jal line

# Mouth Right
li a0, 35
li a1, 90
li a2, 40
li a3, 85  # Adjusted Y coordinate
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




# Line (x0, y0, x1, y1)
line:
	# saving ra to stack (will be overwritten by later function calls)
	addi sp, sp, -16
	sw ra, 0(sp)
	
	
	# t0 = x0
	# t1 = y0
	# t2 = x1
	# t3 = y1
	mv t0, a0 
	mv t1, a1
	mv t2, a2
	mv t3, a3
	
	mv a0, t3
	mv a1, t1
	jal abs # abs(y1-y0)
	# t4 = abs(y1 - y0)
	mv t4, a0
	
	mv a0, t2
	mv a1, t0
	jal abs
	# t5 = abs(x1 - x0)
	mv t5, a0
	
	# t6 = st
	bgt t4, t5, true # if abs(y1 - y0) > abs(x1 - x0)
	li t6, 0 # else: st = 0
	j nextIf
	true:
	li t6, 1 # st = 1
	
	nextIf: 
	li a0, 0
	beq t6, a0, nextIf2 # if st != 1 (st = 0)
	# swap(x0, y0)
	mv a0, t0
	mv t0, t1
	mv t1, a0

	# swap(x1, y1)
	mv a0, t2
	mv t2, t3
	mv t3, a0
	

	nextIf2: 
	# if x0 > x1 (skip if x0 <= x1)
	ble t0, t2, continueLine
	# swap(x0, x1)
	mv a0, t0
	mv t0, t2
	mv t2, a0
	# swap(y0, y1)
	mv a0, t1
	mv t1, t3
	mv t3, a0
	

	# all the a registers except a0 and a1 (for plot)
	# t5 and t4
	
	continueLine:
	# a2 = deltax
	# a3 = deltay
	# a4 = error
	# a5 = y
	# a6 = ystep
	# a7 = x
	sub a2, t2, t0#mv a2, t5#sub a2, t2, t0 # deltax = x1 - x0 # MAYBE ABS??? # THIS DIDN'T CHANGE ANYTHING
	mv a3, t4 # deltay = abs(y1 - y0)
	li a4, 0 # error = 0
	mv a5, t1 # y = y0
	
	bge t1, t3, else# if y0 < y1 (aka if y0 >= y1 inverse)
	li a6, 1
	j setX
	else:
	li a6, -1
	
	setX:
	mv a7, t0 # x = x0 to start
	lineForLoop:
		beq a7, t2, endLoop # if x > x1 # MIGHT NEED TO CHANGE FOR UPRIGHT STICK FIGURE
		li t4, 1
		beq t6, t4, st1 # if st == 1
		# else: plot(x, y)
		mv a0, a7
		mv a1, a5
		jal plot
		j continueForLoop
		st1:
		# plot(y, x)
		mv a0, a5
		mv a1, a7
		jal plot
		
		continueForLoop:
		add a4, a4, a3 # error = error + deltay
		
		li t4, 2
		mul t5, t4, a4 # 2*error
		# if 2*error < deltax, skip this and continue loop
		blt t5, a2, incrementX
		add a5, a5, a6 # y = y + ystep
		sub a4, a4, a2 # error = error - deltax
		
		# increment x
		incrementX:
		blt t2, t0, decrementX
		addi a7, a7, 1
		ble a7, t0, endLoop
		j lineForLoop
		decrementX:
		addi a7, a7, -1
		bge a7, t0, endLoop
		j lineForLoop
	
	endLoop:
	
	# reload return address and move stack pointer back
	lw ra, 0(sp)
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

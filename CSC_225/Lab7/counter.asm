#########################################
# 	     Eliska Jelinek 		#
# 		CPE 225			#
#########################################


.text
main:
# LOAD DIGITS INTO STATIC DATA LIST
la a0, list
# 0 = 63
li a1, 63
sb a1, 0(a0)
# 1 = 6
li a1, 6
sb a1, 1(a0)
# 2 = 91
li a1, 91
sb a1, 2(a0)
# 3 = 79
li a1, 79
sb a1, 3(a0)
# 4 = 102
li a1, 102
sb a1, 4(a0)
# 5 = 109
li a1, 109
sb a1, 5(a0)
# 6 = 125
li a1, 125
sb a1, 6(a0)
# 7 = 7
li a1, 7
sb a1, 7(a0)
# 8 = 127
li a1, 127
sb a1, 8(a0)
# 9 = 111
li a1, 111
sb a1, 9(a0)


# Initialize counters
# t1 = right counter = 0
# t2 = left counter = 0
li t1, 0
li t2, 0

# I could put the display code into a function, but that would take more time than it's worth and it's still readable :)
# Display the right number 
li a0, 0xffff0010 # right LED address
li t3, 0x10010000 # index 0 of list essentially (address of the beginning)
add t3, t3, t1 # index 0 + RIGHT
lb a1, 0(t3) # load digit code
sb a1, 0(a0) # display

# Display the left number
li a0, 0xffff0011
li t3, 0x10010000
add t3, t3, t2 # index 0 + LEFT
lb a1, 0(t3)
sb a1, 0(a0)


mainLoop:
	# read char
	la a0, userInput
	li a7, 8
	li a1, 2
	ecall
	
	# If char is "q"
	la a1, q
	lb a1, 0(a1) # load byte not address
	lb a0, 0(a0)
	beq a0, a1, exit # exit
	
	# If char is not a space, ignore
	la a1, space
	lb a1, 0(a1)
	bne a0, a1, mainLoop # return to beginning of loop, ready for input
	
	# Else: increment counter
	addi t1, t1, 1 # increment right digit by 1
	li t3, 9
	ble t1, t3, display # if less than 9, good to display (no carry to left)
	# if right > 9:
	li t1, 0 # set right to 0
	addi t2, t2, 1 # increment left by 1, carry
	ble t2, t3, display # skip to display if no left carry
	# if left > 9:
	li t2, 0
	
	
	display:
	# Display right digit
	li a0, 0xffff0010
	li t3, 0x10010000
	add t3, t3, t1 # index 0 + RIGHT
	lb a1, 0(t3)
	sb a1, 0(a0)
	
	# Display left digit
	li a0, 0xffff0011
	li t3, 0x10010000
	add t3, t3, t2 # index 0 + LEFT
	lb a1, 0(t3)
	sb a1, 0(a0)
	
	
	# Repeat
	j mainLoop
	


# exit
exit: 
li a7, 10
ecall




# PSEUDOCODE:
# get input
# if input is "q"
# 	exit
# if input is " "
# 	right = right + 1
# 	if right > 9
# 		right = 0
# 		left = left + 1
# 		if left >= 9 (could be 10 now)
#			#right = 0
#			left = 0
# 	display
#	continue
# else:
# 	continue


.data
list: .space 10 #first 10 bytes of data
space: .string " "
q: .string "q"
userInput: .space 1
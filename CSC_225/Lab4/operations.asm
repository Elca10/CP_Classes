.text
#### ADDITION ####
.global addnums
addnums:
add a0, a0, a1
ret

#### SUBTRACTION ####
.globl subnums
subnums:
sub a0, a0, a1
ret

#### MULTIPLICATION ####
.globl multnums
multnums:
# If either num is 0, return 0
li t0, 0
beq a0, t0, returnZero
beq a1, t0, returnZero

# If second num is odd...
li t4, 0 # setup (default to add is 0)
li t0,1
and t1, a1, t0 # mask to determine last bit
bne t0, t1, multPart2 # skip adding if last bit is not a 1
# Save num1 for adding to itself later (multiply x1)
mv t4, a0 # overwrite default set above

# Subtract one from 2nd number
sub a1, a1, t0

multPart2:
# Keep shifting (multiply x2) while num > 0, and subtract two from it
li t0, 0
li t5, 0 # initialize to 0
# check that a1 is not already 0
beq a1, t0, multReturn
multLoop:
	slli t6, a0, 1 # initial num x2
	add t5, t5, t6 # add to final result
	li t1, 2
	sub a1, a1, t1 # subtract 2
	bne a1, t0, multLoop # keep going while still nums left to multiply

multReturn:
add a0, t4, t5
ret


returnZero:
li a0, 0
ret

#### DIVISION ####
.globl divnums
divnums:
# return "!" if divBy0
li t0, 0
beq a1, t0, invalidDivision

validDivision:
	# loop setup
	li t0, 0 # t0 = result
	mv t1, a0 # Dividend
	mv t2, a1 # Divisor
	
	# If dividend < divisor, return 0
	blt t1, t2, returnPrep
	
	divLoop: # not efficient, but just keep subtracting divisor
		# Subtract divisor from dividend
		sub t1, t1, t2
		# Increment quotient
		addi t0, t0, 1
		# Keep going while dividend >= divisor
		bge t1, t2, divLoop
	
	returnPrep:
	# Return the quotient
	mv a0, t0

ret

invalidDivision:
	la a0, divBy0Error
	ret


#### AND ####
.globl andnums
andnums:
and a0, a0, a1
ret

#### OR ####
.globl ornums
ornums:
or a0, a0, a1
ret

#### XOR ####
.globl xornums
xornums:
xor a0, a0, a1
ret


.data
invalid: .string "!"

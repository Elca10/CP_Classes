# CPE 225
# Lab 1
# Name:
.data
Name: .string "NNNNNNNNNNNNN" # Your name in double quotes

# For signed, 8-bit numbers, what is the value (in decimal) 
#   of each of the following 2's complement binary numbers:

# Replace DDDD with the signed decimal equivalent 
#    of the provided 2's complement binary number
# To provide an example, the first question is answered.

decval1:	.word DDDD  # 00000000b 
#decval1: .word 0  # 00000000b 
decval2:	.word DDDD  # 00011010b
decval3:	.word DDDD  # 11111111b
decval4:	.word DDDD  # 10000001b
decval5:	.word DDDD  # 10000000b
decval6:	.word DDDD  # 10110101b

# What is the largest unsigned value that fits in 16 bits.
unsigned16bmin:	.word	0  # The minimum value of an unsigned number is 0.
unsigned16bmax:	.word	DDDDD  # Replace DDDDD with the maximum value that fits in 16bits.

# What are the minimum and maximum SIGNED values that fit in 16 bits.
signed16bmin:	.word	DDDDD  # Replace DDDDD with the minimum value that fits in 16bits.
signed16bmax:	.word	DDDDD  # Replace DDDDD with the maximum value that fits in 16bits.

# Provide two 8 bit values that causes a Carry without a Sign overflow:
CarryNoOV1:	.word	DDD  # Replace DDD with a decimal value.
CarryNoOV2:	.word	DDD  # Replace DDD with a decimal value.
# The 8bit result of CarryNoOV1 + CarryNoOV2 results 
#   in a Carry without a Sign overflow.

# Provide two 8 bit values that causes a Sign Overflow without a Carry overflow:
SignNoCarry1:	.word	DDD  # Replace DDD with a decimal value.
SignNoCarry2:	.word	DDD  # Replace DDD with a decimal value.
# The 8bit result of SignNoCarry1 + SignNoCarry2 results 
#   in a Sign Overflow without a Carry.

# Bitwise Logic Operations

# Provide the answer in hexadecimal:
#	0x25A6 & 0x5087 = ________
bitval1:	.word 0xHHHH	# replace the HHHH with your answer in hexadecimal

#	0xABCD | 0x1DDD = ________
bitval2:	.word 0xHHHH	# replace the HHHH with your answer in hexadecimal

# Determine both the operation (ADD/AND/OR/NOT/XOR) and the value needed to 
#   clear bit 7 of the following value to zero (clear bit 7) in a single operation.
#   Leave the rest of the bits unchanged. (Hint: expand the values to binary.)
#   See the discussion on "Clear Mask" in the reading.
#
#	 0x97CA (ADD/AND/OR/NOT/XOR) CLEARMASK  =  ????

.eqv CLEAROP OPERATION	# replace OPERATION with one of (ADD/AND/OR/NOT/XOR).
CLEARMASK: .word 0xHHHH	# replace HHHH with hexadecimal VALUE you selected.

# Determine both the operation (ADD/AND/OR/NOT/XOR) and the value needed to 
#   set bit 5 of the following value to one (set bit 5) in a single operation.
#   Leave the rest of the bits unchanged.
#   See the discussion on "Set Mask" in the reading.
#
#	0x85CA (ADD/AND/OR/NOT/XOR) SETMASK  =  ????

.eqv SETOP OPERATION	# replace OPERATION with one of (ADD/AND/OR/NOT/XOR).
SETMASK:	.word 0xHHHH	# replace HHHH with hexadecimal VALUE you selected.




 

 

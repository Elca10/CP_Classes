#########################################
# 	     Eliska Jelinek 		#
# 		CPE 225			#
# 	       5/11/2024		#
#########################################


#########################################
# REGISTER VALUES                       #
# s0: operations count                  #
# s1: num1                              #
# s2: num2              	        #
# s3: operation			        #
# s4: result			        #
#				        #
# ARGUMENT VALUES		        #
# a0: num1/result		        #
# a1: num2			        #
#########################################

.text
#### Startup ####
main:
# Print Welcome
la a0, welcome
jal printstring

# Print operation options
la a0, operations
jal printstring

# Operations performed counter
li s0, 0

#### MAIN LOOP ####
loop:
	jal printNewLine
	
	#### Print operations performed ####
	# Print operations performed text
	la a0, operationsPerformed
	jal printstring
	
	# Print counter value
	mv a0, s0
	jal printint
	
	#### User input: number 1 ####
	jal printNewLine
	# Ask for num text
	la a0, askForNum1
	jal printstring
	# Receive user input (int)
	jal readint
	mv s1, a0 # Move input out of a0 so it's not overwritten
	
	####  User input: number 2 ####
	# Ask for num 2 text
	la a0, askForNum2
	jal printstring
	# Receive user input (int)
	jal readint
	mv s2, a0 # Move input out of a0 so it's not overwritten
	
	#### User input: operation ####
	# Ask for operation
	la a0, selectOp
	jal printstring
	
	# Receive user input (int)
	jal readint
	
	#### Check input operation validity
	# Check >= 8
	li t1, 8
	bge a0, t1, invalid
	# Check < 1
	li t1, 1
	blt a0, t1, invalid
	# Operation is certified valid, continue with execution
	mv s3, a0
	
	#### Execute operation ####
	# Move variables into argument registers
	mv a0, s1
	mv a1, s2
	
	# Figure out operation, execute corresponding function call
	li t0, 1
	beq t0, s3, addNumsFunc
	addi t0, t0, 1
	beq t0, s3, subNumsFunc
	addi t0, t0, 1
	beq t0, s3, multNumsFunc
	addi t0, t0, 1
	beq t0, s3, divNumsFunc
	addi t0, t0, 1
	beq t0, s3, andNumsFunc
	addi t0, t0, 1
	beq t0, s3, orNumsFunc
	addi t0, t0, 1
	beq t0, s3, xorNumsFunc
	
	addNumsFunc:
	jal addnums
	mv s4, a0
	j valid
	
	subNumsFunc:
	jal subnums
	mv s4, a0
	j valid
	
	multNumsFunc:
	jal multnums
	mv s4, a0
	j valid
	
	divNumsFunc:
	jal divnums
	mv s4, a0
	# if result is not a divBy0
	la t0, divBy0Error
	bne s4, t0, goodDiv
	# Print result text
	la a0, result
	jal printstring
	# Print error result
	la a0, div0Result
	jal printstring
	j incrementOpCount
				
		goodDiv:
		j valid
	
	andNumsFunc:
	jal andnums
	mv s4, a0
	j valid
	
	orNumsFunc:
	jal ornums
	mv s4, a0
	j valid
	
	xorNumsFunc:
	jal xornums
	mv s4, a0
	j valid
	
	#### Print result - valid ####
	valid:
		# Print result text
		la a0, result
		jal printstring
		# Print integer result
		mv a0, s4 # Load operation result
		jal printint
		#jal printint
		j incrementOpCount # skip invalid printing
	
	
	#### Print result - invalid ####
	invalid:
		# Print result text
		la a0, result
		jal printstring
		# Print invalid operation text
		la a0, invalidOperation
		jal printstring
		
		#### Add to operations count ####
		incrementOpCount:
		addi s0, s0, 1
	
	#### Ask to continue ####
	jal printNewLine
	# Ask to continue
	la a0, askContinue
	jal printstring
	
	# Get user input (string)
	la a0, userContinue
	jal readchar
	
	# Check if user inputted "n"
	la t1, no
	lb a0, (a0)
	lb t1, (t1)
	
	# Return to beginning of loop if user didn't input "n"
	bne a0, t1, loop


#### Exit Program ####
exit:
	jal printNewLine
	# Print operations performed text
	la a0, operationsPerformed
	jal printstring
	# Print operations performed counter
	mv a0, s0
	jal printint
	jal printNewLine
	# Print exiting
	la a0, exiting 
	jal printstring
	# Actually exit
	li a7, 10
	ecall 



#### All program static data ####
.data
welcome: .string "Welcome to the Calculator program.\n"
operations: .string "Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor\n"
operationsPerformed: .string "Number of operations performed: "
askForNum1: .string "Enter number: "
askForNum2: .string "Enter second number: "
selectOp: .string "Select operation: "
result: .string "Result: "
invalidOperation: .string "Invalid Operation"
askContinue: .string "Continue (y/n)?: "
userContinue: .space 3
no: "n"
exiting: .string "Exiting"
.globl divBy0Error
divBy0Error: .string "!"
div0Result: .string "Error! Can't divide by 0"


# Import other file's functions
# Not needed when assembling all files in directory together
# .include "operations.asm"
# .include "io.asm"

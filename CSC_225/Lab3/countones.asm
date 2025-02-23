# CPE 225
# Lab 3
# Names: Eliska Jelinek and James Hazelwood

#### Code
.text
main: # Label to indicate main portion of code
	### Welcome user to program
	li a7, 4 # Print a string
	la a0, welcome # Load address of welcome string to prep for printing
	ecall # Actually execute the printing command
	
	### Repeatedly asks user for int and prints number of 1 bits
	loop: # Loop label
	
		#### Print a new line
		li a7, 4 # Prep for printing a string
		la a0, newLine # Load address of new line string
		ecall # Execute printing command
		
		### Ask user for an int
		li a7, 4 # Prep for printing a string
		la a0, askForNum # Load address of askForNum string
		ecall # Execute
		
		### Read an int from the user
		li a7, 5 # Prep for user input as an int
		ecall # Execute and store in a0
		
		
		### Count ones
		###	 a0 == user int as function input
		jal countOnes # Call countOnes function
		mv s1, a0 # Save result in s1
		
		### Display the result
		li a7, 4 # Prep for printing a string
		la a0, printBits # Load address of printBits string
		ecall # Execute
		li a7, 1 # Print a number
		mv a0, s1 # Move countOnes result to a0 for printing
		ecall # Execute
		
		
		### Print a new line
		li a7, 4 # Prep for printing a string
		la a0, newLine # Load newLine string address
		ecall # Execute
		
		### Ask to continue
		li a7, 4 # Print string
		la a0, continue # Load continue string address
		ecall # Execute
		li a7, 8 # Prep for user input as string
		la a0, userContinue # Saves user input in a0
		li a1, 3 # includes null (accepts 1 char?)
		ecall # Execute
		
		### Prep for comparison
		mv t1, a0 # Save user input in t1 for comparison later
		la s0, yes # Load yes string into s0
		lb t1, (t1) # Load the character from memory address t1
		lb s0, (s0) # Load the character from memory address s0
		
		# Returns to beginning of loop if user inputted "y"
		beq t1, s0, loop
		
	# Print a new line
	li a7, 4 # Prep for printing a string
	la a0, newLine # Load newLine string address
	ecall # Execute
	
	# Proceed to exit if user wants to stop
	exit:
		li a7, 4 # Print string
		la a0, close # Load close string
		ecall # Execute
		
		### Official exit
		li a7, 10
		ecall
	
### Count Ones Function
countOnes: 	
	### If -1, return 32
	li t1, -1
	beq a0, t1, ret32
	
	### Start ones count at 0
	li t0, 0
	
	countLoop:
		### While (num != 0 && num != -1):
		li t1, 0
		beq a0, t1, exitLoop # If num is 0, exit
		li t1, -1
		beq a0, t1, exitLoop # If num is -1, exit
		
		# Prep for if statement comparisons
		li t1, -1 # Should already be -1 from previous condition check, but adding for clarity
		li t2, 1
		li t3, 2
		
		# if num is odd (and positive), add to count
		rem t4, a0, t3 # number % 2 --> t4 (remainder)
		beq t4, t2, plusOne
		
		# if num is not odd (and negative), skip to shift
		rem t4, a0, t3 # (remainder)
		bne t4, t1, shift # don't add one if it's not odd
		
		
		### add one to count 
		plusOne:
		addi t0, t0, 1
		
		shift:
		### shift bit digit to right >>> 1;
		srli a0, a0, 1
		j countLoop # return to beginning of loop 
		
		
	exitLoop:
	mv a0, t0 # Move ones count to a0
	ret # return count
	
	
	ret32:
	li a0, 32
	ret # Return 32 (num == -1)




### All the data for the code
.data
	welcome: .string "Welcome to the CountOnes program.\n"
	yes: .string "y"
	continue: .string "Continue (y/n)?: "
	userContinue: .space 3
	close: .string "Exiting"
	askForNum: .string "Please enter a number: "
	printBits: .string "The number of bits set is: "
	newLine: .string "\n"
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
		jal zeros # Call countOnes function
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
zeros: 	

######################### ADD CODE HERE ##########################
###### YOU CAN BASE IT OFF THE COUNTONES ONE IF IT'S HELPFUL
###### Remember that the input is in a0, and the output should be returned in a0 as well




### All the data for the code
.data
	welcome: .string "Welcome to the Zeros program.\n"
	yes: .string "y"
	continue: .string "Continue (y/n)?: "
	userContinue: .space 3
	close: .string "Exiting"
	askForNum: .string "Please enter a number: "
	printBits: .string "The number of leading zeros is: "
	newLine: .string "\n"
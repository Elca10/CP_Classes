.text

main:
	# Print user prompt
	li a7, 4
	la a0, enterWord
	ecall

	# readstring takes the address of the input buffer as an argument.  
	#addi a0, sp, -20 # 20 characters, last one is the buffer
	la a0, userInput
	li a2, 0
	jal readstring
	
	maxCharsReached:
	# print a new line
	li a7, 11
	li a0, 0xa
	ecall
	
	
	enterPressed:
	li s0, 0
	beq a2, s0, exitMain
	# Print "Original word: "
	li a7, 4
	la a0, ogWord
	ecall
	
	# Print the original word
	li a7, 4
	la a0, userInput
	ecall
	
	
	# Print "Alphabetized word: "
	li a7, 4
	la a0, alphWord
	ecall
	
	# Print sorted words
	la a0, userInput
	jal printsort
	
	# Print new line
	li a7, 11
	li a0, 0xa
	ecall
	
	j main
	
	exitMain:
	j exit

	
	

readstring:
	# To allow a nested subroutine call to readchar, you may save the ra and s0 to locations set aside in the data section.
	# readstring takes the address of the input buffer as an argument.  
	# The setup is similar to printstring, but reads in the chars instead of printing them.
	# Store the word one character per location in memory.  You must store the word and terminate the string properly
	
	
	# Check if max num of chars inputted # THIS ISN'T NECESSARY
	li t0, 20 # Assuming user will always want to press enter (19 chars + enter)
	beq a2, t0, maxCharsReached
	
	
	
	# saving ra and a0 to stack
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)

	
	jal readChar	
	mv a1, a0
	# if char is enter
	li t0, 0xa
	beq a1, t0, enterPressed
	lw a0, 4(sp)
	
	# Store char in a0 (userInput)
	sb a1, 0(a0)
	addi a0, a0, 1

	# Add to char count
	addi a2, a2, 1
	
	# Keep calling function
	jal readstring

	# move stack pointer back
	lw ra, 0(sp)
	addi sp, sp, 16
	
	# ret
	ret


readChar:
	li a7, 12
	ecall
	ret

printsort:
	li t6, 0x0 # Last smallest
	li t2, 0x0 # null char
	li t3, 20#lb t3, 0(a2) #li t3, 20 # max chars (user input length) # CHANGE THIS
	
	printSortLoop:
	li t0, 0 # Loop counter
	lb t1, 0(a0) # Current smallest (first char by default)
	mv a1, a0 # User input pointer (will change during loop)
	
	findSmallest:
		lb t4, 0(a1) # current character
		# if current char null, continue
		beq t2, t4, continue
		# if last smallest, replace with null and continue
		beq t4, t6, overwrite
		# if current smallest is not null continue, else replace with current char
		#bne t1, t2, continue
		#lb t1, 0(a1) # can rewrite this
		#j continue
		beq t1, t2, newSmallest
		
		# if bigger, continue
		bge t4, t1, continue
		
		newSmallest:
		# else, new smallest
		lb t1, 0(a1)
		j continue # skip overwriting
		
		overwrite:
		sb t2, 0(a1) #overwrite in current version of word
		#sb t2, 0(a0) # overwrite in whole version
		bne t1, t6, finishOverwrite
		lb t1, 1(a1)
		
		finishOverwrite:
		mv t6, t2
		
		#sb t2, 0(t6) # Overwrite last smallest
		# current smallest is next char
		#lb t1, 1(a1)
		
		continue:
		addi t0, t0, 1
		addi a1, a1, 1
		bne t0, t3, findSmallest
	
	# if smallest is null (default 0x0 declared)
	beq t1, t2, done
	
	# else, print smallest and clear (overwrite with null)
	mv a2, a0
	li a7, 11
	mv a0, t1
	ecall
	mv a0, a2
	#mv a0, a1
	# CLEAR??
	mv t6, t1 # update previous smallest
	
	j printSortLoop
	
	# save a0
	#addi sp, sp, -16
	#sw a0, 0(sp)
	
	# else, print smallest
	#li a7, 11
	#lb a0, 0(t1)
	#ecall
	
	# reassign a0
	#lw a0, 0(sp)
	#addi sp, sp, 16
	
	
	# if at the end (beq 19/20)
	# if smallest is null, done
	# else, reloop printsort


	# find smallest
	# save it
	# replace with 0 (null)
	# return smallest
	# keep going until they're all null (increment is at 19 and smallestChar = 0 (false)
	
	
	done:
	ret




exit:
# Print exiting
li a7, 4
la a0, exiting
ecall
# Exit program
li a7, 10
ecall




.data
enterWord: .string "Enter word: "
ogWord: .string "Original word: "
alphWord: .string "\nAlphabetized word: "
exiting: .string "Exiting"
userInput: .space 20

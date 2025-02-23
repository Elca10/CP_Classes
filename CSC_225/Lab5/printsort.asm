#########################################
# 	     Eliska Jelinek 		#
# 		CPE 225			#
# 	       5/20/2024		#
#########################################

.text
main:
	# Print user prompt
	la a0, enterWord
	jal printstring
	
	# readstring takes the address of the input buffer as an argument.  
	#addi a0, sp, -20 # 20 characters, last one is the buffer
	la a0, userInput
	li a2, 0
	jal readstring

	# maxChars Reached
	
		
	#enterPressed:
	li s0, 0
	beq a2, s0, exitMain
	# Print "Original word: "
	la a0, ogWord
	jal printstring
	
	# Print the original word
	la a0, userInput
	jal printstring
	
		
	# Print "Alphabetized word: "
	la a0, alphWord
	jal printstring
	
	# Print sorted words
	la a0, userInput
	jal printSort
	
	# Print new line
	li a0, 0xa
	jal printchar
	
	j main
	
	exitMain:
	j exit
	
	
printSort:
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
	# else, reloop printSort


	# find smallest
	# save it
	# replace with 0 (null)
	# return smallest
	# keep going until they're all null (increment is at 19 and smallestChar = 0 (false)
	
	
	done:
	ret

	
.data
enterWord: .string "Enter word: "
ogWord: .string "Original word: "
alphWord: .string "\nAlphabetized word: "
userInput: .space 20

.include "io.asm"

############# TEST EDGE CASES: 19/20 CHARS #########

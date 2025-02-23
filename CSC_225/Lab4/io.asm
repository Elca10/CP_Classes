.text
#### MINI HELPER FUNCTIONS ####
.globl printint
printint: # (int)
	li a7, 1
	# Int will aready be in a0
	ecall
	ret
	
.globl printstring
printstring: # (address)
	li a7, 4
	# Address will already by in a0
	ecall
	ret
	
.globl readchar
readchar: # --> char
	li a7, 8
	li a1, 3
	ecall
	ret
	
.globl readint
readint: # --> int
	li a7, 5
	ecall # User inputted number stored in a0
	ret
	
.globl printNewLine
printNewLine:
	li a7, 4
	la a0, newLine
	ecall
	ret
	
.data
newLine: .string "\n"




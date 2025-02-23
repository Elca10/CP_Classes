# Names: James Hazelwood, Eliska Jelinek 

.text
main:
# print welcom to the zeroes progrm
li a7, 4
la a0, welcome
ecall

loop:
# print prompt
li a7, 4
la a0, prompt
ecall

# get input number
li a7, 5
ecall

# check if its negative, and if so goes to print num with t0 = 0
li t1, -2147483648 # 1000...000 in binary
li t0, 0
or t2, a0, t1
beq a0, t2, printnum

# uses t0 to count zeroes and t1 to check if the bit is 0
li t0, 0
li t1, 1073741824 # 01000..000 in binary

zerosLoop:
# adds 1 to the number
addi t0, t0, 1

# uses or operator and brach equals to check bit, t2 is temperary to check against input
or t2, a0, t1
srai t1, t1, 1 # shifting the bit right for next time
bne t2, a0, zerosLoop

printnum:
# if the branch is not equal, we hit a one and now print to the user
li a7, 4
la a0, numberIs
ecall

li a7, 1
mv a0, t0
ecall

# now asks if the user wants to continue
li a7, 4
la a0, continue
ecall 

# gets character from user
li a7, 8
la a0, input_str
li a1, 2
ecall

#loads "y" into t0 and loads the byte to allow beq to work
la t0, y
lb t0, (t0)
lb a0, (a0)

# if the character is "y" does the whole thing again
beq  a0, t0, loop

# if the character is not y, prints exiting
li a7, 4
la a0, exiting
ecall

# then exits 
li a7, 10
ecall

.data 
welcome: .string "Welcome to the Zeros program."
prompt: .string "\n\nPlease enter a number: "
numberIs: .string "The number of leading zeros is: "
continue: .string "\nWould you like to continue (y/n): "
input_str: .space 2
exiting: .string "\n\nExiting"
y: .string "y"

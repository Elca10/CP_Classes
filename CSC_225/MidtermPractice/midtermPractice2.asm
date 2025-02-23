.text
main:
li a7, 4
la a0, prompt
ecall
li a7, 8
la a0, name
li a1, 15 # Accepts up to 14 chr name (plus null)
ecall
li a7, 4
la a0, name
ecall
li a7, 10
ecall
.data
prompt: .string "Enter your name: "
name: .space 15
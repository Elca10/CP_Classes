.text 
main:
li t0, 29 # CHANGE THIS (ARBITRARY NUM)

li s0, 5
bne t0, s0, exit
correct:
li a7, 4
la a0, correct_msg
ecall
exit:
li a7, 10
ecall
.data
correct_msg: .string "correct"
.text
main:
li t0, 20
li t1, 0
loop:
li a7, 4
la a0, hello
addi t1, t1, 1
bne t0, t1, loop
exit:
li a7, 10
ecall
.data
hello: .string "hello"
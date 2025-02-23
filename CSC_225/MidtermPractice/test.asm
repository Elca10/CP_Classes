li t1, 0x1A0
li t0, 0
loop:
   addi t0, t0, 1
   slli t1, t1, 1
   bne t1, zero, loop

li a7, 1
mv a0, t0
ecall

li a7, 10
ecall
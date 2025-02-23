swap(int*, int*):
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48
        sd      a0,-40(s0)
        sd      a1,-48(s0)
        ld      a5,-40(s0)
        lw      a5,0(a5)
        sw      a5,-20(s0)
        ld      a5,-48(s0)
        lw      a4,0(a5)
        ld      a5,-40(s0)
        sw      a4,0(a5)
        ld      a5,-48(s0)
        lw      a4,-20(s0)
        sw      a4,0(a5)
        nop
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
.LC0:
        .string "Plotting point (%d, %d)\n"
plot(int, int):
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32
        mv      a5,a0
        mv      a4,a1
        sw      a5,-20(s0)
        mv      a5,a4
        sw      a5,-24(s0)
        lw      a4,-24(s0)
        lw      a5,-20(s0)
        mv      a2,a4
        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf
        nop
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
Line(int, int, int, int):
        addi    sp,sp,-64
        sd      ra,56(sp)
        sd      s0,48(sp)
        addi    s0,sp,64
        mv      a5,a0
        mv      a4,a3
        sw      a5,-52(s0)
        mv      a5,a1
        sw      a5,-56(s0)
        mv      a5,a2
        sw      a5,-60(s0)
        mv      a5,a4
        sw      a5,-64(s0)
        lw      a4,-64(s0)
        lw      a5,-56(s0)
        subw    a5,a4,a5
        sext.w  a5,a5
        sraiw   a4,a5,31
        xor     a5,a5,a4
        subw    a5,a5,a4
        sext.w  a3,a5
        lw      a4,-60(s0)
        lw      a5,-52(s0)
        subw    a5,a4,a5
        sext.w  a5,a5
        sraiw   a4,a5,31
        xor     a5,a5,a4
        subw    a5,a5,a4
        sext.w  a5,a5
        ble     a3,a5,.L4
        li      a5,1
        sw      a5,-20(s0)
        j       .L5
.L4:
        sw      zero,-20(s0)
.L5:
        lw      a5,-20(s0)
        sext.w  a4,a5
        li      a5,1
        bne     a4,a5,.L6
        addi    a4,s0,-56
        addi    a5,s0,-52
        mv      a1,a4
        mv      a0,a5
        call    swap(int*, int*)
        addi    a4,s0,-64
        addi    a5,s0,-60
        mv      a1,a4
        mv      a0,a5
        call    swap(int*, int*)
.L6:
        lw      a4,-52(s0)
        lw      a5,-60(s0)
        ble     a4,a5,.L7
        addi    a4,s0,-60
        addi    a5,s0,-52
        mv      a1,a4
        mv      a0,a5
        call    swap(int*, int*)
        addi    a4,s0,-64
        addi    a5,s0,-56
        mv      a1,a4
        mv      a0,a5
        call    swap(int*, int*)
.L7:
        lw      a4,-60(s0)
        lw      a5,-52(s0)
        subw    a5,a4,a5
        sw      a5,-40(s0)
        lw      a4,-64(s0)
        lw      a5,-56(s0)
        subw    a5,a4,a5
        sext.w  a5,a5
        sraiw   a4,a5,31
        xor     a5,a5,a4
        subw    a5,a5,a4
        sw      a5,-44(s0)
        sw      zero,-24(s0)
        lw      a5,-56(s0)
        sw      a5,-28(s0)
        lw      a4,-56(s0)
        lw      a5,-64(s0)
        bge     a4,a5,.L8
        li      a5,1
        sw      a5,-32(s0)
        j       .L9
.L8:
        li      a5,-1
        sw      a5,-32(s0)
.L9:
        lw      a5,-52(s0)
        sw      a5,-36(s0)
        j       .L10
.L14:
        lw      a5,-20(s0)
        sext.w  a4,a5
        li      a5,1
        bne     a4,a5,.L11
        lw      a4,-36(s0)
        lw      a5,-28(s0)
        mv      a1,a4
        mv      a0,a5
        call    plot(int, int)
        j       .L12
.L11:
        lw      a4,-28(s0)
        lw      a5,-36(s0)
        mv      a1,a4
        mv      a0,a5
        call    plot(int, int)
.L12:
        lw      a5,-24(s0)
        mv      a4,a5
        lw      a5,-44(s0)
        addw    a5,a4,a5
        sw      a5,-24(s0)
        lw      a5,-24(s0)
        slliw   a5,a5,1
        sext.w  a5,a5
        lw      a4,-40(s0)
        sext.w  a4,a4
        bgt     a4,a5,.L13
        lw      a5,-28(s0)
        mv      a4,a5
        lw      a5,-32(s0)
        addw    a5,a4,a5
        sw      a5,-28(s0)
        lw      a5,-24(s0)
        mv      a4,a5
        lw      a5,-40(s0)
        subw    a5,a4,a5
        sw      a5,-24(s0)
.L13:
        lw      a5,-36(s0)
        addiw   a5,a5,1
        sw      a5,-36(s0)
.L10:
        lw      a5,-60(s0)
        lw      a4,-36(s0)
        sext.w  a4,a4
        ble     a4,a5,.L14
        nop
        nop
        ld      ra,56(sp)
        ld      s0,48(sp)
        addi    sp,sp,64
        jr      ra
main:
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)
        addi    s0,sp,16
        li      a3,3
        li      a2,5
        li      a1,0
        li      a0,0
        call    Line(int, int, int, int)
        li      a5,0
        mv      a0,a5
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16
        jr      ra
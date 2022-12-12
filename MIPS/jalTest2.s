.data
.text

jal here

halt # shouldn't halt until after addi 5

here:
    addi $t0, $t0, 5

jr $ra

addi $t0, $t0, 6 # this shouldn't occur
.data
.text

addi $t0, $t0, 1
addi $t0, $t1, 1
beq $t0, $t1, here

addi $t0, $t0, $t1 # this shouldn't occur

here:
    halt
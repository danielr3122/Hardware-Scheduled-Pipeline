.data
.text

addi $t1, $t0, 1
bne $t1, $t0, exit

fail:
    addi $t2, $t0, 1

exit:
    halt
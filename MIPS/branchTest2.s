.data
.text

addi $t1, $t0, 1
addi $t2, $t0, 1
bne $t1, $t0, exit 

fail:
    addi $t0, $t0, 5

exit:
halt
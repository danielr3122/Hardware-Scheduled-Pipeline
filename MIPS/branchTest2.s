.data
.text

addi $t1, $t0, 1
addi $t2, $t0, 1
bne $t1, $t0, exit 

wrong:
    addi $t2, $t0, 10 

exit:
halt
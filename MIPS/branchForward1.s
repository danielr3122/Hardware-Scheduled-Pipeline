.data
.text

addi $1, $0, 1
bne $1, $0, exit

fail:
    addi $2, $0, 10

exit:
    halt
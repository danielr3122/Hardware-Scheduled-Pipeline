# #
# # Bubblesort algorithm
# #

.data
arr:.word  19, 91, 25, 41, 87, 55, 68, 13, 83, 49

.text
main:
	lui $s0, 0x1001		# array address
	addi $s1, $zero, 10	# n
	j bubblesort

bubblesort:
    nop
	addi $t0, $zero, 0	# i
	addi $t1, $zero, 0	# j
	addi $t2, $s1, -1
	j loop1
	
loop1:
    nop
	addi $t1, $zero, 0	# j
	j loop2

	loop1cond:
        nop
		addi $t0, $t0, 1
        nop
        nop
        nop

		bne $t0, $t2, loop1
        nop
	
add $t2, $zero, $s0
addi $t0, $zero, 0
j  exit
	
loop2:
	# arr[j]
    nop
	sll $s2, $t1, 2
    nop
    nop
    nop
	add $s2, $s2, $s0
    nop
    nop
	lw $t6, 0($s2)

	# arr[j+1]
	addi $s3, $t1, 1
    nop
    nop
    nop
	sll $s3, $s3, 2
    nop
    nop
    nop
	add $s3, $s3, $s0
    nop
    nop
	lw $t7, 0($s3)
    nop
    nop
    nop

	slt $t5, $t7, $t6
    nop
    nop
    nop
	bne $t5, $zero, swap

	loop2cond:
        nop
		addi $t1, $t1, 1	# j++
		addi $t3, $s1, -1	# x = n - 1
        nop
        nop
        nop
		sub $t3, $t3, $t0	# x = x - i
        nop
        nop
        nop
		slt $t4, $t1, $t3	# j < x
        nop
        nop
        nop
		bne $t4, $zero, loop2
        nop

	j loop1cond
	
swap:
    nop
	sw $t6, 0($s3)
	sw $t7, 0($s2)
	j loop2cond

 exit:
    nop
	halt

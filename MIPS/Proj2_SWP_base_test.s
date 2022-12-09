# data section
.data

# code/instruction section
.text

j MAIN

MAIN:
    nop
    # Arithmetic
    addi 	$s0, $zero, 1   # $s0 = 1  
    addiu	$s1, $zero, 1   # $s1 = 1
    nop 
    nop
    nop
    addu	$s2, $s0, $s1   # $s2 = 2 
    add	    $s3, $s0, $s1   # $s3 = 2 
    nop
    nop
    sub	    $s4, $s2, $s1   # $s4 = 1 
    subu	$s5, $s3, $s1   # $s5 = 1

    addi 	$s6, $zero, -1  # $s6 = -1 
    nop
    nop
    nop
    sra	    $s6, $s6, 1     # $s6 = -1 #dp: s6

    #Logical
    lui	    $s0, 0xFFFF         # $s0 = 0xFFFF_0000
    nop
    nop
    nop
    ori 	$s1, $s0, 0xFFFF    # $s1 = 0xFFFF_FFFF
    nop
    nop
    nop
    or	    $s2, $s1, $s0       # $s2 = 0xFFFF_FFFF
    and 	$s3, $s1, $s0       # $s3 = 0xFFFF_0000
    andi	$s4, $s1, 0xFFFF    # $s4 = 0x0000_FFFF
    not	    $s5, $s1            # $s5 = 0x0000_0000
    nop
    nop
    nor	    $s6, $s5, $s4       # $s6 = 0xFFFF_0000
    xor	    $s7, $s0, $s1       # $s7 = 0x0000_FFFF
    xori	$t0, $s1, 0xFFFF    # $t0 = 0xFFFF_0000
    sll	    $t1, $s1, 16        # $t1 = 0xFFFF_0000
    nop
    nop
    nop
    srl	    $t2, $t1, 16        # $t2 = 0x0000_FFFF
    repl.qb	$t3, 0x0F           # $t3 = 0x0F0F_0F0F

    # Load and Store
    lui     $s5, 0x1000
    nop
    nop
    nop
    ori     $s5, $s5, 0x9000
    nop
    nop
    nop
    sw      $s1, 0($s5) 
    lw      $t4, 0($s5) # t4 = FFFF_FFFF
    and     $s5, $s5, $zero
    nop
    nop

    # Comparison
    slt     $s1, $t4, $s5 # t4 = FFFF_FFFF, s5 = 0
    slti    $s2, $s5, 1
    nop
    nop

    # Branch
    bne     $s1, $s2, B1    # if(s1 != s2) branch to B1 (SHOULD FAIL)
    bne     $s1, $s5, B1    # if(s1 != 0) branch to B1    

OTHERBRANCH:
    beq		$s5, $s1, B2  # if(s5 == s1) branch to B2 (SHOULD FAIL)
    beq		$s5, $zero, B2  # if(s5 == 0) branch to B2

B1:
    j OTHERBRANCH

B2:
    jal METHOD

    halt

METHOD:
    nop
    nop
    jr  $ra

.data
    .equ OFFSET_A, 0
    .equ OFFSET_B, 1024
    .equ OFFSET_C, 2048
    .equ OFFSET_D, 3072

# Allocate enough memory (approx 4KB)
base_addr:
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0
    .word 0,0,0,0,0,0,0,0,0,0

.text
.globl main
main:
    # Load base address
    la  s0, base_addr

    # Initialize values
    li t5, 100
    sw t5, OFFSET_A(s0)

    li t5, 200
    sw t5, OFFSET_B(s0)

    # For OFFSET_C (2048) ? use register
    li t6, OFFSET_C
    add t6, s0, t6
    li t5, 300
    sw t5, 0(t6)

    # For OFFSET_D (3072) ? use register
    li t6, OFFSET_D
    add t6, s0, t6
    li t5, 400
    sw t5, 0(t6)

    # Loop counter
    li t0, 10

conflict_loop:
    # Small offsets (valid)
    lw t1, OFFSET_A(s0)
    lw t2, OFFSET_B(s0)

    # Large offsets (fixed)
    li t6, OFFSET_C
    add t6, s0, t6
    lw t3, 0(t6)

    li t6, OFFSET_D
    add t6, s0, t6
    lw t4, 0(t6)

    addi t0, t0, -1
    bnez t0, conflict_loop
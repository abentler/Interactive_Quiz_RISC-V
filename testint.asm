# Anna Bentler
# CSC 225
# 5/12/21

# This program initializes a new ISR that interrupts constantly printing asterisks when a key is pressed
# and begins printing the input letter. After five inputs, the program restarts to main.
	
	.globl main
	main:
	jal IntInit
	sw t0, 0(zero)
	
	li a0, 42		# load 42 (*) to a0 then print
loop:
	jal PrintChar
	b loop
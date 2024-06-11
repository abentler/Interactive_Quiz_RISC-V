	.globl IntInit
	.text
IntInit:
	addi sp, sp, -16
	sw ra, 12(sp)
	
	csrrw zero, 64, zero
	la t0, handler
	csrrw zero, 5, t0
	li t0, 0x100
	csrrw zero, 4, t0	# allow external interrupts
	csrrsi zero, 0, 1	# allow global interrupts?
	
	li t0, 2
	lw t1, RCR
	lw t2, (t1)
	or t2, t2, t0		# set bit 1 of TCR to 1 to expect interrupts
	sw t2, (t1)
	
	la a0, init
	jal PrintString
	
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
handler:
	csrrw 	sp, 64, sp   # swap run-time sp and system sp
	addi  	sp, sp, -16   # create space on system stack
	sw    	t0, 12(sp)   # preserve t0
	sw	t1, 8(sp)
	sw	ra, 4(sp)
	
	csrr	t0, 66
	lui	t1, 0x80000
	and	t0, t0, t1
	
	bne	t0, zero, int	# if bit 31 is 1, aka it's an interrupt, continue with interrupt ISR
	la	a0, except
	jal PrintString
	csrrw t0, 65, zero	# read n clear epc
	addi t0, t0, 4		# increment to next instruction past exception
	csrrw zero, 65, t0
	lw	ra, 4(sp)
	b next
	
	int:
	la 	a0, key
	jal PrintString
	
	checkReady:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, checkReady
	
	lw 	t1, RDR
	lw 	a0, (t1)	# load char from RDR to a0
	
	jal PrintChar
	sw	a0, 0(sp)
	li	a0, 0xa
	jal PrintChar	
	
	la	t0, numint	# load address to track number of interrupts
	lb	t1, (t0)
	addi	t1, t1, 1
	
	li	a0, 5
	blt 	t1, a0, else	# set ra to main if 5, else continue
	la	t1, main
	csrrw 	t1, 65, t1	# set uret to go to main
	sb	zero, (t0)	# reset counter
	lw	a0, 0(sp)
	b next
	
	else:
	sb	t1, (t0)	# if less than five, store incremented value
	lw	a0, 0(sp)
	lw	ra, 4(sp)
	next:
	lw	t1, 8(sp)
	lw	t0, 12(sp)   # restore t0
	addi	sp, sp, 16   # pop space
	csrrw	sp, 64, sp   # swap run-time sp and system sp
	uret
	
	.data
init:	.string "\nInitializing Interrupts\n"
key:	.string "\nkey pressed is : "
except:	.string "\nundetermined exception\n"
numint:	.space 1
RCR:	.word 0xffff0000
RDR:	.word 0xffff0004
TCR:	.word 0xffff0008
TDR:	.word 0xffff000c

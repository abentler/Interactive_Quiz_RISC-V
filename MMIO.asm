# Anna Bentler

# All subroutines use a0 for parameter, return value, and ecalls. a7 also used for ecall.
# In ReadString, t1 stores name address in memory and t2 represents \n.

.text
.globl ReadString PrintString PrintChar ReadChar ReadInt PrintInt

j end

ReadString:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, ReadString
	ret
	
PrintString:
	addi sp, sp, -16
	sw ra, 12(sp)
	loop:
	sw a0, 8(sp)
	lb a0, 0(a0)
	beq a0, zero, return
	jal PrintChar
	lw a0, 8(sp)
	addi a0, a0, 1
	b loop
	return:
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
PrintChar:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, PrintChar
	lw t1, TDR			# getting funky
	sw a0, (t1)
	ret
	
ReadChar:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, ReadChar
	lw t1, RDR
	lw a0, (t1)
	ret
	
ReadInt:
	li a7, 5
	ecall
	ret
	
PrintInt:
	li a7, 1
	ecall
	ret
	
end:

	.data

RCR:	.word 0xffff0000
RDR:	.word 0xffff0004
TCR:	.word 0xffff0008
TDR:	.word 0xffff000c

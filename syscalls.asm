# Anna Bentler

# All subroutines use a0 for parameter, return value, and ecalls. a7 also used for ecall.
# In ReadString, t1 stores name address in memory and t2 represents \n.

.text
.globl ReadString PrintString PrintChar ReadChar ReadInt PrintInt

j end

ReadString:
	mv t1, a0			# now t1 will have address to store name
	li t2, 10			# \n char
	while:
	li a7, 12
	ecall
	beq a0, t2, return		# stop reading chars if enter pressed
	sb a0, 0(t1)
	addi t1, t1, 1
	b while
	return:
	ret
	
PrintString:
	li a7, 4
	ecall
	ret
	
PrintChar:
	li a7, 11
	ecall
	ret
	
ReadChar:
	li a7, 12
	ecall
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
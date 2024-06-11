# Anna Bentler
# CSC 225
# 4/28/21
# This program asks three questions and uses points from different results to decide which character
# from Ratatouille is most like you.

# a0 - passes values to and from subroutines
# s0 - saves the total points as the user answers questions
# t1 - stores name address in getname, caller saved. also represents point values in getresult
# t2 and t3 - represent integers to turn input int into point value in getval

.text
.globl main
main:
	and s0, s0, zero		# store to s0 from the original program. wasn't part of assignment to change, hope it's ok
	la a0, name
	jal getname
	
	jal askQ1
	li a1, 1
	jal getval
	add s0, s0, a0			# a0 is the return point value to add to s0 which is total points
	
	jal askQ2			
	li a1, 2
	jal getval
	add s0, s0, a0
	
	jal askQ3
	li a1, 3
	jal getval
	add s0, s0, a0
	
	add a0, s0, zero		# s0 has been storing total points, so add back into a0 for final jal
	jal getresult
	b done
	
# get name from user
getname:
	addi sp, sp, -16		# set aside space on the stack
	add t1, a0, zero		# set t1 to a0 parameter with name address
	la a0, askname
	sw ra, 12(sp)
	sw t1, 8(sp)
	jal PrintString
	lw t1, 8(sp)
	
	
	mv a0, t1
	jal ReadString
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
# ask Q1
askQ1:
	addi sp, sp, -16
	sw ra, 12(sp)
	la a0, Q1
	jal PrintString
	jal ReadInt
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# ask Q2
askQ2:
	addi sp, sp, -16
	sw ra, 12(sp)
	la a0, Q2
	jal PrintString				# print q2
	jal ReadInt
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# ask Q3	
askQ3:
	addi sp, sp, -16
	sw ra, 12(sp)
	la a0, Q3
	jal PrintString
	jal ReadInt
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	

# get the point value for specified question answer
getval:
	addi a0, a0, -1			# next few steps modify a0 to the correct offset val
	addi t4, zero, 4
	mul a0, a0, t4			# a0 is now offset
	li t2, 2
	li t3, 3
	blt a1, t3, q2ans		# a1 conveys which question values we load from
	la t1, Q3Ans
	b next
q2ans:
	blt a1, t2, q1ans		# branch if < 2, aka branch if need val for Q1
	la t1, Q2Ans
	b next
q1ans:
	la t1, Q1Ans
next:
	add t1, t1, a0
	lw a0, (t1)		
	ret


# get the result
getresult:
	addi sp, sp, 16
	sw ra, 12(sp)
	sw a0, 8(sp)
	la a0, name
	jal PrintString
	lw t0, 8(sp)
	
	li t1, 25
	blt t0, t1, res3	# branch if not result 4
	la t0, Result4
	b print
res3:
	li t1, 17
	blt t0, t1, res2	# branch if not result 3
	la t0, Result3
	b print
res2:
	li t1, 9
	blt t0, t1, res1	# branch if not result 2
	la t0, Result2
	b print
res1:
	la t0, Result1
print:
	add a0, t0, zero
	jal PrintString
	lw ra, 12(sp)
	addi sp, sp, 16
	ret	
	
done:
	
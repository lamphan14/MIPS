.data 

	Row0: .word 0,   45,   45,   45,   45,   45,   45,   45,   45
	Row1: .word 1,   45,   45,   45,   45,   45,   45,   45,   45
	Row2: .word 2,   45,   45,   45,   45,   45,   45,   45,   45
	Row3: .word 3,   45,   45,   45,   111,   120,   45,   45,   45
	Row4: .word 4,   45,   45,   45,   120,   111,   45,   45,   45
	Row5: .word 5,   45,   45,   45,   45,   45,   45,   45,   45
	Row6: .word 6,   45,   45,   45,   45,   45,   45,   45,   45
	Row7: .word 7,   45,   45,   45,   45,   45,   45,   45,   45
	
	Direction_Change_Made: .word 0, 0, 0, 0, 0, 0, 0, 0, 0 #
	
	Pieces_Flipped: .word 0
	
	Move_Made: .word 0 # This will either be 0 or 1, has the players piece been put down?
	
	Copy_Row0: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row3: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row4: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row5: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row6: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	Copy_Row7: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	Integer_Array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8
	
	Prompt4: .asciiz "\nEnter Player \n"
	Prompt5: .asciiz "\nEnter Row \n"
	Prompt6: .asciiz "\nEnter Column \n"
		
	Not_Valid: .asciiz "\nThis move is not valid!\n"
	Not_Valid1: .asciiz "\nThis move is not valid Player 1!\n"
	Not_Valid2: .asciiz "\nThis move is not valid Player 2!\n"
			
	Line_Space: .asciiz "\n"
	Integer_Space: .asciiz " "
	Prompt2: .asciiz "\n Direction Change Array \n"
	Prompt3: .asciiz "\n Pieces Flipped"
	
	Player_Value: .word 0
	
	
	
.text

addi	$sp, $sp, -32

j	Continue_Output

Main:
# Player Input



la	$a0, Prompt4
li	$v0, 4
syscall

li	$v0, 5
syscall

sw	$v0, 8($sp)	# player number

la	$a0, Prompt6
li	$v0, 4
syscall

li	$v0, 5
syscall

move	$a0, $v0	# COLUMN value !!!!!
sw	$a0, 0($sp) # x value

la	$a0, Prompt5
li	$v0, 4
syscall

li	$v0, 5
syscall

move	$a1, $v0	# ROW value !!!!!!!
addi	$a1, $a1, -1
sw	$a1, 4($sp)  # y value




# At this point pass the player input to flip all of the pieces
# DO NOT TOUCH BEYOND THIS POINT

# These must be saved on stack
# Push


lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value
# sw	Store the player number



jal	Check





# Chunk

Check:

li	$t0, 1
sw	$t0, Move_Made		#This is needed to make sure things run smoothly

# push stack pointer onto stack

sw	$ra, 12($sp) # This is our return to Main

jal	Copy
jal	North

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	North_East

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	East

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	South_East

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	South

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	South_West

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	West

# Restore a0 and a1
lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	North_West

lw	$a0, 0($sp) # x value
lw	$a1, 4($sp) # y value

# Restore pieces flipped to 0
la	$t0, Pieces_Flipped
sw	$zero, ($t0)

jal	Copy
jal	Player_Move_Change

j	Output_Board



Player_Move_Change:
sw	$zero, Move_Made
sw	$ra, 20($sp)
jal	Direction
lw	$ra, 20($sp)
jr	$ra

North:
li	$t8, 4
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_North:

addi	$a1, $a1, -1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_North
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra


North_East:
li	$t8, 8
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_North_East:

addi	$a1, $a1, -1
addi	$a0, $a0, 1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_North_East
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra

East:
li	$t8, 12
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_East:

addi	$a0, $a0, 1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_East
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra

South_East:
li	$t8, 16
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_South_East:

addi	$a1, $a1, 1
addi	$a0, $a0, 1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_South_East
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra

South:
li	$t8, 20
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_South:

addi	$a1, $a1, 1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_South
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra

South_West:
li	$t8, 24
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_South_West:

addi	$a1, $a1, 1
addi	$a0, $a0, -1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_South_West
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra


West:
li	$t8, 28
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_West:

addi	$a0, $a0, -1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_West
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra


North_West:
li	$t8, 32
sw	$t8, Direction_Change_Made

li	$t0, 0
sw	$t0, 24($sp)
li	$t1, 8
sw	$t1, 28($sp)
sw	$ra, 20($sp) # ra for jal North

Sub_North_West:

addi	$a1, $a1, -1
addi	$a0, $a0, -1
jal	Direction
# get count values from stack increment one of them
lw	$t0, 24($sp)
addi	$t0, $t0, 1
sw	$t0, 24($sp)
lw	$t1, 28($sp)
bne	$t0, $t1, Sub_North_West
# get the ra for jal North
lw	$ra, 20($sp)
jr	$ra


Copy: # This subroutine copies values from the major arrays to the copy arrays

# save return address on stack

sw	$ra, 16($sp) # This returns to chunk
# begin loop

Row_To_Row_0:
li	$s0, 0
li	$s2, 9
Continue_Copy_0:
la	$t1, Row0
la	$t2, Copy_Row0
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_1
j	Continue_Copy_0

Row_To_Row_1:
li	$s0, 0
li	$s2, 9
Continue_Copy_1:
la	$t1, Row1
la	$t2, Copy_Row1
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_2
j	Continue_Copy_1

Row_To_Row_2:
li	$s0, 0
li	$s2, 9
Continue_Copy_2:
la	$t1, Row2
la	$t2, Copy_Row2
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_3
j	Continue_Copy_2

Row_To_Row_3:
li	$s0, 0
li	$s2, 9
Continue_Copy_3:
la	$t1, Row3
la	$t2, Copy_Row3
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_4
j	Continue_Copy_3

Row_To_Row_4:
li	$s0, 0
li	$s2, 9
Continue_Copy_4:
la	$t1, Row4
la	$t2, Copy_Row4
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_5
j	Continue_Copy_4

Row_To_Row_5:
li	$s0, 0
li	$s2, 9
Continue_Copy_5:
la	$t1, Row5
la	$t2, Copy_Row5
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_6
j	Continue_Copy_5

Row_To_Row_6:
li	$s0, 0
li	$s2, 9
Continue_Copy_6:
la	$t1, Row6
la	$t2, Copy_Row6
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Row_To_Row_7
j	Continue_Copy_6

Row_To_Row_7:
li	$s0, 0
li	$s2, 9
Continue_Copy_7:
la	$t1, Row7
la	$t2, Copy_Row7
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t1)
sw	$t3, ($t2)
addi	$s0, $s0, 1
beq	$s0, $s2, Finish
j	Continue_Copy_7

# get ra restore stack and return to chunk
Finish:
lw	$ra, 16($sp)

# Increment stack pointer so that it is where it was befor copy was called




jr	$ra


# CHUNK This chunk contains the NORTH subroutine
Direction: 		# It is important to note that the original name of this subroutine was North, everything inside it has been left unchanged because the naming system isn't very important


# save ra of the compass values that called Direction



# Bounds Checking
li	$t9, -1
beq	$a1, $t9, Move_Not_Valid_North
beq	$a0, $t9, Move_Not_Valid_North
li	$t9, 8
beq	$a1, $t9, Move_Not_Valid_North
addi	$t9, $t9, 1
beq	$a0, $t9, Move_Not_Valid_North

# Searching for row value of input
la	$t5, Copy_Row0
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row0

la	$t5, Copy_Row1
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row1

la	$t5, Copy_Row2
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row2

la	$t5, Copy_Row3
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row3

la	$t5, Copy_Row4
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row4

la	$t5, Copy_Row5
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row5

la	$t5, Copy_Row6
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row6

la	$t5, Copy_Row7
lw	$t3, 0($t5)
beq	$a1, $t3, North_Row7

# CHUNK Row has been found, now find value of column and see if it is a valid value

North_Row0:
mul 	$t0, $a0, 4
la	$a3, Copy_Row0
add	$a2, $t0, $a3

# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row0_Player1
beq	$t1, $t3, Row0_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row0_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row0_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row1:
mul 	$t0, $a0, 4
la	$a3, Copy_Row1
add	$a2, $t0, $a3
	
# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row1_Player1
beq	$t1, $t3, Row1_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row1_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row1_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North


North_Row2:
mul 	$t0, $a0, 4
la	$a3, Copy_Row2
add	$a2, $t0, $a3


# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row2_Player1
beq	$t1, $t3, Row2_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row2_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row2_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row3:
mul 	$t0, $a0, 4
la	$a3, Copy_Row3
add	$a2, $t0, $a3

# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row3_Player1
beq	$t1, $t3, Row3_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row3_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row3_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row4:
mul 	$t0, $a0, 4
la	$a3, Copy_Row4
add	$a2, $t0, $a3

# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row4_Player1
beq	$t1, $t3, Row4_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row4_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row4_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row5:
mul 	$t0, $a0, 4
la	$a3, Copy_Row5
add	$a2, $t0, $a3

# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row5_Player1
beq	$t1, $t3, Row5_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row5_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row5_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row6:
mul 	$t0, $a0, 4
la	$a3, Copy_Row6
add	$a2, $t0, $a3

# save $ra on stack
lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row6_Player1
beq	$t1, $t3, Row6_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row6_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row6_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

North_Row7:
mul 	$t0, $a0, 4
la	$a3, Copy_Row7
add	$a2, $t0, $a3

# save $ra on stack

lw	$t0, ($a2) # get value to check
lw	$t1, 8($sp) # Player #
li	$t2, 1
li	$t3, 2
li	$t4, 45
beq	$t1, $t2, Row7_Player1
beq	$t1, $t3, Row7_Player2
beq	$t0, $t4, Move_Not_Valid_North
Row7_Player1:
beq	$t0, 111, North_Flankee # there is an opponents piece here
beq	$t0, 120, North_Flanker
beq	$t0, $t4, Move_Not_Valid_North
Row7_Player2:
beq	$t0, 111, North_Flanker 
beq	$t0, 120, North_Flankee # there is an opponents piece here
beq	$t0, $t4, Move_Not_Valid_North

# CHUNK Opponents piece has been found, searching for flanked piece, turning over opponents pieces


North_Flankee:

lw	$t2, 8($sp)
li	$t3, 1
li	$t4, 2
beq	$t2, $t3, Flankee_Player1
beq	$t2, $t4, Flankee_Player2

Flankee_Player1:
li	$t1, 120
sw	$t1, ($a2) # flip piece at y-1
j	Flankee_Finish

Flankee_Player2:
li	$t1, 111
sw	$t1, ($a2) # flip piece at y-1

Flankee_Finish:
li	$t8, 1
la	$t9, Pieces_Flipped
sw	$t8, ($t9)





# return to Compass values

# increment the stack pointer

jr	$ra # This must return to the compass subroutine that called


North_Flanker: # check if any pieces are flipped if yes, player has made a valid move in North, if No, player has not made a valid move in the North

la	$t0, Pieces_Flipped
lw	$t1, ($t0)

# Printing out value of pieces flipped
# move	$t9, $a0
# move	$a0, $t1
# li	$v0, 1
# syscall

# la	$a0, Prompt3
# li	$v0, 4
# syscall

# move	$a0, $t9
# Done printing

bgt	$t1, $zero, Successful_Move
beq	$t1, $zero, Move_Not_Valid_North



Move_Not_Valid_North:

# Check if this is the players move, if it is change the values in copyarray to match the move and jump to Back_To_Row_0
lw	$t0, Move_Made
bne	$zero, $t0, Continue_Move_Not_Valid
lw	$t0, 8($sp)
li	$t1, 1
li	$t2, 2
beq	$t1, $t0, P1_First_Move
beq	$t0, $t2, P2_First_Move

P1_First_Move:
# Since the players piece will be put in the array after all the checks have been made to make sure its a valid move, you have to see if any successfull moves have been 
# made before you can put it in the array

# Check if a valid move was made
li	$t0, 0 # NOTICE ME!!!!!
la	$t1, Direction_Change_Made
li	$t4, 0 # count variable
li	$t5, 8 # count variable
Loop_P1:
addi	$t4, $t4, 1 # increment count
addi	$t1, $t1, 4 # I THINK IM INCREASING MORE THAN YOU WERE PLANNING!!!! I'M the problem :o
lw	$t2, ($t1)
li	$t3, 1
beq	$t2, $t3, Continue_P1_First_Move
bne	$t4, $t5, Loop_P1
# The move is not valid
li	$v0, 4
la	$a0, Not_Valid1
syscall

j	Exit

Continue_P1_First_Move:
# If this is a valid move for player 1, place the piece in the array
li	$t0, 120
sw	$t0, ($a2)

li	$t0, 1
sw	$t0, Move_Made

j	Back_To_Row_0

P2_First_Move:

# Check if a valid move was made
li	$t0, 0
la	$t1, Direction_Change_Made
li	$t4, 0 # count variable
li	$t5, 8 # count variable
Loop_P2:
addi	$t4, $t4, 1 # increment count
addi	$t1, $t1, 4
lw	$t2, ($t1)
li	$t3, 1
beq	$t2, $t3, Continue_P2_First_Move
bne	$t4, $t5, Loop_P2
# The move is not valid
li	$v0, 4
la	$a0, Not_Valid2
syscall

j	Exit

Continue_P2_First_Move:
# If player 2's move was valid place it in the array

li	$t0, 111
sw	$t0, ($a2)

li	$t0, 1
sw	$t0, Move_Made

j	Back_To_Row_0

Continue_Move_Not_Valid:

# Change Direction array value to 0
la	$t1, Direction_Change_Made
lw	$t0, ($t1)
add	$t1, $t1, $t0
sw	$zero, ($t1)



# return to Check call by getting ra from value 20 on the stack

lw	$ra, 20($sp)

jr	$ra # return to jal (North, East, ....)





Successful_Move: # Once all flips in the north have been made restore the sp and copy array onto original

# Change Direction_Made matrix value from 2 to 1
la	$t1, Direction_Change_Made
lw	$t0, ($t1)
add	$t1, $t1, $t0
li	$t2, 1
sw	$t2, ($t1)


# copy array back to original array

# begin loop

Back_To_Row_0:
li	$s0, 0
li	$s2, 9
Continue_0:
la	$t1, Row0
la	$t2, Copy_Row0
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_1
j	Continue_0

Back_To_Row_1:
li	$s0, 0
li	$s2, 9
Continue_1:
la	$t1, Row1
la	$t2, Copy_Row1
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_2
j	Continue_1

Back_To_Row_2:
li	$s0, 0
li	$s2, 9
Continue_2:
la	$t1, Row2
la	$t2, Copy_Row2
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_3
j	Continue_2

Back_To_Row_3:
li	$s0, 0
li	$s2, 9
Continue_3:
la	$t1, Row3
la	$t2, Copy_Row3
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_4
j	Continue_3

Back_To_Row_4:
li	$s0, 0
li	$s2, 9
Continue_4:
la	$t1, Row4
la	$t2, Copy_Row4
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_5
j	Continue_4

Back_To_Row_5:
li	$s0, 0
li	$s2, 9
Continue_5:
la	$t1, Row5
la	$t2, Copy_Row5
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_6
j	Continue_5

Back_To_Row_6:
li	$s0, 0
li	$s2, 9
Continue_6:
la	$t1, Row6
la	$t2, Copy_Row6
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Back_To_Row_7
j	Continue_6

Back_To_Row_7:
li	$s0, 0
li	$s2, 9
Continue_7:
la	$t1, Row7
la	$t2, Copy_Row7
mul	$s1, $s0, 4
add	$t1, $t1, $s1
add	$t2, $t2, $s1
lw	$t3, ($t2)
sw	$t3, ($t1)
addi	$s0, $s0, 1
beq	$s0, $s2, Final
j	Continue_7

Final:

lw	$ra, 20($sp) # ra for jal North

jr	$ra # The Compass subroutine (i.e jal North) That called Direction



Output_Board:

# Check if a valid move was made
li	$t0, 0
la	$t1, Direction_Change_Made
li	$t4, 0 # count variable
li	$t5, 8 # count variable
Loop:
addi	$t4, $t4, 1 # increment count
addi	$t1, $t1, 4
lw	$t2, ($t1)
li	$t3, 1
beq	$t2, $t3, Continue_Output
bne	$t4, $t5, Loop
# The move is not valid
li	$v0, 4
la	$a0, Not_Valid
syscall

j	Exit



Continue_Output:

li	$v0, 1
li	$a0, 0
syscall

li	$v0, 4
la	$a0, Integer_Space
syscall

# Ouput Integer_Array
la	$t0, Integer_Array
li	$t2, 32		# count
li	$t1, 0		# count
Output_Integer_Array:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 1
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Integer_Array # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall


# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 4
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

# Ouput Row 0
la	$t0, Row0
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_0:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_0 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall



# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 8
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 1
la	$t0, Row1
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_1:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_1 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall



# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 12
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 2
la	$t0, Row2
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_2:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_2 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall



# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 16
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 3
la	$t0, Row3
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_3:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_3 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall



# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 20
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall
#########################################################
# Ouput Row 4
la	$t0, Row4
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_4:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_4 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall


# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 24
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 5
la	$t0, Row5
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_5:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_5 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall


# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 28
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 6
la	$t0, Row6
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_6:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_6 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall


# Output value for row space 1
li	$v0, 1
la	$t0, Integer_Array
addi	$t0, $t0, 32
lw	$a0, ($t0)
syscall
# Output a space
li	$v0, 4
la	$a0, Integer_Space
syscall

#########################################################
# Ouput Row 7
la	$t0, Row7
li	$t2, 32		# count
li	$t1, 0		# count
Output_Array_7:

addi	$t0, $t0, 4	# increment address
addi	$t1, $t1, 4	# increment count
li	$v0, 11
lw	$a0, ($t0)
syscall
# output a space between each value
li	$v0, 4
la	$a0, Integer_Space
syscall

bne	$t1, $t2, Output_Array_7 # continue array until t2 == t1

# output a space between lines
li	$v0, 4
la	$a0, Line_Space
syscall



Exit:
#Output Direction Change made array

la	$a0, Prompt2
li	$v0, 4
syscall


la	$a0, Direction_Change_Made
addi	$a0, $a0, 4
lw	$a0, ($a0)
li	$v0, 1
syscall

la	$a0, Direction_Change_Made
addi	$a0, $a0, 8
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 12
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 16
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 20
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 24
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 28
lw	$a0, ($a0)
li	$v0, 1
syscall

  la	$a0, Direction_Change_Made
addi	$a0, $a0, 32
lw	$a0, ($a0)
li	$v0, 1
syscall  

li	$v0, 4
la	$a0, Line_Space
syscall
    

j	Main   
         
li	$v0, 10
syscall
	     





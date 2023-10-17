
.data 
	board: .asciiz "  1   2   3   4\n1   |   |   |   \n ---+---+---+---\n2   |   |   |   \n ---+---+---+---\n3   |   |   |   \n ---+---+---+---\n4   |   |   |   \n"
	askMove: .asciiz "\nPlease insert your play (2 numbers without space: row and column): "
	invalidMove: .asciiz "\n*****Invalid Move!*****\n"
	x: .asciiz "x"
	o: .asciiz "o"
	c1: .asciiz "1"
	c2: .asciiz "2"
	c3: .asciiz "3"
	c4: .asciiz "4"
	win: .asciiz "\n Win! \n"
	lose: .asciiz "\n Lose! \n"
	tie: .asciiz  "\nTie!\n"
	lost: .asciiz "\n Player Lost! \n"
	Menu: .asciiz "\n 1.New Game \n 2.Quit \n Enter The Number : "
	clean: .byte ' '
	nextLine: .asciiz "\n"
	xo : .asciiz "x or o?\n"
	array: .space 16
	computerPlaying: .asciiz "\nComputer Should Play!"
	resultString: .asciiz "\n win: 0  lose: 0  tie: 0   \n\n"
	computerString: .asciiz "\n Computer Chooses Square :     \n"
	
.text
.globl main
main:
	# x = 1 and o = 2
	li $v0, 4
	la $a0, xo
	syscall 
	
	li $v0, 12 
	syscall#input
	
	la $s1, board #$s1 = adress of board
	la $s4, array #address of the array , array[i] = 1 ----> X , array[i] = 2 -----> O
	la $s3, resultString #address of the resultString
	
	
	li $s2, -1 #s2 = number of moves
	
	move $s7,$v0 # s7 = what did player chose ( x or o )
printboard:
	li $v0,4
	la $a0,nextLine
	syscall# prints \n
	
	# x = 120 and o = 111
	li $v0, 4
	la $a0, board
	syscall#prints the board
	
	beq $s2,15,tie2 #
	
	addi $s2, $s2, 1
	
	li $t0, 2
	div $s2,$t0
	mfhi $t0 #$t0 = (number of moves) mod 2 . if $t0 = 0 ---> X's turn . if $t0 = 1 ----> O's turn
	
	bne $t0,$0,oturn
xturn:
	li $t0,120 #ascii number of x
	beq $s7,$t0,playerx
	j computerx	
oturn:
	li $t0, 111
	
	beq $s7,$t0,playero
	j computero
playerx:
	li $v0, 4
	la $a0, askMove
	syscall
	
	li $v0, 5
	syscall
	move $s6, $v0
	
	beq $s6, 11, P11
	beq $s6, 12, P12
	beq $s6, 13, P13
	beq $s6, 14, P14
	beq $s6, 21, P21
	beq $s6, 22, P22
	beq $s6, 23, P23
	beq $s6, 24, P24
	beq $s6, 31, P31
	beq $s6, 32, P32
	beq $s6, 33, P33
	beq $s6, 34, P34
	beq $s6, 41, P41
	beq $s6, 42, P42
	beq $s6, 43, P43
	beq $s6, 44, P44
	
	j invalid
playero:
	li $v0, 4
	la $a0, askMove
	syscall
	
	li $v0, 5
	syscall
	move $s6, $v0
	
	beq $s6, 11, P11
	beq $s6, 12, P12
	beq $s6, 13, P13
	beq $s6, 14, P14
	beq $s6, 21, P21
	beq $s6, 22, P22
	beq $s6, 23, P23
	beq $s6, 24, P24
	beq $s6, 31, P31
	beq $s6, 32, P32
	beq $s6, 33, P33
	beq $s6, 34, P34
	beq $s6, 41, P41
	beq $s6, 42, P42
	beq $s6, 43, P43
	beq $s6, 44, P44
	
	j invalid
computerx:
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,3($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,0($s4)
	lb $t1,3($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,3($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,4($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,7($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,8($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,11($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,12($s4)
	lb $t1,15($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,15($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,0($s4)
	lb $t1,12($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,12($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,1($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,2($s4)
	lb $t1,14($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,14($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,3($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,7($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,0($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,3($s4)
	lb $t1,12($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,12($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,4($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,1($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,1($s4)
	lb $t1,6($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,6($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,2($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,7($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,4($s4)
	lb $t1,9($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,10($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,6($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,11($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,8($s4)
	lb $t1,13($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,13($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,9($s4)
	lb $t1,14($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,10($s4)
	lb $t1,11($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,11($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,11($s4)
	lb $t1,14($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33



	#----------------------------------
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,3($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,0($s4)
	lb $t1,3($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,3($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,4($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,7($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,8($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,11($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,12($s4)
	lb $t1,15($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,15($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,0($s4)
	lb $t1,12($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,12($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,1($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,2($s4)
	lb $t1,14($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,14($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,3($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,7($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,0($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,3($s4)
	lb $t1,12($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,12($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,4($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,1($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,1($s4)
	lb $t1,6($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,6($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,2($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,7($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,4($s4)
	lb $t1,9($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,10($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,6($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,11($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,8($s4)
	lb $t1,13($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,13($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,9($s4)
	lb $t1,14($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,10($s4)
	lb $t1,11($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,11($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,11($s4)
	lb $t1,14($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	li $t0,0 #index
	loop:
		lb $t1,array($t0)
		beq $t1,$zero,done
		addi $t0,$t0,1
		j loop
	
	done:
		
		beq $t0,0,C11
		beq $t0,1,C12
		beq $t0,2,C13
		beq $t0,3,C14
		beq $t0,4,C21
		beq $t0,5,C22
		beq $t0,6,C23
		beq $t0,7,C24
		beq $t0,8,C31
		beq $t0,9,C32
		beq $t0,10,C33
		beq $t0,11,C34
		beq $t0,12,C41
		beq $t0,13,C42
		beq $t0,14,C43
		beq $t0,15,C44
	

computero:
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,3($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,0($s4)
	lb $t1,3($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,3($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,4($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,7($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,8($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,11($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,12($s4)
	lb $t1,15($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,15($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,0($s4)
	lb $t1,12($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,12($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,1($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,2($s4)
	lb $t1,14($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,14($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,3($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,7($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,0($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,3($s4)
	lb $t1,12($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,12($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,4($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,1($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,1($s4)
	lb $t1,6($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,6($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,2($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,7($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,4($s4)
	lb $t1,9($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,10($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,6($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,11($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,8($s4)
	lb $t1,13($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,13($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,9($s4)
	lb $t1,14($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,10($s4)
	lb $t1,11($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,11($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,11($s4)
	lb $t1,14($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,2
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	
	
	#---------------------------------------------

	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,3($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,0($s4)
	lb $t1,3($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,3($s4)
	lb $t1,1($s4)
	lb $t2,2($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,4($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,7($s4)
	lb $t1,5($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,8($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,11($s4)
	lb $t1,9($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,12($s4)
	lb $t1,13($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,12($s4)
	lb $t1,15($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,15($s4)
	lb $t1,13($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,0($s4)
	lb $t1,12($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,12($s4)
	lb $t1,4($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,1($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,1($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,2($s4)
	lb $t1,6($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,2($s4)
	lb $t1,14($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,14($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,3($s4)
	lb $t1,7($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,3($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,7($s4)
	lb $t1,11($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,0($s4)
	lb $t1,5($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,0($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,3($s4)
	lb $t1,6($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,3($s4)
	lb $t1,12($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,12($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,4($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,0($s4)
	lb $t1,1($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,0($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,1($s4)
	lb $t1,4($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,0($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C11
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,1($s4)
	lb $t1,2($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,1($s4)
	lb $t1,6($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,6($s4)
	lb $t1,2($s4)
	lb $t2,5($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,1($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C12
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,2($s4)
	lb $t1,3($s4)
	lb $t2,7($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,2($s4)
	lb $t1,7($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,3($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C14
	
	lb $t0,7($s4)
	lb $t1,3($s4)
	lb $t2,6($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,2($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C13
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,4($s4)
	lb $t1,5($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,4($s4)
	lb $t1,9($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,9($s4)
	lb $t1,5($s4)
	lb $t2,8($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,4($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C21
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,5($s4)
	lb $t1,6($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,5($s4)
	lb $t1,10($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,10($s4)
	lb $t1,6($s4)
	lb $t2,9($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,5($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C22
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,6($s4)
	lb $t1,7($s4)
	lb $t2,11($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,6($s4)
	lb $t1,11($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,7($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C24
	
	lb $t0,11($s4)
	lb $t1,7($s4)
	lb $t2,10($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,6($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C23
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,8($s4)
	lb $t1,9($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,12($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C41
	
	lb $t0,8($s4)
	lb $t1,13($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,13($s4)
	lb $t1,9($s4)
	lb $t2,12($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,8($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C31
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,9($s4)
	lb $t1,10($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,13($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C42
	
	lb $t0,9($s4)
	lb $t1,14($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,13($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,9($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C32
	
	lb $t0,10($s4)
	lb $t1,11($s4)
	lb $t2,14($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,15($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C44
	
	lb $t0,11($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,14($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C43
	
	lb $t0,14($s4)
	lb $t1,10($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,11($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C34
	
	lb $t0,11($s4)
	lb $t1,14($s4)
	lb $t2,15($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	li $t5,1
	lb $t0,10($s4)
	mul $t0,$t0,20
	add $t4,$t4,$t0
	beq $t4,$t5,C33
	
	li $t0,0 #index
	loop2:
		lb $t1,array($t0)
		beq $t1,$zero,done2
		addi $t0,$t0,1
		j loop
	
	done2:
		
		beq $t0,0,C11
		beq $t0,1,C12
		beq $t0,2,C13
		beq $t0,3,C14
		beq $t0,4,C21
		beq $t0,5,C22
		beq $t0,6,C23
		beq $t0,7,C24
		beq $t0,8,C31
		beq $t0,9,C32
		beq $t0,10,C33
		beq $t0,11,C34
		beq $t0,12,C41
		beq $t0,13,C42
		beq $t0,14,C43
		beq $t0,15,C44

P11:
	lb $t0,0($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o11
	
	x11:
		li $t1,1
		li $t2, 0
		sb $t1, array($t2)
		sb $s7, 18($s1)
		j check
	o11:
		li $t1,2
		li $t2, 0
		sb $t1, array($t2)
		sb $s7, 18($s1)
		j check
P12:
	lb $t0,1($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o12
	
	x12:
		li $t1,1
		li $t2, 1
		sb $t1, array($t2)
		sb $s7, 22($s1)
		j check
	o12:
		li $t1,2
		li $t2, 1
		sb $t1, array($t2)
		sb $s7, 22($s1)
		j check
P13:
	lb $t0,2($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o13
	
	x13:
		li $t1,1
		li $t2, 2
		sb $t1, array($t2)
		sb $s7, 26($s1)
		j check
	o13:
		li $t1,2
		li $t2, 2
		sb $t1, array($t2)
		sb $s7, 26($s1)
		j check
P14:
	lb $t0,3($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o14
	
	x14:
		li $t1,1
		li $t2, 3
		sb $t1, array($t2)
		sb $s7, 30($s1)
		j check
	o14:
		li $t1,2
		li $t2, 3
		sb $t1, array($t2)
		sb $s7, 30($s1)
		j check
P21:
	lb $t0,4($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o21
	
	x21:
		li $t1,1
		li $t2, 4
		sb $t1, array($t2)
		sb $s7, 52($s1)
		j check
	o21:
		li $t1,2
		li $t2, 4
		sb $t1, array($t2)
		sb $s7, 52($s1)
		j check
P22:
	lb $t0,5($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o22
	
	x22:
		li $t1,1
		li $t2, 5
		sb $t1, array($t2)
		sb $s7, 56($s1)
		j check
	o22:
		li $t1,2
		li $t2, 5
		sb $t1, array($t2)
		sb $s7, 56($s1)
		j check
P23:
	lb $t0,6($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o23
	
	x23:
		li $t1,1
		li $t2, 6
		sb $t1, array($t2)
		sb $s7, 60($s1)
		j check
	o23:
		li $t1,2
		li $t2, 6
		sb $t1, array($t2)
		sb $s7, 60($s1)
		j check	
P24:
	lb $t0,7($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o24
	
	x24:
		li $t1,1
		li $t2, 7
		sb $t1, array($t2)
		sb $s7, 64($s1)
		j check
	o24:
		li $t1,2
		li $t2, 7
		sb $t1, array($t2)
		sb $s7, 64($s1)
		j check
P31:
	lb $t0,8($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o31
	
	x31:
		li $t1,1
		li $t2, 8
		sb $t1, array($t2)
		sb $s7, 86($s1)
		j check
	o31:
		li $t1,2
		li $t2, 8
		sb $t1, array($t2)
		sb $s7, 86($s1)
		j check
P32:
	lb $t0,9($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o32
	
	x32:
		li $t1,1
		li $t2, 9
		sb $t1, array($t2)
		sb $s7, 90($s1)
		j check
	o32:
		li $t1,2
		li $t2, 9
		sb $t1, array($t2)
		sb $s7, 90($s1)
		j check
P33:
	lb $t0,10($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o33
	
	x33:
		li $t1,1
		li $t2, 10
		sb $t1, array($t2)
		sb $s7, 94($s1)
		j check
	o33:
		li $t1,2
		li $t2, 10
		sb $t1, array($t2)
		sb $s7, 94($s1)
		j check
P34:
	lb $t0,11($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o34
	
	x34:
		li $t1,1
		li $t2, 11
		sb $t1, array($t2)
		sb $s7, 98($s1)
		j check
	o34:
		li $t1,2
		li $t2, 11
		sb $t1, array($t2)
		sb $s7, 98($s1)
		j check
P41:
	lb $t0,12($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o41
	
	x41:
		li $t1,1
		li $t2, 12
		sb $t1, array($t2)
		sb $s7, 120($s1)
		j check
	o41:
		li $t1,2
		li $t2, 12
		sb $t1, array($t2)
		sb $s7, 120($s1)
		j check
P42:
	lb $t0,13($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o42
	
	x42:
		li $t1,1
		li $t2, 13
		sb $t1, array($t2)
		sb $s7, 124($s1)
		j check
	o42:
		li $t1,2
		li $t2, 13
		sb $t1, array($t2)
		sb $s7, 124($s1)
		j check
P43:
	lb $t0,14($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o43
	
	x43:
		li $t1,1
		li $t2, 14
		sb $t1, array($t2)
		sb $s7, 128($s1)
		j check
	o43:
		li $t1,2
		li $t2, 14
		sb $t1, array($t2)
		sb $s7, 128($s1)
		j check
P44:
	lb $t0,15($s4)
	bne $t0,$zero,invalid
	li $t0,120
	bne $s7,$t0,o44
	
	x44:
		li $t1,1
		li $t2, 15
		sb $t1, array($t2)
		sb $s7, 132($s1)
		j check
	o44:
		li $t1,2
		li $t2, 15
		sb $t1, array($t2)
		sb $s7, 132($s1)
		j check


C11:
	#computerString
	#29 and 30
	lb $t0,c1
	la $t1, computerString
	sb $t0, 29($t1)
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co11
	
	
	
	cx11:
		li $t1,1
		li $t2, 0
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 18($s1)
		j check
	co11:
		li $t1,2
		li $t2, 0
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 18($s1)
		j check
C12:
	lb $t0,c1
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c2
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	
	li $t0,120
	beq $s7,$t0,co12
	
	cx12:
		li $t1,1
		li $t2, 1
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 22($s1)
		j check
	co12:
		li $t1,2
		li $t2, 1
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 22($s1)
		j check
C13:
	lb $t0,c1
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c3
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co13
	
	cx13:
		li $t1,1
		li $t2, 2
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 26($s1)
		j check
	co13:
		li $t1,2
		li $t2, 2
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 26($s1)
		j check
C14:
	lb $t0,c1
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c4
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall

	li $t0,120
	beq $s7,$t0,co14
	
	cx14:
		li $t1,1
		li $t2, 3
		sb $t1, array($t2)
		lb $t0,x
		sb $t0, 30($s1)
		j check
	co14:
		li $t1,2
		li $t2, 3
		sb $t1, array($t2)
		lb $t0,o
		sb $t0, 30($s1)
		j check
C21:
	lb $t0,c2
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c1
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co21
	
	cx21:
		li $t1,1
		li $t2, 4
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 52($s1)
		j check
	co21:
		li $t1,2
		li $t2, 4
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 52($s1)
		j check
C22:
	lb $t0,c2
	la $t1, computerString
	sb $t0, 29($t1)
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co22
	
	cx22:
		li $t1,1
		li $t2, 5
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 56($s1)
		j check
	co22:
		li $t1,2
		li $t2, 5
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 56($s1)
		j check
C23:
	lb $t0,c2
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c3
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co23
	
	cx23:
		li $t1,1
		li $t2, 6
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 60($s1)
		j check
	co23:
		li $t1,2
		li $t2, 6
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 60($s1)
		j check	
C24:
	lb $t0,c2
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c4
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall

	li $t0,120
	beq $s7,$t0,co24
	
	cx24:
		li $t1,1
		li $t2, 7
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 64($s1)
		j check
	co24:
		li $t1,2
		li $t2, 7
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 64($s1)
		j check
C31:
	lb $t0,c3
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c1
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co31
	
	cx31:
		li $t1,1
		li $t2, 8
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 86($s1)
		j check
	co31:
		li $t1,2
		li $t2, 8
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 86($s1)
		j check
C32:
	lb $t0,c3
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c2
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co32
	
	cx32:
		li $t1,1
		li $t2, 9
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 90($s1)
		j check
	co32:
		li $t1,2
		li $t2, 9
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 90($s1)
		j check
C33:
	lb $t0,c3
	la $t1, computerString
	sb $t0, 29($t1)
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co33
	
	cx33:
		li $t1,1
		li $t2, 10
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 94($s1)
		j check
	co33:
		li $t1,2
		li $t2, 10
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 94($s1)
		j check
C34:
	lb $t0,c3
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c4
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co34
	
	cx34:
		li $t1,1
		li $t2, 11
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 98($s1)
		j check
	co34:
		li $t1,2
		li $t2, 11
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 98($s1)
		j check
C41:
	lb $t0,c4
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c1
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co41
	
	cx41:
		li $t1,1
		li $t2, 12
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 120($s1)
		j check
	co41:
		li $t1,2
		li $t2, 12
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 120($s1)
		j check
C42:
	lb $t0,c4
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c2
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co42
	
	cx42:
		li $t1,1
		li $t2, 13
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 124($s1)
		j check
	co42:
		li $t1,2
		li $t2, 13
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 124($s1)
		j check
C43:
	lb $t0,c4
	la $t1, computerString
	sb $t0, 29($t1)
	lb $t0,c3
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co43
	
	cx43:
		li $t1,1
		li $t2, 14
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 128($s1)
		j check
	co43:
		li $t1,2
		li $t2, 14
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 128($s1)
		j check
C44:
	lb $t0,c4
	la $t1, computerString
	sb $t0, 29($t1)
	sb $t0, 30($t1)
	
	li $v0,4
	la $a0,computerString
	syscall
	
	li $t0,120
	beq $s7,$t0,co44
	
	cx44:
		li $t1,1
		li $t2, 15
		sb $t1, array($t2)
		lb $t0, x
		sb $t0, 132($s1)
		j check
	co44:
		li $t1,2
		li $t2, 15
		sb $t1, array($t2)
		lb $t0, o
		sb $t0, 132($s1)
		j check
check:
	lb $t0, 0($s4)
	lb $t1, 1($s4)
	lb $t2, 2($s4)
	lb $t3, 3($s4)
	and $t4,$t0,$t1
	and $t4,$t4,$t2
	and $t4,$t4,$t3
	lb $s0, 0($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 4($s4)
	lb $t1, 5($s4)
	lb $t2, 6($s4)
	lb $t3, 7($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 4($s4)#x won or o
	bne $t4,$zero,won
	
	
	lb $t0, 8($s4)
	lb $t1, 9($s4)
	lb $t2, 10($s4)
	lb $t3, 11($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 8($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 12($s4)
	lb $t1, 13($s4)
	lb $t2, 14($s4)
	lb $t3, 15($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 12($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 0($s4)
	lb $t1, 4($s4)
	lb $t2, 8($s4)
	lb $t3, 12($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 0($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 1($s4)
	lb $t1, 5($s4)
	lb $t2, 9($s4)
	lb $t3, 13($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 1($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 2($s4)
	lb $t1, 6($s4)
	lb $t2, 10($s4)
	lb $t3, 14($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 2($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 3($s4)
	lb $t1, 7($s4)
	lb $t2, 11($s4)
	lb $t3, 15($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 3($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 0($s4)
	lb $t1, 5($s4)
	lb $t2, 10($s4)
	lb $t3, 15($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 0($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 3($s4)
	lb $t1, 6($s4)
	lb $t2, 9($s4)
	lb $t3, 12($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 3($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 0($s4)
	lb $t1, 1($s4)
	lb $t2, 4($s4)
	lb $t3, 5($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 0($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 1($s4)
	lb $t1, 2($s4)
	lb $t2, 5($s4)
	lb $t3, 6($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 1($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 2($s4)
	lb $t1, 3($s4)
	lb $t2, 6($s4)
	lb $t3, 7($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 2($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 8($s4)
	lb $t1, 9($s4)
	lb $t2, 4($s4)
	lb $t3, 5($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 4($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 5($s4)
	lb $t1, 6($s4)
	lb $t2, 9($s4)
	lb $t3, 10($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 5($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 6($s4)
	lb $t1, 7($s4)
	lb $t2, 10($s4)
	lb $t3, 11($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 6($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 8($s4)
	lb $t1, 9($s4)
	lb $t2, 12($s4)
	lb $t3, 13($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 8($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 13($s4)
	lb $t1, 9($s4)
	lb $t2, 10($s4)
	lb $t3, 14($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 9($s4)#x won or o
	bne $t4,$zero,won
	
	lb $t0, 14($s4)
	lb $t1, 15($s4)
	lb $t2, 10($s4)
	lb $t3, 11($s4)
	and $t4, $t0,$t1
	and $t4, $t4,$t2
	and $t4, $t4,$t3
	lb $s0, 10($s4)#x won or o
	bne $t4,$zero,won
	
	j printboard

won:
	beq $s0,2,owon
	
	xwon:
		beq $s7,120,playerwon
		j computerwon
	owon:
		beq $s7,111,playerwon
		j computerwon
playerwon:
	lb $t0, 7($s3)
	addi $t0,$t0,1
	sb $t0, 7($s3)
	
	
	li $v0, 4
	la $a0, board
	syscall

	li $v0, 4
	la $a0, win
	syscall
	
	li $v0,4
	la $a0, Menu
	syscall
	
	li $v0, 5
	syscall
	
	move $t0,$v0
	beq $t0,1,newGame
	
	li $v0,4
	la $a0, resultString
	syscall
	
	li $v0,10
	syscall
computerwon:
	lb $t0, 16($s3)
	addi $t0,$t0,1
	sb $t0, 16($s3)


	li $v0, 4
	la $a0, board
	syscall
	

	li $v0, 4
	la $a0, lose
	syscall
	
	li $v0,4
	la $a0, Menu
	syscall
	
	li $v0, 5
	syscall
	
	move $t0,$v0
	beq $t0,1,newGame
	
	li $v0,4
	la $a0, resultString
	syscall
	
	li $v0,10
	syscall

tie2:	
	lb $t0, 24($s3)
	addi $t0,$t0,1
	sb $t0, 24($s3)
	
	
	li $v0, 4
	la $a0, board
	syscall
	
	
	li $v0, 4
	la $a0, tie
	syscall
	
	li $v0,4
	la $a0, Menu
	syscall
	
	li $v0, 5
	syscall
	
	move $t0,$v0
	beq $t0,1,newGame
	
	li $v0,4
	la $a0, resultString
	syscall
	
	li $v0,10
	syscall
	
newGame:
	
	li $v0,4
	la $a0, resultString
	syscall
	
	
	li $s2,-1
	
	lb $a1, clean
	sb $a1, 18($s1)
	sb $a1, 22($s1)
	sb $a1, 26($s1)
	sb $a1, 30($s1)
	sb $a1, 52($s1)
	sb $a1, 56($s1)
	sb $a1, 60($s1)
	sb $a1, 64($s1)
	sb $a1, 86($s1)
	sb $a1, 90($s1)
	sb $a1, 94($s1)
	sb $a1, 98($s1)
	sb $a1, 120($s1)
	sb $a1, 124($s1)
	sb $a1, 128($s1)
	sb $a1, 132($s1)
	
	li $t0 , 0
	loop3:
		sb $zero,array($t0)
		addi $t0,$t0,1
		bne $t0,16,loop3
	beq $s7,120,XtoO
	j OtoX
XtoO:
	li $s7,111
	j printboard
OtoX:
	li $s7,120
	j printboard
	
invalid:
	li $v0,4
	la $a0,invalidMove
	syscall
	
	addi $s2,$s2,-1
	j printboard


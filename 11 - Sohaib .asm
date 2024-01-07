		ORG 00H

mov r0, #40h
mov r1, 5
mov a, #0
mov r2, #0
CLR C

loop:

	add a, @r0

	JB CY, add_carry

	INC r0
	djnz r1, loop

add_carry:
	INC R2
	clr CY
	sjmp loop
	
		ORG 00H

MOV P2, #55h;

Mov r2,#8
MOV R3, #0
loop:

	mov C,p2.7
	mov a, r3
	rlc a
	mov r3, a
	
	mov a,p2
	rl a
	MOV P2, A
	
djnz r2,loop

END
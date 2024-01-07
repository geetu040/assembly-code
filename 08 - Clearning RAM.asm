;clear memory of ram at 16 locations
; starting from 60H

		ORG 00H;

MOV R0, #16
MOV R1, #40H;

MAIN:
	MOV @R1, #00H ; clearing

	; moving to next location
	MOV A, R1
	ADD A, #01H;
	MOV R1, A

	DJNZ R0, MAIN
END
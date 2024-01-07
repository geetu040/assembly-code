;s at p2.7 LED at p1.0
;get status of s and send to LED

		ORG 00H;

MAIN:
	MOV C, P2.7
	MOV P1.7, C
	SJMP MAIN

END
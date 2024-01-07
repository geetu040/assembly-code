; switch connected to P1.7
;if s is 0 send n to p2
;else y

		ORG 00H;

SETB P2.7

MAIN:
	JNB P2.7, SEND_N
	MOV P1, #0
	SJMP MAIN

SEND_N:
	MOV P1, #55H
	SJMP MAIN

END

; switch connected to P1.7
;if s is 0 send n to p2
;else y

		ORG 00H;

MAIN:
	ACALL CALL_Y
	ACALL CALL_N
	SJMP MAIN

CALL_N:
	SEND_N:
		MOV P1, #55H
		JNB P2.7, SEND_N
RET

CALL_Y:
	SEND_Y:
		MOV P1, #0H;
		JB P2.7, SEND_Y
RET

END

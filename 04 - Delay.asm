		ORG 0

; main function
BACK:
	MOV A, #55H
	MOV P1, A
	LCALL DELAY
	SJMP BACK

; sub routine at distance
		ORG 300H
DELAY:
	MOV R5, #00FH
	AGAIN:
		MOV P1, R5
		DJNZ R5, AGAIN
RET

; ending after the main function
END

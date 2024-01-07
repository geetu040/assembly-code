		ORG 0

; main function
BACK:
	CALL subrout1
	CALL subrout_delay
	LCALL subrout2

subrout1:
	MOV P1, #55H
	RET

subrout_delay:
	MOV R5, #3
	delay_method:
		DJNZ R5, delay_method
	RET

	org 300H
subrout2:
	MOV P1, #0AAH
	RET

END
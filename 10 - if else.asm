;if (a == 80) {
;	// something
;} else if (a > 80) {
;	// something
;} else {
;	// something
;}


		ORG 00H;

MOV R2, #79;

CJNE R2, #80, not_equal

; -- r2 == 80
MOV P1, #55h;
SJMP finish
; --

not_equal:
	JB CY, less
	; -- greater
	MOV P1, #00;
	SJMP finish
	; -- 

less:
	; -- less
	MOV P1, #0FFH;
	SJMP finish
	; -- 

;CJNE P2, #4

finish:
	; code ends here
end;

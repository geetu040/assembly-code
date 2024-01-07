org 0;

mov a, #0
mov r0, #10
mov p1, a;

myloop:
	add a, #03
	mov p1, a;
	DJNZ r0, myloop

END
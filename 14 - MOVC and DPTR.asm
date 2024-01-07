		org 00H

MOV DPTR, #00H
MOV A, #60H
MOVC A, @A+DPTR
MOV P1, A

		org 60H

MYDB: DB 1, 2, 3, 4, 5



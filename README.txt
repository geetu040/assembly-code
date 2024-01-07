# x86 Instruction cycle
several sub-operations, each one clock cycle, e.g.:
- Fetch: Get next instruction into IR
- Decode: Determine what the instruction means
- Fetch operands: Move data from memory to datapath register
- Execute: Move data through the ALU
- Store results: Write data from register to memory

# Addressing Modes

- Immediate
Data

- Register-direct
Register address -> Data

- Register
Register address -> Memory Address

- Direct
Memory Address -> Data

- Indirect
Memory Address -> Memory Address -> Data

Types of Registors
- General Purpose
	- R8 - R15
	- AX (Accumulator)
	- BX (base)
	- CX (count)
	- DX (destination)
- Special Purpose
	- IP
	- IR
	- BP (base pointer)
	- SP
	- SI (source index)
	- DI (destination index)

// start code from this code memory
Org 00H

MOV R0, #10H;
MOV R0, #10;

// memories
A - Accumulator
R0-7 - Registers
P1 - Port 1

# 8051 Instruction Cycle

1 machine cycle / instruction cycle = 12 oscillations

MOV - 1 machine cycles
DEC - 1
ADD - 1
SUBB - 1
MUL - 4
DIV - 17 (gpt), 4 (google)

ANL - 1
ORL - 1
XRL - 1

CPL - 1
CLR - 1
SETB - 1
INC - 1

; jumps and calls take 2
DJNZ - 2
LJMP - 2
SJUMP - 2
RET - 2

NOP - 1


# Memory

Total: 128 bytes

0x00 - 0x07 -> Bank 0 R0-R7
0x07 - 0x0F -> Bank 1 R0-R7 (Stack)
0x10 - 0x17 -> Bank 2 R0-R7
0x17 - 0x1F -> Bank 3 R0-R7

0x20 - 0x2F -> Bit Addressable (called using 00 - 7F)
0x30 - 0x7F -> Direct and Indirect Addressing

0x80 - 0xFF -> SFR

# Directives

ORG
EQU
DB
END

- EQU
COUNT EQU 05H;	
MOV P1, #COUNT;	05 shown on P1
MOV P1, COUNT;	content in 05 at data memory shown on P1

- DB
VAR: DB 05H;
MOV P1, #VAR;	location in code memory where 05H is stored
MOV P1, VAR;	05 shown on P1

- BIT
; used for bit-addressable I/0 and RAM Locations

LED BIT P1.7 ; assings LED as a variable that stores the bit on P1.7

# General Purpose Registers

R0 - R7

- R0 and R1 can be used to hold address of an operand located in RAM

# Special Function Registers

A or Accumulator (ACC)
- Arithmetic Operations like Addition, Subtraction, Multiplication etc.
- Logical Operations like AND, OR, NOT etc.
- Data Transfer Operations (between 8051 and External Memory)
- 8 bit

B (Register B)
- The B Register is used along with the ACC in Multiplication and Division operations
- In case of Division Operation, the B Register holds the divisor and also the remainder of the result
- 8 bit

- ADD
ADD A, #3 ; results is always stored in A

- SUBB
CLR C ; clear out carry before subtraction
SUBB A, #3;	carry is put in C

- MUL
MUL AB ; 16-bit results -> higher bits stored in B and lower in A

; B=65H and A=25H => 25H * 65H = E99H => B=0EH and A=99H

- Div
DIV AB

; B=10H and A=95H => 95H / 10H = 09 (q) and 05 (r) => B=05 and A=09

- ANL
; performs and operation

# PSW

- Flag Register
- 8 bit

- PSW.4 (RS1) and PSW.3 (RS0) are responsible for selecting the Register Bank

00 - Bank 0
CLR RS1, CLR RS0

01 - Bank 1
CLR RS1, SETB RS0

02 - Bank 2
SETB RS1, CLR RS0

03 - Bank 3
SETB RS1, SETB RS0

; this code first puts FF in Bank0R1 then in Bank1R1
MOV R1, #0FFH
CLR RS1
SETB RS0
MOV R1, #0FFH
END;

- PSW.7 (CY) - Carry

MOV C, P1.4;
MOV P2.7, C;

- PSW.2 (OV) - Overflow

JB PSW.2, TARGET ; jump to target if there is an overflow

# Data Pointer (DPTR – DPL and DPH)

- Data Pointer can be used as a single 16-bit register (as DPTR) or two 8-bit registers (as DPL and DPH)

MOV DPTR, #8000H ; load table address
MOVC A, @A+DPTR

write a program to get x value from P1 and send x^2 to P2

# Instructions

MOV R3, #10
DEC R3
CLR
SETB
CPL A ; 1's complement
ADD A, #1 ; 2's complement

ANL ; and
ORL ; or
XRL ; xor

RR
RL
RRC
RLC

SWAP


# Jump Instructions

- JZ ; jump if 0
- JNZ ; jump if not 0
- DJNZ ; decrement and jump
- CJNE ; jump if not equal , dest >= src then CY=0, dest < src then CY=1
- JC ; jump if carry (CY) = 1
- JB ; jump if bit = 1
- JNB ; jump if bit = 0
- JBC ; jump if bit=1 and then clear bit
- SJMP; 128 Bytes
- AJMP; 2KB i.e 11-bit address (0x000 to 0x7FF)
- LJMP; 64KB i.e 16-bit address (0X00 TO 0xFFFF)

- JB P1.0, LOOP		; Jump to LOOP if P1.0 = 1
- JNB P1.0, LOOP	; Jump to LOOP if P1.0 = 0
- JBC P1.0, LOOP	; Jump to LOOP if P1.0 = 1 then CLR P1.0
- JNC LOOP ; jumo to loop if CY=0

11111 + 1
100000

A:255
R:0

+1

A:0
R:1

```
MOV r0, #10;
myloop:
	; instructions here that will run for 10 times
	DJNZ r0, myloop
```
# Call Instructions

• CALL
	• calls from anywhere in the memory
• ACALL (Absolute CALL)
	• 2 BYTE instruction
	• Target address must be within 2KB i.e 11-bit address (0x000 to 0x7FF)

• LCALL (Long CALL)
	• 3 BYTE instruction
	• Target address must be within 64KB i.e 16-bit address (0X00 TO 0xFFFF)


```
BACK:
	CALL subrout1
	LCALL sub_delay
	CALL subrout2
subrout1:
	MOV P1, #55H
	RET
subrout2:
	MOV P1, #FFH
	RET
		ORG 300H
sub_delay:
	; this produces a delay
	RET
END
```

# Jump and Call distances



# Use cases

MOV DPTR, A ; gives an error: not of equal size

MOV R0, R1 ; data cannot be moved between registers

MOV 0F0H, R0; SFR can be accessed by memory thus this is same as MOV B, R0

MOV A, @R0 ; move contents of RAM whose address is held by R0

MAIN:
    SJMP $ ; create infinite loop as $ represents current address

MOV P1.0, P2.5 ; gives error



# Valid Operations

JB P1.5, LOOP
MOV P1, P2

# InValid Operations

MOV R1, R2

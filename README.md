## x86 Instruction Cycle

The x86 instruction cycle consists of several sub-operations, each taking one clock cycle:

- **Fetch:** Get the next instruction into the Instruction Register (IR).
- **Decode:** Determine the meaning of the instruction.
- **Fetch operands:** Move data from memory to the datapath register.
- **Execute:** Move data through the Arithmetic Logic Unit (ALU).
- **Store results:** Write data from the register to memory.

## Addressing Modes

- **Immediate:** Data is provided directly.
- **Register-direct:** Data is accessed using a register address.
- **Register:** Data is accessed using a register address that points to a memory address.
- **Direct:** Data is accessed using a memory address directly.
- **Indirect:** Data is accessed using an address that points to another address which then points to the data.

### Types of Registers

- **General Purpose:**
  - R8 - R15
  - AX (Accumulator)
  - BX (base)
  - CX (count)
  - DX (destination)
- **Special Purpose:**
  - IP
  - IR
  - BP (base pointer)
  - SP
  - SI (source index)
  - DI (destination index)

```assembly
; Start code from this code memory
Org 00H

MOV R0, #10H;
MOV R0, #10;

; Memories
A - Accumulator
R0-7 - Registers
P1 - Port 1
```

## 8051 Instruction Cycle

- 1 machine cycle / instruction cycle = 12 oscillations
- Instructions take varying machine cycles.

```assembly
MOV - 1 machine cycle
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

; Jumps and calls take 2 cycles
DJNZ - 2
LJMP - 2
SJUMP - 2
RET - 2

NOP - 1
```

## Memory

Total memory: 128 bytes

```assembly
0x00 - 0x07 -> Bank 0 R0-R7
0x07 - 0x0F -> Bank 1 R0-R7 (Stack)
0x10 - 0x17 -> Bank 2 R0-R7
0x17 - 0x1F -> Bank 3 R0-R7

0x20 - 0x2F -> Bit Addressable (called using 00 - 7F)
0x30 - 0x7F -> Direct and Indirect Addressing

0x80 - 0xFF -> SFR
```

## Directives

- **ORG**
- **EQU**
- **DB**
- **END**

### EQU

```assembly
COUNT EQU 05H;
MOV P1, #COUNT; ; 05 shown on P1
MOV P1, COUNT; ; content in 05 at data memory shown on P1
```

### DB

```assembly
VAR: DB 05H;
MOV P1, #VAR; ; location in code memory where 05H is stored
MOV P1, VAR; ; 05 shown on P1
```

### BIT

Used for bit-addressable I/O and RAM Locations.

```assembly
LED BIT P1.7 ; assigns LED as a variable that stores the bit on P1.7
```

## General Purpose Registers

- R0 - R7
- R0 and R1 can hold the address of an operand located in RAM.

## Special Function Registers

### Accumulator (A or ACC)

- 8-bit register.
- Used for arithmetic, logical, and data transfer operations.

### B (Register B)

- 8-bit register.
- Used in multiplication and division operations.

```assembly
ADD A, #3 ; result is always stored in A
CLR C ; clear out carry before subtraction
SUBB A, #3; carry is put in C
MUL AB ; 16-bit result -> higher bits stored in B, lower in A
DIV AB ; B=10H, A=95H => 95H / 10H = 09 (q) and 05 (r) => B=05, A=09
ANL ; performs AND operation
```

## PSW (Flag Register)

- 8-bit register.

```assembly
MOV C, P1.4; ; Move P1.4 to Carry
MOV P2.7, C; ; Move Carry to P2.7
JB PSW.2, TARGET ; Jump to target if there is an overflow
```

## Data Pointer (DPTR – DPL and DPH)

- 16-bit register (DPTR) or two 8-bit registers (DPL and DPH).

```assembly
MOV DPTR, #8000H ; Load table address
MOVC A, @A+DPTR ; Move code memory to A
```

## Instructions

```assembly
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
```

## Jump Instructions

- JZ: Jump if zero
- JNZ: Jump if not zero
- DJNZ: Decrement and jump
- CJNE: Jump if not equal, dest >= src then CY=0, dest < src then CY=1
- JC: Jump if carry (CY) = 1
- JB: Jump if bit = 1
- JNB: Jump if bit = 0
- JBC: Jump if bit=1 and then clear bit
- SJMP: 128 Bytes
- AJMP: 2KB (11-bit address)
- LJMP: 64KB (16-bit address)

```assembly
JB P1.0, LOOP ; Jump to LOOP if P1.0 = 1
JNB P1.0, LOOP ; Jump to LOOP if P1.0 = 0
JBC P1.0, LOOP ; Jump to LOOP if P1.0 = 1 then CLR P1.0
JNC LOOP ; Jump to loop if CY=0
```

```assembly
; Adding 11111 + 1
; Result: 100000

A: 255
R: 0

+1

A: 0
R: 1

MOV r0, #10;
myloop:
	; Instructions here that will run for 10 times
	DJNZ r0, myloop
```

## Call Instructions

- CALL: Calls from anywhere in the memory
- ACALL (Absolute CALL): 2-byte instruction, target address within 2KB (11-bit address).
- LCALL (Long CALL): 3-byte instruction, target address within 64KB (16-bit address).

```assembly
BACK:
	CALL subrout1
	LCALL sub_delay
	C

ALL subrout2
subrout1:
	MOV P1, #55H
	RET
subrout2:
	MOV P1, #FFH
	RET
	ORG 300H
sub_delay:
	; This produces a delay
	RET
END
```

## Jump and Call Distances

### Use Cases

- `MOV DPTR, A`: Gives an error as operands are not of equal size.
- `MOV R0, R1`: Data cannot be moved between registers.
- `MOV 0F0H, R0`: SFR can be accessed by memory, thus equivalent to `MOV B, R0`.
- `MOV A, @R0`: Move contents of RAM whose address is held by R0.
- `MAIN: SJMP $`: Create an infinite loop as $ represents the current address.
- `MOV P1.0, P2.5`: Gives an error.

### Valid Operations

- `JB P1.5, LOOP`
- `MOV P1, P2`

### Invalid Operations

- `MOV R1, R2`
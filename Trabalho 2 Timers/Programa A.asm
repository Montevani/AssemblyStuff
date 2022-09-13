; program for generating 1ms delay using 8051 timer. cristal 12mhz
	ORG	0000H
	JMP	0100H

	ORG	0100H
DELAY:	MOV	TMOD, #01H	; sets timer 0 to mode1 (16 bit timer). timer 1 is not used
	MOV	TH0, #0FCH	; loads th0 register with fch
	MOV	TL0, #018H	; loads tl0 register with 18h
	SETB	TR0		; starts the timer 0
HERE:	JNB	TF0, HERE	; loops here until tf0 is set (ie; until overflow)
	CLR	TR0		; stops timer 0
	CLR	TF0		; clears tf0 flag
	END
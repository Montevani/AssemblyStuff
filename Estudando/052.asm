RS	EQU	P0.0
RW	EQU	P0.1
EN	EQU	P0.2
LCD	EQU	P1
	ORG	00H
	JMP	INICIO
	ORG	23H
	LJMP	SERIAL
	ORG	30H
	
INICIO:	MOV	SP, #8FH; Inicia pilha no endereço indicado
	MOV	SCON, #01010000B; Habilita recepçao serial no modo sincrono
	MOV	IE, #10010000B;Habilita ocorrencia de interrupçao serial
	MOV	TMOD, #00100000B; Configura timer 1 no modo 2
	MOV	TL1, #0FDH ; Configura valores iniciais de timer
	MOV	TH1, #0FDH
	ACALL	INICIALCD; Chama subrotina de inicializaçao de LCD
	MOV	R1, #80H
	SETB	TR1
	SJMP	$

SERIAL:	MOV	A, SBUF
	ACALL	LCD
	CLR	RI
	RETI

LCD:	MOV	R2, A
	ACALL	ESCREVER
	INC	R1
	CJNE	R1, #88H, KEEP
	MOV	R1, #0C0H
KEEP:	CJNE	R1, #0C8H, KEEP2
	MOV	R1, #80H
KEEP2:	RET
ESCREVER:	ACALL	INSLCD
	CLR	RW
	SETB	RS
	SETB	EN
	MOV	LCD, R2
	CLR	EN
	ACALL	DELAY
	RET
INICIALCD:	PUSH	ACC
	MOV	R1, #038H
	ACALL	INSLCD
	MOV	R1, #0FH
	ACALL	INSLCD
	MOV	R1, #01H
	ACALL	INSLCD
	MOV	R1, #06H
	ACALL	INSLCD
	POP	ACC
	RET
INSLCD:	CLR	RS
	CLR	RW
	SETB	EN
	MOV	LCD, R1
	CLR	EN
	ACALL	DELAY
	RET
DELAY:	MOV	R3, #4H
	DJNZ	R3, $
	RET
END
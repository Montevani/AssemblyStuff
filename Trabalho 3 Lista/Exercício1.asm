ORG	000H
	JMP	Inicio

ORG	003H
	LCALL	FREQ1
	RETI

ORG	013H
	LCALL	FREQ2
	RETI

ORG	100H
Inicio:	MOV	IE, #10000101b ;configura interrupções
	MOV	TCON, #00000101b
	MOV	TMOD, #00000001b
	MOV	R6, #0FFH ;salva valores que permitem que timer faça frequencia de 2KHz em registradores
	MOV	R7, #05H
Aqui1:	CLR	TF0 ;limpa flag de overflow
	MOV	TH0, R6 ;transfere valores salvos em registradores para o timer
	MOV	TL0, R7
	SETB	TR0 ;liga timer
	CPL	P1.0 ;liga ou desliga o led
	JNB	TF0, $
	CLR	Tr0 ;desliga timer
	SJMP	Aqui1

FREQ1:	MOV	R6, #0FEH ;frequencia de 2 Khz
	MOV	R7, #0BH
	RET

freq2:	MOV	R6, #0FFH ;frequencia de 1 Khz
	MOV	R7, #05H
	RET
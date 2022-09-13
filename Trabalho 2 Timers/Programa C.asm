	ORG	0H
	LJMP	Inicio		; Pula para o programa principal

	ORG	000BH
	CLR	TR0		; Para o Timer 0
	CLR	TF0		; Reinicia tag de overflow
	LCALL	TIMER		; Chama subrotina de atraso por timer
	RETI

	ORG	100h
Inicio:
	MOV	IE, #10000010B	; Habilita interrupções advindas do timer
	MOV	IP, #10B	; Configura prioridade de interrupções
	MOV	TMOD, #01H	;Seta timers operando em interrupção e Timer 0 no modo 1
	LCALL	TIMER		; Chama subrotina de atraso
	JMP	$		; Aguarda interrupções

TIMER:	MOV	TH0, #High(65535-500)	; Carrega o timer para que a frequencia necessária seja 						gerada
	MOV	TL0, #Low(65535-500)	; Carrega o timer para que a frequencia necessária seja							 gerada
	SETB	TR0		; Dispara o timer
	CPL	P1.0		; Inverte sinal em P1.0
	RET			; Retorna da subrotina
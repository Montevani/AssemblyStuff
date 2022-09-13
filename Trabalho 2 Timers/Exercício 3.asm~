	ORG	0H

	LJMP	Inicio

	ORG	100h

Inicio:	MOV	TMOD, #10000b	; Configura Timer 1 em modo 1
	MOV	TH1, #High(65535-30000)	; Cria frequecia de 1kHz colocando valores inciais no 							Timer 1
	MOV	TL1, #Low(65535-30000)	; Cria frequecia de 1kHz colocando valores inciais no 							Timer 1
	SETB	TR1		; Dispara timer
	CLR	P1.0		; Coloca nivel alto na saída
	JNB	TF1, $		; Aguarda fim da temporização
	CLR	TR1		; Para o timer
	CLR	TF1		; Limpa flag indicadora de overflow
	SETB	P1.0		;Zera o nivel de saída
	SJMP	$		; Retorna ao inicio do programa para proximo pulso
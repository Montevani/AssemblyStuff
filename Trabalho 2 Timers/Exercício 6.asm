	ORG	0H
	LJMP	Inicio

	ORG	100h
Inicio:	MOV	TMOD, #10000b
	CLR	P1.0		; Coloca nivel alto na saida
	LCALL	Atraso		; Chama subrotina de atraso
	SETB	P1.0		; Coloca nivel baixo na saída
	SJMP	$

Atraso:
	MOV	R0, #10		; Inicia registrador para contar LOOPS
	MOV	TH1, #High(65535-50000)	; Espera 1 décimo do tempo necessário
	MOV	TL1, #Low(65535-50000)	;  Espera 1 décimo do tempo necessário
	SETB	TR1		; Dispara o timer
	JNB	TF1, $		; Aguarda fim da temporização
	CLR	TR1		; Para o timer
	CLR	TF1		; Limpa flag de
	DJNZ	R0, Atraso	; Verifica se todos os loops foram realizados
	RET
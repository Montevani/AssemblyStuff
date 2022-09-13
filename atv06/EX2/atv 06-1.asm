	ORG	0H
	LJMP	INICIO

	ORG	30H
INICIO:
	MOV	A, #0H		; Inicia A com 0, que será futuramente usado em contagem 					que será enviada
	MOV	SCON, #00H	;Configura as portas seriais como modo 0

LOOP:
	MOV	SBUF, A		;Amazena o valor de A antes de ser enviado
	JNB	TI, $		; Espera até transmissão ser realizada
	CLR	TI		; Limpa a flag de transmissão
	INC	A		;Aumenta o valor de A em 1, para prosseguir com a contagem
	LCALL	ATRASO
	SJMP	LOOP

ATRASO:
	MOV	R1, #3H
ATR:
	MOV	R2, #3H
	DJNZ	R2, $
	DJNZ	R1, ATR
	RET
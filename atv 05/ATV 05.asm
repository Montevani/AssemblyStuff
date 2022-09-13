	ORG	00H
	LJMP	INICIO		; Pula para o programa principal

	ORG	003H
	LJMP	RESETA		; Pula para reseta, ponto dos comandos de subrotina de 						interrupçao

	ORG	0030H
INICIO:	MOV	SP, #30H
	JB	P3.2, $		; Espera que haja sinal em baixo garantindo que a contagem 				nao comece durante um ciclo de alto
	MOV R7, #05H
	DJNZ R7,$
	MOV	TMOD, #08H	; Configura timer 0 operando no modo zero
	MOV	IE, #05H	; Habilita a ocorrencia de interrupçoes externas mas nao 					libera aceitaçao de ocorrencia.
	MOV	TCON, #01H	; Configura interrupçao por borda de descida
	SETB	TR0		; Libera temporizaçao
	SETB	EA		; Habilita interrupçoes externas
	SJMP	$		; Aguarda

RESETA:
	MOV	A, TL0		; Armazena valor menos significativo em R0
	MOV	R0, A
	MOV	A, TH0		; Armazena valor mais significativo em R1
	MOV	R1, TH0
	MOV	TH0, #00H	; Reseta timer
	MOV	TL0, #00H	; Reseta timer
	RETI			; Retorna ao ponto de parada
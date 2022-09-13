	ORG	00H
	LJMP	INICIO

	ORG	23H
	CLR	RI		; Limpa flag indicadora de interrupçao
	MOV	P1, SBUF	; Coloca dado reecebido e armazenado no registrador de 						dados seriais na P1
	RETI			; Retorna ao programa principal

	ORG	50H
INICIO:
	MOV	SCON, #90H	; Habilita recepçao de sinal serial no modo 2
	MOV	TMOD, #20H	; Habilita timer 1 no modo 2,
	MOV	TL1, #0FDH	; Seta valor inicial de timer
	MOV	TH1, #0FDH	; Seta valor de recarga do timer
	MOV	IE, #90H	; Habilita interrupçao da transferencia serial
	SETB	TR1		; Dispara timer para geraçao de clock
	SJMP	$		; Aguarda a ocorrencia de interrupçao serial, a qual 						ocorrera ao final da chegada do dado
	END


	ORG	00H
	LJMP	INICIO		; Vai para o programa principal
	ORG	050H
INICIO:
	MOV	A, #0AAH	; Armazena valor a ser enviado no acumulador
	MOV	SCON, #01010000B	; Configura transmissao serial no modo 1
TIMER:
	MOV	TMOD, #20H	; Configura timer 1 no modo 2 para gerar Bound Rate
	MOV	TL1, #0FDH	; Configura valores iniciais do timer para Bound Rate 
	MOV	TH1, #0FDH	;esperado
	SETB	TR1		; Dispara timer
LOOP:
	ACALL	TRANSMITE	; Chama subrotina de transmissao
	ACALL	RECEBE		; Chama subrotina de envio
	SJMP	LOOP		; Retorna a transmissao
TRANSMITE:
	MOV	SBUF, A		; Move dado a ser transfirido para SBUF iniciando a 						transmissao
	JNB	TI, $		; Aguarda ate o fim da transmissao
	CLR	TI		; Limpa flag indicadora de fim de transmissao
	RET			; Retorna ao programa principal
RECEBE:
	JNB	RI, $		; Aguarda ate o fim do recebimento
	CLR	RI		; Limpa flag indicadora de recebimento
	MOV	A, SBUF		; Armazena no acumulador dado recebido
	MOV	P2, A		; Mostra na P2 dado recebido por serial
	RET			; Retorna ao programa principal
END

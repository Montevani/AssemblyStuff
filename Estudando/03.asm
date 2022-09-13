	ORG	00H
	LJMP	INICIO		; Vai para o programa principal

	ORG	023H
	JMP	INT_SERIAL

	ORG	050H
INICIO:
	MOV	IE, #10010000B
	MOV	SCON, #01010000B	; Configura transmissao serial no modo 1
	MOV	A, #0AAH	; Armazena valor a ser enviado no acumulador


TIMER:
	MOV	TMOD, #20H	; Configura timer 1 no modo 2 para gerar Bound Rate
	MOV	TL1, #0FDH	; Configura valores iniciais do timer para Bound Rate
	MOV	TH1, #0FDH	;esperado
	SETB	TR1		; Dispara timer
	ACALL	TRANSMITE
	SJMP	$		; Aguarda ocorrencia de interrupçao

INT_SERIAL:

	JB	TI, REC1
	ACALL	TRANSMITE	; Chama subrotina de transmissao
	JMP	RETORNA
REC1:	ACALL	RECEBE		; Chama subrotina de envio

RETORNA:	RETI		; Retorna ao programa principal

TRANSMITE:
	CLR	RI		; Limpa flag indicadora de fim de transmissao
	MOV	SBUF, A		; Move dado a ser transfirido para SBUF iniciando a 						transmissao
	RET			; Retorna a subrotina de interrupçao
RECEBE:
	CLR	TI		; Limpa flag indicadora de recebimento
	MOV	A, SBUF		; Armazena no acumulador dado recebido
	MOV	P2, A		; Mostra na P2 dado recebido por serial
	RET			; Retorna a subrotina de interrupçao
END


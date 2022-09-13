	ORG	00H
	JMP	INICIO		; Vai para o programa principal

	ORG	23H
	LJMP	SERIAL		; Pula para subrotina de interrupçao serial

	ORG	30H
INICIO:	MOV	SP, #8FH	; Indica inicio da pilha
	MOV	SCON, #01000000B	; Habilita transmissao no modo sincrono
	MOV	IE, #10010000B	; Habilita a ocorrencia de interrupçoes por serial
	MOV	TMOD, #00100000B	; Configura timer 1 no modo zero
	MOV	TL1, #0FDH	; Seta valores iniciais de timer
	MOV	TH1, #0FDH
	SETB	TR1		;Dispara timer

ATRASO:				; Gera atraso para garantir inicializaçao de LCD
	MOV	R1, #50H
REINICIA:
	MOV	R2, #0FFH
	DJNZ	R2, $
	DJNZ R1, REINICIA

PRINCIPAL:
	MOV	A, #00H		; Zera acumulador para varredura da tabela
	MOV	R0, #00H	; Zera registrador que verifica se dado foi completamente 					enviado
	MOV	DPTR, #100H	; Configura valor inicial da leitura da tabela atraves do 					ponteiro DPTR
	MOVC	A, @A+DPTR	; Armazenano acumulador o valor apontado pelo DPTR no 						acumulador
	MOV	SBUF, A		;Move para a memoria de serial, e dispara o envio do 						caracter armazenado no acumulador
	CJNE	R0, #6H, $	; Verifica se a tabela ja foi enviada, caso contrario, 						aguarda interrupçao sinalizadora de envio de caractere
	LJMP	FIM_PROG	; Se a tabela foi completamente enviada vai para o 						fim do 	programa
SERIAL:	JB	RI, FIM		; Verifica se a interrupçao ocorreu por envio de caracter, 				caso contrario
	CLR	TI		; Limpa flags indicadora de interrupçao de serial
	MOV	A, #00H		;  Zera acumulador para varredura da tabela
	INC	DPTR		; Incrementa DPTR para que o proximo caractere seja lido
	INC	R0		; Incrementa contador de caractere
	MOVC	A, @A+DPTR	; Armazenano acumulador o valor apontado pelo DPTR no 						acumulador
	MOV	SBUF, A		; M Move para a memoria de serial, e dispara o envio do 					caracter armazenado no acumulador
FIM:	CLR	RI
	RETI			; Retorna ao programa principal

	ORG	100H
	DB	'CAIQUE'	; Armazena string a partir do ponto indicado pela diretiva 				ORG anterior
FIM_PROG:	NOP
	END			; Finaliza o programa
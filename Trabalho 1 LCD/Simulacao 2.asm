RS EQU P3.0
RW EQU P3.1
EN EQU P3.2
LCD EQU P1
ORG 0
JMP Inicio

ORG 100H
Inicio: LCALL IniciaLCD
	MOV R1,#65d ;Primeiro caractere do alfabeto
	MOV R4,#16d ;Conta número de colunas antes de ir para a próxima linha
	MOV R5,#1d ;Para parar programa no Z

Aqui:	LCALL escreve
	INC R1 ;Vai para próxima letra
	LCALL Atraso
	DJNZ R4, Aqui
	CJNE R5,#1d, Fim ;Se for segunda passagem vai parar o programa
	MOV R4,#11d ;Conta número de colunas antes de parar programa
	INC R5
	MOV A,#0C0H ;Vai para a próxima linha
	ACALL WriteCMD
	DEC R1
	SJMP Aqui
Fim:	SJMP Fim

IniciaLCD: PUSH A
	   MOV A,#00000001b ;Clear Display
	   ACALL WriteCMD
	   MOV A,#00000010b ;Cursor na home
	   ACALL WriteCMD
	   MOV A,#00000110b ;Entry mod set
	   ACALL WriteCMD
	   MOV A,#00001111b ;Display ON/OFF
	   ACALL WriteCMD
	   MOV A,#00011110b ;Shift no Cursor do Display
	   ACALL WriteCMD
	   MOV A,#00111100b ;Function set
	   ACALL WriteCMD
	   MOV A,#10000001b ;Set DDRAM address
	   ACALL WriteCMD
	   POP A
	   RET

WriteCMD: CLR RS ;Modo envia/recebe comando
	  CLR RW ;Modo escrita
	  SETB EN ;Prepara cursor para enviar comando ao LCD
	  MOV LCD,A ;Coloca o comando no barramento externo
	  CLR EN ;LCD obtém comando no barramento
	  RET

ATRASO:	MOV R2, #1h
ATR:	MOV R3, #1h
	DJNZ R3, $
	DJNZ R2, ATR
	RET

Escreve:CLR RW ;Modo escrita
	SETB RS ;Modo escrita/novo caractere
	SETB EN ;Pulso EN
	MOV LCD,R1 ;Coloca caractere no bus
	CLR EN ;LCD obtém caractere do bus
	Ret
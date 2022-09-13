RS EQU P3.0
RW EQU P3.1
EN EQU P3.3 ;Mudado de P3.2 para P3.3 para não se ter conflito com interrupção
LCD EQU P1
ORG 0H
JMP Inicio

ORG 3H
LJMP interrup

ORG 100H
Inicio: LCALL IniciaLCD
	MOV IE, #81H ;Interrupção na P3.2
	MOV TCON, #01H
	MOV R1,#65d ;Primeiro caractere do alfabeto
Fim:	SJMP Fim

IniciaLCD: PUSH A
	   MOV A,#00000001b ;Clear Display
	   ACALL WriteCMD
	   MOV A,#00000010b ;Cursor na home
	   ACALL WriteCMD
	   MOV A,#00001111b ;Display ON/OFF
	   ACALL WriteCMD
	   MOV A,#00111100b ;Function set
	   ACALL WriteCMD
	   MOV A,#10000001b ;Set DDRAM address
	   ACALL WriteCMD
	   MOV A,#80h
	   ACALL WriteCMD
	   POP A
	   RET

WriteCMD: CLR RS ;Modo envia/recebe comando
	  CLR RW ;Modo escrita
	  SETB EN ;Prepara cursor para enviar comando ao LCD
	  MOV LCD,A ;Coloca o comando no barramento externo
	  CLR EN ;LCD obtém comando no barramento
	  RET

interrup:LCALL escreve
	INC R1 ;Vai para a próxima letra
	MOV A,#80h
	ACALL WriteCMD
	RETI

Escreve:CLR RW ;Modo escrita
	SETB RS ;Modo escrita/novo caractere
	SETB EN ;Pulso EN
	MOV LCD,R1 ;Coloca caractere no bus
	CLR EN ;LCD obtém caractere do bus
	Ret

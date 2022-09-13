
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

escreve:CLR RW ;Modo escrita
	SETB RS ;Modo escrita/novo caractere
	SETB EN ;Pulso EN
	MOV LCD,R1 ;Coloca caractere no bus
	CLR EN ;LCD obtém caractere do bus
	Ret

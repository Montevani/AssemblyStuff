ORG 00H
LJMP Inicio

ORG 003H
	LCALL	FREQ1
	RETI

ORG 013H
	LCALL	FREQ2
	RETI

ORG 1BH
	LCALL MudaLed
	RETI

ORG 100H
Inicio: MOV IE,   #10001101b ;inicia interrupções
	MOV TMOD, #01010000b
	MOV TCON, #00000101b
	MOV IP,   #00000001b
	MOV R6, #0FFH ;inicia registradores que serão utilizados no programa
	MOV R7, #05H
	MOV R1, #2h
	SETB TR1 ;liga contador
	LCALL IniciaTimer
	LCALL ApagaLeds
Aqui1:	CLR	TF0 ;limpa flag de overflow
	MOV	TH0, R6 ;passa valores armazenados para o timer
	MOV	TL0, R7
	SETB	TR0 ;liga timer
	CPL P3.5 ;manda pulso para o contador
	JNB	TF0, $
	CLR	Tr0 ;para timer
	SJMP	Aqui1

MudaLed: CJNE R1, #2h, amarelo ;checa em qual ciclo o contador está
	 LCALL IniciaTimer
	 LCALL ApagaLeds
	 DEC R1 ;atualiza ciclo do contador
	 CLR P1.2 ;acende led verde
	 SJMP fim
amarelo: CJNE R1, #1h, vermelho
	 LCALL IniciaTimer
	 LCALL ApagaLeds
	 CLR P1.1 ;acende led amarelo
	 DEC R1 ;atualiza ciclo do contador
	 SJMP fim
vermelho:LCALL IniciaTimer
	 LCALL ApagaLeds
	 CLR P1.0 ;acende led vermelho
	 MOV R1, #02h ;atualiza ciclo do contador
fim:     RET

IniciaTimer: MOV TH1, #0FFh ;inicia contadores para darem overflow em dois avanços
	     MOV TL1, #0FEh
	     CLR TF1
	     RET

ApagaLeds: SETB P1.0 ;apaga todos os leds
	   SETB P1.1
	   SETB P1.2
	   RET

FREQ1:	MOV	R6, #0FEH ;frequencia de 2 Khz
	MOV	R7, #0BH
	RET

freq2:	MOV	R6, #0FFH ;frequencia de 1 Khz
	MOV	R7, #05H
	RET
ORG 00H
LJMP Inicio

ORG 13H
MOV A, #1h ;reseta programa
RETI

ORG 1BH
LCALL MudaLed
RETI

ORG 100H
Inicio: MOV IE,   #10001101b ;inicia interrupções e timer
	MOV TMOD, #01010000b
	MOV TCON, #00000101b
	SETB TR1 ;liga contador
Reinicia:MOV A, #0h ;inicia variaveis que serão utilizadas no programa
	 MOV R1, #2h
	 LCALL IniciaTimer
	 LCALL ApagaLeds
	 CJNE A, #1h, $ ;aguarda interrupção de overflow ou reset
	 SJMP Reinicia

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
	 MOV R1, #02h ;reinicia ciclo
fim:     RET

IniciaTimer: MOV TH1, #0FFh ;inicia contadores para darem overflow em dois avanços
	     MOV TL1, #0FEh
	     CLR TF1
	     RET

ApagaLeds: SETB P1.0 ;apaga todos os leds
	   SETB P1.1
	   SETB P1.2
	   RET
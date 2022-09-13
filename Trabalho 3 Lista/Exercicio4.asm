Repete EQU P1.0
Motor EQU P1.1
Buzzer EQU P1.2
Para EQU P1.3
ORG 00H
LJMP Inicio
ORG 0BH
INC A
RETI
ORG 100H
Inicio: LCALL Reinicia ;inicia todas as variaveis
	JNB Para, $ ;espera o botão "para" ser desativado
	SETB Motor ;liga motor
loop:	JNB Para, fim2 ;fica em loop checando se já passaram 100 peças ou se o botão "para" foi ativado
	CJNE A, #100d, loop
	CLR TR0 ;para sensores
	CLR TR1
	MOV A, TL1
	SUBB A, #59d ;caso tenha passado 60 ou mais peças grandes, o carry é ativado
	JNC fim
	LCALL BEEP
	LCALL reinicia
	SJMP loop

fim: CLR Motor ;caso 60 ou mais peças sejam grandes, a esteira para e fica em loop soltando beeps até que o botão "repete" seja pressionado
     LCALL BEEP
     JB Repete, fim
     LCALL Reinicia
     LJMP loop

fim2:CLR Motor ;caso o botão "para" seja ativado, a esteira simplesmente para e aguarda reinicialização com o botão "repete"
     JB Repete, $
     LCALL Reinicia
     LJMP loop

Reinicia:MOV IE, #10000010b
	 MOV TMOD, #01010110b
	 SETB TR0
	 SETB TR1
	 MOV TH0,#0FFh
	 MOV TL0,#0FFh
	 MOV TH1,#000h
	 MOV TL1,#000h
	 MOV A, #0H
	 CLR C
	 RET

BEEP:   MOV IE, 0H ;considerando um cristal de 4mHz o tempo de espera para um beep de 15000us é 5000 contagens
	MOV TCON, 0H
	MOV TMOD, #1H
	MOV TH0, #0E2h
	MOV TL0, #0B3h
	SETB TR0
	CPL Buzzer
	JNB TF0, $
	CLR TR0
	CLR Buzzer
	RET
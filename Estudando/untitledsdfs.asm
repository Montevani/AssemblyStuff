ORG 0H
LJMP INICIO

ORG 1BH
	SJMP $
	RETI

Org 50H
INICIO:	MOV TMOD, #100000b ; Timer 1 no modo 2
	MOV IE, #10001000b ; Liga interrupção para timer 1
	MOV TCON, #100b ; Interrupção na borda de descida
	MOV TH1, 0h
	MOV TL1, 0h
	SETB TR1
	Sjmp $

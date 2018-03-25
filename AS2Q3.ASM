				;BLINKING STRING WITH BEEP SOUND
				
				
.model small

.stack 64H

.data
STR1 	DB	07H,'HELLO$'

.code
	main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	CALL	CLS

	MOV	DH,12D
	MOV	DL,37D
	CALL	SETCUR
	
	LEA	SI,STR1
	MOV	CX,6
	
	MOV	AH,09H
	MOV	AL,0
	MOV	BH,00H
	MOV	BL,10001111B	;BLACK BACKGROUND AND WHITE FOREGROUND
	INT	10H
	LEA 	dx,STR1
	int 	21h
	

	


	MOV	AX,4C00H
	INT	21H
MAIN	ENDP


;----------------------------------------------------------------------------------------------


SETCUR	PROC	NEAR
	MOV	AH,02H
	MOV	BH,00H
	INT	10H
	RET
	SETCUR	ENDP


;----------------------------------------------------------------------------------------------


CLS	PROC	NEAR
	MOV	AH,00H
	MOV	AL,03H
	INT	10H
	RET
	CLS ENDP


;----------------------------------------------------------------------------------------------


END MAIN

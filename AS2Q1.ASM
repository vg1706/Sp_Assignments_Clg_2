.model small

.stack 64

.data
STRING1	DB	'HELLO$'

.code
	main	proc	far
	mov	ax,@data
	mov	ds,ax
	

	;LEFT TO RIGHT
	CALL 	LTOR

	;RIGHT TO LEFT
	CALL	RTOL

	;TOP TO BOTTOM
	CALL	TTOB
	


	MOV	AX,4C00H
	INT	21H
MAIN	ENDP

;----------------------------------------------------------------------------------------------

;TOP TO BOTTOM PROCEDURE
TTOB	PROC	NEAR
	MOV	CX,19H
	MOV	BL,00H

QQQ:	;CLEAR THE SCREEN
	CALL CLS

	;SET THE CURSOR
	MOV	AH,02H
	MOV	BH,00H
	MOV	DH,BL
	MOV	DL,00H
	INT	10H


	;PRINT
	CALL PRINTS

	INC	BL

	;CALL DELAY LOOP
	CALL	DELLOOP
	LOOP	QQQ
	RET
	TTOB	ENDP

;----------------------------------------------------------------------------------------------

;RIGHT TO LEFT PROCEDURE
RTOL	PROC	NEAR
	MOV	CX,4CH
	MOV	BL,4BH
	
PPP:	;CLEAR THE SCREEN
	CALL CLS

	;SET THE CURSOR
	MOV	AH,02H
	MOV	BH,00H
	MOV	DH,00H
	MOV	DL,BL
	INT	10H


	;PRINT
	CALL PRINTS

	DEC	BL

	;CALL DELAY LOOP
	CALL	DELLOOP
	LOOP	PPP
	RET
	RTOL	ENDP


;----------------------------------------------------------------------------------------------


;LEFT TO RIGHT PROCEDURE
LTOR 	PROC	NEAR
	MOV	CX,4CH
	MOV	BL,0H
	
XXX:	;CLEAR THE SCREEN
	CALL CLS

	;SET THE CURSOR
	MOV	AH,02H
	MOV	BH,00H
	MOV	DH,00H
	MOV	DL,BL
	INT	10H


	;PRINT
	CALL PRINTS

	INC	BL

	;CALL DELAY LOOP
	CALL	DELLOOP
	LOOP	XXX
	RET
	LTOR	ENDP

;----------------------------------------------------------------------------------------------

CLS	PROC	NEAR
	MOV	AH,00H
	MOV	AL,03H
	INT	10H
	RET
	CLS ENDP

;----------------------------------------------------------------------------------------------


PRINTS	PROC	NEAR
	LEA	DX,STRING1	
	MOV	AH,09H
	INT	21H
	RET
	PRINTS ENDP

;----------------------------------------------------------------------------------------------


DELLOOP	PROC	NEAR
	MOV	SI,00H
YYY:	INC	SI
	CMP	SI,6000H
	JNE	YYY
	RET
	DELLOOP	ENDP
END 	MAIN
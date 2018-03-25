.model small

.stack 64H

.data

STRING1	DB	201,24H
STRING2	DB	187,24H
STRING3	DB	200,24H
STRING4	DB	188,24H
STRING5	DB	205,24H
STRING6	DB	186,24H
ROW	DB	?
COL	DB	?
.code
	main	proc	far
	mov	ax,@data
	mov	ds,ax

	;CLEAR SCREEN
	CALL	CLS

	;PRINT BOX
	CALL	PBOX

	;PRINT CHARACTERS
	CALL	PRINTCHARS

	


	MOV	AX,4C00H
	INT	21H
MAIN	ENDP


;----------------------------------------------------------------------------------------------


PBOX	PROC	NEAR
	
	
	;SET CURSOR
	MOV	DH,05H
	MOV	DL,15D
	CALL	SETCUR

	LEA	DX,STRING1
	MOV	AH,09H
	INT	21H
	;PRINT====
	MOV	DH,05H
	CALL PRINTEQU

	MOV	DH,05H
	MOV	DL,66D
	CALL	SETCUR

	LEA	DX,STRING2
	MOV	AH,09H
	INT	21H


	;PRINT ||
	MOV	DL,15D
	CALL	PRINTOR

	MOV	DL,66D
	CALL	PRINTOR

	

	MOV	DH,21D
	MOV	DL,15D
	CALL	SETCUR

	LEA	DX,STRING3
	MOV	AH,09H
	INT	21H
	;PRINT====
	MOV	DH,21D
	CALL PRINTEQU

	MOV	DH,21D
	MOV	DL,66D
	CALL	SETCUR

	LEA	DX,STRING4
	MOV	AH,09H
	INT	21H
	RET
	PBOX	ENDP


;----------------------------------------------------------------------------------------------



PRINTCHARS	PROC	NEAR
	MOV	CX,128D	;128 ASCII VALUES
	MOV	AH,06H
	MOV	ROW,AH	;ROW STARTING FROM 06D TO 20D
	MOV	AH,16D	
	MOV	COL,AH	;COLUMN STARTING FROM 16D TO 65D
	MOV	BL,00D	;CHAR NUMBER
	
L1:	MOV	DH,ROW
	MOV	DL,COL
	CALL	SETCUR
	MOV	DL,BL
	MOV	AH,02H
	INT	21H
	INC	BL
	INC	COL
	CMP	COL,66D
	JE	P1
	JMP	Q1
P1:	MOV	COL,16D		;INCREMENT ROW# IF THE EXTREME RIGHT BOUNDARY OF THE BOX OCCURS
	INC	ROW
Q1:	LOOP	L1
	


EXIT:	RET
	PRINTCHARS	ENDP
	
	




;----------------------------------------------------------------------------------------------
PRINTOR	PROC	NEAR
	MOV	CX,15D
	MOV	BL,06D
	MOV	COL,DL
LOOP2:	MOV	DH,BL
	CALL	SETCUR
	
	;PRINT =
	LEA	DX,STRING6
	MOV	AH,09H
	INT	21H
	INC	BL
	MOV	DL,COL
	LOOP LOOP2

	RET
	PRINTOR	ENDP


;----------------------------------------------------------------------------------------------


PRINTEQU	PROC	NEAR
	MOV	CX,50D
	MOV	ROW,DH
	MOV	BL,10H
LOOP1:	MOV	DL,BL
	CALL	SETCUR
	
	;PRINT =
	LEA	DX,STRING5
	MOV	AH,09H
	INT	21H
	INC	BL
	MOV	DH,ROW
	LOOP LOOP1

	RET
	PRINTEQU	ENDP


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

				;SCROLL THE SCREEN
				
				
.model small

.stack 64H

.data
one	db	00H
two	db	?
TEN	DB	0AH
HUNDERED	DB	100D
ROW	DB	?
PAGEN	DB	?
npagen	db	?
col	db	?
temp1	db	81 dup(' ')
temp2	db	81 dup(' ')

.code
	main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	CALL	CLS
	mov	ah,02h
	mov	bh,00h
	mov	dh,00h
	mov	dl,00h
	int 	10h
	call	fillpages


l1:	mov	ah,0h
	int	16h
	

l2:	cmp	ah,50h;	<DOWN>
	jne	l3
	call	scrolldown
	jmp	l1
	
l3:	cmp	ah,01h;	<esc>
	jne	l1
	

	

	MOV	AX,4C00H
	INT	21H
MAIN	ENDP


;----------------------------------------------------------------------------------------------


scrolldown	proc	near
	mov	ah,05h
	mov	al,00h
	int	10h

	mov	pagen,00h
	mov	row,00h
	mov	col,00h
	mov	npagen,01h
	
	;storing first line of pageno.1 in temp1
	
	lea	si,temp1
	mov	cx,79d
	
x1:	mov	ah,02h
	mov	dh,row
	mov	dl,col
	mov	bh,pagen
	int	10h

	mov	ah,08h
	mov	bh,pagen
	int	10h
	mov	[si],al
	inc	si
	inc	col
	loop	x1
	mov	al,'$'
	mov	[si],al
	
	
	mov	col,00h
	
	;scrolling


	;select active page as next page	
xxx:	mov	ah,05h
	mov	al,npagen
	int	10h
	
	;reading first line of next page
	lea	si,temp2
	mov	cx,79d
	
x2:	mov	ah,02h
	mov	dh,row
	mov	dl,col
	mov	bh,npagen
	int	10h
	mov	ah,08h
	mov	bh,npagen
	int	10h
	mov	[si],al
	inc	si
	inc	col
	loop	x2
	mov	al,'$'
	mov	[si],al


	mov	ah,05h
	mov	al,pagen
	int	10h
	mov	ah,06h
	mov	al,01h
	mov	bh,07h
	mov	cx,0000
	mov	dx,184fh
	int	10h
	
	mov	ah,02h
	mov	dh,24d
	mov	dl,00
	mov	bh,pagen
	int	10h
	
	lea	dx,temp2
	mov	ah,09h
	int	21h
	inc	pagen
	inc	npagen
	mov	row,00h
	mov	col,00h
	cmp	npagen,04h
	je	x3
	jmp	xxx
	
x3:	mov	ah,05h
	mov	al,pagen
	int	10h
	
	mov	npagen,00h
	
	mov	ah,06h
	mov	al,01h
	mov	bh,07h
	mov	cx,0000
	mov	dx,184fh
	int	10h
	mov	row,24d
	mov	col,00
	mov	dh,row
	mov	dl,col
	mov	bh,pagen
	call	setcur

	lea	dx,temp1
	mov	ah,09h
	int	21h
	mov	ah,05h
	mov	al,npagen
	int	10h

	ret
	scrolldown	endp


;----------------------------------------------------------------------------------------------


SETCUR	PROC	NEAR
	MOV	AH,02H
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


fillpages	proc	near
	mov	one,00h
	mov	two,25d
	mov	row,00h
	mov	col,00h
	mov	pagen,00h
y1:	mov	ah,05h
	mov	al,pagen
	int	10h
	mov	ah,02h
	mov	bh,pagen
	mov	dh,row
	mov	dl,col
	int	10h
	mov	ah,00h
	mov	al,one
	call	printnum
	inc	one
	inc	row
	mov	al,row
	
	cmp	al,25d
	jne	y2
	
	inc	pagen
	mov	row,00h
	cmp	pagen,04h
	je	exitp
y2:	jmp	y1

	
exitp:	
	ret
	fillpages	endp
	
	
;----------------------------------------------------------------------------------------------
			
	

PRINTNUM	PROC	NEAR
	MOV	BH,HUNDERED
	DIV	BH
	MOV	BL,AH
	ADD	AL,30H
	MOV	DL,AL
	MOV	AH,02H
	INT	21H
	MOV	AH,00H
	MOV	AL,BL
	DIV	TEN
	MOV	BL,AH
	MOV	DL,AL
	ADD	DL,30H
	MOV	AH,02H
	INT	21H
	MOV	DL,BL
	ADD	DL,30H
	INT	21H
	
	RET
	PRINTNUM	ENDP
	
	
;----------------------------------------------------------------------------------------------


END MAIN

; Attributes: bp-based frame

bat_monDisbelieve proc far

	charNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+charNo], 0
	jmp	short loc_1EB89
loc_1EB86:
	inc	[bp+charNo]
loc_1EB89:
	cmp	[bp+charNo], 7
	jge	short loc_1EBEB
	getCharP	[bp+charNo], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1EBE9
	cmp	gs:party.class[si], class_illusion
	jnz	short loc_1EBE9
	mov	gs:bat_curTarget, 80h
	sub	ax, ax
	push	ax
	push	ax
	call	savingThrowCheck
	add	sp, 4
	or	ax, ax
	jz	short loc_1EBE9
	inc	gs:monDisbelieveFlag
	mov	ax, offset aTheyDisbelieve
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayWithTable
	jmp	short loc_1EBEB
loc_1EBE9:
	jmp	short loc_1EB86
loc_1EBEB:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monDisbelieve endp

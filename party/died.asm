; Attributes: bp-based frame

party_died proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	byte ptr g_printPartyFlag,	0
	mov	gs:byte_42296, 0FFh
	mov	ax, 57
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aSorryBud
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, offset aAlasYourPartyHasExp
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	g_partyAttackFlag, al
	sub	ah, ah
	mov	g_locationNumber, ax
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	g_direction, 0
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_1E958:
	retf
party_died endp

; Attributes: bp-based frame

sp_identifySpell proc far

	var_F4=	word ptr -0F4h
	var_34=	word ptr -34h
	var_32=	word ptr -32h
	var_2= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F4h
	call	someStackOperation
	call	clearTextWindow
	and	[bp+spellCaster], 7Fh
	push_ss_string	var_32
	push_ss_string	var_F4
	push	[bp+spellCaster]
	std_call	sub_188E8,0Ah
	mov	[bp+var_34], ax
	or	ax, ax
	jnz	short loc_22080
	mov	al, byte ptr aYourPocketsAreEm
	cbw
	push	ax
	call	printString
	add	sp, 2
	mov	[bp+var_2], 0FFFFh
	jmp	short loc_22098
loc_22080:
	push	[bp+var_34]
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	mov	ax, offset aWhichItem?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_2], ax
loc_22098:
	cmp	[bp+var_2], 0
	jge	short loc_220AD
	mov	ax, offset aSpellAborted_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_return
loc_220AD:
	getCharIndex	ax, [bp+spellCaster]
	mov	bx, [bp+var_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	byte ptr gs:[bx+62h], 3Fh
	mov	ax, offset aItemHasBeenIde
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_identifySpell endp


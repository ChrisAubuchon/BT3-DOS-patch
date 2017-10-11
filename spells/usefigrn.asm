; Attributes: bp-based frame

_sp_useFigurine	proc far

	loopCounter= word ptr -4
	itemNo=	word ptr -2
	spellCaster=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push_ds_string aInvokesAFiguri
	func_printString
	getCharP	[bp+spellCaster], bx
	mov	al, gs:byte_4227E
	sub	ah, ah
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	mov	[bp+itemNo], ax

	mov	[bp+loopCounter], 8
l_loopEnter:
	mov	bx, [bp+loopCounter]
	mov	al, figurineItemNo[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNo]
	jnz	short l_loopEnter
	mov	al, byte_483AC[bx]
	push	ax
	push	[bp+spellCaster]
	std_call	doSummon,4
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	l_loopEnter

	mov	sp, bp
	pop	bp
	retf
_sp_useFigurine	endp

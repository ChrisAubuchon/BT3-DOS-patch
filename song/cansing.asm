; Attributes: bp-based frame

_canSingSong proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+partySlotNumber], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	getCharP	[bp+partySlotNumber], bx

	cmp	gs:roster.class[bx], class_bard
	jz	short l_checkInstrument
	mov	ax, offset aNotABard
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_returnZero

l_checkInstrument:
	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	std_call	inven_hasTypeEquipped,4
	or	ax, ax
	jz	short l_noInstrument

	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.specAbil[bx],	0
	jnz	l_returnOne
	mov	ax, offset aYourThroatIsDr
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_returnZero

l_noInstrument:
	mov	ax, offset aYouArenTUsingA
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

l_returnZero:
	sub	ax, ax
	jmp	l_return

l_returnOne:
	mov	ax, 1

l_return:
	mov	sp, bp
	pop	bp
	retf
_canSingSong endp

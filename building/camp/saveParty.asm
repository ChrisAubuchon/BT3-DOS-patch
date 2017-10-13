; Attributes: bp-based frame

camp_saveParty proc far

	savedPartyCount=	word ptr -18h
	partyName=	word ptr -16h
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 18h
	call	someStackOperation
	mov	ax, offset aNameToSavePart
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short l_return
	push	cs
	call	near ptr countSavedParties
	mov	[bp+savedPartyCount], ax
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	push	cs
	call	near ptr roster_partyExists
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_13291
	mov	ax, [bp+savedPartyCount]
	mov	[bp+var_2], ax
loc_13291:
	cmp	[bp+var_2], 9
	jg	short l_return
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr sub_132F7
	add	sp, 6
l_return:
	mov	sp, bp
	pop	bp
	retf
camp_saveParty endp


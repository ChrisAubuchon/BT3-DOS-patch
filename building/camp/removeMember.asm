; Attributes: bp-based frame

camp_removeMember proc far

	loopCounter=	word ptr -24h
	slotToRemove=	word ptr -22h
	partyMemberList=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	push	si
	mov	[bp+loopCounter], 0
	mov	ax, offset aRemoveThemAll
	mov	[bp+partyMemberList], ax
	mov	[bp+var_1E], ds
loc_12723:
	cmp	[bp+loopCounter], 7
	jge	short loc_1275A
	getCharP	[bp+loopCounter], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jz	short loc_1275A
	getCharIndex	ax, [bp+loopCounter]
	add	ax, offset roster
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_1C],	ax
	mov	[bp+si+var_1A],	seg seg027
	inc	[bp+loopCounter]
	jmp	short loc_12723
loc_1275A:
	mov	ax, [bp+loopCounter]
	inc	ax
	push	ax
	lea	ax, [bp+partyMemberList]
	push	ss
	push	ax
	mov	ax, offset aSelectWhichPar
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+slotToRemove], ax
	or	ax, ax
	jl	l_return
l_removeAll:
	cmp	[bp+slotToRemove], 0
	jnz	short l_removeOneCharacter
	push	cs
	call	near ptr party_clear
	jmp	short l_saveAndReturn
l_removeOneCharacter:
	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	std_call	roster_writeCharacter,2

	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	near_call	part_pack, 2
l_saveAndReturn:
	call		countSavedChars
	push		ax
	std_call	saveCharsInf,2
	mov	byte ptr word_44166,	0
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_removeMember endp


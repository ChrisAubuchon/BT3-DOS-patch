camp_addMember proc far

	var_15C= word ptr -15Ch
	var_15A= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	savedList= dword	ptr -154h

	push	bp
	mov	bp, sp
	mov	ax, 15Ch
	call	someStackOperation
	push	si
	call	clearTextWindow
	push	cs
	call	near ptr countSavedChars
	or	ax, ax
	jz	l_noSavedCharacters
	mov	[bp+var_15A], 0
	mov	[bp+var_15C], 0
loc_12428:
	cmp	[bp+var_15A], 10
	jge	l_addCharacters
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_15C]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+si+savedList], ax
	mov	word ptr [bp+si+savedList+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+savedList]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12428
l_addCharacters:
	dec	[bp+var_15C]
	mov	ax, [bp+var_15C]
	mov	[bp+var_156], ax
	mov	[bp+var_15A], 0
l_nextCharacter:
	cmp	[bp+var_15A], 75
	jge	l_savedListComplete
	mov	ax, [bp+var_15C]
	sub	ax, [bp+var_156]
	getCharIndex	cx, cx
	add	ax, 0
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+savedList], ax
	mov	word ptr [bp+si+savedList+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+savedList]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_nextCharacter
l_savedListComplete:
	dec	[bp+var_15C]

l_ioLoopEnter:
	push	[bp+var_15C]
	lea	ax, [bp+savedList]
	push	ss
	push	ax
	mov	ax, offset aWhoShallJoin?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_15A], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+var_15A], ax
	jge	short l_addCharacter
	push	[bp+var_15A]
	push	cs
	call	near ptr camp_insertParty
	add	sp, 2
	jmp	l_return
l_addCharacter:
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	near_call	party_nameExists, 4
	or	ax, ax
	jl	short l_loopContinue
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	call	printStringWClear
	add	sp, 4
	mov	ax, offset aIsAlreadyInThe
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	mov	[bp+var_158], 1
	jmp	short l_loopComparison
l_loopContinue:
	mov	[bp+var_158], 0
l_loopComparison:
	cmp	[bp+var_158], 0
	jnz	l_ioLoopEnter
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_158], ax
	cmp	ax, 7
	jge	short l_shortReturnLabel
	getCharP [bp+var_158], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_15A]
	sub	ax, [bp+var_156]
	getCharIndex	cx, cx
	mov	bx, ax
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	cs
	call	near ptr rost_insertMember
	mov	byte ptr word_44166,	0
l_shortReturnLabel:
	jmp	short l_return
l_noSavedCharacters:
	mov	ax, offset aThereAreNoChar
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_addMember endp

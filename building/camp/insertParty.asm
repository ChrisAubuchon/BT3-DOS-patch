; Attributes: bp-based frame

camp_insertParty proc far

	loopCounter= word ptr	-0Ah
	savedPartiesP= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	savedPartyNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	mov	ax, [bp+savedPartyNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+savedPartiesP], ax
	mov	word ptr [bp+savedPartiesP+2], seg seg022
	call	clearTextWindow
	mov	[bp+loopCounter], 0
	jmp	short l_loopComparison
l_incrementCounter:
	inc	[bp+loopCounter]
l_loopComparison:
	cmp	[bp+loopCounter], 7
	jge	l_return

	mov	si, [bp+loopCounter]
	mov	cl, 4
	shl	si, cl
	lfs	bx, [bp+savedPartiesP]
	cmp	byte ptr fs:[bx+si+10h], 0
	jz	l_return
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, bx
	mov	dx, fs
	add	ax, 10h
	push	dx
	push	ax
	near_call	party_nameExists, 4
	or	ax, ax
	jl	short l_findEmptySlot
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aIsAlreadyInThe
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	jmp	short l_incrementCounter
l_findEmptySlot:
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_2], ax
	cmp	ax, 7
	jge	l_rosterFull

	; Check that the character named in the party is in the
	; list of saved characters
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	push	cs
	call	near ptr roster_nameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short l_addCharacter
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aThereSNoOneHer
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	jmp	l_incrementCounter
l_addCharacter:
	getCharP [bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getCharP [bp+var_4], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	near_call	copyCharacterBuf,8
	push	cs
	call	near ptr rost_insertMember
	mov	byte ptr word_44166,	0
	jmp	l_incrementCounter
l_rosterFull:
	mov	ax, offset aTheRosterIsFul
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	jmp	l_incrementCounter
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_insertParty endp

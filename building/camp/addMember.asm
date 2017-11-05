camp_addMember proc far

	var_15C= word ptr -15Ch
	var_15A= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	savedList= dword	ptr -154h

	FUNC_ENTER(15Ch)
	push	si

	CALL(text_clear)
	CALL(roster_countCharacters, near)
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
	add	ax, offset g_rosterPartyBuffer
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
	CHARINDEX(cx, cx)
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
	PUSH_STACK_ADDRESS(savedList)
	PUSH_OFFSET(s_whoJoins)
	CALL(text_scrollingWindow)
	mov	[bp+var_15A], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+var_15A], ax
	jge	short l_addCharacter
	push	[bp+var_15A]
	CALL(camp_insertParty, near)
	jmp	l_return
l_addCharacter:
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	CALL(party_nameExists, near)
	or	ax, ax
	jl	short l_loopContinue
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	PRINTSTRING(true)
	PUSH_OFFSET(s_alreadyInParty)
	PRINTSTRING
	IOWAIT
	mov	[bp+var_158], 1
	jmp	short l_loopComparison
l_loopContinue:
	mov	[bp+var_158], 0
l_loopComparison:
	cmp	[bp+var_158], 0
	jnz	l_ioLoopEnter
	CALL(party_findEmptySlot, near)
	mov	[bp+var_158], ax
	cmp	ax, 7
	jge	short l_shortReturnLabel
	CHARINDEX(ax, STACKVAR(var_158), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_15A]
	sub	ax, [bp+var_156]
	CHARINDEX(cx, cx)
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	CALL(party_addCharacter, near)
	mov	byte ptr g_printPartyFlag,	0
l_shortReturnLabel:
	jmp	short l_return
l_noSavedCharacters:
	PUSH_OFFSET(s_noCharsOnDisk)
	PRINTSTRING
	IOWAIT
l_return:
	pop	si
	FUNC_EXIT
	retf
camp_addMember endp

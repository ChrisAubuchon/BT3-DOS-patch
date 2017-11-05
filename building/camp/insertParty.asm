; Attributes: bp-based frame

camp_insertParty proc far

	loopCounter= word ptr	-0Ah
	savedPartiesP= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	savedPartyNumber= word ptr	 6

	FUNC_ENTER(0Ah)
	push	si

	mov	ax, [bp+savedPartyNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+savedPartiesP], ax
	mov	word ptr [bp+savedPartiesP+2], seg seg022
	CALL(text_clear)
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
	CALL(party_nameExists, near)
	or	ax, ax
	jl	short l_findEmptySlot
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	PRINTSTRING
	PUSH_OFFSET(s_alreadyInParty)
	PRINTSTRING
	DELAY(2)
	jmp	short l_incrementCounter
l_findEmptySlot:
	CALL(party_findEmptySlot, near)
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
	CALL(roster_nameExists, near)
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
	PRINTSTRING
	PUSH_OFFSET(s_noOneHereNamedThat)
	PRINTSTRING
	DELAY(2)
	jmp	l_incrementCounter
l_addCharacter:
	CHARINDEX(ax, STACKVAR(var_2), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(var_4), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	CALL(party_addCharacter, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_incrementCounter
l_rosterFull:
	PUSH_OFFSET(s_rosterIsFull)
	PRINTSTRING
	DELAY(2)
	jmp	l_incrementCounter
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_insertParty endp

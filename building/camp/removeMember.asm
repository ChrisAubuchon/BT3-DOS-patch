; Attributes: bp-based frame

camp_removeMember proc far

	loopCounter=	word ptr -24h
	slotToRemove=	word ptr -22h
	partyMemberList=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah

	FUNC_ENTER(24h)
	push	si

	mov	[bp+loopCounter], 0
	mov	ax, offset s_removeAll
	mov	[bp+partyMemberList], ax
	mov	[bp+var_1E], ds
loc_12723:
	cmp	[bp+loopCounter], 7
	jge	short loc_1275A
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	short loc_1275A
	CHARINDEX(ax, STACKVAR(loopCounter))
	add	ax, offset party
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
	PUSH_STACK_ADDRESS(partyMemberList)
	PUSH_OFFSET(s_whichPartyMemberToRemove)
	CALL(text_scrollingWindow)

	mov	[bp+slotToRemove], ax
	or	ax, ax
	jl	l_return
l_removeAll:
	cmp	[bp+slotToRemove], 0
	jnz	short l_removeOneCharacter
	CALL(party_clear, near)
	jmp	short l_saveAndReturn
l_removeOneCharacter:
	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	CALL(roster_writeCharacter)

	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	CALL(party_pack, near)
l_saveAndReturn:
	CALL(roster_countCharacters)
	push	ax
	CALL(writeCharacterFile)
	mov	byte ptr g_printPartyFlag,	0
l_return:
	pop	si
	FUNC_EXIT
	retf
camp_removeMember endp


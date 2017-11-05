; Attributes: bp-based frame

camp_deleteMember proc far

	counter= word ptr -15Ch
	nameToDelete= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	var_154= dword ptr -154h
	var_150= word ptr -150h
	var_14E= word ptr -14Eh

	FUNC_ENTER(15Ch)
	push	si

	CALL(text_clear)
	CALL(roster_countCharacters, near)
	or	ax, ax
	jz	l_noSavedCharacters
	mov	[bp+counter], 0
	mov	[bp+nameToDelete], 0
l_partyLoopEntry:
	cmp	[bp+nameToDelete], 10
	jge	l_partyLoopExit
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+counter]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_partyLoopEntry
l_partyLoopExit:
	dec	[bp+counter]
	mov	ax, [bp+counter]
	mov	[bp+var_156], ax
	mov	[bp+nameToDelete], 0
l_characterLoopEntry:
	cmp	[bp+nameToDelete], 75
	jge	l_characterLoopExit
	mov	ax, [bp+counter]
	sub	ax, [bp+var_156]
	CHARINDEX(cx, cx)
	add	ax, 0
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_characterLoopEntry
l_characterLoopExit:
	dec	[bp+counter]
	push	[bp+counter]
	PUSH_STACK_ADDRESS(var_154)
	PUSH_OFFSET(s_deleteWho)
	CALL(text_scrollingWindow)
	mov	[bp+nameToDelete], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+nameToDelete], ax
	jge	short l_checkInParty
	push	[bp+nameToDelete]
	CALL(camp_deleteParty, near)
	jmp	l_return
l_checkInParty:
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	CALL(party_nameExists, near)
	or	ax, ax
	jl	short l_verifyDelete
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	PRINTSTRING(true)

	PUSH_OFFSET(s_currentlyInParty)
	PRINTSTRING(false)
	IOWAIT
	jmp	l_return
l_verifyDelete:
	PUSH_OFFSET(s_confirmDelete)
	PRINTSTRING(true)
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	PRINTSTRING(false)
	CALL(getYesNo)
	or	ax, ax
	jz	short l_return
	mov	ax, [bp+nameToDelete]
	mov	[bp+var_158], ax
l_packRoster:
	mov	ax, [bp+counter]
	cmp	[bp+var_158], ax
	jge	short l_zeroName
	mov	si, [bp+var_158]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	mov	si, [bp+var_158]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_14E]
	push	[bp+si+var_150]
	CALL(copyCharacterBuf, near)
	inc	[bp+var_158]
	jmp	short l_packRoster
l_zeroName:
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	mov	byte ptr fs:[bx], 0
	jmp	short l_return
l_noSavedCharacters:
	mov	ax, offset s_noCharsOnDisk
	push	ds
	push	ax
	PRINTSTRING(false)
	IOWAIT
l_return:
	pop	si
	FUNC_EXIT
	retf
camp_deleteMember endp


; Attributes: bp-based frame

camp_deleteMember proc far

	counter= word ptr -15Ch
	nameToDelete= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	var_154= dword ptr -154h
	var_150= word ptr -150h
	var_14E= word ptr -14Eh

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
	add	ax, offset partyIOBuf
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
	getCharIndex	cx, cx
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
	lea	ax, [bp+var_154]
	push	ss
	push	ax
	mov	ax, offset aDeleteWho?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+nameToDelete], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+nameToDelete], ax
	jge	short l_checkInParty
	push	[bp+nameToDelete]
	near_call	camp_deleteParty, 2
	jmp	l_return
l_checkInParty:
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	near_call	party_nameExists, 4
	or	ax, ax
	jl	short l_verifyDelete
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printStringWClear
	add	sp, 4
	mov	ax, offset aIsCurrentlyInT
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	l_return
l_verifyDelete:
	mov	ax, offset aAreYouSureYouW
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printString
	add	sp, 4
	call	getYesNo
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
	near_call	copyCharacterBuf, 8
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
camp_deleteMember endp


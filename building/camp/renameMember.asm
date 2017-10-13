
; Attributes: bp-based frame

camp_renameMember proc far

	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	loopCounter= word ptr -25Ah
	nameSelected= word ptr -258h
	nameBuf= word ptr -254h
	characterNameList= dword ptr -22Ch
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 25Eh
	call	someStackOperation
	push	si
	call	clearTextWindow
	push	cs
	call	near ptr countSavedChars
	or	ax, ax
	jz	l_noSavedCharacters
loc_12835:
	mov	[bp+loopCounter], 0
	mov	[bp+nameSelected], 0
l_createListLoopEntry:
	cmp	[bp+nameSelected], 75
	jge	l_selectFromList
	getCharIndex	ax, [bp+loopCounter]
	add	ax, 0
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+characterNameList], ax
	mov	word ptr [bp+si+characterNameList+2], seg	seg022
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	inc	[bp+nameSelected]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+characterNameList]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_createListLoopEntry
l_selectFromList:
	dec	[bp+loopCounter]
	push	[bp+loopCounter]
	lea	ax, [bp+characterNameList]
	push	ss
	push	ax
	mov	ax, offset aRenameWho?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+nameSelected], ax
	or	ax, ax
	jl	l_return

	mov	ax, offset aWhatIs
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	si, [bp+nameSelected]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+characterNameList+2]
	push	word ptr [bp+si+characterNameList]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	ax, offset aSNewName?
	push	ds
	push	ax
	push	dx
	push	[bp+var_25E]
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+loopCounter], 0

l_clearNameLoopEntry:
	mov	si, [bp+loopCounter]
	mov	byte ptr [bp+si+nameBuf], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_clearNameLoopEntry
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short l_return
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	near_call	roster_nameExists, 4
	or	ax, ax
	jl	short l_renameCharacter
	mov	ax, offset aThereIsAlready
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_return
l_renameCharacter:
	mov	[bp+loopCounter], 0
l_renameLoopEntry:
	mov	si, [bp+loopCounter]
	mov	al, byte ptr [bp+si+nameBuf]
	mov	si, [bp+nameSelected]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+characterNameList]
	mov	si, [bp+loopCounter]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_renameLoopEntry
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
camp_renameMember endp

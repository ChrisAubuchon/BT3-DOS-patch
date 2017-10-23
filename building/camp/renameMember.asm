
; Attributes: bp-based frame

camp_renameMember proc far

	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	loopCounter= word ptr -25Ah
	nameSelected= word ptr -258h
	nameBuf= word ptr -254h
	characterNameList= dword ptr -22Ch
	var_100= word ptr -100h

	FUNC_ENTER
	CHKSTK(25Eh)
	push	si

	CALL(clearTextWindow)
	NEAR_CALL(roster_countCharacters)
	or	ax, ax
	jz	l_noSavedCharacters
loc_12835:
	mov	[bp+loopCounter], 0
	mov	[bp+nameSelected], 0
l_createListLoopEntry:
	cmp	[bp+nameSelected], 75
	jge	l_selectFromList
	CHARINDEX(ax, STACKVAR(loopCounter))
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
	PUSH_STACK_ADDRESS(characterNameList)
	PUSH_OFFSET(s_renameWho)
	CALL(text_scrollingWindow, 0Ah)
	mov	[bp+nameSelected], ax
	or	ax, ax
	jl	l_return

	PUSH_OFFSET(s_whatIs)
	PUSH_STACK_ADDRESS(var_100)
	STRCAT()
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	si, [bp+nameSelected]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+characterNameList+2]
	push	word ptr [bp+si+characterNameList]
	push	dx
	push	ax
	STRCAT()
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	PUSH_OFFSET(s_newName)
	push	dx
	push	[bp+var_25E]
	STRCAT()
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	PUSH_STACK_ADDRESS(var_100)
	PRINTSTRING(true)
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
	CALL(_readString, 6)
	or	ax, ax
	jz	short l_return
	PUSH_STACK_ADDRESS(nameBuf)
	NEAR_CALL(roster_nameExists, 4)
	or	ax, ax
	jl	short l_renameCharacter
	PUSH_OFFSET(s_nameAlreadyExists)
	PRINTSTRING(true)
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
	PUSH_OFFSET(s_noCharsOnDisk)
	PRINTSTRING
	IOWAIT
l_return:
	pop	si
	FUNC_EXIT
	retf
camp_renameMember endp

; This function	counts the number of characters	in
; the ioBuffer memory area.
; Attributes: bp-based frame

roster_countCharacters	proc far

	bufferP= dword ptr -6
	loopCounter= word ptr -2

	FUNC_ENTER(6)
	push	si

	mov	word ptr [bp+bufferP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
loc_13842:
	cmp	[bp+loopCounter], 75
	jge	loc_13858
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	lfs	si, [bp+bufferP]
	cmp	fs:[bx+si+character_t._name], 0
	jz	short loc_13858
	inc	[bp+loopCounter]
	jmp	short loc_13842
loc_13858:
	mov	ax, [bp+loopCounter]
	jmp	short $+2
	pop	si
	FUNC_EXIT
	retf
roster_countCharacters	endp

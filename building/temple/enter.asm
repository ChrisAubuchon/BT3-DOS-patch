; Attributes: bp-based frame

temple_enter proc far

	lastSlot= word ptr	-4
	inputKey= word ptr	-2

	FUNC_ENTER
	CHKSTK(4)

	CALL(text_clear)
	mov	ax, 49
	push	ax
	CALL(bigpic_drawPictureNumber)
	CALL(temple_setTitle, near)
	CALL(party_findEmptySlot, near)
	mov	[bp+lastSlot], ax
l_templeIoLoopEntry:
	PUSH_OFFSET(s_templeGreeting)
	PRINTSTRING(true)

l_badKey:
	mov	ax, 70h	
	push	ax
	CALL(getKey)
	mov	[bp+inputKey], ax

	; Subtract 4 if selected with mouse
	cmp	ax, 10Eh
	jl	short l_skipMouseSubtract
	cmp	ax, 119h
	jg	short l_skipMouseSubtract
	sub	[bp+inputKey], 4

l_skipMouseSubtract:
	mov	ax, [bp+inputKey]
	jmp	short l_keySwitch
l_healCharacter:
	CALL(temple_getHealee, near)
	jmp	short l_ioWaitAndLoop
l_poolGold:
	push	[bp+lastSlot]
	CALL(temple_getGoldPoolee, near)
l_ioWaitAndLoop:
	mov	byte ptr g_printPartyFlag,	0
	IOWAIT
	jmp	l_templeIoLoopEntry
l_keySwitch:
	cmp	ax, 'E'
	jz	short l_returnZero
	cmp	ax, 'H'
	jz	short l_healCharacter
	cmp	ax, 'P'
	jz	short l_poolGold
	cmp	ax, 10Eh
	jz	short l_healCharacter
	cmp	ax, 10Fh
	jz	short l_poolGold
	cmp	ax, 110h
	jz	short l_returnZero
	jmp	l_badKey
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
temple_enter endp

; Attributes: bp-based frame

tavern_enter proc far

	loopCounter= word ptr -4
	lastCharNo= word ptr -2

	FUNC_ENTER(4)

	CALL(party_findEmptySlot, near)
	mov	[bp+lastCharNo], ax

	; Reset drunk status
	mov	[bp+loopCounter], 0
l_resetDrunkLoop:
	mov	bx, [bp+loopCounter]
	mov	tav_drunkLevel[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_resetDrunkLoop

	mov	ax, bigpic_tavern
	push	ax
	CALL(bigpic_drawPictureNumber)
	CALL(tav_setTitle, near)
	mov	g_tavernSayingBase, ax

l_tavernMainLoop:
	PUSH_OFFSET(s_tavernGreeting)
	PRINTSTRING(true)
	mov	ax, 70h	
	push	ax
	CALL(getKey)
	cmp	ax, 'E'
	jz	short l_exitTavern
	cmp	ax, 'O'
	jz	short l_orderDrink
	cmp	ax, 'T'
	jz	short l_talkToBarkeep
	cmp	ax, 112h
	jz	short l_orderDrink
	cmp	ax, 113h
	jz	short l_talkToBarkeep
	cmp	ax, 114h
	jz	short l_exitTavern
	jmp	l_tavernMainLoop

l_orderDrink:
	push	[bp+lastCharNo]
	CALL(tav_orderDrink, near)
	or	ax, ax
	jnz	short l_returnZero
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_talkToBarkeep:
	push	[bp+lastCharNo]
	CALL(tavern_talkToBarkeep, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_exitTavern:
	CALL(text_clear)
	jmp	short l_returnZero

l_waitAndLoop:
	IOWAIT
	jmp	l_tavernMainLoop

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
tavern_enter endp

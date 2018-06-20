; Attributes: bp-based frame

tavern_enter proc far

	loopCounter= word ptr -6
	lastCharNo= word ptr -4
	var_2= word ptr	-2

	FUNC_ENTER(6)

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

	mov	ax, 83
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
	mov	[bp+var_2], ax
	jmp	short l_optionSwitch

l_orderDrink:
	push	[bp+lastCharNo]
	CALL(tav_orderDrink, near)
	or	ax, ax
	jz	short l_refreshParty
	sub	ax, ax
	jmp	short l_return
l_refreshParty:
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_talkToBarkeep:
	push	[bp+lastCharNo]
	CALL(tavern_talkToBarkeep, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_exitTavern:
	CALL(text_clear)
	sub	ax, ax
	jmp	short l_return

l_optionSwitch:
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
l_waitAndLoop:
	IOWAIT
	jmp	l_tavernMainLoop
l_return:
	FUNC_EXIT
	retf
tavern_enter endp

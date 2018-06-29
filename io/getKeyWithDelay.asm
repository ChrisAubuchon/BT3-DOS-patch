; This is where the print delay occurs during battle.
getKeyWithDelay proc far

	var_2= word ptr	-2
	delayTime= word ptr	 6
	speedupFlag= word ptr 8

	FUNC_ENTER(2)

	cmp	[bp+delayTime], 0
	jl	l_return

	mov	ax, [bp+delayTime]
	add	ax, _clockTicks
	mov	[bp+var_2], ax
	CALL(mouse_draw, near)

l_loopEntry:
	CALL(checkKeyboard)
	or	ax, ax
	jz	short l_doTimeEvents
	CALL(_readChFromKeyboard)

	cmp	[bp+speedupFlag], 0
	jz	l_skipFastCheck

	sub	ah, ah
	cmp	ax, '>'
	jz	l_faster
	cmp	ax, '.'
	jnz	l_slowCheck

l_faster:
	mov	al, txtDelayIndex
	dec	txtDelayIndex
	or	al, al
	ja	l_printFaster
	mov	txtDelayIndex, 0
	jmp	l_loopEntry

l_slowCheck:
	cmp	ax, '<'
	jz	l_slower
	cmp	ax, ','
	jnz	l_skipFastCheck

l_slower:
	mov	al, txtDelayIndex
	inc	txtDelayIndex
	cmp	al, 9
	jb	l_printSlower
	mov	txtDelayIndex, 9
	jmp	l_loopEntry

l_printFaster:
	mov	ax, offset s_faster
	jmp	l_doPrint

l_printSlower:
	mov	ax, offset s_slower

l_doPrint:
	push	ds
	push	ax
	PRINTSTRING
	jmp	l_loopEntry

l_skipFastCheck:
	call	far ptr	gfx_disableMouseIcon
	jmp	short l_return

l_doTimeEvents:
	CALL(checkMouse)
	CALL(doRealtimeEvents, near)
	CALL(party_print, near)
	mov	ax, [bp+var_2]
	cmp	_clockTicks, ax
	jl	short loc_1550B
	call	far ptr	gfx_disableMouseIcon
	jmp	short l_return
loc_1550B:
	cmp	mouse_moved, 0
	jz	short loc_15520
	call	far ptr	gfx_disableMouseIcon
	CALL(mouse_draw, near)
loc_15520:
	jmp	l_loopEntry
l_return:
	FUNC_EXIT
	retf
getKeyWithDelay endp

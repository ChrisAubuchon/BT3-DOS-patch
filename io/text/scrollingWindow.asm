; Attributes: bp-based frame

text_scrollingWindow proc far

	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	highlightedLine=	word ptr -16h		; Highlighted line
	var_14=	word ptr -14h
	displayIndexHead=	word ptr -12h		; Index into stringList of top item
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	TxtNumLines= word ptr	-0Ah
	var_8= word ptr	-8
	displayIndexTail= word ptr	-6		; Index into stringList of bottom item
	var_4= word ptr	-4
	var_2= word ptr	-2
	headerString= dword ptr	 6
	stringList= dword ptr  0Ah
	stringListLength= word ptr	 0Eh

	FUNC_ENTER(20h)
	push	si

	sub	ax, ax
	mov	[bp+displayIndexHead], ax
	mov	[bp+highlightedLine], ax
	mov	[bp+var_1E], ax
	mov	[bp+var_10], ax
	mov	[bp+var_E], 1
	CALL(mouse_draw, near)

l_mainLoop:
	cmp	[bp+var_E], 0
	jz	l_doRealTimeEvents

	call	far ptr	gfx_disableMouseIcon
	PUSH_STACK_DWORD(headerString)
	PRINTSTRING(clear)

	mov	al, gs:txt_numLines
	sub	ah, ah
	inc	ax
	mov	[bp+TxtNumLines], ax
	mov	ax, 0Ah
	sub	ax, [bp+TxtNumLines]
	mov	[bp+displayIndexTail], ax
	mov	ax, [bp+displayIndexHead]
	add	ax, [bp+displayIndexTail]
	cmp	ax, [bp+stringListLength]
	jle	short loc_159BF
	mov	ax, [bp+stringListLength]

loc_159BF:
	mov	[bp+var_1C], ax
	mov	ax, [bp+displayIndexHead]
	mov	[bp+var_1A], ax

l_writeItemLoop:
	mov	ax, [bp+var_1C]
	cmp	[bp+var_1A], ax
	jge	short loc_159EF
	mov	bx, [bp+var_1A]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+stringList]
	push	word ptr fs:[bx+si+2]
	push	word ptr fs:[bx+si]
	PRINTSTRING
	inc	[bp+var_1A]
	jmp	short l_writeItemLoop

loc_159EF:
	mov	[bp+var_4], 0
	mov	ax, [bp+displayIndexHead]
	add	ax, [bp+displayIndexTail]
	cmp	ax, [bp+stringListLength]
	jle	short loc_15A07
	mov	ax, [bp+stringListLength]
	sub	ax, [bp+displayIndexHead]
	jmp	short loc_15A0A
loc_15A07:
	mov	ax, [bp+displayIndexTail]
loc_15A0A:
	mov	[bp+var_14], ax
	mov	[bp+var_1A], 0
	jmp	short loc_15A17
loc_15A14:
	inc	[bp+var_1A]
loc_15A17:
	mov	ax, [bp+var_14]
	cmp	[bp+var_1A], ax
	jge	short loc_15A35
	mov	bx, [bp+var_1A]
	add	bx, [bp+TxtNumLines]
	shl	bx, 1
	mov	ax, g_mouseLineMaskList[bx]
	or	[bp+var_4], ax
	jmp	short loc_15A14
loc_15A35:
	mov	ax, g_mouseLineMaskList+16h
	or	[bp+var_4], ax
	CALL(scroll_printArrows, near)
	mov	ax, [bp+highlightedLine]
	add	ax, [bp+TxtNumLines]
	sub	ax, [bp+displayIndexHead]
	push	ax
	call	far ptr	gfx_highlightLine			; This probably does the highlighting
	add	sp, 2
	CALL(mouse_draw, near)
	mov	[bp+var_E], 0
	jmp	short l_getInput

l_doRealTimeEvents:
	CALL(doRealtimeEvents, near)

l_getInput:
	CALL(checkMouse)
	cmp	g_mouseMoved, 0
	jz	short l_skipMouseIcon
	call	far ptr	gfx_disableMouseIcon
	push	[bp+var_4]
	CALL(mouse_setScrollingIcon, near)
	mov	[bp+var_2], 1
	CALL(mouse_draw, near)

l_skipMouseIcon:
	push	[bp+var_4]
	CALL(scroll_checkArrowClick, near)
	mov	[bp+var_8], ax
	or	ax, ax
	jz	l_checkKeyboard
	CALL(checkGamePort)
	or	ax, ax
	jz	short loc_15AB9
	mov	ax, 1
	jmp	short loc_15ABB
loc_15AB9:
	sub	ax, ax
loc_15ABB:
	mov	[bp+var_20], ax
	cmp	[bp+var_1E], ax
	jnz	short loc_15AC7
	sub	ax, ax
	jmp	short loc_15ACA
loc_15AC7:
	mov	ax, [bp+var_20]
loc_15ACA:
	mov	[bp+var_10], ax
	mov	ax, [bp+var_20]
	mov	word_440BC, ax
	cmp	[bp+var_8], 10Eh
	jl	short loc_15B27
	cmp	[bp+var_8], 118h
	jg	short loc_15B27
	cmp	[bp+var_2], 0
	jz	short loc_15AFB
	mov	ax, [bp+var_8]
	sub	ax, [bp+txtNumLines]
	add	ax, [bp+displayIndexHead]
	sub	ax, 10Eh
	mov	[bp+highlightedLine], ax
	mov	[bp+var_2], 0
loc_15AFB:
	cmp	[bp+var_10], 0
	jz	short loc_15B0C
	call	far ptr	gfx_disableMouseIcon
	mov	ax, [bp+highlightedLine]
	jmp	l_return
loc_15B0C:
	mov	ax, [bp+var_C]
	cmp	[bp+highlightedLine], ax
	jz	short loc_15B19
	mov	ax, 1
	jmp	short loc_15B1B
loc_15B19:
	sub	ax, ax
loc_15B1B:
	mov	[bp+var_E], ax
	mov	ax, [bp+highlightedLine]
	mov	[bp+var_C], ax
	jmp	l_checkKeyboard
loc_15B27:
	mov	ax, [bp+var_8]
	jmp	short loc_15B98
loc_15B2C:
	cmp	[bp+var_10], 0
	jz	short loc_15B5A
	mov	ax, [bp+stringListLength]
	sub	ax, 5
	cmp	ax, [bp+displayIndexHead]
	jle	short loc_15B5A
	add	[bp+displayIndexHead], 5
	mov	ax, [bp+displayIndexHead]
	add	ax, 2
	mov	[bp+highlightedLine], ax
	mov	si, [bp+stringListLength]
	dec	si
	cmp	ax, si
	jle	short loc_15B55
	mov	[bp+highlightedLine], si
loc_15B55:
	mov	[bp+var_E], 1
loc_15B5A:
	jmp	short l_checkKeyboard
loc_15B5C:
	cmp	[bp+var_10], 0
	jz	short loc_15B81
	cmp	[bp+displayIndexHead], 5
	jle	short loc_15B6E
	sub	[bp+displayIndexHead], 5
	jmp	short loc_15B73
loc_15B6E:
	mov	[bp+displayIndexHead], 0
loc_15B73:
	mov	ax, [bp+displayIndexHead]
	add	ax, 2
	mov	[bp+highlightedLine], ax
	mov	[bp+var_E], 1
loc_15B81:
	jmp	short l_checkKeyboard
loc_15B83:
	cmp	[bp+var_10], 0
	jz	short loc_15B94
	call	far ptr	gfx_disableMouseIcon
	mov	ax, 0FFFFh
	jmp	l_return
loc_15B94:
	jmp	short l_checkKeyboard

loc_15B98:
	cmp	ax, dosKeys_ESC
	jz	short loc_15B83
	cmp	ax, dosKeys_upArrow
	jz	short loc_15B5C
	cmp	ax, dosKeys_downArrow
	jz	short loc_15B2C

l_checkKeyboard:
	CALL(checkKeyboard)
	or	ax, ax
	jz	l_mainLoopNext
	CALL(_readChFromKeyboard)
	mov	[bp+var_18], ax
	or	al, al
	jz	short loc_15BD4
	mov	al, byte ptr [bp+var_18]
	sub	ah, ah
	push	ax
	CALL(toUpper)
	mov	[bp+var_8], ax
	jmp	short loc_15BDA
loc_15BD4:
	mov	ax, [bp+var_18]
	mov	[bp+var_8], ax
loc_15BDA:
	mov	[bp+var_E], 1
	mov	ax, [bp+var_8]
	jmp	l_keySwitch

l_enterKey:
	call	far ptr	gfx_disableMouseIcon
	mov	ax, [bp+highlightedLine]
	jmp	l_return

l_escapeKey:
	call	far ptr	gfx_disableMouseIcon
	mov	ax, 0FFFFh
	jmp	l_return

l_upArrow:
	cmp	[bp+highlightedLine], 0
	jz	short l_upArrowScroll
	dec	[bp+highlightedLine]

l_upArrowScroll:
	mov	ax, [bp+displayIndexHead]
	cmp	[bp+highlightedLine], ax
	jge	short l_upArrowDone
	dec	[bp+displayIndexHead]
l_upArrowDone:
	jmp	l_mainLoopNext

l_downArrow:
	mov	ax, [bp+stringListLength]
	dec	ax
	cmp	ax, [bp+highlightedLine]
	jle	short l_downArrowScroll
	inc	[bp+highlightedLine]
l_downArrowScroll:
	mov	ax, [bp+displayIndexHead]
	add	ax, [bp+displayIndexTail]
	cmp	ax, [bp+highlightedLine]
	jg	short l_downArrowDone
	inc	[bp+displayIndexHead]
l_downArrowDone:
	jmp	l_mainLoopNext

l_pageDown:
	mov	ax, [bp+highlightedLine]
	add	ax, [bp+displayIndexTail]
	mov	cx, [bp+stringListLength]
	dec	cx
	cmp	ax, cx
	jge	short loc_15C48
	mov	ax, [bp+displayIndexTail]
	add	[bp+highlightedLine], ax
	add	[bp+displayIndexHead], ax
	jmp	short l_pageDownDone
loc_15C48:
	mov	ax, [bp+stringListLength]
	dec	ax
	mov	[bp+highlightedLine], ax
	mov	ax, [bp+displayIndexTail]
	cmp	[bp+highlightedLine], ax
	jl	short loc_15C66
	mov	ax, [bp+stringListLength]
	mov	cx, [bp+displayIndexTail]
	sar	cx, 1
	sub	ax, cx
	mov	[bp+displayIndexHead], ax
	jmp	short l_pageDownDone
loc_15C66:
	mov	[bp+displayIndexHead], 0
l_pageDownDone:
	jmp	l_mainLoopNext

l_pageUp:
	mov	ax, [bp+displayIndexTail]
	cmp	[bp+highlightedLine], ax
	jg	short loc_15C82
	mov	[bp+highlightedLine], 0
	mov	[bp+displayIndexHead], 0
	jmp	short l_pageUpDown
loc_15C82:
	mov	ax, [bp+displayIndexTail]
	sub	[bp+highlightedLine], ax
	cmp	[bp+displayIndexHead], ax
	jle	short loc_15C92
	sub	[bp+displayIndexHead], ax
	jmp	short l_pageUpDown
loc_15C92:
	mov	[bp+displayIndexHead], 0
l_pageUpDown:
	jmp	short l_mainLoopNext

l_homeKey:
	sub	ax, ax
	mov	[bp+displayIndexHead], ax
	mov	[bp+highlightedLine], ax
	jmp	short l_mainLoopNext

l_endKey:
	mov	ax, [bp+stringListLength]
	dec	ax
	mov	[bp+highlightedLine], ax
	mov	ax, [bp+displayIndexTail]
	cmp	[bp+highlightedLine], ax
	jge	short loc_15CB6
	sub	ax, ax
	jmp	short loc_15CC0
loc_15CB6:
	mov	ax, [bp+highlightedLine]
	mov	cx, [bp+displayIndexTail]
	sar	cx, 1
	sub	ax, cx
loc_15CC0:
	mov	[bp+displayIndexHead], ax
	jmp	short l_mainLoopNext

l_keySwitch:
	cmp	ax, dosKeys_upArrow
	jz	l_upArrow
	jg	short l_higherThanUpArrow
	cmp	ax, dosKeys_Enter
	jz	l_enterKey
	cmp	ax, dosKeys_ESC
	jz	l_escapeKey
	cmp	ax, dosKeys_home
	jz	short l_homeKey
	jmp	short l_mainLoopNext

l_higherThanUpArrow:
	cmp	ax, dosKeys_pageUp
	jz	short l_pageUp
	cmp	ax, dosKeys_end
	jz	short l_endKey
	cmp	ax, dosKeys_downArrow
	jz	l_downArrow
	cmp	ax, dosKeys_pageDown
	jz	l_pageDown

l_mainLoopNext:
	jmp	l_mainLoop
l_return:
	pop	si
	FUNC_EXIT
	retf
text_scrollingWindow endp

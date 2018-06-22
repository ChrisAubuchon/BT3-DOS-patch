; Attributes: bp-based frame

review_enter proc far

	loopCounter= word ptr	-6
	inKey= word ptr	-4
	getKeyMouseMask= word ptr	-2

	FUNC_ENTER(6)

loc_23001:
	and	byte_4EE71, 0FDh
	CALL(review_setTitle, near)
	test	byte_4EE71, 2
	jnz	l_return

	CALL(review_quest, near)
	test	byte_4EE71, 2
	jnz	short loc_23001

l_ioLoop:
	PRINTOFFSET(s_lastOfTheGuildElders, clear)
	mov	[bp+getKeyMouseMask], 0

	mov	[bp+loopCounter], 0
l_loop:
	mov	bl, gs:txt_numLines
	sub	bh, bh
	sub	bx, [bp+loopCounter]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+getKeyMouseMask], ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_loop

	push	[bp+getKeyMouseMask]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, 10Eh
	jl	short l_processKey
	cmp	ax, 119h
	jg	short l_processKey
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 4
	sub	[bp+inKey], ax

l_processKey:
	mov	ax, [bp+inKey]
	cmp	ax, 'T'
	jz	short l_speakToElder
	jg	short l_processMouseKey
	cmp	ax, 'A'
	jz	short l_checkXp
	cmp	ax, 'C'
	jz	short l_changeClass
	cmp	ax, 'S'
	jz	short l_learnSpells
	jmp	short l_checkExit

l_processMouseKey:
	cmp	ax, 10Eh
	jz	short l_checkXp
	cmp	ax, 10Fh
	jz	short l_learnSpells
	cmp	ax, 110h
	jz	short l_changeClass
	cmp	ax, 111h
	jz	short l_speakToElder

l_checkExit:
	cmp	[bp+inKey], 'E'
	jz	short l_return
	cmp	[bp+inKey], 112h
	jz	short l_return
	jmp	l_ioLoop

l_checkXp:
	sub	ax, ax
	push	ax
	CALL(review_checkXp, near)
	jmp	l_ioLoop

l_learnSpells:
	sub	ax, ax
	push	ax
	CALL(review_learnSpells, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_ioLoop

l_changeClass:
	CALL(review_changeMageClass, near)
	jmp	l_ioLoop

l_speakToElder:
	CALL(review_speakToElder, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_ioLoop

l_return:
	sub	ax, ax
	FUNC_EXIT
	retf
review_enter endp

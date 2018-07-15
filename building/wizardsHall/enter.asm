; Attributes: bp-based frame
wizardHall_enter proc	far

	loopCounter= word ptr	-6
	inKey= word ptr	-4
	mouseMask= word ptr	-2

	FUNC_ENTER(6)

	PUSH_OFFSET(s_guild)
	CALL(setTitle)

	mov	ax, bigpic_maleWizard
	push	ax
	CALL(bigpic_drawPictureNumber)

l_hallLoop:
	PUSH_OFFSET(s_hallOfWizards)
	PRINTSTRING(true)

	mov	[bp+mouseMask], 0
	mov	[bp+loopCounter], 0
l_mouseLoop:
	mov	bl, gs:txt_numLines
	sub	bh, bh
	sub	bx, [bp+loopCounter]
	shl	bx, 1
	mov	ax, g_mouseLineMaskList[bx]
	or	[bp+mouseMask], ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_mouseLoop

	push	[bp+mouseMask]
	CALL(getKey)
	add	sp, 2
	mov	[bp+inKey], ax
	cmp	ax, 10Eh
	jl	short l_keySwitch
	cmp	ax, 119h
	jg	short l_keySwitch
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 3
	sub	[bp+inKey], ax

l_keySwitch:
	mov	ax, [bp+inKey]
	cmp	ax, 'A'	
	jz	short l_advance
	cmp	ax, 'B'	
	jz	short l_buySpell
	cmp	ax, 'S'	
	jz	short l_acquireSpell
	cmp	ax, 10Eh
	jz	short l_advance
	cmp	ax, 10Fh
	jz	short l_acquireSpell
	cmp	ax, 110h
	jz	short l_buySpell
	cmp	[bp+inKey], 'E'	
	jz	short l_return
	cmp	[bp+inKey], 111h
	jz	short l_return
	jmp	l_hallLoop

l_advance:
	mov	ax, 1
	push	ax
	CALL(review_checkXp, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_hallLoop

l_acquireSpell:
	mov	ax, 1
	push	ax
	CALL(review_learnSpells, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_hallLoop

l_buySpell:
	CALL(wizardHall_buySpell, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_hallLoop

l_return:
	sub	ax, ax
	FUNC_EXIT
	retf
wizardHall_enter endp

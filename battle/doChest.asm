; Attributes: bp-based frame

bat_doChest proc far

	validOptionMouse=	word ptr -30h
	printPromptFlag=	word ptr -1Ch
	loopCounter=	word ptr -1Ah
	mouseBitmask=	word ptr -18h
	validOptionKeys=	word ptr -16h
	inKey= word ptr	-0Ch
	optionList= word ptr	-0Ah

	FUNC_ENTER(30h)
	push	si

	mov	ax, bigpic_chest
	push	ax
	CALL(bigpic_drawPictureNumber)

	PUSH_OFFSET(s_chest)
	CALL(setTitle)

	CALL(random)
	and	ax, 3
	mov	cl, g_levelNumber
	sub	ch, ch
	shl	cx, 1
	shl	cx, 1
	add	cx, ax
	mov	gs:g_trapIndex, cx
	mov	gs:g_chestExamined, 0

	sub	si, si
l_initOptionListLoop:
	mov	byte ptr [bp+si+optionList],	1
	inc	si
	cmp	si, 0Ah
	jl	short l_initOptionListLoop

l_chestLoop:
	CALL(text_clear)
	PUSH_STACK_ADDRESS(validOptionMouse)
	PUSH_STACK_ADDRESS(validOptionKeys)
	PUSH_STACK_ADDRESS(optionList)
	PUSH_OFFSET(s_chestPrompt)
	CALL(printVarString)
	mov	[bp+mouseBitmask], ax

l_getKey:
	mov	[bp+printPromptFlag], 1
	push	[bp+mouseBitmask]
	CALL(getKey)
	mov	[bp+inKey], ax
	mov	[bp+loopCounter], 0

l_searchOptionsLoop:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+validOptionKeys], 0
	jz	short l_chestLoopNext

	mov	al, byte ptr [bp+si+validOptionKeys]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_keyFound

	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+validOptionMouse],	ax
	jnz	short l_searchOptionsNext

l_keyFound:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_chestActionFunctions[bx]
	or	ax, ax
	jz	short l_markReprintPrompt

	CALL(text_clear)
	jmp	short l_return

l_markReprintPrompt:
	mov	[bp+printPromptFlag], 0
	DELAY(2)

l_searchOptionsNext:
	inc	[bp+loopCounter]
	jmp	short l_searchOptionsLoop

l_chestLoopNext:
	cmp	[bp+printPromptFlag], 0
	jnz	short l_getKey
	jmp	l_chestLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_doChest endp

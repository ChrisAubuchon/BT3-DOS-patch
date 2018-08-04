; Attributes: bp-based frame

dun_wanderingCreature proc far

	pluralizedNameP=	dword ptr -46h
	loopCounter=	word ptr -42h
	pluralizedName=	word ptr -40h
	monsterBufferP=	dword ptr -30h
	unmaskedName=	word ptr -2Ch
	validOptionCharacters=	word ptr -1Ch
	inKey=	word ptr -16h
	validOptionMouse=	word ptr -14h
	optionList= word ptr	-8
	monsterIndex= word ptr	-2

	FUNC_ENTER(46h)
	push	si

l_selectMonsterRetry:
	mov	ax, 17h
	push	ax
	sub	ax, ax
	push	ax
	CALL(randomBetweenXandY)			; Pick a random monster to wander
	mov	[bp+monsterIndex], ax
	MONINDEX(ax, STACKVAR(monsterIndex))
	add	ax, offset monsterBuf
	mov	word ptr [bp+monsterBufferP], ax
	mov	word ptr [bp+monsterBufferP+2],	seg seg023
	lfs	bx, [bp+monsterBufferP]			; Retry if
	test	fs:[bx+mon_t.flags], mon_noSummon	;	monster can't be summoned
	jnz	short l_selectMonsterRetry		; or
	cmp	byte ptr fs:[bx], 0			; 	no monster at that index
	jz	short l_selectMonsterRetry

	; Draw monster image
	mov	al, fs:[bx+mon_t.picIndex]
	sub	ah, ah
	push	ax
	CALL(bigpic_drawPictureNumber)

	; Set title with properly pluralized name
	PUSH_STACK_ADDRESS(unmaskedName)
	push	word ptr [bp+monsterBufferP+2]
	push	word ptr [bp+monsterBufferP]
	CALL(unmaskString)
	sub	ax, ax
	push	ax
	PUSH_STACK_ADDRESS(pluralizedName)
	PUSH_STACK_ADDRESS(unmaskedName)
	PLURALIZE(pluralizedNameP)
	lfs	bx, [bp+pluralizedNameP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(pluralizedName)
	CALL(setTitle)

	mov	gs:g_monGroups.groupSize,	1
	mov	al, byte ptr [bp+monsterIndex]
	mov	byte ptr gs:g_monGroups._name, al

	mov	[bp+loopCounter], 0
l_setOptionListLoop:
	mov	si, [bp+loopCounter]
	mov	byte ptr [bp+si+optionList],	1
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_setOptionListLoop

l_ioLoop:
	CALL(text_clear)
	PUSH_STACK_ADDRESS(validOptionMouse)
	PUSH_STACK_ADDRESS(validOptionCharacters)
	PUSH_STACK_ADDRESS(optionList)
	PUSH_OFFSET(s_wandererText)
	CALL(printVarString)
	mov	[bp+loopCounter], 0
	push	ax
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, dosKeys_ESC
	jz	short l_return

loc_25AC1:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+validOptionCharacters], 0
	jz	short l_ioLoop
	mov	al, byte ptr [bp+si+validOptionCharacters]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_callWandererFunction
	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+validOptionMouse],	ax
	jnz	short l_optionCheckNext

l_callWandererFunction:
	push	word ptr [bp+monsterBufferP+2]
	push	word ptr [bp+monsterBufferP]
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_wandererFunctionTable[bx]
	add	sp, 4
	or	ax, ax
	jz	short l_return
	CALL(text_clear)
	jmp	short l_return

l_optionCheckNext:
	inc	[bp+loopCounter]
	jmp	short loc_25AC1

l_return:
	pop	si
	FUNC_EXIT
	retf
dun_wanderingCreature endp

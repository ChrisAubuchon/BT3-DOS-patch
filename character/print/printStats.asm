; Attributes: bp-based frame

character_printStats proc far

	stringBuffer=	word ptr -0DAh
	loopCounter=	word ptr -26h
	attributeList=	word ptr -24h
	stringBufferP=	dword ptr -1Ah
	attributeP=	dword ptr -16h
	slotNumber= word ptr	 6

	FUNC_ENTER(0DAh)
	push	si

	CALL(text_clear)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, 1
	cmp	gs:party.class[bx], class_illusion
	jnz	short l_setArticle
	sub	ax, ax

l_setArticle:
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_OFFSET(s_isAn)
	PLURALIZE(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	l_skipCharacterDescription

	PUSH_OFFSET(s_level)
	PUSH_STACK_PTR(stringBufferP)
	STRCAT(stringBufferP)

	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.level[bx]
	PUSH_STACK_PTR(stringBufferP)
	ITOA(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.gender[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (s_genderString+2)[bx]
	push	word ptr s_genderString[bx]
	PUSH_STACK_PTR(stringBufferP)
	STRCAT(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.race[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_raceString+2)[bx]
	push	word ptr g_raceString[bx]
	PUSH_STACK_PTR(stringBufferP)
	STRCAT(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '

l_skipCharacterDescription:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_classString+2)[bx]
	push	word ptr g_classString[bx]
	PUSH_STACK_PTR(stringBufferP)
	STRCAT(stringBufferP)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_skipAttributes

	CHARINDEX(ax, STACKVAR(slotNumber))
	add	ax, offset party.strength
	mov	word ptr [bp+attributeP], ax
	mov	word ptr [bp+attributeP+2],	seg seg027

	mov	[bp+loopCounter], 0
l_attributeLoop:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+attributeP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	si, bx
	shl	si, 1
	mov	[bp+si+attributeList],	ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_attributeLoop

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.currentHP[bx]
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0Ah

	mov	ax, 5
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_STACK_ADDRESS(attributeList)
	CALL(getAttributeString, near)

l_skipAttributes:
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_skipExperience

	PUSH_STACK_ADDRESS(stringBuffer)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.maxSppt[bx]
	PUSH_OFFSET(s_spellPoints)
	CALL(printNumberAndString, near)

	PUSH_STACK_ADDRESS(stringBuffer)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	push	word ptr gs:(party.experience+2)[bx]
	push	word ptr gs:party.experience[bx]
	PUSH_OFFSET(s_expr)
	CALL(printNumberAndString, near)

l_skipExperience:
	PUSH_STACK_ADDRESS(stringBuffer)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	push	word ptr gs:(party.gold+2)[bx]
	push	word ptr gs:party.gold[bx]
	PUSH_OFFSET(s_gold)
	CALL(printNumberAndString, near)

	PUSH_OFFSET(s_poolGold)
	PRINTSTRING
	PUSH_OFFSET(s_escToContinue)
	PRINTSTRING

	pop	si
	FUNC_EXIT
	retf
character_printStats endp

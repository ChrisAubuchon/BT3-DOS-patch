; Attributes: bp-based frame

review_advance proc far

	attributeC= dword ptr -0Ch
	ageStatusFlag= word ptr	-8
	attributeIndex= word ptr	-6
	hpBonus= word ptr	-4
	bonusVar= word ptr	-2
	charNo=	word ptr  6
	arg_2= word ptr	 8

	FUNC_ENTER(0Ch)
	push	si

	CHARINDEX(ax, STACKVAR(charNo), si)
	inc	gs:party.maxLevel[si]
	mov	ax, gs:party.maxLevel[si]
	mov	gs:party.level[si], ax
	push	[bp+charNo]
	CALL(review_removeAgeStatus, near)
	mov	[bp+ageStatusFlag], ax
	CHARINDEX(ax, STACKVAR(charNo), si)
	CALL(random)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, hpLevelBonusMask[bx]
	sub	ah, ah
	and	ax, cx
	mov	cl, gs:party.constitution[si]
	sub	ch, ch
	shr	cx, 1
	shr	cx, 1
	add	ax, cx
	mov	[bp+hpBonus], ax
	mov	ax, gs:party.currentHP[si]
	add	ax, [bp+hpBonus]
	sub	cx, cx
	push	cx
	push	ax
	CALL(lib_maxFFFF, near)
	mov	gs:party.currentHP[si], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	ax, gs:party.maxHP[bx]
	add	ax, [bp+hpBonus]
	sub	cx, cx
	push	cx
	push	ax
	CALL(lib_maxFFFF, near)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.maxHP[bx], cx
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.class[bx]
	sub	ah, ah

	or	ax, ax
	jz	fighterLevelUp
	cmp	ax, class_rogue
	jz	rogueLevelUp
	cmp	ax, class_bard
	jz	bardLevelUp
	cmp	ax, class_paladin
	jz	fighterLevelUp
	cmp	ax, class_hunter
	jz	hunterLevelUp
	cmp	ax, class_monk
	jz	fighterLevelUp
	jmp	mageLevelUp

fighterLevelUp:
	CHARINDEX(ax, STACKVAR(charNo), si)
	mov	ax, gs:party.level[si]
	dec	ax
	shr	ax, 1
	shr	ax, 1
	mov	[bp+bonusVar], ax
	cmp	ax, 8
	jge	short l_setMaxAttacks
	mov	al, byte ptr [bp+bonusVar]
	jmp	short l_setAttackCount
l_setMaxAttacks:
	mov	al, 7
l_setAttackCount:
	mov	gs:party.numAttacks[si], al
	jmp	l_increaseRandomAttribute

rogueLevelUp:
	CALL(random_1d8)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.dexterity[bx]
	sub	ah, ah
	mov	dx, cx
	mov	cl, 3
	shr	ax, cl
	add	ax, dx
	mov	[bp+bonusVar], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	add	ax, [bp+bonusVar]
	push	ax
	CALL(lib_maxFF)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.specAbil[bx],	cl

	; Adding random_1d8 to bonusVar looks wrong. Doing it this way,
	; specAbil+1 gets bonusVar+1d8 and specAbil+2 gets bonusVar+1d8+1d8.
	CALL(random_1d8)
	add	[bp+bonusVar], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	add	ax, [bp+bonusVar]
	push	ax
	CALL(lib_maxFF)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:(party.specAbil+1)[bx], cl

	CALL(random_1d8)
	add	[bp+bonusVar], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:(party.specAbil+2)[bx]
	sub	ah, ah
	add	ax, [bp+bonusVar]
	push	ax
	CALL(lib_maxFF)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:(party.specAbil+2)[bx], cl

	jmp	l_increaseRandomAttribute

bardLevelUp:
	CHARINDEX(ax, STACKVAR(charNo), si)
	push	gs:party.level[si]
	CALL(lib_maxFF)
	mov	gs:party.specAbil[si],	al
	jmp	l_increaseRandomAttribute

hunterLevelUp:
	CALL(random_1d8)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.dexterity[bx]
	sub	ah, ah
	mov	dx, cx
	mov	cl, 3
	shr	ax, cl
	add	ax, dx
	mov	[bp+bonusVar], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	add	ax, [bp+bonusVar]
	push	ax
	CALL(lib_maxFF)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.specAbil[bx],	cl
	jmp	l_increaseRandomAttribute

mageLevelUp:
	CALL(random)
	and	ax, 3
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	al, gs:party.intelligence[bx]
	sub	ah, ah
	shr	ax, 1
	shr	ax, 1
	add	ax, cx
	inc	ax
	mov	[bp+bonusVar], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	ax, gs:party.currentSppt[bx]
	add	ax, [bp+bonusVar]
	sub	cx, cx
	push	cx
	push	ax
	CALL(lib_maxFFFF, near)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.currentSppt[bx], cx
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	ax, gs:party.maxSppt[bx]
	add	ax, [bp+bonusVar]
	sub	cx, cx
	push	cx
	push	ax
	CALL(lib_maxFFFF, near)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.maxSppt[bx], cx
	jmp	short l_increaseRandomAttribute

l_increaseRandomAttribute:
	mov	ax, 4
	push	ax
	sub	ax, ax
	push	ax
	CALL(randomBetweenXandY)
	mov	[bp+attributeIndex], ax
	CHARINDEX(ax, STACKVAR(charNo), bx)
	add	ax, offset party.strength
	mov	word ptr [bp+attributeC], ax
	mov	word ptr [bp+attributeC+2], seg seg027

; This section looks for an attribute under 30 to increase. It is possible
; to not increase an attribute when levelling up since the attribute search
; starts at a random attribute and doesn't wrap. 
;
l_findAttributeToIncrease:
	cmp	[bp+attributeIndex], 5
	jge	short l_restoreAgeStatus
	mov	bx, [bp+attributeIndex]
	lfs	si, [bp+attributeC]
	cmp	byte ptr fs:[bx+si], 30
	jl	short l_printIncreasedAttribute
	mov	byte ptr fs:[bx+si], 30
	inc	[bp+attributeIndex]
	jmp	short l_findAttributeToIncrease

l_printIncreasedAttribute:
	mov	bx, [bp+attributeIndex]
	lfs	si, [bp+attributeC]
	inc	byte ptr fs:[bx+si]
	PUSH_OFFSET(s_plusOneTo)
	PUSH_STACK_DWORD(arg_2)
	STRCAT(arg_2)
	mov	bx, [bp+attributeIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (fullAttributeString+2)[bx]
	push	word ptr fullAttributeString[bx]
	push	dx
	push	ax
	STRCAT(arg_2)
	jmp	short l_restoreAgeStatus

l_restoreAgeStatus:
	cmp	[bp+ageStatusFlag], 0
	jz	short l_return
	push	[bp+charNo]
	CALL(review_resetAgeStatus)

l_return:
	mov	ax, word ptr [bp+arg_2]
	mov	dx, word ptr [bp+arg_2+2]
	pop	si
	FUNC_EXIT
	retf
review_advance endp

; Attributes: bp-based frame

bat_monMelee proc far

	groupDistance= byte ptr -120h
	newDistance= word ptr -11Eh
	amountToAdvance= word ptr -11Ch
	pluralFlag= word ptr -11Ah
	loopCounter= word ptr -118h
	groupName= word ptr -116h
	stringBufferP= dword ptr -106h
	currentDistance= word ptr -102h
	stringBuffer= word ptr -100h
	monNo= word ptr	 6
	arg_2= word ptr  8
	arg_4= word ptr  0Ah
	arg_6= word ptr	 0Ch

	FUNC_ENTER(120h)
	push	si

	PUSH_STACK_ADDRESS(groupName)
	MONINDEX(ax, STACKVAR(monNo), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)

	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss

	MONINDEX(ax, STACKVAR(monNo), si)
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jb	l_inMeleeRange

	; A value of 0C0 in packedGenAc indicates that the source's name
	; is unique. (e.g. Tarjan)
	mov	al, gs:monGroups.packedGenAc[si]
	and	al, 0C0h
	cmp	al, 0C0h
	jnz	short l_addIndefiniteArticle

	mov	[bp+pluralFlag], 0
	jmp	short l_advance

l_addIndefiniteArticle:
	MONINDEX(ax, STACKVAR(monNo), bx)
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 2
	jnb	short l_pluralAdvance
	mov	[bp+pluralFlag], 0
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 'A'
	mov	al, byte ptr [bp+groupName]
	cbw
	push	ax
	CALL(str_startsWithVowel, near)
	or	ax, ax
	jz	short l_startsWithConsonant
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 'n'

l_startsWithConsonant:
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	jmp	short l_advance

l_pluralAdvance:
	mov	[bp+pluralFlag], 1
	PUSH_OFFSET(s_the)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)

l_advance:
	push	[bp+pluralFlag]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_STACK_ADDRESS(groupName)
	PLURALIZE(stringBufferP)
	push	[bp+pluralFlag]
	push	dx
	push	ax
	PUSH_OFFSET(s_advances)
	PLURALIZE(stringBufferP)
	MONINDEX(ax, STACKVAR(monNo), bx)
	mov	al, gs:monGroups.distance[bx]
	mov	[bp+groupDistance], al
	sub	ah, ah
	mov	si, ax
	mov	cl, 4
	shr	ax, cl
	mov	[bp+amountToAdvance], ax
	mov	ax, si
	and	ax, 0Fh
	mov	[bp+currentDistance], ax
	mov	ax, [bp+amountToAdvance]
	cmp	[bp+currentDistance], ax
	jle	short l_setToMeleeRange
	mov	ax, [bp+currentDistance]
	sub	ax, [bp+amountToAdvance]
	jmp	short l_setDistance

l_setToMeleeRange:
	mov	ax, 1

l_setDistance:
	mov	[bp+newDistance], ax
	mov	al, byte ptr [bp+newDistance]
	mov	cl, [bp+groupDistance]
	and	cl, 0F0h
	add	al, cl
	mov	cx, ax
	MONINDEX(ax, STACKVAR(monNo), bx)
	mov	gs:monGroups.distance[bx], cl

	mov	[bp+loopCounter], 0
l_clearPriorityLoop:
	mov	bx, [bp+monNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 20h 
	jl	short l_clearPriorityLoop
	jmp	l_return

l_inMeleeRange:
	push	[bp+monNo]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_monGetName, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	CALL(random)
	and	ax, 1
	mov	cx, ax
	MONINDEX(ax, STACKVAR(monNo), bx)
	mov	al, gs:monGroups.flags[bx]
	sub	ah, ah
	and	ax, mon_attackStr
	shl	ax, 1
	add	ax, cx
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (monMeleeAttString+2)[bx]
	push	word ptr monMeleeAttString[bx]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	mov	ax, 3
	push	ax
	CALL(bat_getRandomChar, near)
	mov	gs:bat_curTarget, al
	sub	ah, ah
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_getAttackerName, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx

	; Push the special attack value
	push	[bp+arg_4]

	push	[bp+arg_6]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+monNo]
	CALL(bat_monMeleeRoll, near)
	or	ax, ax
	jnz	short l_attackSucceeds
	PUSH_OFFSET(s_butMisses)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	jmp	l_return

l_attackSucceeds:
	sub	ax, ax
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_charPrintMeleeDamage, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	CALL(bat_damageHp, near)
	or	ax, ax
	jz	short l_noKill
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_appendSpecialAttackString, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+stringBufferP]
	CALL(printCharPronoun)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	jmp	l_return

l_noKill:
	PUSH_OFFSET(s_periodNlNl)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

l_return:
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	DELAY

	pop	si
	FUNC_EXIT
	retf
bat_monMelee endp


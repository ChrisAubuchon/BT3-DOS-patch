; Attributes: bp-based frame
sp_farFoes proc	far

	stringBuf= word ptr	-58h
	loopCounter= word ptr	-8
	stringBufP= dword ptr	-6
	newDistance= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(5Ah)

	push	[bp+spellCaster]
	CALL(spellSavingThrowHelper, near)
	or	ax, ax
	jz	l_return
	test	byte ptr [bp+spellCaster], 80h
	jz	short l_monCaster

	mov	[bp+loopCounter], 0
l_loopEnter:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	mov	al, gs:g_monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, g_spellEffectData[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_notTooFar
	mov	[bp+newDistance], 9
l_notTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	CALL(_sp_setMonDistance, near)
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_loopEnter
	jmp	short l_outputString
l_monCaster:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+loopCounter], ax
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	mov	al, gs:g_monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, g_spellEffectData[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_partyNotTooFar
	mov	[bp+newDistance], 9
l_partyNotTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	CALL(_sp_setMonDistance, near)
l_outputString:
	PUSH_OFFSET(s_andTheFoesAre)
	PUSH_STACK_ADDRESS(stringBuf)
	STRCAT(stringBufP)

	PUSH_OFFSET(s_fartherAway)
	push	dx
	push	word ptr [bp+stringBufP]
	STRCAT(stringBufP)

	PUSH_STACK_ADDRESS(stringBuf)
	PRINTSTRING
l_return:
	DELAY
	FUNC_EXIT
	retf
sp_farFoes endp

; Attributes: bp-based frame
_sp_setMonDistance proc	far

	monsterGroupIndex= word ptr	 6
	newDistance= byte ptr	 8

	FUNC_ENTER
	push	si

	MONINDEX(ax, STACKVAR(monsterGroupIndex), si)
	cmp	byte ptr gs:g_monGroups._name[si], 0
	jz	short l_return
	mov	al, gs:g_monGroups.distance[si]
	and	al, 0F0h
	or	al, [bp+newDistance]
	mov	gs:g_monGroups.distance[si], al
l_return:
	pop	si
	FUNC_EXIT
	retf
_sp_setMonDistance endp


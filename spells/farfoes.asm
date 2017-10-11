; Attributes: bp-based frame
sp_farFoes proc	far

	stringBuf= word ptr	-58h
	loopCounter= word ptr	-8
	stringBufP= dword ptr	-6
	newDistance= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 5Ah	
	call	someStackOperation
	push	[bp+spellCaster]
	near_call	spellSavingThrowHelper,2
	or	ax, ax
	jz	l_return
	test	byte ptr [bp+spellCaster], 80h
	jz	short l_monCaster

	mov	[bp+loopCounter], 0
l_loopEnter:
	getMonP	[bp+loopCounter], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_notTooFar
	mov	[bp+newDistance], 9
l_notTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	near_call	_sp_setMonDistance,4
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_loopEnter
	jmp	short l_outputString
l_monCaster:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+loopCounter], ax
	getMonP	[bp+loopCounter], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_partyNotTooFar
	mov	[bp+newDistance], 9
l_partyNotTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	near_call	_sp_setMonDistance,4
l_outputString:
	strcat_offset aAndTheFoesAre, stringBufP
	mov	ax, offset aAndTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	do_strcat stringBufP
	mov	ax, offset aFartherAway
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+stringBufP]
	do_strcat stringBufP
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	func_printString
l_return:
	delayWithTable
	mov	sp, bp
	pop	bp
	retf
sp_farFoes endp

; Attributes: bp-based frame
_sp_setMonDistance proc	far

	monsterGroupIndex= word ptr	 6
	newDistance= byte ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getMonP	[bp+monsterGroupIndex], si
	cmp	byte ptr gs:monGroups._name[si], 0
	jz	short l_return
	mov	al, gs:monGroups.distance[si]
	and	al, 0F0h
	or	al, [bp+newDistance]
	mov	gs:monGroups.distance[si], al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_setMonDistance endp


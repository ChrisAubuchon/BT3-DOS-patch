; Attributes: bp-based frame

sp_divineIntervention proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+loopCounter], 0
l_loopEnter:
	getCharP	[bp+loopCounter], bx
	cmp	gs:roster.class[bx], class_illusion
	jnz	short l_notIllusion
	getCharP	[bp+loopCounter], bx
	mov	gs:roster.class[bx], class_monster
l_notIllusion:
	getCharP	[bp+loopCounter], bx
	and	gs:roster.status[bx], stat_old or stat_unknown
	mov	ax, gs:roster.maxHP[bx]
	mov	gs:roster.currentHP[bx], ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loopEnter
	cmp	gs:byte_422A4, 0
	jz	short l_return
	mov	al, 14h
	mov	gs:byte_42440, al
	mov	gs:byte_41E70, al
	mov	gs:antiMagicFlag, al
	mov	gs:partySpellAcBonus, al
	mov	gs:songExtraAttack, 8
	mov	gs:bat_curTarget, 80h
	mov	ax, 0CEh 
	push	ax
	push	[bp+spellCaster]
	push	cs
	call	near ptr _batchSpellCast
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_divineIntervention endp

; Attributes: bp-based frame

sp_divineIntervention proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	mov	[bp+loopCounter], 0
l_loopEnter:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	cmp	gs:party.class[bx], class_illusion
	jnz	short l_notIllusion

	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	mov	gs:party.class[bx], class_monster
l_notIllusion:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	and	gs:party.status[bx], stat_old or stat_unknown
	mov	ax, gs:party.maxHP[bx]
	mov	gs:party.currentHP[bx], ax
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
	NEAR_CALL(_batchSpellCast, 4)
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_divineIntervention endp

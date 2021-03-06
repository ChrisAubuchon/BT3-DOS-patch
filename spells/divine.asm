; Attributes: bp-based frame

sp_divineIntervention proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	FUNC_ENTER(2)

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

	cmp	gs:g_inBattleFlag, 0
	jz	short l_return

	mov	al, 20
	mov	gs:g_divineDamageBonus, al
	mov	gs:g_charFreezeToHitBonus, al
	mov	gs:g_spellAntiMagicValue, al
	mov	gs:partySpellAcBonus, al
	mov	gs:g_songExtraAttackFlag, 8
	mov	gs:bat_curTarget, 80h
	mov	ax, BITMASK(spell_mangarsMallet, 80h)
	push	ax
	push	[bp+spellCaster]
	CALL(_batchSpellCast, near)
l_return:
	FUNC_EXIT
	retf
sp_divineIntervention endp

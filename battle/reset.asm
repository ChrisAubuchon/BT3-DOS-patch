; Attributes: bp-based frame

bat_reset proc far

	counter= word ptr -2

	FUNC_ENTER(2)

	mov	[bp+counter], 0
l_resetMonsterDataLoop:
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)

	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, bat_monPriorityList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)

	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, bat_monBeenHitList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)

	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:g_monFreezeAcPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_41E50[bx], al
	mov	bx, [bp+counter]
	mov	gs:monSpellToHitPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:monAttackBonus[bx], al
	inc	[bp+counter]
	cmp	[bp+counter], 4
	jl	l_resetMonsterDataLoop

	mov	[bp+counter], 0
l_resetCharacterDataLoop:
	mov	bx, [bp+counter]
	mov	gs:g_charActionList[bx], charAction_defend
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:vorpalPlateBonus[bx], al
	mov	bx, [bp+counter]
	mov	gs:g_strengthSpellBonus[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+counter]
	mov	gs:g_characterMeleeDistance[bx], al
	mov	bx, [bp+counter]
	mov	gs:bat_charPriority[bx], al
	inc	[bp+counter]
	cmp	[bp+counter], 7
	jl	short l_resetCharacterDataLoop

	sub	al, al
	mov	gs:g_divineDamageBonus, al
	mov	gs:g_charFreezeToHitBonus, al
	mov	gs:g_charFreezeAcPenalty, al
	mov	gs:partySpellAcBonus, al
	mov	gs:g_monsterWOFBonus, al
	mov	gs:monFrozenFlag, al
	mov	gs:byte_422A4, al
	mov	gs:byte_41E63, al
	mov	gs:g_disbelieveFlags, al
	mov	gs:monDisbelieveFlag, al
	mov	gs:antiMagicFlag, al
	mov	gs:partyFrozenFlag, al
	mov	gs:songHalfDamage, al
	mov	gs:songCanRun, al
	mov	gs:songExtraAttack, al
	mov	gs:byte_4229A, al
	mov	gs:songRegenHP,	al
	sub	ax, ax
	mov	gs:batRewardHi,	ax
	mov	gs:batRewardLo,	ax

	FUNC_EXIT
	retf
bat_reset endp

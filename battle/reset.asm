; Attributes: bp-based frame

bat_reset proc far

	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1D0B8
loc_1D0B5:
	inc	[bp+counter]
loc_1D0B8:
	cmp	[bp+counter], 4
	jge	loc_1D130
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8

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
	call	memset
	add	sp, 8

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
	call	memset
	add	sp, 8

	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:g_monFreezeAcPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_41E50[bx], al
	mov	bx, [bp+counter]
	mov	gs:monSpellToHitPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:monAttackBonus[bx], al
	jmp	loc_1D0B5
loc_1D130:
	mov	[bp+counter], 0
	jmp	short loc_1D13A
loc_1D137:
	inc	[bp+counter]
loc_1D13A:
	cmp	[bp+counter], 7
	jge	short loc_1D18D
	mov	bx, [bp+counter]
	mov	gs:g_charActionList[bx], 2
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:[bx+8], al
	mov	bx, [bp+counter]
	mov	gs:g_strengthSpellBonus[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+counter]
	mov	gs:g_characterMeleeDistance[bx], al
	mov	bx, [bp+counter]
	mov	gs:bat_charPriority[bx], al
	jmp	short loc_1D137
loc_1D18D:
	sub	al, al
	mov	gs:g_divineDamageBonus, al
	mov	gs:g_charFreezeToHitBonus, al
	mov	gs:g_charFreezeAcPenalty, al
	mov	gs:partySpellAcBonus, al
	mov	gs:g_monsterWOFBonus, al
	mov	gs:monFrozenFlag, al
	mov	gs:byte_422A4, al
	mov	gs:byte_41E63, al
	mov	gs:disbelieveFlags, al
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
	mov	sp, bp
	pop	bp
	retf
bat_reset endp

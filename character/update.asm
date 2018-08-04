; Attributes: bp-based frame

character_update proc far

	songAcBonus= word ptr	-4
	acValue= word ptr	-2
	slotNumber=	word ptr  6

	FUNC_ENTER(4)
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned
	jz	short l_skipResurrect

	mov	ax, itemEff_resurrect
	push	ax
	push	[bp+slotNumber]
	CALL(character_isEffectEquipped, near)
	or	ax, ax
	jnz	short l_skipResurrect

	CALL(inventory_pack, near)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	and	gs:party.status[bx], stat_poisoned or stat_old	or stat_paralyzed or stat_possessed or stat_nuts or stat_unknown
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	ax, gs:party.maxHP[si]
	mov	gs:party.currentHP[si], ax

l_skipResurrect:
	cmp	gs:songHalfDamage, 0
	jz	short l_noSongAcBonus

	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+slotNumber]
	jnz	short l_noSongAcBonus
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.level[bx], 60
	jbe	short l_notMaxLevelSinger
	mov	ax, 0Fh
	jmp	short l_setSongAcBonus

l_notMaxLevelSinger:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1

l_setSongAcBonus:
	mov	[bp+songAcBonus], ax
	jmp	short l_songBonusExit

l_noSongAcBonus:
	mov	[bp+songAcBonus], 0

l_songBonusExit:
	push	[bp+slotNumber]
	CALL(character_getEquipmentAcBonus, near)
	mov	si, ax

	push	[bp+slotNumber]
	CALL(character_getDexterityAcBonus)
	mov	cx, ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.acBase[bx]
	sub	ah, ah
	mov	bx, [bp+slotNumber]
	mov	dl, gs:g_unusedBattleAcBonus[bx]
	sub	dh, dh
	add	ax, dx
	add	ax, cx
	add	ax, si
	add	ax, [bp+songAcBonus]
	mov	[bp+acValue], ax

	CHARINDEX(ax, bx, bx)
	cmp	gs:party.class[bx], class_monk
	jnz	short l_notMonk
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	add	[bp+acValue], ax

l_notMonk:
	mov	al, shieldAcBonus
	sub	ah, ah
	mov	cl, gs:partySpellAcBonus
	sub	ch, ch
	add	ax, cx
	mov	cl, gs:g_songAcBonus
	add	ax, cx
	mov	cl, gs:g_charFreezeAcPenalty
	sub	ax, cx
	or	ax, ax
	jle	short l_checkMaxAc
	add	[bp+acValue], ax

l_checkMaxAc:
	mov	al, byte ptr [bp+acValue]
	cmp	ax, 60
	jle	l_setValues
	mov	ax, 60

l_setValues:
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	gs:party.ac[bx], cl
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.currentHP[bx], 0
	jnz	short l_return
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	or	gs:party.status[bx], stat_dead

l_return:
	pop	si
	FUNC_EXIT
	retf
character_update endp
